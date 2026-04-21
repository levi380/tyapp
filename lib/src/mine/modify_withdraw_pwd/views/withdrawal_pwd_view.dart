import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/withdrawal_pwd_controller.dart';

//修改取款密码/忘记取款密码提示页
class WithdrawalPwdView extends GetView<WithdrawalPwdController> {
  const WithdrawalPwdView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: '修改取款密码'.tr,
      ),
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 83.w,
            height: 80.w,
            decoration: const BoxDecoration(
              color: Color(0xFF28B955),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 38.w,
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            '您已设置取款密码',
            style: TextStyle(
              fontSize: 16.sp,
              color: appnewColors.text31,
            ),
          ),

          SizedBox(height: 24.h),

          /// 修改密码按钮
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  // String needEmail = UserService.to.state.userInfo.email ?? "";
                  // String needPhone = UserService.to.state.userInfo.phone ?? "";
                  // if (needEmail.isNotEmpty || needPhone.isNotEmpty) {
                  //   var isResult = await Get.toNamed(Routes.VERITY_IDENTITY, arguments: {
                  //     'needEmail': needEmail,
                  //     'needPhone': needPhone,
                  //     'verityType': ValidationType.changePayPwd,
                  //   });
                  //   if (isResult is String) {
                  //     Get.toNamed(Routes.MODIFY_WITHDRAW_PWD, arguments: {'sid': isResult});
                  //   }
                  // } else {
                    Get.toNamed(Routes.MODIFY_WITHDRAW_PWD);
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appnewColors.bgBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'modify_pwd'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  // var phone = UserService.to.state.userInfo.phone ?? "";
                  // if (phone.isEmpty) {
                  //   final bindPhone = Get.toNamed(Routes.BIND_PHONE);
                  // } else {
                  ///都是验证手机号
                  Get.toNamed(Routes.RETRIEVE_WITHDRAWAL_PWD);
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAFAFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'forgot_pwd'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9AA0A6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
