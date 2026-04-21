import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountSecurityTipsDialog extends StatefulWidget {
  const AccountSecurityTipsDialog({super.key});

  @override
  State<AccountSecurityTipsDialog> createState() => _AccountSecurityTipsDialog();
}

class _AccountSecurityTipsDialog extends State<AccountSecurityTipsDialog> {
  @override
  Widget build(BuildContext context) {
    return SkBaseDialog(
      callback: () {},
      cancelCallback: () {},
      title: "tips".tr,
      showFooterBtn: false,
      showDeleteBtn: false,
      showOneBtn: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Text(
              "为账户与资金安全提示".tr,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: appnewColors.text1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back(result: true);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              height: 44.h,
              width: 166.w,
              decoration: BoxDecoration(
                color: appnewColors.bgBlue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                '确认',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: appnewColors.text4,
                  fontFamily: "PingFang SC",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
