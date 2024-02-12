
import 'dart:convert';

import 'package:flutter_chat/app/model/user_info.dart';

class SendInfo{
  int cmd;
  UserInfo sender;
  List<UserInfo> receivers;
  bool sendResult;
  String serviceName;
  dynamic data;

  SendInfo({required this.cmd,required this.sender,required this.receivers,required this.sendResult,required this.serviceName,required this.data});

  factory SendInfo.fromJson(Map<String, dynamic> json) => SendInfo(
    cmd: json["cmd"],
    sender: UserInfo.fromJson(json["sender"]),
    receivers: List<UserInfo>.from(json["receivers"].map((x) => UserInfo.fromJson(x))),
    sendResult: json["sendResult"],
    serviceName: json["serviceName"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "cmd": cmd,
    "sender": sender,
    "receivers": receivers,
    "sendResult": sendResult,
    "serviceName": serviceName,
    "data": data,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}