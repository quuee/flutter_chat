
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/date_util.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/core/widget/custom_app_bar.dart';
import 'package:flutter_chat/app/modules/talks/controllers/chat_controller.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:get/get.dart';

/// 进入聊天界面
class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleText: controller.conversation?.conversationName ?? '',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      resizeToAvoidBottomInset: true, //默认是 true
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
          child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppValues.padding),
                child: Obx(() => controller.messageMapListG[
                controller.conversation?.conversationId] !=
                    null
                    ? _buildChatList()
                    : const SizedBox.shrink()),
              ),
            )),

            //keyboard
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const AssetImageView(
                      fileName: 'ic_keyboard.svg',
                    )),
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minHeight: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      controller: controller.textEditingController,
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                      ),
                      onChanged: (value) {
                        controller.sendMessageStr.value = value;
                      },
                    ),
                  ),
                ),
                _buildSendOrAddButton(),
              ],
            )
          ],
        ),
      )),
    );
  }

  _buildSendOrAddButton() {
    return Obx(() => controller.sendMessageStr.value.isNotEmpty
        ? IconButton(
            onPressed: () {
              controller.sendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: AppColors.colorLightGreen,
            ))
        : IconButton(onPressed: () {}, icon: const Icon(Icons.add)));
  }

  _buildChatList() {
    // Scrollable(
    //   controller: controller.scrollController,
    //   axisDirection: AxisDirection.up,
    //   physics: const ScrollPhysics(),
    //   viewportBuilder: (context, position) {
    //     return Viewport(
    //       offset: position,
    //       axisDirection: AxisDirection.up,
    //       slivers: [
    //         SliverList(
    //             delegate: SliverChildBuilderDelegate(
    //                 childCount: controller.messageList.length,
    //                     (context, index) {
    //                   MainAxisAlignment layout = index % 2 == 0
    //                       ? MainAxisAlignment.start
    //                       : MainAxisAlignment.end;
    //
    //                   return Column(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: layout,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Text(controller.messageList[index])
    //                         ],
    //                       ),
    //                     ],
    //                   );
    //                 }))
    //       ],
    //     );
    //   },
    // ),
    return ListView.builder(
      reverse: true,
        controller: controller.scrollController,
        itemCount: controller
                .messageMapListG[controller.conversation?.conversationId]
                ?.length ??
            0,
        // shrinkWrap: true,
        itemBuilder: (c, i) {
          MessageInfo receiveInfo = controller
              .messageMapListG[controller.conversation?.conversationId]!.reversed.elementAt(i);
          MainAxisAlignment layout =
              receiveInfo.sender.userId != controller.currentUser?.userId
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end;

          return Column(
            children: [
              _buildMergeTime(i),
              Row(
                mainAxisAlignment: layout,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CachedNetworkImage(imageUrl: receiveInfo.sender.userId)
                  Text(receiveInfo.data)
                ],
              ),
            ],
          );
        });
  }

  _buildMergeTime(int index) {
    // 短时间内的消息合并为一个时间
    if (index != 0) {
      var time1 = (DateTime.parse(controller
          .messageMapListG[
      controller.conversation?.conversationId]!.elementAt(index).messageTime)
          .millisecondsSinceEpoch ~/
          1000);
      var time2 = (DateTime.parse(controller
          .messageMapListG[
      controller.conversation?.conversationId]!.elementAt(index-1).messageTime)
          .millisecondsSinceEpoch ~/
          1000);
      var timeDiff = time1 - time2 ;
      if (timeDiff < 10 * 30) {
        return const SizedBox();
      }

      String timeNew = controller
          .messageMapListG[
      controller.conversation?.conversationId]![index].messageTime;
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(0x44, 0x66, 0x66, 0x66),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Text(DateUtil.formatTime(timeNew) ?? ""),
      );
    }
    return const SizedBox();
  }
}
