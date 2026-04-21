import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class BottomSafeVerify extends StatefulWidget {
  const BottomSafeVerify({
    super.key,
    required this.phoneNum,
    this.onConfirm,
  });

  final String phoneNum;
  final void Function(String inputContent)? onConfirm; //close button action

  @override
  State<StatefulWidget> createState() {
    return _BottomSafeVerify();
  }
}

class _BottomSafeVerify extends State<BottomSafeVerify> {
  bool isActive = false;
  String inputContent = "";

  @override
  void initState() {
    super.initState();
    isActive = false;
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = buildDefaultTheme();
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appnewColors.borderBlue),
    );
    final submittedPinTheme = defaultPinTheme;
    List<String> tipArr = StringUtils.extractParts('phone_num_finish_tip'.tr);
    List<String> phoneArr = widget.phoneNum.split('****');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.r),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: tipArr[0]),
                TextSpan(
                  text: tipArr[1],
                  style: TextStyle(
                    color: appnewColors.textRed,
                    fontSize: 14.sp,
                  ),
                ),
                TextSpan(text: tipArr[2]),
              ],
            ),
            style: TextStyle(
              color: appnewColors.text3,
              fontSize: 14.sp,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.r, bottom: 28.r),
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
                if (phoneArr.length > 1) TextSpan(text: phoneArr[1]),
              ],
            ),
            style: TextStyle(
              color: appnewColors.text1,
              fontSize: 18.sp,
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
          onChanged: (value) {
            var inputLength = value.length;
            if (inputLength >= 4) {
              setState(() {
                isActive = true;
              });
            } else {
              setState(() {
                isActive = false;
              });
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(
            left: 16.r,
            right: 16.r,
            top: 55.r,
            bottom: 30.r,
          ),
          child: CommonActionButton.confirm(
            isActive,
            onPressed: () async {
              widget.onConfirm?.call(inputContent);
            },
          ),
        ),
      ],
    );
  }

  PinTheme buildDefaultTheme() {
    return PinTheme(
      width: 48.r,
      height: 48.r,
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

  void clickConfirm() {}
}
