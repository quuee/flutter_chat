import 'package:flutter_chat/app/data/local/sqf/sqlite_plus.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';

class ConversationDao extends SqlLitePlus {
  static ConversationDao? _ins;

  ConversationDao._();

  static ConversationDao instance() {
    if (_ins == null) {
      print("实例化");
    }
    return _ins ??= ConversationDao._();
  }

  @override
  String tableName = "conversation";

  static const String conversationId = 'conversationId'; //primary key
  static const String _conversationName = 'conversationName';
  static const String _conversationType = 'conversationType';
  static const String currentUserId = 'currentUserId';
  static const String _conversationThumb = 'conversationThumb';
  static const String _contentType = 'contentType';
  static const String _lastTime = 'lastTime';
  static const String _lastMessage = 'lastMessage';

  //建表函数,当数据库中没有这个表时,基类会触发这个函数
  @override
  onCreate(db, version) async {
    print("创建 $tableName 数据表");
    await db.execute('''
      CREATE TABLE $tableName(
      $conversationId INTEGER PRIMARY KEY,
      $_conversationName TEXT,
      $_conversationType INTEGER,
      $currentUserId INTEGER,
      $_conversationThumb TEXT,
      $_contentType INTEGER,
      $_lastTime TEXT,
      $_lastMessage TEXT
      )
      ''');
  }

  ///当数据库升级时,基类会触发的函数
  @override
  onUpgrade(db, oldVersion, newVersion) {}

  ///当数据库降级,基类会触发的函数
  @override
  onDowngrade(db, oldVersion, newVersion) {}

  ///查询数据
  Future<List<ConversationModel>> queryById(int conversationId) async {
    var result = await database.query(tableName,
        where: '$conversationId = ?', whereArgs: [conversationId]);
    if (result.isNotEmpty) {
      return result.map((e) => ConversationModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  ///插入数据
  insertBean(ConversationModel bean) async{

    // bean 转换下
    Map<String,dynamic> map = bean.toJson();
    map.remove('contactUsers');

    return await database.insert(tableName, map);
  }

  // static ConversationDao? _instance;
  // static ConversationDao getInstance() => _instance ??= ConversationDao();
  //
  // ///插入数据
  // Future<void> insert(ConversationModel bean,int currentUserId) async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //   db.transaction((txn) async{
  //     await db.insert(DBManager.conversationTable, bean.toJson());
  //     bean.contactUsers?.forEach((element) async {
  //       var conversationContactModel = ConversationContactModel(conversationId: bean.conversationId!,contactId: element.userId,currentUserId: currentUserId);
  //       await db.insert(DBManager.conversationContactTable, conversationContactModel.toJson());
  //     });
  //   });
  //
  // }
  //
  //
  // ///删除数据
  // Future<void> delete(int conversationId) async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //
  //   db.transaction((txn) async {
  //     await db.delete(DBManager.conversationTable,where:'${DBManager.conversationId} = ?',whereArgs:[conversationId]);
  //     await db.delete(DBManager.conversationContactTable,where:'${DBManager.conversationId} = ?',whereArgs:[conversationId]);
  //   });
  // }
  //
  // ///删除全部数据
  // Future<int> deleteAll() async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //   return await db.delete(DBManager.conversationTable);
  // }
  //
  // ///查询数据
  // Future<List<ConversationModel>> queryById(int conversationId) async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.conversationTable, where: '${DBManager.conversationId} = ?', whereArgs: [conversationId]);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ConversationModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
  //
  // Future<List<ConversationModel>> queryByCurrentUserId(int currentUserId) async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.conversationTable, where: '${DBManager.currentUserId} = ?', whereArgs: [currentUserId]);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ConversationModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
  //
  //
  // /// =====================会话 联系人======================
  // Future<List<ConversationContactModel>> queryByUserIdContactId(int userId,int contactId) async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.conversationContactTable, distinct: true,where: '${DBManager.userId} = ? AND ${DBManager.contactUserId} = ?', whereArgs: [userId,contactId]);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ConversationContactModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
  //
  // Future<List<ConversationContactModel>> queryByConversationId(int conversationId) async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.conversationContactTable, distinct: true,where: '${DBManager.conversationId} = ?', whereArgs: [conversationId]);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ConversationContactModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
}
