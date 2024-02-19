import 'dart:convert';

import 'package:flutter_chat/app/core/id_util.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/data/remote/user_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/modules/talks/model/chat_log_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';
import 'package:flutter_chat/app/network/model/message_wrapper.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';

/// 全局变量
class GlobalValueController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  final WebSocketProvider webSocketProvider = Get.find<WebSocketProvider>();
  // 会话对象
  RxList<ConversationModel> conversationList = RxList.empty(growable: true);
  // <会话id,消息集合>
  RxMap<int, RxList<MessageInfo>> messageMapList = RxMap.identity();

  // 在会话界面收到消息，打开聊天界面 消息需要一致存在

  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());
  final Isar _isar = Get.find(tag: (Isar).toString());

  UserDO? currentUser;

  List<ContacterModel> cList = [];

  @override
  onInit() async {
    await _loadUserInfo();// 加载当前用户
    _loadContacts(); // 加载联系人
    _loadConversations(); // 加载会话
    _initWebSocket();
    super.onInit();
  }

  // 初始化websocket连接
  _initWebSocket() {
    webSocketProvider.connect().then((isConnect) {
      if (isConnect) {
        webSocketProvider.listen((msg) {
          // logger.i('Received: $msg');
          MessageWrapper data = MessageWrapper.fromJson(json.decode(msg));

          _switchConversationTypeHandler(data);

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
  _switchConversationTypeHandler(MessageWrapper data) {
    switch (data.conversationType) {
      case ConversationType.PRIVATE_MESSAGE:
        MessageInfo messageInfo = MessageInfo.fromJson(data.data);
        logger.i(
          '私聊消息${messageInfo.toJsonString()}',
        );

        ConversationModel newConversation = _newConversation(messageInfo);
        _switchMessageTypeHandler(messageInfo);
        newConversation.lastTime = messageInfo.contentTime;
        newConversation.lastMessage = messageInfo.content;
        messageMapListAdd(newConversation.conversationId!, messageInfo);
        isarSaveMessage([messageInfo], newConversation.conversationId!);

        break;

      case ConversationType.GROUP_MESSAGE:
        MessageInfo receiveInfo = MessageInfo.fromJson(data.data);
        logger.i(
          '群聊消息${receiveInfo.toJsonString()}',
        );
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

  // newConversation 根据消息创建新会话
  _newConversation(MessageInfo messageInfo){
    // 如果没有通过联系人找到会话
    ConversationModel? newConversation;
    for (ConversationModel conversation in conversationList) {
      bool b = conversation.contactUserIds.first == messageInfo.sender.userId;
      if(b){
        newConversation = conversation;

      }
    }

    if(newConversation == null){

      ContacterModel? contacterModel = _isar.contacterModels.getSync(messageInfo.sender.userId);

      // 不存在会话 则创建
      newConversation = ConversationModel(
          conversationId: IdUtil.getId(),
          contactUserIds: [messageInfo.sender.userId],
          contactUsers: [contacterModel!],
          conversationType: ConversationType.PRIVATE_MESSAGE,
          currentUserId: currentUser?.userId,
          conversationName: contacterModel.nickname,
          avatarUrl: contacterModel.avatarUrl,
          contentType: messageInfo.contentType,
          lastMessage: messageInfo.content,
          lastTime: messageInfo.contentTime);
      conversationList.add(newConversation);
    }
    return newConversation;
  }


  // 处理不同类型消息
  _switchMessageTypeHandler(MessageInfo receiveInfo) {
    switch (receiveInfo.contentType) {
      case MessageType.text:
        break;
      case MessageType.picture:
        receiveInfo.content = '[图片]';
        break;
      case MessageType.voice:
        receiveInfo.content = '[语音]';
        break;
      case MessageType.video:
        receiveInfo.content = '[视频]';
        break;
      case MessageType.atText:
        receiveInfo.content = '[@我]';
        break;
      case MessageType.location:
        receiveInfo.content = '[定位]';
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
    List<ConversationModel> temp = _isar.conversationModels
        .filter()
        .currentUserIdEqualTo(currentUser!.userId)
        .findAllSync();
    conversationList.addAllIf(temp.isNotEmpty, temp);

    _conversationSetContracts();
    conversationList.refresh();
  }

  // 获取会话
  getConversation(ConversationModel conversation){
    // 1、从联系人进入聊天界面,
    if (conversation.conversationId == null) {
      // 可能存在会话 按当前用户+联系人查询
      ConversationModel? cs = _isar.conversationModels
          .filter()
          .currentUserIdEqualTo(currentUser?.userId)
          .contactUserIdsElementEqualTo(conversation.contactUserIds.first)
          .findFirstSync();
      if (cs != null) {
        conversation = cs;
      } else {
        conversation.conversationId = IdUtil.getId();
      }
      conversationList.add(conversation);
    } else {
      // 2、从会话界面进入聊天
      conversation = conversationList.firstWhere(
              (element) => element.conversationId == conversation.conversationId);
    }
    _conversationSetContracts();
    return conversation;
  }

  // 加载联系人到会话 (是不是只需要加载单个联系人)
  _conversationSetContracts(){

    for (var element in conversationList) {
      element.contactUsers ??= [];
      List<ContacterModel?> contacts = _isar.contacterModels.getAllSync(element.contactUserIds);
      for (ContacterModel? contact in contacts) {
        bool isBlank = contact.isBlank!;
        if(!isBlank){
          // 去重
          int index = element.contactUsers?.indexWhere((ee) => ee.userId == contact?.userId)??-1;
          if(index<0){
            element.contactUsers?.add(contact!);
          }
        }
      }

    }
  }


  // 会话存入本地数据库
  isarSaveConversation(ConversationModel conversation) {
    _isar.writeTxn(() => _isar.conversationModels.put(conversation));
  }

  // 删除会话
  deleteConversation(int conversationId) {
    _isar.writeTxnSync(
        () => _isar.conversationModels.deleteSync(conversationId));
    conversationList
        .removeWhere((element) => element.conversationId == conversationId);
    conversationList.refresh();
  }

  // 发送消息
  sendMessage(MessageWrapper messageWrapper) {
    webSocketProvider.sendMsg(messageWrapper);
  }

  // 消息存入本地数据库
  isarSaveMessage(List<MessageInfo> receiveInfoList, int conversationId) {
    List<ChatLogModel> list = receiveInfoList
        .map((e) => ChatLogModel.convertFromReceiveInfo(
            e, currentUser!.userId, conversationId))
        .toList();
    // for (ReceiveInfo element in receiveInfoList) {
    //   ChatLogModel chatLogModel = ChatLogModel.convertFromReceiveInfo(
    //       element, currentUser!.userId, conversationId);
    // }

    _isar.writeTxn(() async {
      await _isar.chatLogModels.putAll(list);
    });
  }

  // 加载历史消息（缓存消息 数据库消息必须一致）
  // 有会话id就是有历史消息，无会话没有历史消息
  loadChatLog(int conversationId) {
    List<ChatLogModel> chats = _isar.chatLogModels
        .filter()
        .conversationIdEqualTo(conversationId)
        .limit(30)
        .findAllSync();
    List<MessageInfo> temp =
        chats.map((e) => ChatLogModel.convertToReceiveInfo(e)).toList();

    // if(messageMapList[conversationId]!=null && messageMapList[conversationId]!.isNotEmpty){
    //   messageMapList[conversationId]!.clear();
    //
    // }
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
      cList.add(contacterModel);
    }
    // 写入数据库
    _isar.writeTxn(() => _isar.contacterModels.putAll(cList));
  }


}
