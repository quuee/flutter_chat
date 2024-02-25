import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import '/app/core/base/base_controller.dart';

class ContactsController extends BaseController {

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
  final GlobalValueController _globalValueController = Get.find<GlobalValueController>();

  @override
  onReady() {
    _convertContacts();
    super.onReady();
  }

  @override
  onClose(){

  }

  _convertContacts() async {

    for (ContacterModel element in _globalValueController.contactList) {
      // 提取pinyin首字母
      String p = PinyinHelper.getShortPinyin(element.nickname)
          .substring(0, 1)
          .toUpperCase();
      for (Map<String, List<ContacterModel>> mm in contacts) {
        for (var key in mm.keys) {
          if (key == p) {
            mm.entries.first.value.add(element);
          }
        }
      }
    }

    update();

  }
}
