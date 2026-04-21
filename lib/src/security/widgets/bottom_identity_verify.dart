import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/count_down_timer.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomIdentityVerify extends StatelessWidget {
  BottomIdentityVerify({super.key, required this.phoneNum});

  final String phoneNum;
  final TextEditingController codeEditingController = TextEditingController();
  final countdownSeconds = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.r),
          child: Text(
            'verify_identity_title'.tr,
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 14.sp,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25.r, right: 25.r, top: 14.r),
          child: SkCommonTextField(
            isError: false,
            hintText: phoneNum,
            isObscure: false,
            enable: false,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25.r, right: 25.r, top: 10.r),
          child: SkCommonTextField(
            isError: false,
            hintText: 'input_verify_code'.tr,
            isObscure: false,
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            suffix: Obx(() {
              return CountDownTimer(
                content: 'get_code'.tr,
                countdownSeconds: countdownSeconds.value,
                callback: () {
                  countdownSeconds.value = 0;
                  clickQuerySmsCode();
                },
              );
            }),
            controller: codeEditingController,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 16.r,
            right: 16.r,
            top: 30.r,
            bottom: 30.r,
          ),
          child: CommonActionButton.confirm(
            true,
            content: 'verify_finished'.tr,
            onPressed: () async {
              clickVerifyFinish();
            },
          ),
        ),
      ],
    );
  }

  void clickQuerySmsCode() {
    //发送成功，倒计时60s
  }

  void clickVerifyFinish() {
    //完成验证
    String code = codeEditingController.text;
    if (code.isEmpty) {
      AppUtils.showToast('input_verify_code'.tr);
      return;
    }
  }
}
