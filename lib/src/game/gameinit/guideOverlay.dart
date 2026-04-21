import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filbet/generated/assets.dart';

/// 顶部引导弹窗（无动画版本）
Future<void> showTopGuideDialog(
  BuildContext context, {
  Function()? onComplete,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54, // 背景半透明
    transitionDuration: Duration.zero, // ❌ 无动画
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
         color: Colors.white.withOpacity(1),
          child: Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [Color(0xffE6F1FE), Colors.white],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                // ),

                ),
            child: GuideOverlay(
              onClose: () {
                Get.back();
                onComplete?.call();
              },
            ),
          ),
        ),
      );
    },
  );
}

/// 顶部引导内容
class GuideOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const GuideOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        /// 点击任意处关闭
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.transparent, // 不遮住内容，只用于点击关闭
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // 蓝色按钮 + 提示气泡
        Positioned(
          top: statusBarHeight + 4+20, // 自动避开状态栏
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ 水平居中
            children: [
             
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Image.asset(
                  Assets.homeShouTop,
                  width: 20,
                  height: 29,
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: statusBarHeight + 4+20+29, // 自动避开状态栏
            left: Get.width / 2 - 20,
            right: 12,
            child: Container(
            
              padding:  EdgeInsets.only(left: 5, right: 5,bottom: 8,top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              
              ),
              child: Text(
                'guideTip'.tr,
                style: TextStyle(color: Color(0xff545A78), fontSize: 12,fontWeight: FontWeight.w500),
              ),
            ))
      ],
    );
  }
}
