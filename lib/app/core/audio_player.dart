
import 'package:just_audio/just_audio.dart';

typedef ListenMessageCallback = void Function(dynamic event);

class AudioPlayUtil{

  late AudioPlayer _audioPlayer;

  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final AudioPlayUtil _instance = AudioPlayUtil._internal();

  //提供了一个工厂方法来获取该类的实例
  factory AudioPlayUtil(){
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  AudioPlayUtil._internal(){
    _audioPlayer = AudioPlayer();

  }

  setUrl(String url) async {
    await _audioPlayer.setUrl(url);
  }

  setPath(String path) async {
    await _audioPlayer.setFilePath(path);
  }

  /// 播放
  play() {
    _audioPlayer.play();
  }

  /// 暂停
  pause() {
    _audioPlayer.pause();
  }

  stop() async {
    await _audioPlayer.stop();
  }

  /// 拖动播放
  Future seekPlay(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  listen(ListenMessageCallback f){
    _audioPlayer.playerStateStream.listen((state){
      f(state);
    });
    // _audioPlayer.playerStateStream.listen((state) {
    //   switch (state.processingState) {
    //     case ProcessingState.idle:
    //     case ProcessingState.loading:
    //     case ProcessingState.buffering:
    //     case ProcessingState.ready:
    //       break;
    //     case ProcessingState.completed:
    //     // 重置 使可以点击重复播放
    //       _audioPlayer.seek(const Duration(seconds: 0));
    //       _audioPlayer.stop();
    //       break;
    //   }
    // });
  }

}
