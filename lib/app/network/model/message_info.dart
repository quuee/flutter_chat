
import 'dart:convert';

import 'package:flutter_chat/app/network/model/user_info.dart';

class MessageInfo{
  int cmd;
  UserInfo sender;
  List<UserInfo> receivers;
  // bool sendResult;
  String serviceName;
  String messageTime;
  dynamic data;

  MessageInfo({required this.cmd,required this.sender,required this.receivers,required this.serviceName,required this.messageTime,required this.data});

  factory MessageInfo.fromJson(Map<String, dynamic> json) => MessageInfo(
    cmd: json["cmd"],
    sender: UserInfo.fromJson(json["sender"]),
    receivers: List<UserInfo>.from(json["receivers"].map((x) => UserInfo.fromJson(x))),
    // sendResult: json["sendResult"],
    serviceName: json["serviceName"]??'',
    messageTime: json["messageTime"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "cmd": cmd,
    "sender": sender,
    "receivers": receivers,
    // "sendResult": sendResult,
    "serviceName": serviceName,
    "messageTime": messageTime,
    "data": data,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}