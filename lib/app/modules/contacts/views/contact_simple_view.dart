import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/core/widget/custom_app_bar.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/model/cmd_type.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ContactSimple extends StatelessWidget {
  ContactSimple({super.key});

  @override
  Widget build(BuildContext context) {

    ContacterModel contact = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(appBarTitleText: '',actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],),
      backgroundColor: AppColors.pageBackground,
      body: Column(
        children: [
          // 头像区域
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: Row(
              children: [
                CachedNetworkImage(
                  width: AppValues.iconLargeSize * 3,
                  height: AppValues.iconLargeSize * 3,
                  imageUrl: contact.avatarUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        contact.nickname,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                    ),
                    Text(
                        contact.phone,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(AppValues.padding),
              child: Row(
                children: [
                  const Text('设置备注', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  const SizedBox(width: AppValues.smallPadding),
                  Text(
                    contact.nickname,
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.colorPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  const AssetImageView(
                    fileName: 'arrow_forward.svg',
                    color: AppColors.suffixImageColor,
                    height: AppValues.iconSize_20,
                    width: AppValues.iconSize_20,
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            child: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(AppValues.padding,
                  AppValues.padding_4, AppValues.padding, AppValues.padding_4),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        '设置备注',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      )),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '被修改的abc',
                      style: TextStyle(color: AppColors.colorPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.navigate_next))
                ],
              ),
            ),
            onTap: () {},
          ),

          InkWell(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: AppValues.padding),
              // margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    color: AppColors.colorPrimary,

                    size: 16,
                  ),
                  Text(
                    '发消息',
                    style: TextStyle(color: AppColors.colorPrimary,fontSize: 16),

                  )
                ],
              ),
            ),
            onTap: () {
              var conversation = ConversationModel(
                conversationName: contact.nickname,
                cmd: CmdType.PRIVATE_MESSAGE,
                contactUserIds: [contact.userId],
                avatarUrl: contact.avatarUrl,);
              Get.toNamed(Routes.TOCHAT,arguments: conversation);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: const Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
