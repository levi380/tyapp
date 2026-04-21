import 'dart:async';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/controllers/user_info_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/views/dialog_change_birthday.dart';
import 'package:filbet/src/mine/views/dialog_change_gender.dart';
import 'package:filbet/src/mine/views/dialog_change_header.dart';
import 'package:filbet/src/mine/views/dialog_change_nickname.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/contact_service_view.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/sk_confirm_dialog.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui'; // ImageFilter 在这里

class UserInfoMationView extends GetView<UserInfoController> {
  // SecurityService securityService = Get.put(SecurityService());
  // final UserInfoController controller = Get.put(UserInfoController());

  UserService get _userService => Get.find<UserService>();

  UserInfoMationView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: 'profile'.tr,
      ),
      body: Obx(() {
        var realName = controller.userState.userInfo.realName ?? "";
        var phone = controller.userState.userInfo.phone ?? "";
        return Column(
          children: [
            if (realName.isEmpty || phone.isEmpty) _hintAuthentication(),
            _buildHeader(),
            Container(
              // margin: EdgeInsets.only(top: 12.h),
              child: Text(
                _userService.state.userName,
                style: TextStyle(
                    color: appnewColors.text1,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            _buildOptMenu(context),
            _buildSecurityMenu(context),
            SizedBox(height: 16.h),
            Text(
              "为了您的隐私安全信息在确认后将无法修改".tr,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: appnewColors.text23),
            ),
            SizedBox(height: 6.h),
            ContactServiceView(),
          ],
        );
      }),
    );
  }

  Widget _hintAuthentication() {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 7.h),
      color: appnewColors.bg5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: Icon(Icons.error_outlined,
                color: appnewColors.text25, size: 12.w),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              '完成姓名与手机号认证，可使用更多支付方式',
              style: TextStyle(
                  color: appnewColors.text28,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Image.asset(
              controller.userState.avatarImgUrl,
              width: 102.w,
            )),
        Positioned(
            bottom: 5.w,
            right: 1,
            child: GestureDetector(
                onTap: () async {
                  // 记录原始头像索引
                  final originalIndex = controller.currentHeaderIndex.value;

                  await Get.bottomSheet(DialogChangeHeader());

                  final newIndex = controller.currentHeaderIndex.value;

                  // 检查是否有变化，没有变化就不更新
                  if (newIndex == originalIndex) {
                    return; // 没有变化，直接返回
                  }

                  final path = "$newIndex";
                  final newEntity =
                      controller.userState.userInfo.copyWith(avatar: path);
                  final tuple =
                      await _userService.updateUserInfos(userInfo: newEntity);
                  if (tuple.item1) {
                    AppUtils.showToast("setSuccess".tr);
                  } else {
                    AppUtils.showToast(tuple.item2 ?? 'unknownError'.tr);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0x99000000), // 半透明底色
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: Color(0x33FFFFFF),
                        ),
                        // border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Image.asset(
                        Assets.mineUserEdit,
                        width: 13.w,
                        height: 13.w,
                      ),
                    ),
                  ),
                )))
      ],
    );
  }

  // Widget _buildBtn() {
  //   return GestureDetector(
  //     child: Container(
  //       margin: EdgeInsets.only(top: 20.w),
  //       padding:
  //           EdgeInsets.only(left: 20.w, right: 20.w, top: 8.w, bottom: 8.w),
  //       decoration: BoxDecoration(
  //         color: Color(0xff00A6D6),
  //         borderRadius: BorderRadius.circular(6.w),
  //       ),
  //       child: Text(
  //         "change_avatar".tr,
  //         style: TextStyle(color: Colors.white, fontSize: 12.sp),
  //       ),
  //     ),
  //     onTap: () async {
  //       // 记录原始头像索引
  //       final originalIndex = controller.currentHeaderIndex.value;

  //       await Get.dialog(DialogChangeHeader());

  //       final newIndex = controller.currentHeaderIndex.value;

  //       // 检查是否有变化，没有变化就不更新
  //       if (newIndex == originalIndex) {
  //         return; // 没有变化，直接返回
  //       }

  //       final path = "$newIndex";
  //       final newEntity = controller.userState.userInfo.copyWith(avatar: path);
  //       final tuple = await _userService.updateUserInfos(userInfo: newEntity);
  //       if (tuple.item1) {
  //         SmartDialog.showToast("setSuccess".tr);
  //       } else {
  //         SmartDialog.showToast(
  //             "settings_failed".tr + ": ${tuple.item2 ?? 'unknownError'.tr}");
  //       }
  //     },
  //   );
  // }

  Widget _buildSecurityMenu(BuildContext context) {
    return GetBuilder<UserInfoController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(children: [
            _buildItem(
              Assets.mineIcNickname,
              "手机号码".tr,
              controller.phone,
              onTap: () async {
                var phone = UserService.to.state.userInfo.phone ?? "";
                if (phone.isEmpty) {
                  final bindPhone = Get.toNamed(Routes.REAL_NAME_AUTHENTICATION);
                }
              },
            ),
            Container(
              height: 1,
              color: appnewColors.lineColor,
            ),
            _buildItem(
              Assets.mineIcNickname,
              "电子邮箱".tr,
              controller.email,
              onTap: () async {
                var email = UserService.to.state.userInfo.email ?? "";
                if (email.isEmpty) {
                  Get.toNamed(Routes.BIND_EMAIL);
                }
              },
            ),
            Container(
              height: 1,
              color: appnewColors.lineColor,
            ),
            _buildItem(
              Assets.mineIcNickname,
              "取款密码".tr,
              controller.securityData.value?.hasPayPwd == true
                  ? "set".tr
                  : 'unset'.tr,
              onTap: () async {
                if (controller.securityData.value?.hasPayPwd == true) {
                  var result = await Get.toNamed(Routes.WITHDRAWAL_PWD);
                } else {
                  var result = await Get.toNamed(Routes.MODIFY_WITHDRAW_PWD);
                  if (result) {
                    var result = await Get.toNamed(Routes.WITHDRAWAL_PWD);
                    controller.loadSecurityData();
                    controller.update();
                  }
                }
              },
            ),
          ]),
        );
      },
    );
  }

  Widget _buildOptMenu(BuildContext context) {
    return GetBuilder<UserInfoController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 18.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              _buildItem(
                Assets.mineIcNickname,
                "nickname".tr,
                controller.nickname,
                onTap: () async {
                  // 设置对话框打开时显示当前的昵称
                  controller.setNickController.text =
                      controller.userState.userInfo.nickName ?? '';

                  // if (controller.setNickController.text.isNotEmpty) return;

                  // 保存原始昵称，用于取消时恢复
                  final originalNickname = controller.setNickController.text;

                  // final nickName = await Get.bottomSheet<String>(
                  //   DialogChangeNickname(
                  //     inputController: controller.setNickController,
                  //   ),
                  // );

                  final nickName = await Get.to<String>(
                    () => DialogChangeNickname(
                      inputController: controller.setNickController,
                    ),
                  );

                  if (nickName != null && nickName.isNotEmpty) {
                    // 用户确认修改，更新昵称
                    controller.setNickController.text = nickName;
                    controller.userState.userInfo.nickName = nickName;
                    // 手动触发更新
                    controller.update();
                  } else {
                    // 用户取消或返回空值，恢复原始昵称
                    controller.setNickController.text = originalNickname;
                  }
                },
              ),
              Container(
                height: 1,
                color: appnewColors.lineColor,
              ),
              Obx(() {
                return _buildItem(
                  Assets.mineIcNickname,
                  "real_name".tr,
                  // UserService.to.state.userInfo.realName?.isEmpty == true ||
                  //         UserService.to.state.userInfo.realName == null
                  //     ? controller.realName
                  //     : controller.verifyState.value
                  //         ? controller.realName //加载未加密的昵称
                  //         : "skkskk",

                  controller.checkState.value
                      ? controller.realNameView.value
                      : controller.realName,
                  // controller.realNameView.value.isEmpty ? controller.realName : controller.realNameView.value,
                  isVisible:
                      controller.userState.userInfo.realName?.isNotEmpty ??
                          false,
                  onVisibleTap: () async {
                    if (controller.realNameView.isEmpty) {
                      showRealName();
                    } else {
                      controller.checkState.value =
                          !controller.checkState.value;
                    }
                  },
                  onTap: () async {
                    if (controller.realNameView.isEmpty) {
                      showRealName();
                    } else {
                      controller.checkState.value =
                          !controller.checkState.value;
                    }
                  },
                );
              }),
              Container(
                height: 1,
                color: appnewColors.lineColor,
              ),
              _buildItem(
                Assets.mineIcGender,
                "gender".tr,
                controller.gender,
                isShowleft: controller.gender == '未选择'.tr,
                onTap: () async {
                  bool? isMale;
                  final currentGenderInt = controller.userState.userInfo.gender;
                  if (currentGenderInt == 1 || currentGenderInt == 2) return;
                  if (currentGenderInt == 1) {
                    isMale = true; // 1 表示男
                  } else if (currentGenderInt == 2) {
                    isMale = false; // 2 表示女
                  } else {
                    isMale = null; // 未设置性别
                  }
                  final gender = await Get.bottomSheet<int>(
                      DialogChangeGender(isMale: isMale));
                  if (gender != null) {
                    // 检查是否有变化，没有变化就不更新
                    final newGenderValue =
                        gender == 0 ? 1 : 2; // 0->1(男), 1->2(女)

                    if (currentGenderInt == newGenderValue) {
                      return; // 没有变化，直接返回
                    }
                    // 更新本地状态
                    controller.userState.userInfo.gender = newGenderValue;
                    controller.update();
                  }
                },
              ),
              Container(
                height: 1,
                color: appnewColors.lineColor,
              ),
              _birthdaybuildItem(
                Assets.mineIcBirthday,
                "birthday".tr,
                controller.birthday,
                onTap: () async {
                  if (controller.userState.birthday.isNotEmpty) {
                    AppUtils.showToast('not_editable'.tr);
                    return;
                  }
                  Get.dialog(SkBaseDialog(
                      bgColor: Colors.white,
                      callback: () async {
                        // Get.back();
                        final birthday = await Get.bottomSheet<DateTime>(
                            DialogChangeBirthday());

                        if (birthday == null) {
                          return; // 用户取消选择
                        }
                        controller.update();
                      },
                      cancelCallback: () {
                        // Get.back();
                      },
                      title: "tips".tr,
                      showFooterBtn: true,
                      showDeleteBtnType: '1',
                      leftBtnTitle: "cancel".tr,
                      rightBtnTitle: "confirm".tr,
                      showDeleteBtn: false,
                      child: Container(
                        padding: EdgeInsets.all(20.r),
                        child: Text(
                          "生日信息用于领取礼金，一经确定不可修改",
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )));
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(
    String img,
    String title,
    String content, {
    GestureTapCallback? onTap,
    bool isShowleft = true,
    bool isVisible = false,
    GestureTapCallback? onVisibleTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        height: 48.w,
        // margin: EdgeInsets.only(bottom: 10.w),
        child: Row(
          children: [
            // Container(
            //   width: 22.w,
            //   height: 22.w,
            //   alignment: Alignment.center, // 居中
            //
            //   child: Image.asset(
            //     img,
            //     width: 22.w,
            //     height: 22.w,
            //   ),
            // ),
            Container(
              // margin: EdgeInsets.only(left: 15.w),
              child: Text(
                title,
                style: TextStyle(
                    color: appnewColors.text22,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (isVisible)
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: GestureDetector(
                  onTap: onVisibleTap,
                  child: Icon(
                    controller.checkState.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 18.w,
                    color: Color(0xFF999999),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 5.w, left: 5.r),
                alignment: Alignment.centerRight,
                child: Text(
                  content,
                  style: TextStyle(
                      color: appnewColors.textFourth, fontSize: 14.sp),
                ),
              ),
            ),
            if (isShowleft)
              Container(
                width: 16.w,
                height: 16.h,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.mineIconArrowR,
                  width: 10.w,
                  height: 10.h,
                  fit: BoxFit.fill,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _birthdaybuildItem(
    String img,
    String title,
    String content, {
    GestureTapCallback? onTap,
  }) {
    bool isShowleft = controller.userState.userInfo.birthday?.isEmpty == true ||
        controller.userState.userInfo.birthday == null;

    //       ? 'unset'.tr
    //       : userState.userInfo.birthday!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),

        // padding: EdgeInsets.all(10.w),
        height: 48.w,
        // margin: EdgeInsets.only(bottom: 10.w),

        child: Row(
          children: [
            // Container(
            //   width: 22.w,
            //   height: 22.w,
            //   alignment: Alignment.center, // 居中
            //
            //
            //   child: Image.asset(
            //     img,
            //     width: 22.w,
            //     height: 22.w,
            //   ),
            // ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                    color: appnewColors.text22,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
                margin: EdgeInsets.only(right: 5.w),
                child: Text.rich(
                  TextSpan(
                    text: isShowleft
                        ? '添加日期，确保您已满18岁'.tr
                        : controller.userState.userInfo.birthday!, // 默认样式
                    style: TextStyle(
                        color: appnewColors.textFourth, fontSize: 14.sp),
                    children: [
                      // TextSpan(
                      //   text: isShowleft ? "I" : "",
                      //   style: TextStyle(color: appnewColors.text3, fontSize: 12.sp),
                      // ),
                      // TextSpan(
                      //   text: isShowleft ? "设置后不允许修改".tr : "",
                      //   style: TextStyle(color: appnewColors.tip3, fontSize: 12.sp),
                      // ),
                    ],
                  ),
                )),
            if (isShowleft)
              Container(
                width: 16.w,
                height: 16.h,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.mineIconArrowR,
                  width: 10.w,
                  height: 10.h,
                  fit: BoxFit.fill,
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<bool> datePickerCaution(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();
    Get.dialog(SKConfirmDialog.text(
      context,
      'date_of_birth_can_only_be_set_once'.tr,
      onPressed: () {
        completer.complete(true);
        Get.back();
      },
      onClose: () {
        completer.complete(false);
      },
    ));
    return completer.future;
  }

  void showRealName() {
    var realName = UserService.to.state.userInfo.realName ?? "";
    if (realName.isEmpty) {
      Get.toNamed(Routes.REAL_NAME_AUTHENTICATION);
    } else {
      String? needEmail = UserService.to.state.userInfo.email;
      String? needPhone = UserService.to.state.userInfo.phone;
      Get.toNamed(Routes.VERIFY, arguments: {
        'needEmail': needEmail,
        'needPhone': needPhone,
        'verityType': ValidationType.userName,
      })?.then((value) {
        if (value is String) {
          controller.realNameView.value = value;
          controller.checkState.value = true;
        }
      });
    }
  }
}
