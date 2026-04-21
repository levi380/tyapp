import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomDialog {
  static void showBottomDialog(Widget widget) {
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true, //// 让 BottomSheet 适应内容
        GestureDetector(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 调整模糊程度
                child: Container(
                    color: Colors.black.withValues(alpha: 0.1)), // 半透明背景
              ),
              Align(
                // child: CircularMenu(),
                alignment: Alignment.bottomCenter,
                // child: CircularMenu(),
                child: widget,
              )
            ],
          ),
          onTap: () {
            Get.back();
          },
        ));
  }

  static void showBottomDialog2(context, Widget widget) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 允许底部弹窗铺满屏幕
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 调整模糊程度
              child: Container(
                  color: Colors.black.withValues(alpha: 0.1)), // 半透明背景
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget,
            )
          ],
        );
      },
    );
  }
}
