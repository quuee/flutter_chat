

// part 'sound_element.g.dart';


class SoundElement {
  /// URL address
  String? sourceUrl;

  /// Local address
  String? soundLocalPath;

  /// Voice file size
  double? soundDataSize;

  /// time
  int? duration;

  // @Ignore()
  // Stream? voiceStream;

  SoundElement({this.sourceUrl, this.soundLocalPath, this.soundDataSize, this.duration});

  SoundElement.fromJson(Map<String, dynamic> json) {
    sourceUrl = json['sourceUrl'];
    soundLocalPath = json['soundLocalPath'];
    soundDataSize = json['soundDataSize'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sourceUrl'] = sourceUrl;
    data['soundLocalPath'] = soundLocalPath;
    data['soundDataSize'] = soundDataSize;
    data['duration'] = duration;
    return data;
  }

  @override
  String toString() {
    return 'SoundElem{sourceUrl: $sourceUrl, soundPath: $soundLocalPath, dataSize: $soundDataSize, duration: $duration}';
  }
}