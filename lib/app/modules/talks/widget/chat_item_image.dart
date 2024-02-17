import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/network/model/image_element.dart';

class ChatImageView extends StatelessWidget {
  const ChatImageView({super.key, required this.imageElement});

  final ImageElement imageElement;

  // 进度条

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageElement.imageWidth,
      height: imageElement.imageHeight,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            image: FileImage(File(imageElement.imageLocalPath!)),
            fit: BoxFit.fill,
          )),
    );
  }
}
