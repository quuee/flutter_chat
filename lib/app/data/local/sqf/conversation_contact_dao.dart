//
// import 'package:flutter_chat/app/data/local/sqf/sqlite_plus.dart';
//
// class ConversationContactDao extends SqlLitePlus{
//   static ConversationContactDao? _ins;
//
//   ConversationContactDao._();
//
//   static ConversationContactDao instance() {
//     if (_ins == null) {
//       print("实例化");
//     }
//     return _ins ??= ConversationContactDao._();
//   }
//
//
//   @override
//   String tableName = "conversation_contact";
//
//   static const String conversationId = 'conversationId';
//   static const String contactUserId = 'contactUserId';
//   static const String currentUserId = 'currentUserId';//冗余字段 方便查询
//
//
//   //建表函数,当数据库中没有这个表时,基类会触发这个函数
//   @override
//   onCreate(db, version) async {
//     print("创建 $tableName 数据表");
//     await db.execute('''
//       CREATE TABLE $tableName(
//       $conversationId INTEGER,
//       $contactUserId INTEGER,
//       $currentUserId INTEGER
//       )
//       ''');
//   }
//
//   ///当数据库升级时,基类会触发的函数
//   @override
//   onUpgrade(db, oldVersion, newVersion) {}
//
//   ///当数据库降级,基类会触发的函数
//   @override
//   onDowngrade(db, oldVersion, newVersion) {}
// }