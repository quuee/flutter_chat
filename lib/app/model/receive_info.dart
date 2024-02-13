
import 'dart:convert';

import 'package:flutter_chat/app/model/user_info.dart';

class ReceiveInfo {
  int cmd;
  UserInfo sender;
  UserInfo receiver;
  String dateTime;
  dynamic data;

  ReceiveInfo({required this.cmd,required this.sender,required this.receiver,required this.dateTime,required this.data});

  factory ReceiveInfo.fromJson(Map<String, dynamic> json) => ReceiveInfo(
    cmd: json["cmd"],
    sender: UserInfo.fromJson(json["sender"]),
    receiver: UserInfo.fromJson(json["receiver"]),
    dateTime: json["dateTime"]??DateTime.now().toIso8601String(),
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "cmd": cmd,
    "sender": sender,
    "receiver": receiver,
    "dateTime": dateTime,
    "data": data,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}