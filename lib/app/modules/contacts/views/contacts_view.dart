import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/base/base_view.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/core/values/app_values.dart';
import 'package:flutter_chat/app/modules/contacts/widgets/contact_item.dart';
import 'package:get/get.dart';
import '/app/core/widget/custom_app_bar.dart';

import '/app/modules/contacts/controllers/contacts_controller.dart';

class ContactsView extends BaseView<ContactsController> {
  static const double contactsHeight = 48;
  static const double contactsNavigateHeight = contactsHeight / 2;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: appLocalization.appbarTitle,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.add))
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return GetBuilder<ContactsController>(builder: (c){
      return Stack(
        children: [
          // 左侧联系人
          ListView.builder(
              controller: controller.contactsScroll,
              itemCount: controller.contacts.length,
              itemBuilder: (c, i) {
                if(controller.contacts[i].entries.first.value.isNotEmpty) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 第一层 字母
                        Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: contactsNavigateHeight,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: AppValues.padding_4),
                              child: Text(
                                  controller.contacts[i].entries.first.key),
                            )),
                        // 第二层 名字
                        ListView.builder(
                            shrinkWrap: true, // 多层嵌套滚动必须加shrinkWrap: true
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                            controller.contacts[i].entries.first.value.length,
                            itemBuilder: (c2, i2) {
                              return ContactItem(
                                  contactsHeight: contactsHeight,
                                  contacterModel: controller.contacts[i].entries.first
                                      .value[i2]);
                            })
                      ]);
                }
                return const SizedBox.shrink();
              }),

          //右侧固定导航字母
          Align(
            alignment: const FractionalOffset(1.0, 0.5), //中部右边
            child: SizedBox(
              width: 20,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: controller.letters.length,
                      itemBuilder: (c, index) {
                        return _buildOnTaoJump(controller.letters[index], index);
                      })),
            ),
          )
        ],
      );
    });

  }

  _buildOnTaoJump(String word, int index) {
    return GestureDetector(
      child: Obx(() => Container(
          decoration: BoxDecoration(
              color: controller.currentIndex.value == index
                  ? AppColors.textColorTag
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              word,
              style: TextStyle(
                fontSize: 12,
                color: controller.currentIndex.value == index
                    ? AppColors.textColorWhite
                    : AppColors.textColorTag,
              ),
            ),
          ))),
      onTap: () {
        controller.currentIndex.value = index;
        double height = index * contactsNavigateHeight; // 多少个 左侧字母的高度
        for (int i = 0; i < index; i++) {
          height += controller.contacts[i].entries.first.value.length *
              contactsHeight; //多少个实际数据的高度
        }
        controller.contactsScroll.jumpTo(height);
      },
    );
  }
}
