
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/voice_record.dart';
import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/data/remote/file_upload_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/network/model/conversation_type.dart';
import 'package:flutter_chat/app/network/model/image_element.dart';
import 'package:flutter_chat/app/network/model/message_info.dart';
import 'package:flutter_chat/app/network/model/message_type.dart';
import 'package:flutter_chat/app/network/model/message_wrapper.dart';
import 'package:flutter_chat/app/network/model/sound_element.dart';
import 'package:flutter_chat/app/network/model/user_info.dart';
import 'package:flutter_chat/app/modules/talks/model/conversation_model.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  // final Isar _isar = Get.find(tag: (Isar).toString());

  ScrollController scrollController = ScrollController();

  TextEditingController textEditingController = TextEditingController();

  RxString sendMessageStr = ''.obs;

  final WebSocketProvider webSocketProvider = Get.find<WebSocketProvider>();

  ConversationModel? conversation;

  final GlobalValueController _globalValueController =
      Get.find<GlobalValueController>();

  UserDO? get currentUser =>
      _globalValueController.currentUser;

  RxMap<int, RxList<MessageInfo>> get messageMapListG =>
      _globalValueController.messageMapList;

  /// ==============控制键盘显示隐藏参数=============== ///
  RxBool leftKeyboardButton = true.obs; // 切换语言按钮 true键盘 false语音
  RxBool keyboardShow = false.obs; // 键盘是否弹起状态
  RxBool toolBtnOff = true.obs; // 工具按钮 true隐藏，false显示
  FocusNode textFocusNode = FocusNode(); // 输入框焦点
  /// ==============控制键盘显示隐藏参数=============== ///

  /// =============控制录音界面显示隐藏参数=============== ///
  RxBool voiceRecordViewShow = false.obs; // 录音界面展示与否

  RxBool selectedCancelArea = false.obs; // 取消区域是否选中
  RxBool selectedSound2WordArea = false.obs; // 取消区域是否选中
  RxBool selectedPressArea = false.obs;// 按下后 开始录音，改变录音背景，出现录音动画，出现释放发送提示文字

  late VoiceRecord record;
  String? _voicePath;
  int _voiceDuration = 0;
  int _voiceFileSize = 0;
  /// =============控制录音界面显示隐藏参数=============== ///

  @override
  void onInit() {
    // _messageListen();
    conversation = Get.arguments;
    record = VoiceRecord(passParamsCallback);
    _getChatLog();
    inputListener();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 自己的最后一条信息，不能传递到会话界面（使会话界面总展示最新的消息）
    // 点进去不做任何操作退出来 没有一条信息
    if (messageMapListG[conversation?.conversationId]!.isNotEmpty) {
      conversation?.lastMessage =
          messageMapListG[conversation?.conversationId]!.last.content;
      conversation?.lastTime = DateTime.now().toString();
      conversation?.currentUserId = currentUser!.userId;

      _globalValueController.isarSaveConversation(conversation!);
    }

    super.onClose();
  }

  /// 向上传递参数
  passParamsCallback(int voiceDuration, String path, int fileSize){
    _voiceDuration = voiceDuration;
    _voicePath = path;
    _voiceFileSize = fileSize;
  }

  inputListener(){
    textFocusNode.addListener(() {
      if(textFocusNode.hasFocus){
        logger.i('textFocusNode.addListener:${toolBtnOff.value}');
        toolBtnOff.value = true;//隐藏
        keyboardShow.value = true; //显示
        if(keyboardShow.value){
          leftKeyboardButton.value = false; //显示语音
        }else{

        }

      }else{
        keyboardShow.value = false; // 键盘隐藏
        // leftKeyboardButton.value = true;
      }

    });
  }


  _getChatLog() async {
    conversation = _globalValueController.getConversation(conversation!);
    _globalValueController.loadChatLog(conversation!.conversationId!);
  }

  sendMessage() {
    MessageInfo sendInfo = MessageInfo(
        conversationType: ConversationType.PRIVATE_MESSAGE,
        sender: UserInfo(
            userId: _globalValueController.currentUser!.userId,
            terminal: TerminalType.APP),
        receivers: List.generate(
            conversation!.contactUserIds.length,
            (index) => UserInfo(
                userId: conversation!.contactUserIds[index],
                terminal: TerminalType.APP)),
        serviceName: '',
        contentTime: DateTime.now().toString(),
        contentType: MessageType.text,
        content: sendMessageStr.value);
    var messageWrapper = MessageWrapper(
        conversationType: ConversationType.PRIVATE_MESSAGE, data: sendInfo);

    _globalValueController.sendMessage(messageWrapper);

    _globalValueController.messageMapListAdd(
        conversation!.conversationId!, sendInfo);

    _globalValueController
        .isarSaveMessage([sendInfo], conversation!.conversationId!);

    textEditingController.clear();
    sendMessageStr.value = '';
  }

  sendImage(String imageLocalPath,String filename,String mimeType) async {
    ApiResult? result = await FileUploadApi.uploadFile(filePath: imageLocalPath,filename: filename,mimeType: mimeType);
    String imageUrl='';
    if(result?.code == 0){
      imageUrl = result?.data;
    }

    ImageElement image = ImageElement(imageLocalPath: imageLocalPath,imageUrl: imageUrl);
    MessageInfo sendInfo = MessageInfo(
        conversationType: ConversationType.PRIVATE_MESSAGE,
        sender: UserInfo(
            userId: _globalValueController.currentUser!.userId,
            terminal: TerminalType.APP),
        receivers: List.generate(
            conversation!.contactUserIds.length,
                (index) => UserInfo(
                userId: conversation!.contactUserIds[index],
                terminal: TerminalType.APP)),
        serviceName: '',
        contentTime: DateTime.now().toString(),
        contentType: MessageType.picture,
        content: '[图片]',
    image: image);
    var messageWrapper = MessageWrapper(
        conversationType: ConversationType.PRIVATE_MESSAGE, data: sendInfo);

    _globalValueController.sendMessage(messageWrapper);

    _globalValueController.messageMapListAdd(
        conversation!.conversationId!, sendInfo);

    _globalValueController
        .isarSaveMessage([sendInfo], conversation!.conversationId!);
  }

  sendVoice() async {
    double fileSizeInMB = _voiceFileSize / (1024 * 1024);
    ApiResult? result = await FileUploadApi.uploadFile(filePath: _voicePath!,filename: _voicePath!.split('/').last,mimeType: 'audio');
    String voiceUrl='';
    if(result?.code == 0){
      voiceUrl = result?.data;
      // voiceStream = result?.data
    }

    SoundElement voice = SoundElement(sourceUrl: voiceUrl,soundLocalPath:_voicePath,dataSize: fileSizeInMB,duration: _voiceDuration);
    MessageInfo sendInfo = MessageInfo(
        conversationType: ConversationType.PRIVATE_MESSAGE,
        sender: UserInfo(
            userId: _globalValueController.currentUser!.userId,
            terminal: TerminalType.APP),
        receivers: List.generate(
            conversation!.contactUserIds.length,
                (index) => UserInfo(
                userId: conversation!.contactUserIds[index],
                terminal: TerminalType.APP)),
        serviceName: '',
        contentTime: DateTime.now().toString(),
        contentType: MessageType.voice,
        content: '',
        sound: voice);
    var messageWrapper = MessageWrapper(
        conversationType: ConversationType.PRIVATE_MESSAGE, data: sendInfo);

    _globalValueController.sendMessage(messageWrapper);

    _globalValueController.messageMapListAdd(
        conversation!.conversationId!, sendInfo);

    _globalValueController
        .isarSaveMessage([sendInfo], conversation!.conversationId!);
  }
}
