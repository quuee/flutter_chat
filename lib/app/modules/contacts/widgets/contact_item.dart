import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/modules/contacts/model/contacter_model.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ContactItem extends StatelessWidget {
  ContactItem(
      {super.key, required this.contactsHeight, required this.contacterModel});

  double contactsHeight;
  ContacterModel contacterModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.blueGrey),
          ),
        ),
        height: contactsHeight,
        child: Padding(
          padding: const EdgeInsets.only(left: AppValues.padding_4),
          child: Row(
            children: [
              CachedNetworkImage(
                  imageUrl: contacterModel.avatarUrl,
                  width: AppValues.iconDefaultSize *2,
                  height: AppValues.iconDefaultSize *2,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const AssetImageView(
                      width: AppValues.iconDefaultSize,
                      height: AppValues.iconDefaultSize,
                      fileName: 'add_contact.svg')),
              Text(contacterModel.nickname)
            ],
          ),
        ),
      ),
      onTap: () {

        if(contacterModel.nickname == '群聊'){
          Get.toNamed(Routes.GROUP);
          return;
        }
        if(contacterModel.nickname == '新朋友'){

        }
        Get.toNamed(Routes.CONTACT_SIMPLE, arguments: contacterModel);
      },
    );
  }
}
