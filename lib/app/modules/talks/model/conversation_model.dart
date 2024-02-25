

import 'dart:convert';

import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';

// part 'conversation_model.g.dart';
// dart run build_runner build

List<ConversationModel> conversationModelFromJson(String str) => List<ConversationModel>.from(json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ConversationModel {


  int? conversationId;

  String conversationName; // 群聊名 或 联系人名

  int conversationType;

  // List<int> contactUserIds;

  int? currentUserId;

  String conversationThumb;

  int? contentType;

  String? lastTime;

  String? lastMessage;

  //只要sender不是本人发的都是联系人发的，在群里，联系人可能不是朋友
  List<ContacterModel>? contactUsers;

  ConversationModel({
    this.conversationId,
    required this.conversationName,
    required this.conversationType,
    // required this.contactUserIds,
    this.currentUserId,
    required this.conversationThumb,
    this.contentType,
    this.lastTime,
    this.lastMessage,
    this.contactUsers,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    conversationId: json["conversationId"],
    conversationName: json["conversationName"],
    conversationType: json["conversationType"],
    // contactUserIds: json["contactUserIds"],
    currentUserId: json["currentUserId"],
    conversationThumb: json["conversationThumb"],
    contentType: json["contentType"],
    lastTime: json["lastTime"],
    lastMessage: json["lastMessage"],
    contactUsers: json["contactUsers"]==null?[]:List<ContacterModel>.from(
        json["contactUsers"].map((x) => ContacterModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "conversationName": conversationName,
    "conversationType": conversationType,
    // "contactUserIds": contactUserIds,
    "contactUsers": contactUsers,
    "currentUserId": currentUserId,
    "conversationThumb": conversationThumb,
    "contentType": contentType,
    "lastTime": lastTime,
    "lastMessage": lastMessage,
  };
}
