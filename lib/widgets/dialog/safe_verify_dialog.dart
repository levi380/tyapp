import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

typedef SafeVerifyConfirm = Function(String value);

class SafeVerifyDialog extends StatelessWidget {
  SafeVerifyDialog({
    super.key,
    required this.phoneNum,
    required this.safeVerifyConfirm,
    required this.verifyType,
    this.deleteId,
  });

  final String phoneNum;
  final ValidationType verifyType;
  final SafeVerifyConfirm safeVerifyConfirm;
  final String? deleteId;
  String inputContent = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            contentView(),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      height: 48.r,
      margin: EdgeInsets.only(top: 10.r),
      alignment: Alignment.center,
      child: Text(
        '安全校验',
        style: TextStyle(
          color: appnewColors.textMain,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget contentView() {
    final defaultPinTheme = buildDefaultTheme();
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appnewColors.borderBlue),
    );
    final submittedPinTheme = defaultPinTheme;
    List<String> tipArr = StringUtils.extractParts('phone_num_finish_tip'.tr);
    List<String> phoneArr = phoneNum.split('****');
    return Container(
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: tipArr[0]),
                TextSpan(
                  text: tipArr[1],
                  style: TextStyle(
                    color: appnewColors.textRed,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: tipArr[2]),
              ],
            ),
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.r, bottom: 15.r),
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: phoneArr[0]),
                  TextSpan(
                    text: '****',
                    style: TextStyle(
                      color: appnewColors.textRed,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (phoneArr.length > 1)
                    TextSpan(
                      text: phoneArr[1],
                    ),
                ],
              ),
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Pinput(
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            validator: (s) {
              // return s == '2222' ? null : 'Pin is incorrect';
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) {
              inputContent = pin;
            },
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget bottomView() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appnewColors.colorLine,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '取消',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textMain,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (inputContent.length < 4) {
                  return;
                }
                confirm();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '确定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textBlue,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentItemView(String title, String content, {bool isTitle = false}) {
    return Container(
      height: 36.r,
      decoration: BoxDecoration(
        color: isTitle ? appnewColors.bgGray2 : null,
        borderRadius: BorderRadius.vertical(
          top: isTitle ? Radius.circular(8.r) : Radius.zero,
          bottom: isTitle ? Radius.zero : Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine2,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PinTheme buildDefaultTheme() {
    return PinTheme(
      width: 50.r,
      height: 50.r,
      textStyle: TextStyle(
          fontSize: 16.r,
          color: appnewColors.text1,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: appnewColors.bg4,
      ),
    );
  }

  void confirm() {
    switch (verifyType) {
      case ValidationType.changeLoginPwd:
        updateLoginPwd1();
        break;
      case ValidationType.changePayPwd:
        payPwdResetStep1();
        break;
      case ValidationType.checkData:
        break;
      case ValidationType.deleteData:
        deleteAccountStep1();
        break;
      case ValidationType.userName:
        userNameStep1();
        break;
      case ValidationType.checkAccount:
        userNameStep1();
        break;
    }
  }

  void updateLoginPwd1() async {
    String? sid = await ApiRequest.updateLoginPwd1(inputContent);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }

  void userNameStep1() async {
    String? sid = await ApiRequest.infoViewStep1(inputContent);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }

  void payPwdResetStep1() async {
    String? sid = await ApiRequest.payPwdResetStep1(inputContent);
    if (sid != null && sid.isNotEmpty) {
      bool? isSuccess = await ApiRequest.payPwdResetStep2(sid);
      if (isSuccess != null && isSuccess) {
        safeVerifyConfirm(sid);
        Get.back();
      }
    }
  }

  void deleteAccountStep1() async {
    String? sid =
        await ApiRequest.deleteAccountStep1(deleteId ?? '', inputContent);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }
}
