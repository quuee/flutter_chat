import 'package:flutter/material.dart';

import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/core/widget/custom_app_bar.dart';
import 'package:flutter_chat/app/model/receive_info.dart';
import 'package:flutter_chat/app/modules/talks/controllers/chat_controller.dart';
import 'package:get/get.dart';

/// 进入聊天界面
class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleText: controller.contacter!.nickname,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
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
                child: Obx(() => _buildChatList()),
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
        controller: controller.scrollController,
        itemCount: controller.messageList.length,
        // shrinkWrap: true,
        itemBuilder: (c, i) {
          ReceiveInfo receiveInfo = controller.messageList[i];
          MainAxisAlignment layout =
          receiveInfo.sender.userId != controller.userDO?.userId ? MainAxisAlignment.start : MainAxisAlignment.end;

          return Column(
            children: [
              Row(
                mainAxisAlignment: layout,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text(receiveInfo.data)],
              ),
            ],
          );
        });
  }
}
