import 'dart:convert';

class ImageElement {
  String? image;
  double? imageWidth;
  double? imageHeight;
  double? fileSize;

  ImageElement({
    this.image,
    this.imageWidth,
    this.imageHeight,
    this.fileSize,
  });

  ImageElement.fromJson(Map<String, dynamic> json)
      : image = json['imageUrl'],
        imageWidth = json['imageWidth']?.toDouble(),
        imageHeight = json['imageHeight']?.toDouble(),
        fileSize = json['fileSize']?.toDouble();

  Map<String, dynamic> toJson() {
    return {
      "imageUrl": image,
      "imageWidth": imageWidth,
      "imageHeight": imageHeight,
      "fileSize": fileSize,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}