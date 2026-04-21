import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/home/home_view_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/utils/font_family.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/utils/base_util.dart';

class MiddleInfo extends GetView<HomeViewController> {
  const MiddleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => _leftWidget()),
        ),
        _middleNavLayout(),
      ],
    );
  }

  Widget _leftWidget() {
    if (UserService.to.state.isVisitor) {
      return Container(
        margin: EdgeInsets.only(left: 14.r),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                EventBus.emit(EventType.goToLogin);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "not_logged_in".tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF545a78),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 2.r,
                  ),
                  Text("login_or_register".tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: appnewColors.text1,
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Row(
      children: [
        SizedBox(
          width: 14.r,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.MY_ASSETS);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    UserService.to.state.nicknamelabel ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff545A78),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Obx(() {
                    return Container(
                      padding: EdgeInsets.only(bottom: 2.r),
                      child: Image.asset(
                        "assets/images/new/mine/vip_level_${controller.vipInfo.value?.currentLevel ?? 0}.webp",
                        width: 46.w,
                        height: 16.h,
                      ),
                    );
                  })
                ],
              ),
            ),
            SizedBox(height: 2.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // 主轴左对齐
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.MY_ASSETS);
                  },
                  child: Text(
                    UserService.to.state.hideBalance.value == true
                        ? UserService.to.state.totalBalance.value.strforcurry()
                        : "*****",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: FontFamily.din_bold,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff40526A),
                    ),
                  ),
                ),
                SizedBox(width: 10.r),
                Image.asset(
                  UserService.to.state.hideBalance.value == true
                      ? Assets.homeEye
                      : Assets.homeNoeye,
                  width: 16.r,
                  height: 16.r,
                  fit: BoxFit.fill,
                ).toBtn(
                  onTap: () {
                    UserService.to.state.hideBalance.value =
                        !UserService.to.state.hideBalance.value;
                    SpStorage.sethibalance(
                        UserService.to.state.hideBalance.value);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _middleNavLayout() {
    return Container(
        padding: EdgeInsets.only(top: 9.r, bottom: 9.r),
        margin: EdgeInsets.only(right: 10.r),
        child: Row(
          spacing: 10.r,
          children: [
            navLayoutItem(Assets.homeHomeD, "deposit".tr, () {
              EventBus.emit(EventType.onGoRecharge);
            }),
            navLayoutItem(Assets.homeHomeTr, 'transfer'.tr, () {
              EventBus.emit(EventType.onGoTransfer);
            }),
            navLayoutItem(Assets.homeHomeW, "withdraw".tr, () {
              EventBus.emit(EventType.onGoWithdraw);
            }),
            navLayoutItem(Assets.homeHomeVip, "VIP".tr, () {
              EventBus.emit(EventType.onGoVip);
            }),
          ],
        ));
  }

  Widget navLayoutItem(String icon, String title, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 36.r,
            height: 38.r,
            fit: BoxFit.fill,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xff595F7C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
