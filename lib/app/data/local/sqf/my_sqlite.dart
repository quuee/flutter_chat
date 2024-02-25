

import 'package:flutter_chat/app/data/local/sqf/chat_log_dao.dart';
import 'package:flutter_chat/app/data/local/sqf/contact_dao.dart';
import 'package:flutter_chat/app/data/local/sqf/conversation_contact_dao.dart';
import 'package:flutter_chat/app/data/local/sqf/conversation_dao.dart';

class MySqlite {
  static forFeature() async {
    var list = [
      ChatLogDao.instance(),
      ContactDao.instance(),
      ConversationDao.instance(),
      ConversationContactDao.instance(),
      //...其他的表实体类
    ];
    for (int i = 0; i < list.length; i++) {
      var entity = list[i];

      //是否还记得基类中定义的 exists 字段,这是用来判断表是否创建完成
      while (!entity.exists) {
        //等待数据表创建完成
        await Future.delayed(const Duration(milliseconds: 60), () {});
      }
    }
  }
}

