import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/data/remote/group_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/modules/contacts/model/group_model.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {

  final GlobalValueController _globalValueController = Get.find<GlobalValueController>();

  late RxList<GroupModel> groups;

  @override
  void onInit() {
    groups = _globalValueController.groups;
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();

    loadGroups();
  }

  @override
  onClose(){

    super.onClose();
  }

  loadGroups() async {

    ApiResult? result = await GroupApi.groupList(_globalValueController.currentUser!.userId);
    if(result==null){
      return;
    }
    if(result.code == 0){
      List list = result.data as List;
      for (var m in list) {
        GroupModel groupModel = GroupModel.fromJson(m);
        groups.add(groupModel);
      }
    }

  }

  Future<GroupModel?> getGroupMembers(int groupId) async {
    GroupModel? groupModel;
    ApiResult? result = await GroupApi.groupMembers(groupId);
    if(result==null){
      return groupModel;
    }

    if(result.code == 0){
      groupModel = GroupModel.fromJson(result.data);
      // List list = result.data.members as List;
      // for (var m in list) {
      //   ContacterModel contacterModel = ContacterModel.fromJson(m);
      //   members.add(contacterModel);
      // }
    }
    return groupModel;
  }


}
