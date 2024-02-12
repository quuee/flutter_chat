import 'package:flutter/material.dart';

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
    return Container(child: Text('chat'),);
  }



}
