import 'dart:async';

import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawDepositHintDialog extends StatefulWidget {
  const WithdrawDepositHintDialog({super.key});

  @override
  State<WithdrawDepositHintDialog> createState() =>
      _WithdrawDepositHintDialog();
}

class _WithdrawDepositHintDialog extends State<WithdrawDepositHintDialog> {
  int seconds = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return SkBaseDialog(
      callback: () {},
      cancelCallback: () {},
      title: "重要提醒",
      showFooterBtn: false,
      showDeleteBtn: false,
      showOneBtn: true,
      showDeleteBtnType: '2',
      rightBtnTitle: "register".tr,
      margin: EdgeInsets.symmetric(horizontal: 45.r),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text.rich(
              TextSpan(
                text: '平台不会有任何工作人员联系您绑定虚拟币地址并引导提款一经发现请与平台客服联系，',
                children: [
                  TextSpan(
                    text: '谨防诈骗！！！',
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: appnewColors.textRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: appnewColors.text22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 0.r),
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
                  color:
                      seconds > 0 ? appnewColors.text31 : appnewColors.textBlue,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
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
