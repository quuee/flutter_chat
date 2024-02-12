part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;

  static const MAIN = _Paths.MAIN;
  static const CHAT = _Paths.CHAT;
  static const TOCHAT = _Paths.TOCHAT;
  static const CONTACTS = _Paths.CONTACTS;
  static const CONTACT_SIMPLE = _Paths.CONTACT_SIMPLE;

  static const EXPLORE = _Paths.EXPLORE;
  static const ME = _Paths.ME;

}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';

  static const MAIN = '/main';

  static const CHAT = '/chat';
  static const TOCHAT = '/to_chat';

  static const CONTACTS = '/contacts';
  static const CONTACT_SIMPLE = '/contact_simple';

  static const EXPLORE = '/explore';
  static const ME = '/me';


}
