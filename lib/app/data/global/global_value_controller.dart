import 'dart:convert';
import 'package:flutter_chat/app/core/id_util.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/data/remote/group_api.dart';
import 'package:flutter_chat/app/data/remote/user_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/modules/contacts/model/group_model.dart';
import 'package:flutter_chat/app/modules/talks/model/chat_log_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_contact_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';
import 'package:flutter_chat/app/network/model/message_wrapper.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// 全局变量
class GlobalValueController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  final WebSocketProvider webSocketProvider = Get.find<WebSocketProvider>();
  // 会话对象
  RxList<ConversationModel> conversationList = RxList.empty(growable: true);
  // <会话id,消息集合>
  RxMap<int, RxList<MessageInfo>> messageMapList = RxMap.identity();

  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());

  // 当前用户
  UserDO? currentUser;

  // 建立朋友关系的联系人
  List<ContacterModel> contactList = [];

  // 群
  RxList<GroupModel> groups = RxList.empty();

  @override
  onInit() async {
    await _loadUserInfo(); // 加载当前用户
    _loadContacts(); // 加载联系人
    _loadConversations(); // 加载会话
    _initWebSocket();
    super.onInit();
  }

  // 初始化websocket连接
  _initWebSocket() {
    webSocketProvider.connect().then((isConnect) {
      if (isConnect) {
        webSocketProvider.listen((msg) async {
          // logger.i('Received: $msg');
          MessageWrapper data = MessageWrapper.fromJson(json.decode(msg));

          await _switchConversationTypeHandler(data);

          // 刷新消息 更新会话界面ui
          conversationList.refresh();
          // _globalValueController.messageMapList.refresh();
        }, onError: (error) {
          // webSocketProvider.getCurrentStatus()
          Fluttertoast.showToast(msg: error.toString());
        });
      }
    });
    webSocketProvider.startHeartBeat();
  }

  // 处理不同类型会话
  _switchConversationTypeHandler(MessageWrapper data) async {
    switch (data.conversationType) {
      case ConversationType.PRIVATE_MESSAGE:
        MessageInfo messageInfo = MessageInfo.fromJson(data.data);
        logger.i(
          '私聊消息${messageInfo.toJsonString()}',
        );

        ConversationModel newConversation =
            await _newPrivateConversation(messageInfo);
        _switchMessageTypeHandler(messageInfo);
        newConversation.lastTime = messageInfo.contentTime;
        newConversation.lastMessage = messageInfo.content;
        messageMapListAdd(newConversation.conversationId!, messageInfo);
        isarSaveMessage([messageInfo], newConversation.conversationId!);

        break;

      case ConversationType.GROUP_MESSAGE:
        MessageInfo messageInfo = MessageInfo.fromJson(data.data);
        logger.i(
          '群聊消息${messageInfo.toJsonString()}',
        );
        ConversationModel newConversation =
            await _newGroupConversation(messageInfo);
        _switchMessageTypeHandler(messageInfo);
        newConversation.lastTime = messageInfo.contentTime;
        newConversation.lastMessage = messageInfo.content;
        messageMapListAdd(newConversation.conversationId!, messageInfo);
        isarSaveMessage([messageInfo], newConversation.conversationId!);
        break;

      case ConversationType.HEART_BEAT:
        logger.i(
          '心跳消息${data.toJsonString()}',
        );
        break;

      case ConversationType.FORCE_LOGOUT:
        logger.i(
          '强制下线消息${data.toJsonString()}',
        );
        break;
    }
  }

  // _newPrivateConversation 根据消息创建新会话
  _newPrivateConversation(MessageInfo messageInfo) async {
    // 如果没有通过联系人找到会话
    ConversationModel? newConversation;
    for (ConversationModel conversation in conversationList) {
      bool b =
          conversation.contactUsers?.first.userId == messageInfo.sender.userId;
      if (b) {
        newConversation = conversation;
        break;
      }
    }

    if (newConversation == null) {
      // List<ContacterModel> ctemp =
      //     await ContactDao.instance().findById(messageInfo.sender.userId);
      ApiResult? apiResult = await UserApi.oneContact(messageInfo.sender.userId);
      ContacterModel contacterModel = ContacterModel.fromJson(apiResult?.data);

      // 不存在会话 则创建
      newConversation = ConversationModel(
          conversationId: IdUtil.getId(),
          contactUsers: [contacterModel],
          conversationType: ConversationType.PRIVATE_MESSAGE,
          currentUserId: currentUser?.userId,
          conversationName: contacterModel.nickname,
          conversationThumb: contacterModel.avatarUrl,
          contentType: messageInfo.contentType,
          lastMessage: messageInfo.content,
          lastTime: messageInfo.contentTime);
      conversationList.add(newConversation);
    }
    return newConversation;
  }

  _newGroupConversation(MessageInfo messageInfo) async {
    // groupId就是conversationId
    ConversationModel? newConversation;
    for (ConversationModel conversation in conversationList) {
      if (messageInfo.groupId == conversation.conversationId) {
        newConversation = conversation;
        break;
      }
    }
    if (newConversation == null) {
      // 查询用户 群组信息
      // 查询 群信息
      GroupModel? groupModel;
      ApiResult? result = await GroupApi.groupMembers(messageInfo.groupId);

      if (result?.code == 0) {
        groupModel = GroupModel.fromJson(result?.data);
      }

      // 不存在会话 则创建
      newConversation = ConversationModel(
          conversationId: messageInfo.groupId,
          contactUsers: groupModel?.members,
          conversationType: ConversationType.GROUP_MESSAGE,
          currentUserId: currentUser?.userId,
          conversationName: groupModel!.groupName,
          conversationThumb: groupModel.conversationThumb!,
          contentType: messageInfo.contentType,
          lastMessage: messageInfo.content,
          lastTime: messageInfo.contentTime);
      conversationList.add(newConversation);
    }
    return newConversation;
  }

  // 处理不同类型消息
  _switchMessageTypeHandler(MessageInfo messageInfo) {
    switch (messageInfo.contentType) {
      case MessageType.text:
        break;
      case MessageType.picture:
        messageInfo.content = '[图片]';
        break;
      case MessageType.voice:
        messageInfo.content = '[语音]';
        break;
      case MessageType.video:
        messageInfo.content = '[视频]';
        break;
      case MessageType.atText:
        messageInfo.content = '[@我]';
        break;
      case MessageType.location:
        messageInfo.content = '[定位]';
        break;
    }
  }

  // 加载用户信息
  _loadUserInfo() async {
    var userDOStr =
        await _preferenceManager.getString(PreferenceManager.userDO);
    currentUser = userDoFromJson(userDOStr);
  }

  // 加载会话
  _loadConversations() async {
    conversationList.clear();
    List<Map<String, dynamic>> temp = await ConversationDao.instance()
        .find(where: {ConversationDao.currentUserId: currentUser!.userId});
    var list = List<ConversationModel>.from(
        temp.map((x) => ConversationModel.fromJson(x)));
    conversationList.addAllIf(temp.isNotEmpty, list);
    list.forEach((element) {
      _loadConversationContact(element);
    });

    conversationList.refresh();
  }

  // 获取会话
  getConversation(ConversationModel conversation) async {
    // 1、从联系人进入聊天界面,
    if (conversation.conversationId == null) {
      // 可能存在会话 按当前用户+联系人查询
      List<Map<String, dynamic>> cctemp =
          await ConversationContactDao.instance().find(where: {
        ConversationContactDao.currentUserId: currentUser!.userId,
        ConversationContactDao.contactUserId:
            conversation.contactUsers!.first.userId
      });

      if (cctemp.isNotEmpty) {
        List<ConversationModel> ctemp = await ConversationDao.instance()
            .queryById(cctemp.first[ConversationDao.conversationId]);
        conversation = ctemp.first;
      } else {
        conversation.conversationId = IdUtil.getId();
      }
      conversationList.add(conversation);
      _loadConversationContact(conversation);
    } else {
      // 2、从会话界面进入聊天, 也可能是进入群聊（因为群聊groupId赋值给conversationId）
      if (conversationList.isEmpty) {
        conversationList.add(conversation);
      } else {
        var newConversation = conversationList.firstWhereOrNull(
            (element) => element.conversationId == conversation.conversationId);
        if (newConversation == null) {
          conversationList.add(conversation);
        } else {
          conversation = newConversation;
        }
        _loadConversationContact(conversation);
      }
    }

    return conversation;
  }

  // 加载联系人到会话
  _loadConversationContact(ConversationModel model) async {
    model.contactUsers ??= [];
    if(model.conversationType == ConversationType.GROUP_MESSAGE){
      // 如果是群聊，联系人从网络获取
      GroupModel? groupModel;
      ApiResult? result = await GroupApi.groupMembers(model.conversationId!);

      if (result?.code == 0) {
        groupModel = GroupModel.fromJson(result?.data);
      }
      model.contactUsers?.addAll(groupModel!.members!);

    }

    if(model.conversationType == ConversationType.PRIVATE_MESSAGE){
      List<Map<String, dynamic>> cctemp =
      await ConversationContactDao.instance().find(where: {
        ConversationContactDao.currentUserId: currentUser!.userId,
        ConversationContactDao.conversationId: model.conversationId
      });
      for (ContacterModel ct in contactList) {
        for (Map<String, dynamic> cc in cctemp) {
          if(ct.userId == cc['userId']){
            model.contactUsers?.add(ct);
          }
        }}
    }
  }


  // 会话存入本地数据库
  isarSaveConversation(ConversationModel conversation) async {

    ConversationDao.instance().remove({ConversationDao.conversationId:conversation.conversationId});
    ConversationDao.instance().insertBean(conversation);

    ConversationContactDao.instance().remove({
      ConversationContactDao.conversationId: conversation.conversationId,
      ConversationContactDao.currentUserId: currentUser!.userId
    });

    conversation.contactUsers?.forEach((element) {
      var c = ConversationContactModel(
          conversationId: conversation.conversationId!,
          currentUserId: currentUser!.userId,
          contactUserId: element.userId);
      ConversationContactDao.instance().insert(c.toJson());
    });
  }

  // 删除会话
  deleteConversation(int conversationId) {
    ConversationDao.instance()
        .remove({ConversationDao.conversationId: conversationId});
    conversationList
        .removeWhere((element) => element.conversationId == conversationId);
    conversationList.refresh();
  }

  // 发送消息
  sendMessage(MessageWrapper messageWrapper) {
    webSocketProvider.sendMsg(messageWrapper);
  }

  // 消息存入本地数据库
  isarSaveMessage(List<MessageInfo> messageInfoList, int conversationId) {
    List<ChatLogModel> list = messageInfoList
        .map((e) => ChatLogModel.convertFromMessageInfo(
            e, currentUser!.userId, conversationId))
        .toList();
    for (ChatLogModel element in list) {
      ChatLogDao.instance().insertBean(element);
    }
  }

  // 加载历史消息（缓存消息 数据库消息必须一致）
  // 有会话id就是有历史消息，无会话没有历史消息
  loadChatLog(int conversationId) async {
    List<Map<String, dynamic>> chatLogMap = await ChatLogDao.instance()
        .find(where: {ChatLogDao.conversationId: conversationId});
    var chatLogs = List<ChatLogModel>.from(
        chatLogMap.map((x) => ChatLogModel.fromJson(x)));
    List<MessageInfo> temp =
        chatLogs.map((e) => ChatLogModel.convertToMessageInfo(e)).toList();

    messageMapList.addAll({conversationId: RxList(temp)});
  }

  // 更新messageMapList
  messageMapListAdd(int conversationId, MessageInfo receiveInfo) {
    List<MessageInfo> messageList =
        messageMapList[conversationId] ?? RxList.empty(growable: true);
    messageList.add(receiveInfo);
    messageMapList.addAll({conversationId: RxList(messageList)});

    // 如果发送者是自己 会话消息不会及时更新
  }

  // 加载联系人
  _loadContacts() async {
    // var userDOStr = await _preferenceManager.getString(PreferenceManager.userDO);
    // var userDO = userDoFromJson(userDOStr);
    ApiResult? loadContacts = await UserApi.loadContacts(currentUser!.userId);
    List dataList = loadContacts?.data as List;
    for (var element in dataList) {
      ContacterModel contacterModel = ContacterModel.fromJson(element);
      // 写入数据库
      ContactDao.instance().remove({ContactDao.userId: contacterModel.userId});
      ContactDao.instance().insert(contacterModel.toJson());

      contactList.add(contacterModel);
    }
  }
}
