import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// “如需帮助？ 请 联系客服” 的公共组件，点击「联系客服」跳转客服
class ContactServiceView extends StatelessWidget {
  const ContactServiceView({
    super.key,
    this.prefixText = '如需帮助？',
    this.middleText = ' 请 ',
    this.linkText = '联系客服',
    this.onTap,
  });

  final String prefixText;
  final String middleText;
  final String linkText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: prefixText,
          style: TextStyle(
            color: appnewColors.text2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: middleText,
              style: TextStyle(
                color: appnewColors.text2,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
                text: linkText,
                style: TextStyle(
                  color: appnewColors.text7,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.gotoseveiceForMain();
                  }),
          ],
        ),
      ),
    );
  }
}
