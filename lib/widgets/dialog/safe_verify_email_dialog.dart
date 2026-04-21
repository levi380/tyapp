import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

typedef SafeVerifyConfirm = Function(String value);

class SafeVerifyEmailDialog extends StatelessWidget {
  SafeVerifyEmailDialog({
    super.key,
    required this.subEmail,
    required this.safeVerifyConfirm,
    required this.verifyType,
    this.deleteId,
  });

  final String subEmail;
  final ValidationType verifyType;
  final SafeVerifyConfirm safeVerifyConfirm;
  final String? deleteId;
  String inputContent = "";
  final TextEditingController textController = TextEditingController();

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
    String tipArr = '为了保障您的账户安全,请输入邮箱中间隐藏账号';
    return Container(
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: tipArr),
              ],
            ),
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 12.sp,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.r, bottom: 15.r),
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: subEmail),
                ],
              ),
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 14.sp,
              ),
            ),
          ),
          Container(
            height: 36.r,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: appnewColors.border1),
            ),
            child: TextField(
              controller: textController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                fillColor: appnewColors.textMain,
                contentPadding: EdgeInsets.only(left: 12.w, right: 12.w),
              ),
              onChanged: (value) {
                inputContent = value;
              },
            ),
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
                if (inputContent.isEmpty) {
                  AppUtils.showToast('请输入邮箱中间隐藏账号');
                  return;
                }
                String inputEmail =
                    subEmail.replaceAll('****', inputContent.trim());
                confirm(inputEmail);
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

  void confirm(String email) {
    switch (verifyType) {
      case ValidationType.changeLoginPwd:
        updateLoginPwd1(email);
        break;
      case ValidationType.changePayPwd:
        break;
      case ValidationType.checkData:
        break;
      case ValidationType.deleteData:
        deleteAccountStep1(email);
        break;
      case ValidationType.userName:
        userNameStep1(email);
        break;
      case ValidationType.checkAccount:
        break;
    }
  }

  void updateLoginPwd1(String inputEmail) async {
    String? sid = await ApiRequest.updateLoginPwd1(inputEmail);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }

  void userNameStep1(String inputEmail) async {
    String? sid = await ApiRequest.infoViewStep1(inputEmail);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }

  void deleteAccountStep1(String inputEmail) async {
    String? sid =
        await ApiRequest.deleteAccountStep1(deleteId ?? '', inputEmail);
    if (sid != null) {
      safeVerifyConfirm(sid);
      Get.back();
    }
  }
}
