import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/setting/pwd_modify/verify_phone/verify_phone_controller.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/area_code_selector.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/dialog/dialog_area_code.dart';
import 'package:filbet/widgets/dialog/safe_verify_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyPhone extends GetView<VerifyPhoneController> {
  VerifyPhone({super.key, required this.verityType, this.deleteId});

  bool isDisableInput = true;

  bool isDepositEnabled = true;
  ValidationType verityType;
  String? deleteId;

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyPhoneController());
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
              Get.dialog(
                SafeVerifyDialog(
                    phoneNum: UserService.to.state.userInfo.phone ?? '',
                    verifyType: verityType,
                    deleteId: deleteId,
                    safeVerifyConfirm: (value) {
                      controller.safeVerifyConfirm(verityType, value);
                    }),
                barrierDismissible: false,
              );
            }
          });
    });
  }

  Widget nextBtn() {
    return Obx(() {
      return CommonActionButton(
        content: Text(
          'verify_finished'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 44.h,
        isActive: controller.codeText.trim().isNotEmpty &&
            controller.codeText.trim().length > 5,
        onPressed: () async {
          controller.nextStep(verityType);
        },
        borderRadius: BorderRadius.circular(12.r),
      );
    });
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
