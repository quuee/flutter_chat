

import 'dart:convert';

List<ConversationModel> conversationModelFromJson(String str) => List<ConversationModel>.from(json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationModel {
  int id;
  int concatUserId;
  String contactName;
  String avatarUrl;
  String lastTime;
  String lastMessage;

  ConversationModel({
    required this.id,
    required this.concatUserId,
    required this.contactName,
    required this.avatarUrl,
    required this.lastTime,
    required this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["id"],
    concatUserId: json["concatUserId"],
    contactName: json["contactName"],
    avatarUrl: json["avatarUrl"],
    lastTime: json["lastTime"],
    lastMessage: json["lastMessage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "concatUserId": concatUserId,
    "contactName": contactName,
    "avatarUrl": avatarUrl,
    "lastTime": lastTime,
    "lastMessage": lastMessage,
  };
}
