
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/core/widget/asset_image_view.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '/app/modules/me/controllers/me_controller.dart';

class MeView extends GetView<MeController> {
  const MeView({super.key});



  @override
  Widget build(BuildContext context) {

    var textStyle = const TextStyle(fontSize: 16,fontWeight: FontWeight.w400);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Column(
        children: [
          // 头像区域
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: Row(
              children: [
                CachedNetworkImage(
                  width: AppValues.iconLargeSize * 3,
                  height: AppValues.iconLargeSize * 3,
                  imageUrl: controller.currentUser!.avatarUrl,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        controller.currentUser!.nickname,style: textStyle),
                    Text(
                        controller.currentUser?.phone??'',style: textStyle
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.padding),
            child: Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(AppValues.padding),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  Text('设置', style: textStyle),
                  SizedBox(width: AppValues.smallPadding),
                  Spacer(),
                  const AssetImageView(
                    fileName: 'arrow_forward.svg',
                    color: AppColors.suffixImageColor,
                    height: AppValues.iconSize_20,
                    width: AppValues.iconSize_20,
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: AppValues.padding),
              // margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    '退出账号',
                    style: TextStyle(color: AppColors.errorColor,fontSize: 24,fontWeight: FontWeight.w600),

                  )
                ],
              ),
            ),
            onTap: () {

              controller.deleteToken();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }

}
