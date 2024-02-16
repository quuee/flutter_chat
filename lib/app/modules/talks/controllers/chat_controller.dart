import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/id_util.dart';
import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';
import 'package:flutter_chat/app/network/model/message_wrapper.dart';
import 'package:flutter_chat/app/network/model/user_info.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';

class ChatController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  final Isar _isar = Get.find(tag: (Isar).toString());

  ScrollController scrollController = ScrollController();

  TextEditingController textEditingController = TextEditingController();

  RxString sendMessageStr = ''.obs;

  final WebSocketProvider webSocketProvider = Get.find<WebSocketProvider>();

  ConversationModel? conversation;

  final GlobalValueController _globalValueController =
      Get.find<GlobalValueController>();

  UserDO? get currentUser => _globalValueController.currentUser;
  RxMap<int, RxList<MessageInfo>> get messageMapListG =>
      _globalValueController.messageMapList;

  RxBool leftKeyboardButton = true.obs;

  RxBool keyboardShow = false.obs;

  RxBool toolBtnShow = true.obs;

  @override
  void onInit() {
    // _messageListen();
    conversation = Get.arguments;
    _getChatLog();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 自己的最后一条信息，不能传递到会话界面（使会话界面总展示最新的消息）
    // 点进去不做任何操作退出来 没有一条信息
    if (messageMapListG[conversation?.conversationId]!.isNotEmpty) {
      conversation?.lastMessage =
          messageMapListG[conversation?.conversationId]!.last.content;
      conversation?.lastTime = DateTime.now().toString();
      conversation?.currentUserId = currentUser!.userId;

      _globalValueController.isarSaveConversation(conversation!);
    }

    super.onClose();
  }

  _getChatLog() async {
    // 1、从联系人进入聊天界面
    if (conversation?.conversationId == null) {
      // 可能存在会话 按当前用户+联系人查询
      ConversationModel? cs = _isar.conversationModels
          .filter()
          .currentUserIdEqualTo(currentUser?.userId)
          .contactUserIdsElementEqualTo(conversation!.contactUserIds.first)
          .findFirstSync();
      if (cs == null) {
        conversation?.conversationId = IdUtil.getId();
        _globalValueController.conversationList.add(conversation!);
      } else {
        conversation = cs;
      }
    } else {
      // 2、从会话界面进入聊天
      conversation = _globalValueController.conversationList.firstWhere(
          (element) => element.conversationId == conversation?.conversationId);
    }

    _globalValueController.loadChatLog(conversation!.conversationId!);
  }

  Future<void> sendMessage() async {
    MessageInfo sendInfo = MessageInfo(
        conversationType: ConversationType.PRIVATE_MESSAGE,
        sender: UserInfo(
            userId: _globalValueController.currentUser!.userId,
            terminal: TerminalType.APP),
        receivers: List.generate(
            conversation!.contactUserIds.length,
            (index) => UserInfo(
                userId: conversation!.contactUserIds[index],
                terminal: TerminalType.APP)),
        serviceName: '',
        contentTime: DateTime.now().toString(),
        contentType: MessageType.text,
        content: sendMessageStr.value);
    var messageWrapper = MessageWrapper(
        conversationType: ConversationType.PRIVATE_MESSAGE, data: sendInfo);

    _globalValueController.sendMessage(messageWrapper);

    _globalValueController.messageMapListAdd(
        conversation!.conversationId!, sendInfo);

    _globalValueController
        .isarSaveMessage([sendInfo], conversation!.conversationId!);

    textEditingController.clear();
    sendMessageStr.value = '';
  }
}
