import 'dart:convert';

import 'package:flutter_chat/app/network/model/image_element.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';
import 'package:flutter_chat/app/network/model/sound_element.dart';
import 'package:flutter_chat/app/network/model/user_info.dart';

class MessageInfo {
  int conversationType;
  UserInfo sender;
  List<UserInfo> receivers;
  // bool sendResult;
  String serviceName;
  String contentTime;
  // int? messageStatus;// 信息发送状态 成功 失败
  String content;
  int contentType;
  ImageElement? image;
  SoundElement? sound;

  MessageInfo(
      {required this.conversationType,
      required this.sender,
      required this.receivers,
      required this.serviceName,
      required this.contentTime,
      required this.contentType,
      required this.content,
      this.image,
      this.sound});

  factory MessageInfo.fromJson(Map<String, dynamic> json) => MessageInfo(
        conversationType: json["conversationType"],
        sender: UserInfo.fromJson(json["sender"]),
        receivers: List<UserInfo>.from(
            json["receivers"].map((x) => UserInfo.fromJson(x))),
        serviceName: json["serviceName"] ?? '',
        contentTime: json["contentTime"],
        content: json["content"] ?? MessageType.text,
        contentType: json["contentType"],
        image: ImageElement.fromJson(json['image'] ?? {}),
        sound: SoundElement.fromJson(json['sound'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "conversationType": conversationType,
        "sender": sender,
        "receivers": receivers,
        "serviceName": serviceName,
        "contentTime": contentTime,
        "content": content,
        "contentType": contentType,
        "image": image,
        "sound": sound,
      };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
