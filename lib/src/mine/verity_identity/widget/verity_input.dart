import 'package:filbet/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//密码输入框
class VerityInput extends StatefulWidget {

  TextEditingController controller;
  bool isDisableInput = false;
  Widget? leftView;
  Widget? rightView;
  String? hintStr;
  bool obscureText;
  final bool hasFocus;
  final FocusNode? focusNode;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChanged;

  VerityInput(
      {super.key,
      required this.controller,
      this.isDisableInput = false,
      this.obscureText = false,
      this.inputFormatters,
      this.keyboardType,
      this.hintStr,
      this.hasFocus = false,
      this.focusNode,
      this.leftView,
      this.onChanged,
      this.rightView});

  @override
  State<StatefulWidget> createState() {
    return VerityInputState();
  }
}

class VerityInputState extends State<VerityInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(color: Color(0xffFAF9FE), borderRadius: BorderRadius.circular(8.w)),
      child: Row(
        children: [
          //左边开始显示
          widget.leftView ?? SizedBox(),
          //输入框内容
          Expanded(
            child: Container(
              height: 40.w,
              alignment: Alignment.center,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: widget.controller,
                focusNode: widget.focusNode,
                readOnly: widget.isDisableInput,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                style: TextStyle(fontSize: 14.sp, color: widget.isDisableInput ? Color(0xff7B7F8B) : Color(0xff1D1D1F)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintStyle: TextStyle(color: Color(0xff7B7F8B), fontSize: 14.sp),
                  hintText: widget.hintStr,
                  suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
                        widget.hasFocus
                            ? GestureDetector(
                                child: Image.asset(
                                  Assets.mineIconClearInputContent,
                                  width: 16.r,
                                  height: 16.r,
                                ),
                                onTap: () {
                                  widget.controller.clear();
                                  // 通知父组件文本已清除
                                  if (widget.onChanged != null) {
                                    widget.onChanged!('');
                                  }
                                },
                              )
                            : Text(""),
                        SizedBox(width: 8.w),
                        widget.hasFocus
                            ? GestureDetector(
                                child: Image.asset(
                                  widget.obscureText ? Assets.loginHidePwd : Assets.loginShowPwd,
                                  width: 16.r,
                                  height: 16.r,
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.obscureText = !widget.obscureText;
                                  });
                                },
                              )
                            : Text(""),
                        SizedBox(width: 8.w),
                      ])),
                ),
              ),
            ),
          ),
          //右边显示
          widget.rightView ?? SizedBox(),
        ],
      ),
    );
  }
}
