import 'dart:convert';


// part 'image_element.g.dart';


class ImageElement {
  String? imageUrl;
  String? imageLocalPath;
  double? imageWidth;
  double? imageHeight;
  double? imageFileSize;

  ImageElement({
    this.imageUrl,
    this.imageLocalPath,
    this.imageWidth,
    this.imageHeight,
    this.imageFileSize,
  });

  ImageElement.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        imageLocalPath = json['imageLocalPath'],
        imageWidth = json['imageWidth']?.toDouble(),
        imageHeight = json['imageHeight']?.toDouble(),
        imageFileSize = json['imageFileSize']?.toDouble();

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": imageUrl,
      "imageLocalPath": imageLocalPath,
      "imageWidth": imageWidth,
      "imageHeight": imageHeight,
      "imageFileSize": imageFileSize,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}