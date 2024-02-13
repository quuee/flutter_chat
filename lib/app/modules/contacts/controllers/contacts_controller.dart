import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/data/remote/user_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:get/get.dart';

import 'package:lpinyin/lpinyin.dart';

import '/app/core/base/base_controller.dart';

class ContactsController extends BaseController {
  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
  List<String> letters = [
    '↑',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#'
  ];

  List<Map<String, List<ContacterModel>>> contacts = [
    {
      '↑': [
        ContacterModel(
            userId: 0,
            account: '',
            nickname: '新朋友',
            phone: '',
            email: '',
            avatarUrl: 'http://192.168.1.7:9000/images/add_contact.png'),
        ContacterModel(
            userId: 0,
            account: '',
            nickname: '群聊',
            phone: '',
            email: '',
            avatarUrl: 'http://192.168.1.7:9000/images/group_message.png'),
      ],
    },
    {
      'A': [],
    },
    {
      'B': [],
    },
    {
      'C': [],
    },
    {
      'D': [],
    },
    {
      'E': [],
    },
    {
      'F': [],
    },
    {
      'G': [],
    },
    {
      'H': [],
    },
    {
      'I': [],
    },
    {
      'J': [],
    },
    {
      'K': [],
    },
    {
      'L': [],
    },
    {
      'M': [],
    },
    {
      'N': [],
    },
    {
      'O': [],
    },
    {
      'P': [],
    },
    {
      'Q': [],
    },
    {
      'R': [],
    },
    {
      'S': [],
    },
    {
      'T': [],
    },
    {
      'U': [],
    },
    {
      'V': [],
    },
    {
      'W': [],
    },
    {
      'X': [],
    },
    {
      'Y': [],
    },
    {
      'Z': [],
    },
    {
      '#': [],
    }
  ];

  ScrollController contactsScroll = ScrollController();

  RxInt currentIndex = 0.obs;

  @override
  onReady() {
    _loadContacts();
    super.onReady();
  }

  _loadContacts() async {
    var userDOStr = await _preferenceManager.getString(PreferenceManager.userDO);
    var userDO = userDoFromJson(userDOStr);
    ApiResult? loadContacts = await UserApi.loadContacts(userDO.userId);
    List dataList = loadContacts?.data as List;

    for (var element in dataList) {
      ContacterModel contacterModel = ContacterModel.fromJson(element);
      // 提取pinyin首字母
      String p = PinyinHelper.getShortPinyin(contacterModel.nickname)
          .substring(0, 1)
          .toUpperCase();

      for (Map<String, List<ContacterModel>> element in contacts) {
        for (var key in element.keys) {
          if (key == p) {
            element.entries.first.value.add(contacterModel);
          }
        }
      }
    }

    update();

  }
}
