import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PopupWindow {
  //加到屏幕上
  static OverlayEntry? _overlayEntry;

  static List<Map<String, dynamic>> items = [
    {'menuName': '置顶该聊天', 'menuCode': '1'},
    {'menuName': '标记已读', 'menuCode': '2'},
    {'menuName': '删除该聊天', 'menuCode': '3'},
  ];

  static double singleMenuItemWidth = 80; // 单个
  static double singleMenuItemHeight = 50;

  // 菜单整体宽度
  static double menuWidth = 0;
  // 菜单整体高度
  static double menuHeight = 0;

  static _buildMenuItem(Function(int) callback,int id) {
    List<Widget> widgets = items
        .map<Widget>((e) => InkWell(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: singleMenuItemWidth,
                height: singleMenuItemHeight,
                child: Text(
                  e.values.first,
                  style: const TextStyle(fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              onTap: () {
                // callback(id);
                callback.call(id);
                hint();
              },
            ))
        .toList();
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey,width: 1)),
      child: Column(
        children: widgets,
      ),
    );
  }

  static void create({
    GlobalKey? key,
    Widget? child,
    double dx = 0,
    double dy = 0,
    required int conversationId,
    required Function(int) deleteConversation
  }) {
    if (key == null) {
      return;
    }

    ui.Size size = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    menuWidth = singleMenuItemWidth;
    menuHeight = singleMenuItemHeight * items.length;
    double left = size.width - dx > menuWidth ? dx : (dx = size.width - menuWidth);
    double height = size.height - dy > menuHeight ? dy : (dy = size.height - menuHeight);


    //获取OverlayState
    OverlayState overlayState = Overlay.of(key.currentContext!);
    if (_overlayEntry == null) {
      //通过OverlayEntry将构建的布局插入到整个布局的最上层
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => GestureDetector(
              onTap: () {
                hint();
              },
              child: Container(
                  color: Colors.transparent,
                  child: Material(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Positioned(
                          top: height,
                          left: left,
                          child: child ??
                              SingleChildScrollView(child: _buildMenuItem(deleteConversation,conversationId)),
                        )
                      ],
                    ),
                  ))));
      //插入到整个布局的最上层
      overlayState.insert(_overlayEntry!);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry?.markNeedsBuild();
    }
  }

  ///隐藏
  static void hint() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
