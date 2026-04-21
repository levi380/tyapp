import 'dart:core';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';

class DialogChangeBirthday extends StatefulWidget {
  const DialogChangeBirthday({super.key});

  @override
  State<StatefulWidget> createState() {
    return DialogChangeBirdayState();
  }
}

class DialogChangeBirdayState extends State<DialogChangeBirthday> {
  UserInfoController controller = Get.find();
  UserService get _userService => Get.find<UserService>();

  late DateTime selectedDate; // 添加变量保存选中的日期

  @override
  void initState() {
    super.initState();
    // 精确计算18年前的日期，确保在有效范围内
    DateTime now = DateTime.now();
    selectedDate = DateTime(now.year - 18, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 324.w + ScreenUtil().bottomBarHeight,
      width: 1.sw,
      // margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          color: appnewColors.bg1, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _buildTitle(),
          _buildContent(),
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // 精确计算18年前的日期作为最大日期和初始日期
    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

    return Container(
      margin: EdgeInsets.only(top: 10.w,bottom: 10.w),
      padding: EdgeInsets.only(bottom: 10.w),
      child: CustomDatePicker(
        mode: CustomerDatePickerMode.yearMonthDay,
        initialDate: eighteenYearsAgo, // 使用18年前作为初始日期
        maxDate: eighteenYearsAgo, // 使用18年前作为最大日期
        onChange: (date) {
          print("当前选择时间===$date");
          selectedDate = date; // 保存选中的日期
        },
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
                  "birthday".tr,
                  style: TextStyle(color: appnewColors.text1, fontSize: 16.sp),
                ))),
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

  Widget _buildBtn() {
    // return GestureDetector(
    //   child: Container(
    //     margin: EdgeInsets.only(top: 30.w, left: 25.w, right: 25.w),
    //     width: 1.sw,
    //     height: 48.w,
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(
    //         image: DecorationImage(image: AssetImage(Assets.mineBtnEnable))),
    //     child: Text(
    //       "confirm".tr,
    //       style: TextStyle(color: Colors.white, fontSize: 16.sp),
    //     ),
    //   ),
    //   onTap: () async {
    //     final birthday =
    //         "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    //     final newEntity =
    //         controller.userState.userInfo.copyWith(birthday: birthday);

    //     final tuple = await _userService.updateUserInfos(userInfo: newEntity);
    //     if (!tuple.item1) {
    //       SmartDialog.showToast(
    //           "settings_failed".tr + ": ${tuple.item2 ?? 'unknownError'.tr}");
    //       return;
    //     }
    //     SmartDialog.showToast("settings_success".tr);
    //     Get.back(result: selectedDate);
    //   },
    // );

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.w + ScreenUtil().bottomBarHeight),
        height: 44.w,
        child: InkWell(
            onTap: () async {
              final birthday =
                  "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
              final newEntity =
                  controller.userState.userInfo.copyWith(birthday: birthday);

              final tuple =
                  await _userService.updateUserInfos(userInfo: newEntity);
              if (!tuple.item1) {
                AppUtils.showToast("settings_failed".tr +
                    ": ${tuple.item2 ?? 'unknownError'.tr}");
                return;
              }
              AppUtils.showToast("settings_success".tr);
              Get.back(result: selectedDate);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: appnewColors.btnbg1, // 渐变的颜色数组
                  begin: Alignment.topCenter, // 从上到下
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated, // 镜像平铺 平点
                ),
              ),
              child: Text(
                'confirm'.tr,
                style: TextStyle(
                  color: appnewColors.bg1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )));
  }
}
