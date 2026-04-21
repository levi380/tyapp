import 'package:filbet/generated/assets.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 登录 / 注册输入框：在 [SkCommonTextField] 上固定配色与描边；前后缀由调用方传入。
/// [suffix] 为 null 时：非密码 → 聚焦且有字显示清除；密码 → 清除 + 显隐。
class LoginAndRegisterTextField extends StatefulWidget {
  static const Color defaultFillColor = Color(0x337486A3);
  static const Color focusBorderColor = Color(0xFF2084D8);
  static const Color errorBorderColor = Color(0xFFEA5B5B);
  static const Color hintTextColor = Color(0xFF7D88A1);

  final TextEditingController? controller;
  final int? maxLength;
  final String hintText;
  final Color? fillColor;
  final double? cornerRadius;
  final FocusNode? focusNode;
  final bool isError;
  final bool hasFocus;
  final void Function(String text)? onChanged;
  final VoidCallback? onSubmitted;
  final TextInputAction? textInputAction;
  final Color? inputTextColor;
  final Color? hintColor;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final bool showClearButton;

  const LoginAndRegisterTextField({
    super.key,
    this.controller,
    this.maxLength,
    required this.hintText,
    this.fillColor = defaultFillColor,
    this.cornerRadius,
    this.focusNode,
    this.isError = false,
    this.hasFocus = false,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.inputTextColor,
    this.hintColor,
    this.obscureText = false,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.showClearButton = true,
  });

  @override
  State<LoginAndRegisterTextField> createState() =>
      _LoginAndRegisterTextFieldState();
}

class _LoginAndRegisterTextFieldState extends State<LoginAndRegisterTextField> {
  late final TextEditingController _c =
      widget.controller ?? TextEditingController();
  late final VoidCallback _repaint = () => setState(() {});
  bool _hidePwd = true;

  @override
  void initState() {
    super.initState();
    _c.addListener(_repaint);
  }

  @override
  void dispose() {
    _c.removeListener(_repaint);
    if (widget.controller == null) _c.dispose();
    super.dispose();
  }

  void _clear() {
    _c.clear();
    widget.onChanged?.call('');
  }

  Widget _clearIconBtn() => IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints.tightFor(width: 36.w, height: 36.w),
        onPressed: _clear,
        icon: Image.asset(Assets.loginCheckError, width: 20.r, height: 20.r),
      );

  BoxConstraints _defaultPrefixConstraints() {
    final minH = 46.r;
    if (widget.prefix == null) {
      return BoxConstraints(minHeight: minH, minWidth: 10.w);
    }
    return BoxConstraints(minHeight: minH, minWidth: 48.w);
  }

  BoxConstraints _defaultSuffixConstraints(bool filled) {
    final minH = 46.r;
    if (widget.obscureText) {
      return BoxConstraints(minHeight: minH, minWidth: 48.w);
    }
    if (widget.suffix != null) {
      return BoxConstraints(minHeight: minH, minWidth: 0);
    }
    return BoxConstraints(
      minHeight: minH,
      minWidth: filled ? 48.w : 0,
    );
  }

  Widget? _buildAutoSuffix(bool filled) {
    if (widget.suffix != null) return null;
    if (widget.obscureText) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showClearButton && filled)
            _clearIconBtn()
          else
            const SizedBox.shrink(),
          SizedBox(width: 8.w),
          if (widget.hasFocus)
            GestureDetector(
              onTap: () => setState(() => _hidePwd = !_hidePwd),
              child: Image.asset(
                _hidePwd ? Assets.loginHidePwd : Assets.loginShowPwd,
                width: 20.r,
                height: 20.r,
              ),
            ),
          SizedBox(width: 8.w),
        ],
      );
    }
    return widget.showClearButton && filled ? _clearIconBtn() : null;
  }

  @override
  Widget build(BuildContext context) {
    final w = widget;
    final filled = _c.text.isNotEmpty && w.hasFocus;
    final bw = 1.w;
    final idle = BorderSide(color: Colors.transparent, width: bw);
    final focus = BorderSide(
        color: LoginAndRegisterTextField.focusBorderColor, width: bw);
    final err = BorderSide(
        color: LoginAndRegisterTextField.errorBorderColor, width: bw);

    final textStyle = TextStyle(
      color: w.inputTextColor ?? Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'PingFang SC',
    );

    final formatters = w.inputFormatters ??
        [
          FilteringTextInputFormatter.allow(
            w.obscureText
                ? AppUtils.getInputFormatters()
                : AppUtils.getInputAccountFormatters(),
          ),
        ];

    final suffixWidget = w.suffix ?? _buildAutoSuffix(filled);

    return SkCommonTextField(
      controller: _c,
      focusNode: w.focusNode,
      maxLength: w.maxLength ?? (w.obscureText ? 12 : 11),
      isObscure: w.obscureText && _hidePwd,
      hintText: w.hintText.tr,
      fillColor: w.fillColor,
      cornerRadius: w.cornerRadius ?? 14.r,
      isError: w.isError,
      tintFillOnError: false,
      errorBorderSide: err,
      enabledBorderSide: w.isError ? null : idle,
      focusedBorderSide: w.isError ? null : focus,
      style: textStyle,
      hintStyle: textStyle.copyWith(
        color: w.hintColor ?? LoginAndRegisterTextField.hintTextColor,
      ),
      cursorColor: textStyle.color,
      inputFormatters: formatters,
      onChanged: w.onChanged,
      onSubmitted: (_) => w.onSubmitted != null
          ? w.onSubmitted!()
          : FocusScope.of(context).nextFocus(),
      textInputAction: w.textInputAction ?? TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      isCollapsed: true,
      contentPadding: EdgeInsets.zero,
      prefix: w.prefix ?? const SizedBox.shrink(),
      prefixIconConstraints:
          w.prefixIconConstraints ?? _defaultPrefixConstraints(),
      prefixIconPadding: w.prefix != null
          ? EdgeInsets.only(left: 18.r, right: 14.r)
          : EdgeInsets.zero,
      suffix: suffixWidget,
      suffixIconConstraints:
          w.suffixIconConstraints ?? _defaultSuffixConstraints(filled),
      suffixIconPadding: w.obscureText && w.suffix == null
          ? EdgeInsets.symmetric(horizontal: 10.w)
          : EdgeInsets.zero,
    );
  }
}
