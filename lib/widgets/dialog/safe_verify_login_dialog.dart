import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

typedef SafeVerifyConfirm = Function(
    bool? value, String inputContent, bool isFirst);

class SafeVerifyLoginDialog extends StatefulWidget {
  SafeVerifyLoginDialog({
    super.key,
    required this.phoneNum,
    required this.safeVerifyConfirm,
    required this.sid,
  });

  final String phoneNum;
  final String sid;
  final SafeVerifyConfirm safeVerifyConfirm;
  bool isFirst = true;

  @override
  State<SafeVerifyLoginDialog> createState() => _SafeVerifyLoginDialogState();
}

class _SafeVerifyLoginDialogState extends State<SafeVerifyLoginDialog> {
  late final TextEditingController _pinController;
  late final FocusNode _pinFocusNode;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _pinFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

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
    List<String> phoneArr = widget.phoneNum.split('****');
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
            child: widget.phoneNum.length < 7
                ? Text(
                    widget.phoneNum,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text.rich(
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
            length: 4,
            controller: _pinController,
            focusNode: _pinFocusNode,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) {},
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
                final inputContent = _pinController.text;
                if (inputContent.length < 4) {
                  return;
                }
                updateLoginPwd1(inputContent, widget.isFirst);
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

  void updateLoginPwd1(String inputContent, bool isFirst) async {
    bool? result =
        await ApiRequest.loginStep2(widget.sid, inputContent, isFirst);
    widget.isFirst = false;
    Get.back();
    widget.safeVerifyConfirm(result, inputContent, isFirst);
  }
}
