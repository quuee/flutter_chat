/// Voice message content
class SoundElement {
  /// URL address
  String? sourceUrl;

  /// Local address

  String? soundPath;

  /// Voice file size
  double? dataSize;

  /// time
  int? duration;

  SoundElement({this.sourceUrl, this.soundPath, this.dataSize, this.duration});

  SoundElement.fromJson(Map<String, dynamic> json) {
    sourceUrl = json['sourceUrl'];
    soundPath = json['soundPath'];
    dataSize = json['dataSize'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sourceUrl'] = sourceUrl;
    data['soundPath'] = soundPath;
    data['dataSize'] = dataSize;
    data['duration'] = duration;
    return data;
  }

  @override
  String toString() {
    return 'SoundElem{sourceUrl: $sourceUrl, soundPath: $soundPath, dataSize: $dataSize, duration: $duration}';
  }
}