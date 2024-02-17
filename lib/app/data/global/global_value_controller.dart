import 'dart:convert';

import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/model/user_do.dart';
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
  RxMap<int, RxList<MessageInfo>> messageMapList = RxMap.identity();

  // 在会话界面收到消息，打开聊天界面 消息需要一致存在

  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());
  final Isar _isar = Get.find(tag: (Isar).toString());

  UserDO? currentUser;

  @override
  onInit() async {
    _initWebSocket();
    await _loadUserInfo();
    loadConversations();
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
        webSocketProvider.startHeartBeat();
      }
    });
  }

  // 处理不同类型会话
  _switchConversationTypeHandler(MessageWrapper data) {
    switch (data.conversationType) {
      case ConversationType.PRIVATE_MESSAGE:
        MessageInfo receiveInfo = MessageInfo.fromJson(data.data);
        logger.i(
          '私聊消息${receiveInfo.toJsonString()}',
        );
        for (var conversation in conversationList) {
          // 接收服务器消息 当聊天对象是发送对象
          // if (conversation.contactUserIds.first == receiveInfo.sender.userId) { }
          _switchMessageTypeHandler(receiveInfo);
          conversation.lastMessage = receiveInfo.content;
          messageMapListAdd(conversation.conversationId!, receiveInfo);
          isarSaveMessage([receiveInfo], conversation.conversationId!);
        }
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
  loadConversations() {
    conversationList.clear();
    List<ConversationModel> temp = _isar.conversationModels
        .filter()
        .currentUserIdEqualTo(currentUser!.userId)
        .findAllSync();
    conversationList.addAllIf(temp.isNotEmpty, temp);
    conversationList.refresh();
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
}
