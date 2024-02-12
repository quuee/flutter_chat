
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/model/cmd_type.dart';
import 'package:flutter_chat/app/model/message_wrapper.dart';
import 'package:flutter_chat/app/model/receive_info.dart';
import 'package:flutter_chat/app/model/send_info.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/model/user_info.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatController extends GetxController{
  final Logger logger = BuildConfig.instance.config.logger;
  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
  ScrollController scrollController = ScrollController();

  TextEditingController textEditingController = TextEditingController();

  RxList<ReceiveInfo> messageList = <ReceiveInfo>[].obs;

  RxString sendMessageStr = ''.obs;

  final WebSocketProvider webSocketProvider = Get.find(tag: (WebSocketProvider).toString());

  ContacterModel? contacter;

  UserDO? userDO;

  @override
  void onInit() {
    _loadUserInfo();
    _messageListen();
    super.onInit();
  }

  _messageListen(){
    webSocketProvider.listen((msg) {

      MessageWrapper data = MessageWrapper.fromJson(
        json.decode(msg),
      );
      logger.i('ChatController: ${data.toJsonString()}');
      if(data.cmd == CmdType.PRIVATE_MESSAGE){
        ReceiveInfo receiveInfo = ReceiveInfo.fromJson(data.data);
        messageList.add(receiveInfo);
      }

      messageList.refresh();

    });
  }

  _loadUserInfo() async {
    contacter = Get.arguments;
    var userDOStr = await _preferenceManager.getString(PreferenceManager.userDO);
    userDO = userDoFromJson(userDOStr);
  }

  Future<void> sendMessage() async {

    var sendInfo = SendInfo(cmd: CmdType.PRIVATE_MESSAGE, sender: UserInfo(userId: userDO!.userId,terminal: TerminalType.APP), receivers: [UserInfo(userId: contacter!.userId,terminal: TerminalType.APP)], sendResult: false,serviceName: 'xxx', data: sendMessageStr.value);
    var messageWrapper = MessageWrapper(cmd: CmdType.PRIVATE_MESSAGE,data: sendInfo);

    webSocketProvider.sendMsg(messageWrapper);
    messageList.add(_sendInfo2ReceiveInfo(sendInfo));

    textEditingController.clear();
    sendMessageStr.value = '';
  }

  _sendInfo2ReceiveInfo(SendInfo sendInfo){
    return ReceiveInfo(cmd: sendInfo.cmd,sender: sendInfo.sender,receiver: sendInfo.receivers[0],data: sendInfo.data);
  }

}