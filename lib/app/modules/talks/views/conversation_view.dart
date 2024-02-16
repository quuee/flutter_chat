import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/date_util.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/paging_view.dart';
import 'package:flutter_chat/app/core/widget/popup_window.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '/app/core/widget/custom_app_bar.dart';
import '/app/modules/talks/controllers/conversation_controller.dart';
import '/app/core/base/base_view.dart';

/// 会话界面
class ConversationView extends BaseView<ConversationController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Chat',
    );
  }

  @override
  Widget body(BuildContext context) {
    return PagingView(
      onRefresh: () async {
        controller.onRefreshPage();
      },
      onLoadNextPage: () {
        // controller.onLoadNextPage();
      },
      child: Obx(() => controller.conversationList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: controller.conversationList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildConversationItem(
                    controller.conversationList[index]);
              })
          : const SizedBox.shrink()),
    );
  }

  _buildConversationItem(ConversationModel conversation) {
    // Slidable 插件功能更丰富
    // return Dismissible(
    //   key: Key(conversation.conversationId.toString()),
    //   direction: DismissDirection.endToStart,
    //   background: Container(
    //     color: Colors.redAccent,
    //     alignment: Alignment.centerRight,
    //     child: const Icon(Icons.delete),
    //   ),
    //   child: SizedBox(
    //     height: AppValues.iconLargeSize * 2,
    //     child: ListTile(
    //       leading: CachedNetworkImage(
    //           width: AppValues.iconLargeSize * 2,
    //           height: AppValues.iconLargeSize * 2,
    //           imageUrl: conversation.avatarUrl),
    //       title: Text(conversation.conversationName),
    //       subtitle: Text(conversation.lastMessage ?? '',maxLines: 1,overflow: TextOverflow.ellipsis,),
    //       trailing: Text(DateUtil.formatTime(conversation.lastTime) ?? ''),
    //       onTap: (){
    //         Get.toNamed(Routes.TOCHAT, arguments: conversation);
    //       },
    //       onLongPress: (){},
    //     )
    //   ),
    //   onDismissed: (direction) {
    //     controller.deleteConversation(conversation.conversationId!);
    //   },
    // );

    return GestureDetector(
      child: SizedBox(
          height: AppValues.iconLargeSize * 2,
          child: ListTile(
            leading: CachedNetworkImage(
                width: AppValues.iconLargeSize * 2,
                height: AppValues.iconLargeSize * 2,
                imageUrl: conversation.avatarUrl),
            title: Text(conversation.conversationName),
            subtitle: Text(conversation.lastMessage ?? '',maxLines: 1,overflow: TextOverflow.ellipsis,),
            trailing: Text(DateUtil.formatTime(conversation.lastTime) ?? ''),
            onTap: (){
              Get.toNamed(Routes.TOCHAT, arguments: conversation);
            },
          )
      ),
      onLongPressStart: (LongPressStartDetails details){
        logger.d('details.globalPosition: ${details.globalPosition.dx},${details.globalPosition.dy}');
        PopupWindow.create(key: globalKey,dx: details.globalPosition.dx,dy:details.globalPosition.dy);

      },
    );

  }

}
