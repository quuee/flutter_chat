

import 'dart:convert';

import 'package:flutter_chat/app/model/receive_info.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

part 'conversation_model.g.dart';
//dart run build_runner build

List<ConversationModel> conversationModelFromJson(String str) => List<ConversationModel>.from(json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class ConversationModel {

  @Name('conversationId')
  Id? conversationId;
  @Name('conversationName')
  String conversationName; // 群聊名 或 联系人名
  @Name('cmd')
  int cmd;
  @Name('contactUserId')
  List<int> contactUserIds; // 只要sender不是本人发的都是联系人
  @Name('currentUserId')
  int? currentUserId;
  @Name('avatarUrl')
  String avatarUrl;
  @Name('lastTime')
  String? lastTime;
  @Name('lastMessage')
  String? lastMessage;

  // @Ignore()
  // RxList<ReceiveInfo>? messageList;

  ConversationModel({
    this.conversationId,
    required this.conversationName,
    required this.cmd,
    required this.contactUserIds,
    this.currentUserId,
    required this.avatarUrl,
    this.lastTime,
    this.lastMessage,
    // this.messageList,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    conversationId: json["conversationId"],
    conversationName: json["conversationName"],
    cmd: json["cmd"],
    contactUserIds: json["contactUserIds"],
    currentUserId: json["currentUserId"],

    avatarUrl: json["avatarUrl"],
    lastTime: json["lastTime"],
    lastMessage: json["lastMessage"],
    // messageList: json["messageList"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "conversationName": conversationName,
    "cmd": cmd,
    "contactUserIds": contactUserIds,
    "currentUserId": currentUserId,
    "avatarUrl": avatarUrl,
    "lastTime": lastTime,
    "lastMessage": lastMessage,
    // "messageList": messageList,
  };
}
