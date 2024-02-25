
import 'dart:convert';


// part 'contacter_model.g.dart';
// dart run build_runner build

ContacterModel contacterFromJson(String str) => ContacterModel.fromJson(json.decode(str));

String contacterToJson(ContacterModel data) => json.encode(data.toJson());


class ContacterModel{

  int userId;

  String account;

  String nickname;

  String phone;

  String email;

  String avatarUrl;

  ContacterModel({
    required this.userId,
    required this.account,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.avatarUrl,
});

  factory ContacterModel.fromJson(Map<String, dynamic> json) => ContacterModel(
    userId: json["userId"],
    account: json["account"],
    nickname: json["nickname"],
    avatarUrl: json["avatarUrl"]??'',
    phone: json["phone"]??'',
    email: json["email"]??'',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "account": account,
    "nickname": nickname,
    "avatarUrl": avatarUrl,
    "phone": phone,
    "email": email,
  };

  String toJsonString(){
    return jsonEncode(toJson());
  }
}