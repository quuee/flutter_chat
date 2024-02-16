

import 'dart:convert';

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
  @Name('conversationType')
  int conversationType;
  @Name('contactUserId')
  List<int> contactUserIds; // 只要sender不是本人发的都是联系人
  @Name('currentUserId')
  int? currentUserId;
  @Name('avatarUrl')
  String avatarUrl;
  @Name('contentType')
  int? contentType;
  @Name('lastTime')
  String? lastTime;
  @Name('lastMessage')
  String? lastMessage;

  // @Ignore()
  // RxList<ReceiveInfo>? messageList;

  ConversationModel({
    this.conversationId,
    required this.conversationName,
    required this.conversationType,
    required this.contactUserIds,
    this.currentUserId,
    required this.avatarUrl,
    this.contentType,
    this.lastTime,
    this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    conversationId: json["conversationId"],
    conversationName: json["conversationName"],
    conversationType: json["conversationType"],
    contactUserIds: json["contactUserIds"],
    currentUserId: json["currentUserId"],

    avatarUrl: json["avatarUrl"],
    contentType: json["contentType"],
    lastTime: json["lastTime"],
    lastMessage: json["lastMessage"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "conversationName": conversationName,
    "conversationType": conversationType,
    "contactUserIds": contactUserIds,
    "currentUserId": currentUserId,
    "avatarUrl": avatarUrl,
    "contentType": contentType,
    "lastTime": lastTime,
    "lastMessage": lastMessage,
  };
}
