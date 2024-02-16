import 'dart:convert';

import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/user_info.dart';
import 'package:isar/isar.dart';

part 'chat_log_model.g.dart';
// dart run build_runner build

ChatLogModel chatLogModelFromJson(String str) =>
    ChatLogModel.fromJson(json.decode(str));

String chatLogModelToJson(ChatLogModel data) => json.encode(data.toJson());

@collection
class ChatLogModel {
  @Name('logId')
  Id? logId = Isar.autoIncrement;
  // 会话id
  @Name('conversationId')
  int conversationId;
  @Name('conversationType')
  int conversationType;
  @Name('currentUserId')
  int currentUserId;
  @Name('senderId')
  int senderId;
  @Name('contentType')
  int contentType;
  @Name('content')
  String content;
  @Name('contentTime')
  String contentTime;
  @Name('imagePath')
  String? imagePath;
  @Name('soundPath')
  String? soundPath;

  ChatLogModel({
    this.logId,
    required this.conversationId,
    required this.conversationType,
    required this.currentUserId,
    required this.senderId,
    required this.content,
    required this.contentTime,
    required this.contentType,
    this.imagePath,
    this.soundPath,
  });

  factory ChatLogModel.fromJson(Map<String, dynamic> json) => ChatLogModel(
        logId: json["logId"],
        conversationId: json["conversationId"],
        conversationType: json["conversationType"],
        currentUserId: json["currentUserId"],
        senderId: json["senderId"],
        content: json["content"],
        contentTime: json["contentTime"],
        contentType: json["contentType"],
        imagePath: json["imagePath"],
        soundPath: json["soundPath"],
      );

  Map<String, dynamic> toJson() => {
        "logId": logId,
        "conversationId": conversationId,
        "conversationType": conversationType,
        "currentUserId": currentUserId,
        "senderId": senderId,
        "content": content,
        "contentTime": contentTime,
        "contentType": contentType,
        "imagePath": imagePath,
        "soundPath": soundPath,
      };

  static ChatLogModel convertFromReceiveInfo(
          MessageInfo receiveInfo, int currentUserId, int conversationId) =>
      ChatLogModel(
        conversationId: conversationId,
        conversationType: receiveInfo.conversationType,
        currentUserId: currentUserId,
        senderId: receiveInfo.sender.userId,
        content: receiveInfo.content,
        contentTime: receiveInfo.contentTime,
        contentType: receiveInfo.contentType,
        imagePath: receiveInfo.image?.image,
        soundPath: receiveInfo.sound?.soundPath,
      );

  static MessageInfo convertToReceiveInfo(ChatLogModel chatLogModel) =>
      MessageInfo(
          conversationType: chatLogModel.conversationType,
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
          contentType: chatLogModel.contentType);
}
