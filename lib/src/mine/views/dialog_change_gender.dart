import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';

class DialogChangeGender extends StatefulWidget {
  final bool? isMale;
  const DialogChangeGender({super.key, required this.isMale});

  @override
  State<StatefulWidget> createState() {
    return DialogChangeGenderState();
  }
}

class DialogChangeGenderState extends State<DialogChangeGender> {
  UserInfoController controller = Get.find();
  UserService get _userService => Get.find<UserService>();

  int selectIndex = -1;

  @override
  void initState() {
    super.initState();
    // 初始化选择的性别
    if (widget.isMale == null) {
      selectIndex = -1; // 未选择
    } else if (widget.isMale == true) {
      selectIndex = 0; // 男
    } else {
      selectIndex = 1; // 女
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.w + ScreenUtil().bottomBarHeight,
      width: 1.sw,
      // margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          color: appnewColors.bg1, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _buildTitle(),
          _buildContent(),

          Spacer(), // 撑开中间空隙
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGenderType(Assets.mineVuesax, "male".tr, 0),
          SizedBox(width: 40.w),
          _buildGenderType(Assets.mineWoman, "female".tr, 1),
        ],
      ),
    );
  }

  Widget _buildGenderType(String img, String str, int type) {
    return GestureDetector(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 65.w,
                height: 65.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65.w / 2),
                    color: appnewColors.bg4),
                alignment: Alignment.center,
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48.w / 2),
                    // gradient: AoneAppTheme.appTheme.themeLinearGradient,
                    gradient: LinearGradient(
                      colors: type == 0
                          ? [Color(0xff77AEFF), Color(0xff4592FF)]
                          : [Color(0xffDA47FF), Color(0xffFF1C91)], // 定义渐变色
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Image.asset(img, width: 28.w),
                ),
              ),
              if (selectIndex == type)
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
          ),
          SizedBox(height: 10.w),
          Text(str),
        ],
      ),
      onTap: () {
        setState(() {
          selectIndex = type;
        });
      },
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
                  "gender".tr,
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
    //       image: DecorationImage(
    //         image: AssetImage(
    //           selectIndex == -1 ? Assets.mineBtnDisable : Assets.mineBtnEnable,
    //         ),
    //       ),
    //     ),
    //     child: Text(
    //       "confirm".tr,
    //       style: TextStyle(color: Colors.white, fontSize: 16.sp),
    //     ),
    //   ),
    //   onTap: () async {
    //     if (selectIndex != -1) {
    //       if (widget.isMale == true && selectIndex == 0 ||
    //           widget.isMale == false && selectIndex == 1) {
    //         Get.back(result: selectIndex); // 没有变化，直接返回
    //         return;
    //       }
    //       final gender = selectIndex == 0 ? 1 : 2;
    //       final newEntity = _userService.state.userInfo.copyWith(gender: gender);
    //       final tuple = await _userService.updateUserInfos(userInfo: newEntity);
    //       if (tuple.item1) {
    //         SmartDialog.showToast("setSuccess".tr);
    //         Get.back(result: selectIndex);
    //       } else {
    //         SmartDialog.showToast("settings_failed".tr +
    //             ": ${tuple.item2 ?? 'unknownError'.tr}");
    //       }
    //     }
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
              if (selectIndex != -1) {
                if (widget.isMale == true && selectIndex == 0 ||
                    widget.isMale == false && selectIndex == 1) {
                  Get.back(result: selectIndex); // 没有变化，直接返回
                  return;
                }
                final gender = selectIndex == 0 ? 1 : 2;
                final newEntity =
                    _userService.state.userInfo.copyWith(gender: gender);
                final tuple =
                    await _userService.updateUserInfos(userInfo: newEntity);
                if (tuple.item1) {
                  AppUtils.showToast("setSuccess".tr);
                  Get.back(result: selectIndex);
                } else {
                  AppUtils.showToast("settings_failed".tr +
                      ": ${tuple.item2 ?? 'unknownError'.tr}");
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: selectIndex == -1
                      ? appnewColors.btnbg6
                      : appnewColors.btnbg1, // 渐变的颜色数组
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
