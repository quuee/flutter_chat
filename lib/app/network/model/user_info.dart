
import 'dart:convert';

List<UserInfo> userInfoFromJson(String str) => List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromJson(x)));

String userInfoToJson(List<UserInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInfo{
  int userId;
  // String nickname;
  // String avatarUrl;
  int terminal;

  UserInfo({required this.userId,
    // required this.nickname,
    // required this.avatarUrl,
    required this.terminal});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userId: json["userId"],
    // nickname: json["nickname"],
    // avatarUrl: json["avatarUrl"],
    terminal: json["terminal"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    // "nickname": nickname,
    // "avatarUrl": avatarUrl,
    "terminal": terminal,
  };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}