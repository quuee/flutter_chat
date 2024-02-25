import 'dart:convert';

ConversationContactModel conversationModelFromJson(String str) => ConversationContactModel.fromJson(json.decode(str));

String conversationModelToJson(ConversationContactModel data) => json.encode(data.toJson());

class ConversationContactModel {
  int conversationId;
  int contactUserId;
  int currentUserId;

  ConversationContactModel({
    required this.conversationId,
    required this.contactUserId,
    required this.currentUserId,
  });

  factory ConversationContactModel.fromJson(Map<String, dynamic> json) => ConversationContactModel(
    conversationId: json["conversationId"],
    contactUserId: json["contactUserId"],
    currentUserId: json["currentUserId"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "contactUserId": contactUserId,
    "currentUserId": currentUserId,
  };
}