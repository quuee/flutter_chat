
import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';
import '/app/core/widget/custom_app_bar.dart';
import '/app/modules/me/controllers/me_controller.dart';

class MeView extends BaseView<MeController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Me',
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(child: Text('Me'),);
  }

}
