

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/contacts/controllers/group_controller.dart';
import 'package:flutter_chat/app/modules/contacts/widgets/group_item.dart';
import 'package:get/get.dart';

/// 群聊界面 展示群聊列表
class ContactGroupView extends StatelessWidget {
  const ContactGroupView({super.key});

  static final groupController = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('群聊'),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],),
      body: SafeArea(
        child: Obx(() => ListView.builder(
            itemCount: groupController.groups.length,

            itemBuilder: (context,index){

              return GroupItem(groupModel: groupController.groups[index]);
            })),
      ),
    );
  }
}

