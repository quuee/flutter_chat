
import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class ConversationController extends BaseController {


  final GlobalValueController _globalValueController = Get.find<GlobalValueController>();

  UserDO? get currentUser => _globalValueController.currentUser;
  // 会话对象
  List<ConversationModel> get conversationList => _globalValueController.conversationList;



  @override
  onInit(){

    super.onInit();
  }

  @override
  onReady(){

    // 页面加载完成后执行
    super.onReady();
  }



  onRefreshPage() {
    // loadConversations();
  }


  deleteConversation(int conversationId){
    _globalValueController.deleteConversation(conversationId);
  }
}