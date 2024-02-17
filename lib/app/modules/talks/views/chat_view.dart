import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/app/core/date_util.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/core/widget/custom_app_bar.dart';
import 'package:flutter_chat/app/modules/talks/controllers/chat_controller.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
          controller.keyboardShow.value = false;
          controller.toolBtnOff.value = true;
          SystemChannels.textInput.invokeMethod('TextInput.hide');
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
                _buildChangeKeyboardOrSpeakBtn(),
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
                      focusNode: controller.textFocusNode,
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
            ),

            // 隐藏的工具栏
            Obx(() => Offstage(
              offstage: controller.toolBtnOff.value, // true隐藏
              child: SizedBox(
                height: 200,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1
                  ),
                  children: [
                    Icon(Icons.add),
                    Icon(Icons.phone),
                    Icon(Icons.voice_chat),
                    IconButton(onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick multiple images and videos.
                      final List<XFile> medias = await picker.pickMultipleMedia();
                      for (XFile f in medias) {
                        String mimeType = f.mimeType??'';
                        String path = f.path??'';
                      }},
                      icon: Icon(Icons.photo),),
                    Icon(Icons.map),
                    Icon(Icons.file_copy),
                    Icon(Icons.attach_money),
                    Icon(Icons.expand_more),
                  ],
                ),
              ),
            ))

          ],
        ),
      )),
    );
  }

  _buildSendOrAddButton() {
    var sendButton = IconButton(
        onPressed: () {
          controller.sendMessage();
        },
        icon: const Icon(
          Icons.send,
          color: AppColors.colorLightGreen,
        ));
    var toolButton = IconButton(onPressed: () {
      if(!controller.keyboardShow.value && controller.toolBtnOff.value){
        controller.toolBtnOff.value = false;
      }else if(controller.keyboardShow.value){
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        controller.keyboardShow.value = false; //隐藏
        controller.textFocusNode.unfocus();
        controller.toolBtnOff.value = false; //显示
      }else{
        SystemChannels.textInput.invokeMethod('TextInput.show');
        controller.keyboardShow.value = true; // 显示
        controller.toolBtnOff.value = true; // 隐藏
      }
    }, icon: const Icon(Icons.add));
    return Obx(() =>
        controller.sendMessageStr.value.isNotEmpty ? sendButton : toolButton);
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
              .messageMapListG[controller.conversation?.conversationId]!
              .reversed
              .elementAt(i);
          // MainAxisAlignment layout =
          //     receiveInfo.sender.userId != controller.currentUser?.userId
          //         ? MainAxisAlignment.start
          //         : MainAxisAlignment.end;
          bool isFromMsg = receiveInfo.sender.userId != controller.currentUser?.userId;
          return Column(
            children: [
              _buildMergeTime(i),
              ChatItem(isFromMsg: isFromMsg,messageInfo: receiveInfo,)
            ],
          );
        });
  }

  _buildMergeTime(int index) {
    // 短时间内的消息合并为一个时间
    if (index != 0) {
      var time1 = (DateTime.parse(controller
                  .messageMapListG[controller.conversation?.conversationId]!
                  .elementAt(index)
                  .contentTime)
              .millisecondsSinceEpoch ~/
          1000);
      var time2 = (DateTime.parse(controller
                  .messageMapListG[controller.conversation?.conversationId]!
                  .elementAt(index - 1)
                  .contentTime)
              .millisecondsSinceEpoch ~/
          1000);
      var timeDiff = time1 - time2;
      if (timeDiff < 10 * 30) {
        return const SizedBox();
      }

      String timeNew = controller
          .messageMapListG[controller.conversation?.conversationId]![index]
          .contentTime;
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

  _buildChangeKeyboardOrSpeakBtn() {
    return Obx(() => IconButton(
        onPressed: () {
          if (!controller.keyboardShow.value) {
            // 控制键盘弹起
            controller.keyboardShow.value = true;
            controller.toolBtnOff.value = true;
            SystemChannels.textInput.invokeMethod('TextInput.show');
          } else {
            controller.keyboardShow.value = false; // 隐藏
            controller.toolBtnOff.value = true; // 隐藏
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            controller.textFocusNode.unfocus();
          }
          controller.leftKeyboardButton.value =
              !controller.leftKeyboardButton.value;
        },
        icon: AssetImageView(
          fileName: controller.leftKeyboardButton.value
              ? 'ic_keyboard.svg'
              : 'ic_voice.svg',
        )));
  }


}
