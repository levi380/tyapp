import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final bool isObscure;
  final String? hintText;
  final double? cornerRadius;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool isError;
  final Color? bgcolor;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;

  const CommonTextfield({
    super.key,
    this.controller,
    this.isObscure = false,
    this.hintText,
    this.bgcolor,
    this.cornerRadius,
    this.focusNode,
    this.maxLength,
    this.suffix,
    this.isError = false,
    this.keyboardType,
    this.inputFormatters,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      obscuringCharacter: '•',
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: isError ? appColors.textRedColor : appColors.inputTextStyleColor,
      style: style ??
          TextStyle(
            color: isError ? appColors.textRedErrorColor : appnewColors.text1,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: appColors.textSecond2Color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
        filled: true,
        fillColor: isError ? appColors.bgErrorColor.withValues(alpha: 0.1) : fillColor ?? appColors.bgSecondColor,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? 12.r),
          borderSide: isError ? BorderSide(color: appColors.textRedColor) : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? 12.r),
          borderSide: isError ? BorderSide(color: appColors.textRedColor) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? 12.r),
          borderSide: isError ? BorderSide(color: appColors.textRedColor) : BorderSide.none,
        ),
        suffixIcon: suffix != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                child: suffix,
              )
            : null,
        suffixIconConstraints: suffix != null
            ? BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              )
            : null,
      ),
    );
  }
}
