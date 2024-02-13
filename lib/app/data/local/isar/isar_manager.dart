//
// import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
//
// class IsarManager {
//
//   static final IsarManager _instance = IsarManager._internal();
//   static IsarManager get instance => _instance;
//
//   factory IsarManager() {
//     return _instance;
//   }
//   IsarManager._internal(){
//     // init();
//   }
//
//   late final Isar isarInstance;
//
//   init() async {
//     final dir = await getApplicationDocumentsDirectory();
//     isarInstance = await Isar.open(
//       [
//         ConversationModelSchema,
//
//       ],
//       directory: dir.path,
//     );
//   }
// }