

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/talks/widget/chat_item_voice.dart';

import '/app/core/base/base_view.dart';
import '/app/core/widget/custom_app_bar.dart';
import '/app/modules/explore/controllers/explore_controller.dart';

class ExploreView extends BaseView<ExploreController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Explore',
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: ChatItemVoice(soundUrl: 'http://192.168.1.7:9000/voices/1708330576678_1708330574539.m4a',),
    );
  }


}
