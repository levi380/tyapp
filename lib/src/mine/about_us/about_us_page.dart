import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/about_us/about_us_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutUsPage extends GetView<AboutUsController> {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg5,
        title: '关于SK体育',
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104.r,
                height: 104.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF74ACFF),
                      Color(0xFF579BFB),
                    ],
                  ),
                ),
                child: Image.asset(
                  Assets.mineLoginLogo,
                  width: 89.r,
                  height: 70.r,
                ),
              ),
              SizedBox(
                height: 20.r,
              ),
              Text(
                '版本号${AppEnvConfig.instance.version}',
                style: TextStyle(
                  color: appnewColors.textMain,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
