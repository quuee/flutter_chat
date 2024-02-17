import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/id_util.dart';
import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/data/remote/file_upload_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/image_element.dart';
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

  UserDO? get currentUser =>
      _globalValueController.currentUser;

  RxMap<int, RxList<MessageInfo>> get messageMapListG =>
      _globalValueController.messageMapList;

  RxBool leftKeyboardButton = true.obs;

  RxBool keyboardShow = false.obs;

  RxBool toolBtnOff = true.obs;

  FocusNode textFocusNode = FocusNode();

  @override
  void onInit() {
    // _messageListen();
    conversation = Get.arguments;
    _getChatLog();
    inputListener();
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

  inputListener(){
    textFocusNode.addListener(() {
      if(textFocusNode.hasFocus){
        logger.i('textFocusNode.addListener:${toolBtnOff.value}');
        toolBtnOff.value = true;//隐藏
        keyboardShow.value = true;
        leftKeyboardButton.value = false;
      }else{
        keyboardShow.value = false;
        leftKeyboardButton.value = true;
      }

    });
  }


  _getChatLog() async {

    _globalValueController.getConversation(conversation!);
    _globalValueController.loadChatLog(conversation!.conversationId!);
  }

  sendMessage() {
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

  sendImage(String imageLocalPath) async {

    ApiResult? result = await FileUploadApi.uploadImage(File(imageLocalPath));
    String imageUrl='';
    if(result?.code == 0){
      var list = result?.data as List<dynamic>;
      imageUrl = list.first as String;
    }

    ImageElement image = ImageElement(imageLocalPath: imageLocalPath,imageUrl: imageUrl);
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
        contentType: MessageType.picture,
        content: '',
    image: image);
    var messageWrapper = MessageWrapper(
        conversationType: ConversationType.PRIVATE_MESSAGE, data: sendInfo);
    


    _globalValueController.sendMessage(messageWrapper);

    _globalValueController.messageMapListAdd(
        conversation!.conversationId!, sendInfo);

    _globalValueController
        .isarSaveMessage([sendInfo], conversation!.conversationId!);
  }
}
