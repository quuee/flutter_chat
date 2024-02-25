import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/app/core/date_util.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/core/widget/custom_app_bar.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/modules/talks/controllers/chat_controller.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item.dart';
import 'package:flutter_chat/app/modules/talks/widget/voice_record_btn.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

import 'package:lottie/lottie.dart';

/// 进入聊天界面
class ChatView extends GetView<ChatController> {
  ChatView({super.key});

  ui.Size size = WidgetsBinding
      .instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

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
                controller.textFocusNode.unfocus();
                // controller.leftKeyboardButton.value = false;
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child: _buildVoiceRecordLayout())),
    );
  }

  _buildVoiceRecordLayout() {
    return Stack(
      children: [
        // 聊天界面
        _buildChatView(),
        // 录音界面，按下录音按钮覆盖聊天界面

        Obx(() => Visibility(
            visible: controller.voiceRecordViewShow.value,
            child: Material(
              color: const Color(0xFF000000).withOpacity(0.5),
              child: Stack(
                children: [
                  // 按下后马上显示的录音波纹动画
                  Positioned(
                    top: (size.height / 10) * 4,
                    left: 0,
                    width: size.width,
                    child: _selectedPressAreaAnimationView(),
                  ),
                  // 左侧取消 (选中、未选中)
                  Positioned(
                      top: (size.height / 10) * 6,
                      left: 30,
                      child: _unselectCancelAreaView()),
                  Positioned(
                      top: (size.height / 10) * 6,
                      left: 30,
                      child: _selectCancelAreaView()),
                  // 右侧语音转文字 (未选中 选中 转换中 失败)
                  Positioned(
                      top: (size.height / 10) * 6,
                      right: 30,
                      child: _unselectSound2WordAreaView()),
                  Positioned(
                      top: (size.height / 10) * 6,
                      right: 30,
                      child: _selectSound2WordAreaView()),
                  // 提示文字 松开发送
                  Positioned(
                    top: ((size.height / 10) * 6) + 45,
                    left: 0,
                    width: size.width,
                    child: _selectedPressAreaReleaseText(),
                  ),
                  // 背景
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AssetImageView(fileName: 'voice/ic_voice_record_bg_white.webp',width: size.width,height: 125,fit: BoxFit.fill,),
                  ),
                  // 录音icon
                  Positioned(bottom: 30,width: size.width,child: const Icon(Icons.keyboard_voice,size: 35,)),

                ],
              ),
            )))

      ],
    );
  }

  // 聊天界面
  _buildChatView() {
    return Column(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: Obx(() => controller.messageMapListG[
                        controller.conversation?.conversationId] !=
                    null
                ? _buildChatLogList()
                : const SizedBox.shrink()),
          ),
        )),

        //keyboard
        Row(
          children: [
            _buildChangeKeyboardOrSpeakBtn(),
            Flexible(
              child: Obx(() => !controller.leftKeyboardButton.value
                  ? _buildTextField()
                  : _buildVoiceRecordBtn()),
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
                      crossAxisCount: 4, childAspectRatio: 1),
                  children: [
                    Icon(Icons.add),
                    Icon(Icons.phone),
                    Icon(Icons.voice_chat),
                    IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick multiple images and videos.
                        final List<XFile> medias =
                            await picker.pickMultipleMedia();
                        for (XFile f in medias) {
                          String mimeType = f.mimeType ?? 'image';
                          String path = f.path ?? '';
                          String filename = f.name??'';
                          controller.sendImage(path,filename,mimeType);
                        }
                      },
                      icon: Icon(Icons.photo),
                    ),
                    Icon(Icons.map),
                    Icon(Icons.file_copy),
                    Icon(Icons.attach_money),
                    Icon(Icons.expand_more),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  // 发送消息 或 其他工具
  _buildSendOrAddButton() {
    var sendButton = IconButton(
        onPressed: () {
          controller.sendMessage();
        },
        icon: const Icon(
          Icons.send,
          color: AppColors.colorLightGreen,
        ));
    var toolButton = IconButton(
        onPressed: () {
          if (!controller.keyboardShow.value && controller.toolBtnOff.value) {
            // 当 键盘、工具按钮都隐藏时
            controller.toolBtnOff.value = false; // 显示
          } else if (controller.keyboardShow.value) {
            // 当键盘显示时
            SystemChannels.textInput.invokeMethod('TextInput.hide'); // 隐藏
            controller.keyboardShow.value = false; //隐藏
            controller.textFocusNode.unfocus();
            controller.toolBtnOff.value = false; //显示
          } else {
            if (controller.leftKeyboardButton.value) {
              controller.toolBtnOff.value = true; // 隐藏
              controller.keyboardShow.value = false; // 隐藏
            } else {
              SystemChannels.textInput.invokeMethod('TextInput.show');
              controller.keyboardShow.value = true; // 显示
              controller.toolBtnOff.value = true; // 隐藏
            }
          }
        },
        icon: const Icon(Icons.add));
    return Obx(() =>
        controller.sendMessageStr.value.isNotEmpty ? sendButton : toolButton);
  }

  // 聊天消息列表
  _buildChatLogList() {
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
          MessageInfo messageInfo = controller
              .messageMapListG[controller.conversation?.conversationId]!
              .reversed
              .elementAt(i);

          bool isFromMsg =
              messageInfo.sender.userId != controller.currentUser?.userId;

          ContacterModel? contacter;

          if(isFromMsg){
            // 联系人发来
            // sender = UserDO(userId: controller.conversation.c, account: account, password: password, nickname: nickname, avatarUrl: avatarUrl, phone: phone, email: email, token: token)

            controller.conversation?.contactUsers?.forEach((ContacterModel element) {
              if(element.userId == messageInfo.sender.userId){
                contacter = element;
              }
            });
          }else{
            // 自己发的
            contacter = ContacterModel(userId: controller.currentUser!.userId,
                account: controller.currentUser!.account,
                nickname: controller.currentUser!.nickname,
                phone: controller.currentUser?.phone??'',
                email: controller.currentUser?.email??'',
                avatarUrl: controller.currentUser!.avatarUrl);
          }

          return Column(
            children: [
              _buildMergeTime(i),
              ChatItem(
                sender: contacter!,
                isFromMsg: isFromMsg,
                messageInfo: messageInfo,
              )
            ],
          );
        });
  }

  // 整合时间
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

  // 文字键盘 或 语音切换
  _buildChangeKeyboardOrSpeakBtn() {
    return Obx(() => IconButton(
        onPressed: () {
          if (!controller.keyboardShow.value) {
            // 控制键盘弹起
            controller.keyboardShow.value = true;
            controller.toolBtnOff.value = true;
            controller.leftKeyboardButton.value = false;
            SystemChannels.textInput.invokeMethod('TextInput.show');
            controller.textFocusNode.requestFocus();
          } else {
            controller.keyboardShow.value = false; // 隐藏
            controller.toolBtnOff.value = true; // 隐藏
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            controller.textFocusNode.unfocus();
            controller.leftKeyboardButton.value = true;
          }

        },
        icon: AssetImageView(
          fileName: controller.leftKeyboardButton.value
              ? 'ic_keyboard.svg'
              : 'ic_voice.svg',
        )));
  }

  // 键盘输入框
  _buildTextField() {
    return Container(
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
    );
  }

  // 语音按钮
  _buildVoiceRecordBtn(){

    longPressStart(details){
      controller.voiceRecordViewShow.value = true; // 显示录音界面
      controller.selectedCancelArea.value = false; // 显示未选中
      controller.selectedSound2WordArea.value = false; // 显示未选中

      controller.selectedPressArea.value = true; // 显示动画和提示文字
      //开始录音
      controller.record.start();
    }
    longPressEnd(details) async {
      controller.voiceRecordViewShow.value = false;
      controller.selectedCancelArea.value = true;
      controller.selectedSound2WordArea.value = true;

      controller.selectedPressArea.value = false;

      //停止录音
      await controller.record.stop();

      //发送音频文件
      controller.sendVoice();

      //如果是音频转文字
    }
    longPressMoveUpdate(details){
      Offset global = details.globalPosition;
      controller.selectedCancelArea.value = (global.dy > ((size.height / 10) * 7) && global.dy < ((size.height / 10) * 9)) && global.dx < (size.width / 2);
      controller.selectedSound2WordArea.value = (global.dy > ((size.height / 10) * 7) && global.dy < ((size.height / 10) * 9)) && global.dx >= (size.width / 2);

      // TODO 中断录音
    }
    return VoiceRecordButton(
      onLongPressStart: longPressStart,
      onLongPressEnd: longPressEnd ,
      onLongPressMoveUpdate: longPressMoveUpdate,
    );
  }

  //=====================录音============================

  _selectedPressAreaReleaseText(){
    return Visibility(
      visible: controller.selectedPressArea.value,
      child: const Text(
        '松开发送',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFFBEBEBE),
          fontSize: 14,
        ),
      ),
    );
  }

  _selectedPressAreaAnimationView(){
    return Visibility(
      visible: controller.selectedPressArea.value,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 194,
              height: 95,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 27),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFFFFFFFF),
              ),
              child: Lottie.asset(
                'assets/anim/voice_record.json',
                width: 140,
                height: 35,
                fit: BoxFit.contain,
              ),
            ),
            // 底部小箭头
            ClipPath(
              clipper: _ArrowClipper(),
              child: Container(
                width: 10,
                height: 10,
                color: const Color(0xFFFFFFFF),
              ),
            )
          ],
        ),
      ),
    );
  }

  _unselectCancelAreaView(){
    return Visibility(
      visible: !controller.selectedCancelArea.value,
      child: AssetImageView(fileName: 'voice/ic_voice_record_cancel_grey.webp',width: 80,height: 80,),
    );
  }
  _selectCancelAreaView(){
    return Visibility(
      visible: controller.selectedCancelArea.value,
      child: AssetImageView(fileName: 'voice/ic_voice_record_cancel_white.webp',width: 80,height: 80,),
    );
  }
  _unselectSound2WordAreaView(){
    return Visibility(
      visible: !controller.selectedSound2WordArea.value,
      child: AssetImageView(fileName: 'voice/ic_voice_record_zi_grey.webp',width: 80,height: 80,),
    );
  }
  _selectSound2WordAreaView(){
    return Visibility(
      visible: controller.selectedSound2WordArea.value,
      child: AssetImageView(fileName: 'voice/ic_voice_record_zi_white.webp',width: 80,height: 80,),
    );
  }


}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, -2);
    path.lineTo(size.width, -2);
    path.lineTo(size.width / 2, size.height * 2 / 4);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}