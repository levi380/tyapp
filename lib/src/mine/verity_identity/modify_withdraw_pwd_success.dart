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

///修改取款密码成功
class ModifyWithdrawPwdSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModifyWithdrawPwdSuccessState();
  }
}

class ModifyWithdrawPwdSuccessState extends State<ModifyWithdrawPwdSuccess> {
  VerityIdentityController controller = Get.find();

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
        title: '取款密码'.tr,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.w, top: 20.w, right: 20.w),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                Assets.mineWithdrawSuccess,
                width: 83.w,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20.w, bottom: 20.w),
              child: Text(
                "您已设置取款密码",
                style: TextStyle(
                    color: Color(0xff7B7F8B),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),

            ///下一步
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: nextBtn(),
            ),

            ///忘记密码
            forgetPwdBtn()
          ],
        ),
      ),
    );
  }

  Widget nextBtn() {
    return CommonActionButton(
      content: Text(
        '提交'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      height: 44.h,
      isActive: true,
      onPressed: () {
        //todo 下一步
      },
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  Widget forgetPwdBtn() {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      height: 45.w,
      width: 1.sw,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffFAFAFC), borderRadius: BorderRadius.circular(8.w)),
      child: Text("忘记密码"),
    );
  }
}
