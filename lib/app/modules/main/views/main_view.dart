
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/contacts/views/contacts_view.dart';
import 'package:flutter_chat/app/modules/explore/views/explore_view.dart';
import 'package:flutter_chat/app/modules/me/views/me_view.dart';
import 'package:get/get.dart';

import '/app/modules/main/model/menu_code.dart';
import '/app/modules/talks/views/conversation_view.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/core/base/base_view.dart';
import 'bottom_nav_bar.dart';

class MainView extends BaseView<MainController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(
            () => getPageOnSelectedMenu(controller.selectedMenuCode),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return BottomNavBar(onItemSelected: controller.onMenuSelected);
  }

  final ConversationView chatView = ConversationView();
  ContactsView? contactsView;
  ExploreView? exploreView;
  MeView? meView;

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.CHAT:
        return chatView;
      case MenuCode.CONTACTS:
        contactsView ??= ContactsView();
        return contactsView!;
      case MenuCode.EXPLORE:
        exploreView ??= ExploreView();
        return exploreView!;
      case MenuCode.ME:
        meView ??= MeView();
        return meView!;
      // default:
      //   return OtherView(
      //     viewParam: describeEnum(menuCode),
      //   );
    }
  }
}
