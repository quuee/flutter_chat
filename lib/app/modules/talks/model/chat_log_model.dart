import 'dart:convert';

import 'package:flutter_chat/app/network/model/cmd_type.dart';
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
  @Name('cmd')
  int cmd;

  @Name('currentUserId')
  int currentUserId;
  @Name('senderId')
  int senderId;
  @Name('message')
  String message;
  @Name('messageTime')
  String messageTime;

  ChatLogModel({
    this.logId,
    required this.conversationId,
    required this.cmd,
    required this.currentUserId,
    required this.senderId,
    required this.message,
    required this.messageTime,
  });

  factory ChatLogModel.fromJson(Map<String, dynamic> json) => ChatLogModel(
        logId: json["logId"],
        conversationId: json["conversationId"],
        cmd: json["cmd"],
        currentUserId: json["currentUserId"],
        senderId: json["senderId"],
        message: json["message"],
        messageTime: json["messageTime"],
      );

  Map<String, dynamic> toJson() => {
        "logId": logId,
        "conversationId": conversationId,
        "cmd": cmd,
        "currentUserId": currentUserId,
        "senderId": senderId,
        "message": message,
        "messageTime": messageTime,
      };

  static ChatLogModel convertFromReceiveInfo(
          MessageInfo receiveInfo, int currentUserId, int conversationId) =>
      ChatLogModel(
        conversationId: conversationId,
        cmd: receiveInfo.cmd,
        currentUserId: currentUserId,
        senderId: receiveInfo.sender.userId,
        message: receiveInfo.data,
        messageTime: receiveInfo.messageTime,
      );

  static MessageInfo
      convertToReceiveInfo(ChatLogModel chatLogModel) =>
      MessageInfo(
              cmd: chatLogModel.cmd,
              sender: UserInfo(
                  userId: chatLogModel.senderId == chatLogModel.currentUserId
                      ? chatLogModel.currentUserId
                      : chatLogModel.senderId,
                  terminal: TerminalType.APP),
              receivers:
                  [UserInfo(
                      userId:
                          chatLogModel.senderId == chatLogModel.currentUserId
                              ? chatLogModel.senderId
                              : chatLogModel.currentUserId,
                      terminal: TerminalType.APP)],
              messageTime: chatLogModel.messageTime,
              data: chatLogModel.message, serviceName: '');
}
