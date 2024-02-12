
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
    userId: int.parse(json["userId"]),
    account: json["account"],
    nickname: json["nickname"],
    avatarUrl: json["avatarUrl"]??'',
    phone: json["phone"]??'',
    email: json["email"]??'',
  );

}