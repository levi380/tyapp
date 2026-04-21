import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/mine/verity_identity/bind_phone_controller.dart';
import 'package:filbet/src/mine/verity_identity/verity_identity_controller.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_input.dart';
import 'package:filbet/src/mine/verity_identity/widget/verity_title.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///绑定手机号
class BindPhoneView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    Get.put(SecurityService());
    return BindPhoneViewState();
  }
}

class BindPhoneViewState extends State<BindPhoneView> {
  final BindPhoneController _controller = Get.put(BindPhoneController());

  bool isDepositEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: '手机号码'.tr,
      ),
      body: Obx(() {
        return Column(
          children: [
            SizedBox(
              height: 10.w,
            ),
            topInfo(),
            Container(
              padding: EdgeInsets.only(left: 20.w, top: 20.w, right: 20.w),
              child: Column(
                children: [
                  VerityTitleView(
                    title: "手机号码",
                  ),

                  ///手机号输入框
                  Padding(
                    padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                    child: VerityInput(
                      controller: _controller.phoneController,
                      leftView: countryCode(),
                      hintStr: "请输入手机号",
                    ),
                  ),
                  VerityTitleView(
                    title: "手机验证码",
                  ),

                  ///验证码输入框
                  Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: VerityInput(
                      controller: _controller.codeController,
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
            )
          ],
        );
      }),
    );
  }

  Widget countryCode() {
    return Row(
      children: [
        Text(
          "+86",
          style: TextStyle(color: Color(0xff7B7F8B), fontSize: 14.sp, fontWeight: FontWeight.w700),
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
    return CountDownTimer(
      content: 'get_code'.tr,
      countdownSeconds: _controller.countdownSeconds.value,
      callback: () async {
        var phone = _controller.phoneController.text.trim();
        if (phone.isEmpty) {
          AppUtils.showToast('请输入手机号'.tr);
          return;
        }
        var isSuccess = await _controller.phoneBindStep1(phone);
      },
    );
  }

  Widget nextBtn() {
    return CommonActionButton(
      content: Text(
        '完成绑定'.tr,
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
        var isSuccess = await _controller.postPhoneBind();
        if (isSuccess) {
          UserService.to.getUserInfos();
          AppUtils.showToast('add_success'.tr);
          Get.back(result: true);
        }
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  Widget topInfo() {
    return Container(
      height: 32.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.w),
      color: Color(0xffF8F8FF),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            Assets.mineVerityAttention,
            width: 12.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "为了您的账户安全，请确保填写真实信息",
            style: TextStyle(color: Color(0xff8888A1), fontSize: 12.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
