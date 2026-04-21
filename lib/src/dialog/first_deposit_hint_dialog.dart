import 'dart:async';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/payment_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FirstDepositHintDialog extends StatefulWidget {
  const FirstDepositHintDialog({super.key});

  @override
  State<FirstDepositHintDialog> createState() => _FirstDepositHintDialog();
}

class _FirstDepositHintDialog extends State<FirstDepositHintDialog> {
  int seconds = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appnewColors.bg1,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                margin: EdgeInsets.only(left: 45.w, right: 45.w, top: 38.h),
                height: 222.h,
                child: Column(
                  children: [
                    SizedBox(height: 53.h),
                    Text(
                      '安全提示',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: appnewColors.text1,
                      ),
                    ),
                    SizedBox(height: 14.h),

                    /// 内容
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: appnewColors.text1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'PingFang SC',
                          ),
                          children: [
                            TextSpan(text: "如有客服人员主动提供卡号引导您进行存款，"),
                            TextSpan(
                              text: "请勿进行资金交易",
                              style: TextStyle(color: Colors.red),
                            ),
                            TextSpan(text: "，否则造成资金损失，平台概不负责。"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14.h, bottom: 0.r),
                      width: 1.sw,
                      height: 1.r,
                      color: appnewColors.colorLine,
                    ),

                    InkWell(
                      onTap: () {
                        if (seconds <= 0) {
                          Get.back(result: true);
                        }
                      },
                      child: Container(
                        height: 50.h,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          seconds > 0 ? "我知道了（${seconds}s）" : '我知道了',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: seconds > 0 ? appnewColors.text31 : appnewColors.textBlue,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    Assets.mineIconSafetyTips,
                    height: 78.h,
                    width: 137.w,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
