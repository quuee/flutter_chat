

import 'package:flutter/material.dart';

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
    return Container(child: Text('Explore'),);
  }


}
