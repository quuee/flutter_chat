
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/modules/contacts/controllers/group_controller.dart';
import 'package:flutter_chat/app/modules/contacts/model/group_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class GroupItem extends StatelessWidget {
  GroupItem({super.key,required this.groupModel});


  GroupModel groupModel;

  static final GroupController groupController = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.blueGrey),
          ),
        ),
        height: 45,
        child: Padding(
          padding: const EdgeInsets.only(left: AppValues.padding_4),
          child: Row(
            children: [
              CachedNetworkImage(
                  imageUrl: groupModel.conversationThumb??'',
                  width: AppValues.iconDefaultSize *2,
                  height: AppValues.iconDefaultSize *2,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
              Text(groupModel.groupName)
            ],
          ),
        ),
      ),
      onTap: () async {

        // 查询成员信息
        GroupModel? group = await groupController.getGroupMembers(groupModel.groupId);
        // 将group信息赋值给会话
        ConversationModel conversationModel = ConversationModel(
          conversationId: groupModel.groupId,
            conversationName:groupModel.groupName,
            conversationType:ConversationType.GROUP_MESSAGE,
          contactUsers: group?.members,
          // currentUserId: ,
            conversationThumb:groupModel.conversationThumb??'',
            // contentType:,
          // lastTime: ,
          // lastMessage:

        );
        // 打开聊天界面
        Get.toNamed(Routes.TOCHAT,arguments: conversationModel);
      },
    );
  }
}
