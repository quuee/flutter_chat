import 'dart:convert';

import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/image_element.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/sound_element.dart';
import 'package:flutter_chat/app/network/model/user_info.dart';


// part 'chat_log_model.g.dart';
// dart run build_runner build

ChatLogModel chatLogModelFromJson(String str) =>
    ChatLogModel.fromJson(json.decode(str));

String chatLogModelToJson(ChatLogModel data) => json.encode(data.toJson());


class ChatLogModel {

  int logId;
  // 会话id
  int conversationId;
  // 群组id
  int groupId;

  int conversationType;

  int currentUserId;

  int senderId;

  int contentType;

  String content;

  String contentTime;

  ImageElement? image;

  SoundElement? sound;

  ChatLogModel({
    required this.logId,
    required this.conversationId,
    required this.groupId,
    required this.conversationType,
    required this.currentUserId,
    required this.senderId,
    required this.content,
    required this.contentTime,
    required this.contentType,
    this.image,
    this.sound,
  });

  factory ChatLogModel.fromJson(Map<String, dynamic> json) => ChatLogModel(
        logId: json["logId"],
        conversationId: json["conversationId"],
    groupId: json["groupId"],
        conversationType: json["conversationType"],
        currentUserId: json["currentUserId"],
        senderId: json["senderId"],
        content: json["content"],
        contentTime: json["contentTime"],
        contentType: json["contentType"],
    image: ImageElement.fromJson(json['image'] ?? {}),
    sound: SoundElement.fromJson(json['sound'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "logId": logId,
        "conversationId": conversationId,
        "groupId": groupId,
        "conversationType": conversationType,
        "currentUserId": currentUserId,
        "senderId": senderId,
        "content": content,
        "contentTime": contentTime,
        "contentType": contentType,
        "image": image,
        "sound": sound,
      };

  static ChatLogModel convertFromMessageInfo(
          MessageInfo messageInfo, int currentUserId, int conversationId) =>
      ChatLogModel(
        logId: DateTime.now().millisecondsSinceEpoch,
        conversationId: conversationId,
        groupId: messageInfo.groupId,
        conversationType: messageInfo.conversationType,
        currentUserId: currentUserId,
        senderId: messageInfo.sender.userId,
        content: messageInfo.content,
        contentTime: messageInfo.contentTime,
        contentType: messageInfo.contentType,
        image: messageInfo.image,
        sound: messageInfo.sound,
      );

  static MessageInfo convertToMessageInfo(ChatLogModel chatLogModel) =>
      MessageInfo(
          conversationType: chatLogModel.conversationType,
          groupId: chatLogModel.groupId,
          sender: UserInfo(
              userId: chatLogModel.senderId == chatLogModel.currentUserId
                  ? chatLogModel.currentUserId
                  : chatLogModel.senderId,
              terminal: TerminalType.APP),
          receivers: [
            UserInfo(
                userId: chatLogModel.senderId == chatLogModel.currentUserId
                    ? chatLogModel.senderId
                    : chatLogModel.currentUserId,
                terminal: TerminalType.APP)
          ],
          contentTime: chatLogModel.contentTime,
          content: chatLogModel.content,
          serviceName: '',
          contentType: chatLogModel.contentType,
      image: chatLogModel.image,
      sound: chatLogModel.sound);
}
