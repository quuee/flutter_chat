import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item_text.dart';
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
          child = _buildLayout(ChatText(
            content: messageInfo.content,
          ));
        }
        break;
      case MessageType.picture:
        {}
        break;
      case MessageType.voice:
        {}
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
