//
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayUtil{
//
//   late AudioPlayer audioPlayer;
//
//   // static _instance，_instance会在编译期被初始化，保证了只被创建一次
//   static final AudioPlayUtil _instance = AudioPlayUtil._internal();
//
//   //提供了一个工厂方法来获取该类的实例
//   factory AudioPlayUtil(){
//     return _instance;
//   }
//
//   // 通过私有方法_internal()隐藏了构造方法，防止被误创建
//   AudioPlayUtil._internal(){
//     audioPlayer = AudioPlayer();
//   }
//
//   /// 播放
//   Future play(String videoPath) async {
//     Duration? result = await audioPlayer.setUrl(videoPath);
//     audioPlayer.play();
//     return result;
//   }
//
//   /// 暂停
//   pause() async {
//     await audioPlayer.pause();
//   }
//
//   /// 拖动播放
//   Future seekPlay(Duration duration) async {
//     await audioPlayer.seek(duration);
//   }
//
//
// }