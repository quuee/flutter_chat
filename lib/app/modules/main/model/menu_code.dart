import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'menu_item.dart';

enum MenuCode { CHAT, CONTACTS, EXPLORE, ME }

extension MenuCodeExtensions on MenuCode {
  BottomNavItem toBottomNavItem(AppLocalizations appLocalization) {
    switch (this) {
      case MenuCode.CHAT:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavChat,
          iconSvgName: "ic_chat.svg",
          menuCode: MenuCode.CHAT,
        );
      case MenuCode.CONTACTS:
        return BottomNavItem(
            navTitle: appLocalization.bottomNavContacts,
            iconSvgName: "ic_contacts.svg",
            menuCode: MenuCode.CONTACTS);
      case MenuCode.EXPLORE:
        return BottomNavItem(
            navTitle: appLocalization.bottomNavExplore,
            iconSvgName: "ic_explore.svg",
            menuCode: MenuCode.EXPLORE);
      case MenuCode.ME:
        return BottomNavItem(
          navTitle: appLocalization.bottomNavMe,
          iconSvgName: "ic_me.svg",
          menuCode: MenuCode.ME);
    }
  }
}
