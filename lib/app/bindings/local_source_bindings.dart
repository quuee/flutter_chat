import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/modules/talks/model/chat_log_model.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '/app/data/local/preference/preference_manager.dart';
import '/app/data/local/preference/preference_manager_impl.dart';

class LocalSourceBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );

    // Get.lazyPut<IsarManager>(
    //       () => IsarManager(),
    //   tag: (IsarManager).toString(),
    //   fenix: true,
    // );
    Isar isar = await initIsar();
    Get.put<Isar>(isar,tag: (Isar).toString(),permanent: true);


  }

  initIsar() async {
    final dir = await getExternalStorageDirectory();
    return Isar.open(
      [
        ConversationModelSchema,
        ChatLogModelSchema,
        ContacterModelSchema,
      ],
      directory: dir!.path,
    );
  }

}
