import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DialogChangeHeader extends StatelessWidget {
  final UserInfoController controller = Get.find();

  DialogChangeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305.w + ScreenUtil().bottomBarHeight,
      width: 1.sw,
      // margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          color: appnewColors.bg1, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _buildTitle(),
          _buildImgs(),
          Spacer(), // 撑开中间空隙
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.w + ScreenUtil().bottomBarHeight),
              height: 44.w,
              child: InkWell(
                  onTap: () {
                    Get.back(result: controller.currentHeaderIndex.value);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appnewColors.bg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'confirm'.tr,
                      style: TextStyle(
                        color: appnewColors.bg1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 20.w),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                // width: 30.w,
                height: 30.w,
                child: Center(
                    child: Text(
                  "avatar".tr,
                  style: TextStyle(color: appnewColors.text1, fontSize: 16.sp),
                )
                
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Container(
                width: 30.w,
                height: 30.w,
                child: Center(
                  child: Image.asset(
                    Assets.mineIconCloes,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImgs() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      margin: EdgeInsets.only(top: 25.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.w,
        children:
            List.generate(controller.userState.avatarList.length, (index) {
          return GestureDetector(
            child: Obx(() => Stack(
                  children: [
                    Image.asset(
                      controller.userState.avatarList[index],
                      width: 60.w,
                    ),
                    if (controller.currentHeaderIndex.value == index)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          Assets.headerCheck,
                          width: 20.w,
                          height: 20.w,
                        ),
                      )
                  ],
                )),
            onTap: () {
              controller.currentHeaderIndex.value = index;
            },
          );
        }),
      ),
    );
  }
}
