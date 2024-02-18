import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

typedef RecordFc = Function(int sec, String path, int fileSize);

class VoiceRecord{
  static const _dir = "voice";
  static const _ext = ".m4a";

  int _fileSize = 0;
  int _time = 0;
  late String _path;
  // late String _someone; // someone pinyin
  final RecordFc _callback; // 用来向上传递参数

  final _audioRecorder = AudioRecorder();

  VoiceRecord(this._callback);

  start() async {

    if (await _audioRecorder.hasPermission()) {

      var path = (await getApplicationDocumentsDirectory()).path;
      _time = DateTime.now().millisecondsSinceEpoch;
      _path = '$path/$_dir/${_time.toString()}$_ext';
      File file = File(_path);
      if (!(await file.exists())) {
        await file.create(recursive: true);
      }
      // Start recording to file
      await _audioRecorder.start(const RecordConfig(), path: _path);

    }
  }

  stop() async {
    if (await _audioRecorder.isRecording()) {
      _time = (DateTime.now().millisecondsSinceEpoch - _time) ~/ 1000;
      await _audioRecorder.stop();

      File file = File(_path);
      _fileSize = await file.length();
      _callback(_time, _path, _fileSize);
    }
  }
}