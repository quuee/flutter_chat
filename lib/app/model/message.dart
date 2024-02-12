// import 'user_info.dart';
//
// import 'dart:convert';
//
// List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));
//
// String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Message {
//   int cmd;
//   String? sendTime;
//   UserInfo? sender;
//   List<UserInfo>? receivers;
//   String? serviceName;
//   bool? needSendResult;
//   String content;
//   // ImageElement? image;
//   // SoundElement? sound;
//
//   Message({
//     required this.cmd,
//     this.sendTime,
//     this.sender,
//     this.receivers,
//     this.serviceName,
//     this.needSendResult,
//     required this.content
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     cmd: json["cmd"],
//     sendTime: json["sendTime"],
//     sender: UserInfo.fromJson(json["sender"]),
//     receivers: List<UserInfo>.from(json["receivers"].map((x) => UserInfo.fromJson(x))),
//     serviceName: json["serviceName"],
//     needSendResult: json["needSendResult"],
//     content: json["content"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cmd": cmd,
//     "sendTime": sendTime,
//     "sender": sender?.toJson(),
//     "receivers": receivers != null ? List<dynamic>.from(receivers!.map((x) => x.toJson())): [],
//     "serviceName": serviceName,
//     "needSendResult": needSendResult,
//     "content": content,
//   };
//
//   String toJsonString() {
//     return jsonEncode(toJson());
//   }
// }
