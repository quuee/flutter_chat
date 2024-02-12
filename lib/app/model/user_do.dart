import 'dart:convert';

UserDO userDoFromJson(String str) => UserDO.fromJson(json.decode(str));

String userDoToJson(UserDO data) => json.encode(data.toJson());

class UserDO {
  int userId;
  String account;
  String password;
  String nickname;
  String avatarUrl;
  String phone;
  String email;
  String token;

  UserDO({
    required this.userId,
    required this.account,
    required this.password,
    required this.nickname,
    required this.avatarUrl,
    required this.phone,
    required this.email,
    required this.token,
  });

  factory UserDO.fromJson(Map<String, dynamic> json) => UserDO(
    userId: json["userId"].runtimeType == String?int.parse(json["userId"]):json["userId"],
    account: json["account"],
    password: json["password"],
    nickname: json["nickname"],
    avatarUrl: json["avatarUrl"]??'',
    phone: json["phone"]??'',
    email: json["email"]??'',
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "account": account,
    "password": password,
    "nickname": nickname,
    "avatarUrl": avatarUrl,
    "phone": phone,
    "email": email,
    "token": token,
  };

  String toJsonString(){
    return jsonEncode(toJson());
  }
}