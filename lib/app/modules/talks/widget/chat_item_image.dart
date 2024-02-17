import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/network/model/image_element.dart';
import 'package:photo_view/photo_view.dart';

class ChatImageView extends StatelessWidget {
  const ChatImageView({super.key, required this.imageElement});

  final ImageElement imageElement;

  // 进度条

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: imageElement.imageWidth??50,
    //   height: imageElement.imageHeight??50,
    //   decoration: BoxDecoration(
    //       borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    //       image: DecorationImage(
    //         image: FileImage(File(imageElement.imageLocalPath!)),
    //         fit: BoxFit.fill,
    //       )),
    // );

    return _buildChildView();
  }

  _buildChildView(){
    if(imageElement.imageUrl!='' && imageElement.imageUrl!=null){
      return CachedNetworkImage(
        imageUrl: imageElement.imageUrl!,
        width: imageElement.imageWidth ?? 56,
        height: imageElement.imageHeight ?? 100,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
          // child: PhotoView(
          //   imageProvider: FileImage(File(imageElement.imageLocalPath!)),
          // ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }else{
      return Container(
          width: imageElement.imageWidth ?? 56,
          height: imageElement.imageHeight ?? 100,
          child: PhotoView(
            imageProvider: FileImage(File(imageElement.imageLocalPath!)),
          ));
    }
  }
}
