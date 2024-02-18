import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item_image.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item_text.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item_voice.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key, required this.messageInfo, required this.isFromMsg});

  final MessageInfo messageInfo;

  final bool isFromMsg;

  MainAxisAlignment get layoutAlignment =>
      isFromMsg ? MainAxisAlignment.start : MainAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (messageInfo.contentType) {
      case MessageType.text:
        {
          child = _buildLayout(ChatTextView(
            content: messageInfo.content,
          ));
        }
        break;
      case MessageType.picture:
        {
          child = _buildLayout(ChatImageView(imageElement: messageInfo.image!));
        }
        break;
      case MessageType.voice:
        {
          child = _buildLayout(ChatItemVoice(
            soundLocalPath: messageInfo.sound?.soundLocalPath,
            soundUrl: messageInfo.sound?.sourceUrl,
            duration: messageInfo.sound?.duration,
          ));
        }
        break;
    }
    return child;
  }

  _buildLayout(Widget widget) {
    return Row(
      mainAxisAlignment: layoutAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 消息发送中。。。CircularProgressIndicator
        // 消息发送成功||失败

        // 消息体
        widget,
      ],
    );
  }
}
