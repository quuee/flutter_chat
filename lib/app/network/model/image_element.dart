import 'dart:convert';

import 'package:isar/isar.dart';
part 'image_element.g.dart';

@embedded
class ImageElement {
  String? imageUrl;
  String? imageLocalPath;
  double? imageWidth;
  double? imageHeight;
  double? fileSize;

  ImageElement({
    this.imageUrl,
    this.imageLocalPath,
    this.imageWidth,
    this.imageHeight,
    this.fileSize,
  });

  ImageElement.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        imageLocalPath = json['imageLocalPath'],
        imageWidth = json['imageWidth']?.toDouble(),
        imageHeight = json['imageHeight']?.toDouble(),
        fileSize = json['fileSize']?.toDouble();

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": imageUrl,
      "imageLocalPath": imageLocalPath,
      "imageWidth": imageWidth,
      "imageHeight": imageHeight,
      "fileSize": fileSize,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}