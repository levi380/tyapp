import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/verity_identity/phone_verity/phone_verity_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/dialog_area_code.dart';
import 'package:filbet/widgets/dialog/safe_verify_dialog.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneVerity extends GetView<PhoneVerityController> {
  PhoneVerity({super.key, this.verityType, this.accountId});

  bool isDisableInput = true;

  bool isDepositEnabled = true;
  ValidationType? verityType;
  String? accountId;

  @override
  Widget build(BuildContext context) {
    Get.put(PhoneVerityController());
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          VerityTitleView(
            title: "手机号码",
          ),

          ///手机号输入框
          Padding(
            key: controller.phoneContainerKey,
            padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
            child: VerityInput(
              controller: controller.phoneController,
              isDisableInput: isDisableInput,
              leftView: countryCode(),
            ),
          ),
          VerityTitleView(
            title: "手机验证码",
          ),

          ///验证码输入框
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: VerityInput(
              controller: controller.codeController,
              hintStr: "请输入手机验证码",
              rightView: sendSmsCode(),
            ),
          ),

          ///下一步
          Padding(
            padding: EdgeInsets.only(top: 30.w),
            child: nextBtn(),
          ),

          ///联系客服
          VerityKfView()
        ],
      ),
    );
  }

  Widget countryCode() {
    return AreaCodeSelector(
      areaCodeLabel: Obx(() {
        return Text(
          controller.selAreaCodeText.value ?? "+86",
          style: TextStyle(
            color: appnewColors.text1,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        );
      }),
      onTap: _showAreaCodeDialogBelowPhone,
    );
  }

  Widget sendSmsCode() {
    return Obx(() {
      return CountDownTimer(
          content: '获取验证码',
          countdownSeconds: controller.countdownSeconds.value,
          callback: () async {
            String phone = UserService.to.state.userInfo.phone ?? '';
            if (phone.isNotEmpty) {
              //todo 根据不同类型加载不同接口
              if (ValidationType.changeLoginPwd.name == verityType?.name) {
              } else if (ValidationType.checkData.name == verityType?.name) {
              } else if (ValidationType.deleteData.name == verityType?.name) {
              } else if (ValidationType.changePayPwd.name == verityType?.name) {
                Get.dialog(
                  SafeVerifyDialog(
                      phoneNum: UserService.to.state.userInfo.phone ?? '',
                      verifyType: ValidationType.changePayPwd,
                      safeVerifyConfirm: (sid) {
                        controller.safeVerifyConfirm(
                            ValidationType.changePayPwd, sid);
                      }),
                  barrierDismissible: false,
                );
              } else if (ValidationType.checkAccount.name == verityType?.name) {
                Get.dialog(
                  SafeVerifyDialog(
                      phoneNum: UserService.to.state.userInfo.phone ?? '',
                      verifyType: ValidationType.checkAccount,
                      safeVerifyConfirm: (value) {
                        controller.safeVerifyConfirm(
                            ValidationType.checkAccount, value);
                      }),
                  barrierDismissible: false,
                );
              } else {
                // var isSuccess = await controller.postPhoneVerify(value);
                // if (isSuccess) {
                //   String replacePhone = phone.replaceAll("****", value);
                //   controller.countdownSeconds.value = 0;
                //   controller.getSendBindCode(replacePhone);
                // }
              }
            }
          });
    });
  }

  Widget nextBtn() {
    return CommonActionButton(
      content: Text(
        '下一步'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      height: 44.h,
      isActive: isDepositEnabled,
      onPressed: () async {
        if (controller.codeController.text.trim().isEmpty) {
          return AppUtils.showToast('请输入验证码！');
        }
        // var isSuccess = await controller.phoneCodeVerify(1, controller.codeController.text.trim(), 2);
        // if (isSuccess) {
        //todo 根据不同类型加载不同接口
        if (ValidationType.changeLoginPwd.name == verityType?.name) {
          Get.back(result: true);
        } else if (ValidationType.checkData.name == verityType?.name) {
          Get.back(result: true);
        } else if (ValidationType.deleteData.name == verityType?.name) {
          Get.back(result: true);
        } else if (ValidationType.changePayPwd.name == verityType?.name) {
          controller.confirmChangePayPwd(
              controller.mSid, controller.codeController.text);
        } else if (ValidationType.checkAccount.name == verityType?.name) {
          ////信息类型（1=实名，2=手机号，3=邮箱，4=取款地址）
          controller.userNameStep2(4, accountId ?? "");
        } else {}
        // }

        ///测试绑定手机号
        // Get.toNamed(Routes.BIND_PHONE);
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  void _showAreaCodeDialogBelowPhone() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = controller.phoneContainerKey.currentContext;
      final box = context?.findRenderObject() as RenderBox?;
      double? left, top, width;
      if (box != null && box.hasSize) {
        final offset = box.localToGlobal(Offset.zero);
        left = offset.dx;
        top = offset.dy + 4.h;
        width = box.size.width;
      }

      DialogAreaCode.show(
        onSelect: (model) =>
            controller.selAreaCodeText.value = model.code ?? '',
        areaCode: controller.selAreaCodeText.value,
        left: left,
        top: top,
        width: width,
      );
    });
  }
}
