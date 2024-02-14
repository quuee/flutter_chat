
import 'dart:convert';

class MessageWrapper{
  int cmd;
  dynamic data;

  MessageWrapper({
    required this.cmd,
    required this.data
  });

  factory MessageWrapper.fromJson(Map<String, dynamic> json) => MessageWrapper(
    cmd: json["cmd"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "cmd": cmd,
    "data": data,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}