import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/setting/setting_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';

import 'package:filbet/themes/app_decoration.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/themes/app_newcolor.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
        showBgTexture: false,
        backgroundColor: appnewColors.bg4,
        appBar: CustomAppbar.normalTitle(
          bgColor: appnewColors.bg4,
          title: 'settings'.tr,
        ),
        body: GetBuilder<SettingController>(builder: (_) {
          return _buildPageWidget(context);
        }));
  }

  Widget _buildPageWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
      child: Column(
        children: [
          // _buildItemWidget(
          //   [
          //     {
          //       'title': 'lang'.tr,
          //       'data': controller.selectLanguageModel.value.title ?? '',
          //       "type": "0",
          //       "image": Assets.setingSetingIcon3
          //     },
          //   ],
          // ),
          Obx(() {
            return _buildItemWidget(
              [
                {
                  'title': 'clear_cache'.tr,
                  'data': "${controller.size.toStringAsFixed(2)}" + "MB",
                  "type": "1",
                  "image": Assets.setingSetingIcon2
                },
                {
                  'title': 'modify_pwd'.tr,
                  'data': "",
                  "type": "2",
                  "image": Assets.setingSettingModifyPwd
                },
                {
                  'title': 'feedback'.tr,
                  'data': "",
                  "type": "3",
                  "image": Assets.setingSettingFeedback
                },
                {
                  'title': 'check_update'.tr,
                  'data': controller.isUpdate.value ? 'new_version'.tr : '',
                  'currentVersion': 'V' + controller.version.value,
                  "type": "4",
                  "image": Assets.setingSetingIcon1
                },
              ],
            );
          }),
          _buildLogOutBtn(),
          Spacer(),
          _buildTimeView(context),
        ],
      ),
    );
  }

  /// item
  Widget _buildItemWidget(List<Map<String, String>> itemMap) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      // padding: EdgeInsets.only(top: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: itemMap.map((e) {
            int index = itemMap.indexOf(e);
            return _buildItem(e, index, itemMap.length);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Map<String, String> map, int index, int length) {
    return GestureDetector(
      onTap: () {
        if (map["type"] == "0") {
          controller.selectLanguage();
        }
        if (map["type"] == "1") {
          controller.clearCache();
        }
        if (map["type"] == "2") {
          String? needEmail = UserService.to.state.userInfo.email;
          String? needPhone = UserService.to.state.userInfo.phone;
          Get.toNamed(Routes.VERIFY, arguments: {
            'needEmail': needEmail,
            'needPhone': needPhone,
            'verityType': ValidationType.changeLoginPwd,
          });
        }
        if (map["type"] == "3") {
          Get.toNamed(Routes.FEEDBACK);
        }
        if (map["type"] == "4") {
          controller.getAppVersion();
        }
      },
      child: Container(
        padding:
            EdgeInsets.only(top: 14.h, bottom: 12.h, left: 14.w, right: 14.w),
        decoration: BoxDecoration(
            color: appnewColors.bg1,
            borderRadius: index == 0
                ? BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  )
                : index == length - 1
                    ? BorderRadius.vertical(
                        bottom: Radius.circular(12.r),
                      )
                    : BorderRadius.zero,
            border: Border(
              bottom: index != length - 1
                  ? BorderSide(color: appnewColors.colorLine, width: 0.5)
                  : BorderSide.none,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   map['image'] ?? '',
            //   width: 22.w,
            //   height: 22.w,
            // ),
            // SizedBox(
            //   width: 10.w,
            // ),
            Container(
              alignment: Alignment.center,
              child: Text(
                map['title'] ?? '',
                style: TextStyle(
                  color: appnewColors.text6,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Text(map['data'] ?? '',
                          style: TextStyle(
                              color: appnewColors.text3,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  if (map['currentVersion'] != null)
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        "cur_version".tr + ' ${map['currentVersion'] ?? ''}',
                        style: TextStyle(
                          color: controller.isUpdate.value
                              ? appnewColors.tip3
                              : appnewColors.text3,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(width: 6.w),
                  Image.asset(
                    Assets.mineIconArrowR,
                    width: 10.w,
                    height: 10.h,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///退出登录
  Widget _buildLogOutBtn() {
    return InkWell(
      onTap: () {
        Get.dialog(SkBaseDialog(
          callback: () {
            controller.logOut();
          },
          title: "tips".tr,
          showFooterBtn: true,
          showDeleteBtn: false,
          showDeleteBtnType: '1',
          leftBtnTitle: 'cancel'.tr,
          rightBtnTitle: "confirm".tr,
          child: Container(
            padding: EdgeInsets.all(20.r),
            child: Text(
              "are_you_sure_you_want_to_log_out".tr,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: appnewColors.text1,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        // width: 1.sw - 50.w,
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(44.r),
        ),
        child: Text(
          'logout'.tr,
          style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTimeView(BuildContext context) {
    const String buildTime =
        String.fromEnvironment('BUILD_TIME', defaultValue: '');
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20.r),
      alignment: Alignment.center,
      child: Text(
        buildTime,
        style: TextStyle(
          color: controller.isUpdate.value
              ? appnewColors.tip3
              : appnewColors.text3,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
