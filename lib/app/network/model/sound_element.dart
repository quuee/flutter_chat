
import 'package:isar/isar.dart';
part 'sound_element.g.dart';

@embedded
class SoundElement {
  /// URL address
  String? sourceUrl;

  /// Local address
  String? soundLocalPath;

  /// Voice file size
  double? dataSize;

  /// time
  int? duration;

  SoundElement({this.sourceUrl, this.soundLocalPath, this.dataSize, this.duration});

  SoundElement.fromJson(Map<String, dynamic> json) {
    sourceUrl = json['sourceUrl'];
    soundLocalPath = json['soundLocalPath'];
    dataSize = json['dataSize'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sourceUrl'] = sourceUrl;
    data['soundLocalPath'] = soundLocalPath;
    data['dataSize'] = dataSize;
    data['duration'] = duration;
    return data;
  }

  @override
  String toString() {
    return 'SoundElem{sourceUrl: $sourceUrl, soundPath: $soundLocalPath, dataSize: $dataSize, duration: $duration}';
  }
}