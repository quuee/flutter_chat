


import 'dart:convert';

import 'package:flutter_chat/app/model/message_wrapper.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '/app/network/websocket_provider.dart';

class ConversationController extends BaseController with GetSingleTickerProviderStateMixin {

  List<ConversationModel> talks = []; // 需从本地数据库加载
  final WebSocketProvider webSocketProvider = Get.find(tag: (WebSocketProvider).toString());

  @override
  onInit(){
    _initWebSocket();

    super.onInit();
  }


  _initWebSocket(){
    webSocketProvider.connect().then((isConnect) {
      if (isConnect) {
        webSocketProvider.listen((msg) {
          // logger.i('Received: $msg');
          MessageWrapper data = MessageWrapper.fromJson(
            json.decode(msg),
          );

          logger.i('处理接收的消息${data.toJsonString()}',);



          //The server returns a message
        }, onError: (error) {
          Fluttertoast.showToast(msg: error.toString());
        });
      }
    });
    // webSocketProvider.login();
    webSocketProvider.startHeartBeat();
  }
}