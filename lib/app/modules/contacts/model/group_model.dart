import 'dart:convert';

import 'contacter_model.dart';

// part 'group_model.g.dart';
// dart run build_runner build

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());


class GroupModel {


  int groupId;

  String groupName;

  String? conversationThumb;

  int ownerId;


  List<ContacterModel>? members;

  GroupModel({
    required this.groupId,
    required this.groupName,
    this.conversationThumb,
    required this.ownerId,
    this.members,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    groupId: int.parse(json["groupId"]),
    groupName: json["groupName"],
    conversationThumb: json["conversationThumb"]??'',
    ownerId: int.parse(json["ownerId"]),
    members: json["members"]!=null?List<ContacterModel>.from(
        json["members"].map((x) => ContacterModel.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "groupAvatarThumb": conversationThumb,
    "ownerId": ownerId,
    "members": members,
  };
}