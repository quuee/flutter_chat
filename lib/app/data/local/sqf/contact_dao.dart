//
//
//
// import 'package:flutter_chat/app/data/local/sqf/sqlite_plus.dart';
// import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
//
// class ContactDao extends SqlLitePlus{
//
//   static ContactDao? _ins;
//
//   ContactDao._();
//
//   static ContactDao instance() {
//     if (_ins == null) {
//       print("实例化");
//     }
//     return _ins ??= ContactDao._();
//   }
//
//
//   @override
//   String tableName = "contact";
//
//   static const String userId = 'userId';//primary key
//   static const String _account = 'account';
//   static const String _nickname = 'nickname';
//   static const String _phone = 'phone';
//   static const String _email = 'email';
//   static const String _avatarUrl = 'avatarUrl';
//
//
//   //建表函数,当数据库中没有这个表时,基类会触发这个函数
//   @override
//   onCreate(db, version) async {
//     print("创建 $tableName 数据表");
//     await db.execute('''
//       CREATE TABLE $tableName(
//       $userId INTEGER PRIMARY KEY,
//       $_account TEXT,
//       $_nickname TEXT,
//       $_phone TEXT,
//       $_email TEXT,
//       $_avatarUrl TEXT
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
//
//   Future<List<ContacterModel>> findById(int userId) async {
//     var result = await database.query(tableName,where: '$userId = ?',whereArgs: [userId]);
//       if (result.isNotEmpty) {
//         return result.map((e) => ContacterModel.fromJson(e)).toList();
//       } else {
//         return [];
//       }
//   }
//
//   // static ContactDao? _instance;
//   // static ContactDao getInstance() => _instance ??= ContactDao();
//   //
//   // ///插入数据
//   // Future<int> insert(ContacterModel bean) async{
//   //   Database db = await DBManager.getInstance().getDatabase;
//   //   return await db.insert(DBManager.contactTable, bean.toJson());
//   // }
//   //
//   // ///修改数据
//   // // Future<int> update() async{
//   // //   Database db = await database;
//   // //   await db.update(table, values)
//   // // }
//   //
//   // ///删除数据
//   // Future<int> delete(int userId) async{
//   //   Database db = await DBManager.getInstance().getDatabase;
//   //   return await db.delete(DBManager.contactTable,where:'${DBManager.userId} = ?',whereArgs:[userId]);
//   // }
//   //
//   // ///删除全部数据
//   // Future<int> deleteAll() async{
//   //   Database db = await DBManager.getInstance().getDatabase;
//   //   return await db.delete(DBManager.contactTable);
//   // }
//   //
//   // ///查询数据
//   // Future<List<ContacterModel>> queryById(int userId) async {
//   //   Database db = await DBManager.getInstance().getDatabase;
//   //   var result = await db.query(DBManager.contactTable, where: '${DBManager.userId} = ?', whereArgs: [userId]);
//   //   if (result.isNotEmpty) {
//   //     return result.map((e) => ContacterModel.fromJson(e)).toList();
//   //   } else {
//   //     return [];
//   //   }
//   // }
//   //
//   //
//   // ///查询所有数据
//   // Future<List<ContacterModel>> queryAll() async {
//   //   Database db = await DBManager.getInstance().getDatabase;
//   //   var result = await db.query(DBManager.contactTable);
//   //   if (result.isNotEmpty) {
//   //     return result.map((e) => ContacterModel.fromJson(e)).toList();
//   //   } else {
//   //     return [];
//   //   }
//   // }
// }
