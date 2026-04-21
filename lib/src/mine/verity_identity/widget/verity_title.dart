import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerityKfView extends StatelessWidget {
  VerityKfView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: InkWell(
        onTap: () {
          AppNavigator.gotoseveiceForMain();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "如需帮助？请",
              style: TextStyle(
                  color: Color(0xff7B7F8B),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
            ),
            Text(
              "联系客服",
              style: TextStyle(
                  color: Color(0xff4C96FF),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class VerityTitleView extends StatelessWidget {
  String title;

  VerityTitleView({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'PingFang SC',
          color: appnewColors.text1,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
