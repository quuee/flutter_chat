
import 'package:isar/isar.dart';
part 'contacter_model.g.dart';
// dart run build_runner build
@collection
class ContacterModel{
  @Name('userId')
  Id userId;
  @Name('account')
  String account;
  @Name('nickname')
  String nickname;
  @Name('phone')
  String phone;
  @Name('email')
  String email;
  @Name('avatarUrl')
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