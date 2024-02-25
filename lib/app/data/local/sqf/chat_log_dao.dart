
import 'package:flutter_chat/app/data/local/sqf/sqlite_plus.dart';
import 'package:flutter_chat/app/modules/talks/model/chat_log_model.dart';

class ChatLogDao extends SqlLitePlus{

  static ChatLogDao? _ins;

  ChatLogDao._();

  static ChatLogDao instance() {
    if (_ins == null) {
      print("实例化");
    }
    return _ins ??= ChatLogDao._();
  }


  @override
  String tableName = "chat_log";

  static const String _logId = 'logId';
  static const String conversationId = 'conversationId';
  static const String _groupId = 'groupId';
  static const String _conversationType = 'conversationType';
  static const String _currentUserId = 'currentUserId';
  static const String _senderId = 'senderId';
  static const String _contentType = 'contentType';
  static const String _content = 'content';
  static const String _contentTime = 'contentTime';
  static const String _imageUrl = 'imageUrl';
  static const String _imageLocalPath = 'imageLocalPath';
  static const String _imageWidth = 'imageWidth';
  static const String _imageHeight = 'imageHeight';
  static const String _imageFileSize = 'imageFileSize';
  static const String _sourceUrl = 'sourceUrl';
  static const String _soundLocalPath = 'soundLocalPath';
  static const String _soundDataSize = 'soundDataSize';
  static const String _duration = 'duration';


  //建表函数,当数据库中没有这个表时,基类会触发这个函数
  @override
  onCreate(db, version) async {
    print("创建 $tableName 数据表");
    await db.execute('''
          CREATE TABLE $tableName(
      $_logId INTEGER PRIMARY KEY,
      $conversationId INTEGER,
      $_groupId INTEGER,
      $_conversationType INTEGER,
      $_currentUserId INTEGER,
      $_senderId INTEGER,
      $_contentType INTEGER,
      $_content TEXT,
      $_contentTime TEXT,
      $_imageUrl TEXT,
      $_imageLocalPath TEXT,
      $_imageWidth REAL,
      $_imageHeight REAL,
      $_imageFileSize REAL,
      $_sourceUrl TEXT,
      $_soundLocalPath TEXT,
      $_soundDataSize REAL,
      $_duration REAL
      )
    ''');
  }

  ///当数据库升级时,基类会触发的函数
  @override
  onUpgrade(db, oldVersion, newVersion) {}

  ///当数据库降级,基类会触发的函数
  @override
  onDowngrade(db, oldVersion, newVersion) {}

  ///插入数据
  insertBean(ChatLogModel bean) async{

    // bean 转换下
    Map<String,dynamic> map = bean.toJson();
    if(bean.image !=null){
      Map<String,dynamic> image = bean.image!.toJson();
      map.addAll(image);
    }
    if(bean.sound!=null){
      Map<String,dynamic> sound = bean.sound!.toJson();
      map.addAll(sound);
    }
    map.remove('image');
    map.remove('sound');

    return await database.insert(tableName, map);
  }



  // static ChatLogDao? _instance;
  // static ChatLogDao getInstance() => _instance ??= ChatLogDao();
  //
  // ///插入数据
  // Future<int> insert(ChatLogModel bean) async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //
  //   // bean 转换下
  //   Map<String,dynamic> map = bean.toJson();
  //   if(bean.image !=null){
  //     Map<String,dynamic> image = bean.image!.toJson();
  //     map.addAll(image);
  //   }
  //   if(bean.sound!=null){
  //     Map<String,dynamic> sound = bean.sound!.toJson();
  //     map.addAll(sound);
  //   }
  //
  //   return await db.insert(DBManager.chatLogTable, map);
  // }
  //
  //
  // ///删除数据
  // Future<int> delete(int conversationId) async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //   return await db.delete(DBManager.chatLogTable,where:'${DBManager.conversationId} = ?',whereArgs:[conversationId]);
  // }
  //
  // ///删除全部数据
  // Future<int> deleteAll() async{
  //   Database db = await DBManager.getInstance().getDatabase;
  //   return await db.delete(DBManager.chatLogTable);
  // }
  //
  // ///查询数据
  // Future<List<ChatLogModel>> queryById(int conversationId) async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.chatLogTable, where: '${DBManager.conversationId} = ?', whereArgs: [conversationId]);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ChatLogModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
  //
  //
  // ///查询所有数据
  // Future<List<ChatLogModel>> queryAll() async {
  //   Database db = await DBManager.getInstance().getDatabase;
  //   var result = await db.query(DBManager.chatLogTable);
  //   if (result.isNotEmpty) {
  //     return result.map((e) => ChatLogModel.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }
}
