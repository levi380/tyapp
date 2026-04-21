import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkCommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isObscure;
  final String? hintText;
  final double? cornerRadius;
  final BorderRadius? radius;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool isError;
  final Color? bgColor;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? obscuringCharacter;
  final bool? enable;
  final String? errorText;
  final TextStyle? errorStyle;

  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final bool isCollapsed;
  final Color? cursorColor;

  /// 为 null 时使用 [EdgeInsets.fromLTRB(12.r, 0, 8.r, 0)]
  final EdgeInsetsGeometry? prefixIconPadding;
  /// 为 null 时使用 [EdgeInsets.fromLTRB(12.r, 0, 12.r, 0)]
  final EdgeInsetsGeometry? suffixIconPadding;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  /// 非错误态：启用/失焦时的描边；与 [focusedBorderSide] 配合用于登录等定制样式
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  /// 错误态描边；为 null 时使用主题红
  final BorderSide? errorBorderSide;
  /// 为 false 时错误态不改变 [fillColor]（仅边框变红）
  final bool tintFillOnError;

  const SkCommonTextField({
    super.key,
    this.controller,
    this.isObscure = false,
    this.radius,
    this.hintText,
    this.bgColor,
    this.cornerRadius,
    this.focusNode,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.isError = false,
    this.keyboardType,
    this.inputFormatters,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.obscuringCharacter,
    this.enable,
    this.errorText,
    this.errorStyle,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.textAlignVertical,
    this.isCollapsed = false,
    this.cursorColor,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.errorBorderSide,
    this.tintFillOnError = true,
  });

  BorderRadius _resolvedRadius() =>
      radius ?? BorderRadius.circular(cornerRadius ?? 8.r);

  OutlineInputBorder _ob(BorderSide side) => OutlineInputBorder(
        borderRadius: _resolvedRadius(),
        borderSide: side,
      );

  @override
  Widget build(BuildContext context) {
    final fillColorResolved = isError && tintFillOnError
        ? appColors.bgErrorColor.withValues(alpha: 0.1)
        : fillColor ?? appnewColors.bg4;

    final errorSide =
        errorBorderSide ?? BorderSide(color: appColors.textRedColor);

    late final OutlineInputBorder borderDefault;
    late final OutlineInputBorder borderEnabled;
    late final OutlineInputBorder borderFocused;
    late final OutlineInputBorder borderDisabled;

    if (isError) {
      borderDefault = _ob(errorSide);
      borderEnabled = _ob(errorSide);
      borderFocused = _ob(errorSide);
      borderDisabled = _ob(errorSide);
    } else if (enabledBorderSide != null) {
      borderDefault = _ob(enabledBorderSide!);
      borderEnabled = _ob(enabledBorderSide!);
      borderDisabled = _ob(enabledBorderSide!);
      borderFocused = _ob(focusedBorderSide ?? enabledBorderSide!);
    } else {
      borderDefault = _ob(BorderSide.none);
      borderEnabled = _ob(BorderSide.none);
      borderFocused = _ob(BorderSide.none);
      borderDisabled = _ob(BorderSide.none);
    }

    final resolvedCursor = cursorColor ??
        (isError ? appColors.textRedColor : appColors.inputTextStyleColor);

    return TextField(
      obscureText: isObscure,
      obscuringCharacter: obscuringCharacter ?? '•',
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      enabled: enable,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlignVertical: textAlignVertical,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      cursorColor: resolvedCursor,
      style: style ??
          TextStyle(
            color: isError ? appColors.textRedErrorColor : appnewColors.text1,
            fontSize: 14.sp,
          ),
      decoration: InputDecoration(
        isCollapsed: isCollapsed,
        counterText: '',
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: appnewColors.text3,
              fontSize: 14.sp,
            ),
        filled: true,
        isDense: true,
        fillColor: fillColorResolved,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
        border: borderDefault,
        enabledBorder: borderEnabled,
        focusedBorder: borderFocused,
        disabledBorder: borderDisabled,
        suffixIcon: suffix != null
            ? Padding(
                padding: suffixIconPadding ??
                    EdgeInsets.fromLTRB(12.r, 0, 12.r, 0),
                child: suffix,
              )
            : null,
        suffixIconConstraints: suffix != null
            ? (suffixIconConstraints ??
                const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ))
            : null,
        prefixIcon: prefix != null
            ? Padding(
                padding: prefixIconPadding ??
                    EdgeInsets.fromLTRB(12.r, 0, 8.r, 0),
                child: prefix,
              )
            : null,
        prefixIconConstraints: prefix != null
            ? (prefixIconConstraints ??
                const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ))
            : null,
        errorText: errorText,
        errorStyle: errorStyle ??
            TextStyle(
              fontSize: 12.sp,
              color: appColors.textRedColor,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
        errorMaxLines: 1,
      ),
    );
  }
}
