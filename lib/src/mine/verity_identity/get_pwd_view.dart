import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/verity_identity/verity_identity_controller.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///找回密码
class GetPwdView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetPwdViewState();
  }
}

class GetPwdViewState extends State<GetPwdView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  VerityIdentityController controller = Get.find();

  bool isDisableInput = true;

  bool isDepositEnabled = true;
  var type = 1; //1:手机号码验证。2:邮箱验证

  @override
  void initState() {
    super.initState();

    type = Get.arguments["type"];
    if (type == 1) {
      phoneController.text = "1530098888";
    } else {
      phoneController.text = "456****@qq.com";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: '取款密码找回'.tr,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.w),
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            VerityTitleView(
              title: type == 1 ? "手机号码" : "邮箱号码",
            ),

            ///手机号输入框
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: VerityInput(
                controller: phoneController,
                isDisableInput: isDisableInput,
                leftView: countryCode(),
              ),
            ),
            VerityTitleView(
              title: type == 1 ? "手机验证码" : "邮箱验证码",
            ),

            ///验证码输入框
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: VerityInput(
                controller: codeController,
                hintStr: type == 1 ? "请输入手机验证码" : "请输入邮箱验证码",
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
      ),
    );
  }

  Widget countryCode() {
    return Row(
      children: [
        Text(
          "+86",
          style: TextStyle(
              color: Color(0xff7B7F8B),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Image.asset(
            Assets.mineVerityDown,
            height: 5.w,
            width: 10.w,
          ),
        ),
      ],
    );
  }

  Widget sendSmsCode() {
    return Container(
      child: Text(
        "获取验证码",
        style: TextStyle(
            color: Color(0xff4C96FF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w700),
      ),
    );
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
      onPressed: () {
        //todo 下一步
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
