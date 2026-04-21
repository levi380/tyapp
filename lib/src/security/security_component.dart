import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityOptionIconAndTitle extends StatelessWidget {
  final String iconPath;
  final String title;
  final Widget suffix;

  const SecurityOptionIconAndTitle({
    super.key,
    required this.iconPath,
    required this.title,
    this.suffix = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          height: 20.h,
          width: 20.w,
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: appColors.inputTextStyleColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

Widget buildCommonSecuritySuffix(String? name) {
  return Row(
    children: [
      if (name != null) ...[
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            color: appColors.textSecondColor,
          ),
        ),
        SizedBox(width: 4.r),
      ],
      Image.asset(
        Assets.securityIconArrowRight,
        width: 12.r,
        height: 12.r,
      ),
    ],
  );
}

Widget buildSecurityOption(
    {required String iconPath,
    required String title,
    Widget? suffix,
    Color? bgColor,
    VoidCallback? onTap,
    final BorderRadiusGeometry? borderRadius}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      height: 48.r,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecurityOptionIconAndTitle(
            iconPath: iconPath,
            title: title,
          ),
          Spacer(),
          if (suffix != null) suffix,
        ],
      ),
    ),
  );
}

Widget buildSecurityPasswordTextFieldContentWithTitle(
  String title, {
  TextEditingController? controller,
  FocusNode? focusNode,
  String? hintText,
  bool isError = false,
  bool hasFocus = false,
  int? maxLength,
  TextInputType? keyboardType,
  ValueChanged<String>? onChanged,
  final List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: appColors.textMainColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 10.h),
      ChangeLoginPwdOrPayPwdTextField(
        controller: controller,
        onChanged: (value) => controller?.text = value,
        focusNode: focusNode,
        hintText: hintText,
        isError: isError,
        hasFocus: hasFocus,
        keyboardType: keyboardType,
        maxLength: maxLength ?? 12,
        inputFormatters: inputFormatters,
      ),
    ],
  );
}

Widget buildSecurityLoginPwdOrPayPwdTextFieldContentWithTitle(
  String title, {
  TextEditingController? controller,
  FocusNode? focusNode,
  String? hintText,
  bool isError = false,
  bool hasFocus = false,
  int? maxLength,
  TextInputType? keyboardType,
  ValueChanged<String>? onChanged,
  final List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: appColors.textMainColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 10.h),
      ChangeLoginPwdOrPayPwdTextField(
        controller: controller,
        onChanged: (value) => controller?.text = value,
        focusNode: focusNode,
        hintText: hintText,
        isError: isError,
        hasFocus: hasFocus,
        keyboardType: keyboardType,
        maxLength: maxLength ?? 12,
        inputFormatters: inputFormatters,
      ),
    ],
  );
}
