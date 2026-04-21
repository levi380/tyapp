import 'dart:ui';

import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:filbet/generated/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextFieldBar extends StatefulWidget {
  final String hint;
  final String text;
  final String? heroTag;
  final double defaultBorderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color splashColor;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String text)? onSubmitted;
  final Function(String text)? onChanged;
  final VoidCallback? clearCallback;
  final VoidCallback? onBackCallback;
  final int inputKeyWordsLength;
  final double fontSize;
  final bool isShowBackButton;
  final double height;
  final bool isshowClear;

  SearchTextFieldBar({
    Key? key,
    this.hint = "",
    this.defaultBorderRadius = 20,
    this.margin = const EdgeInsets.symmetric(vertical: 0),
    this.padding = const EdgeInsets.only(left: 0),
    this.heroTag,
    this.splashColor = const Color(0xFFD6D6D6),
    this.focusNode,
    this.controller,
    this.onSubmitted,
    this.onBackCallback,
    this.clearCallback,
    this.isshowClear = true,
    this.onChanged,
    this.inputKeyWordsLength = 40,
    this.fontSize = 14,
    required this.text,
    this.isShowBackButton = false,
    required this.height,
  }) : super(key: key);

  @override
  State<SearchTextFieldBar> createState() => _SearchTextFieldBarState();
}

class _SearchTextFieldBarState extends State<SearchTextFieldBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // 只在初始时设置默认文本
    if (_controller.text.isEmpty) {
      _controller.text = widget.text;
    }

    // 监听输入变化，动态控制清除按钮
    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (hasText != _showClear) {
        setState(() {
          _showClear = hasText;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: _buildTextFieldContainer(),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 6.w),
      child: GestureDetector(
        onTap: widget.onBackCallback,
        child: Container(
          width: 28.r,
          height: 28.r,
          alignment: Alignment.center,
          child: Image.asset(
            Assets.homeSearch,
            width: 18.r,
            height: 18.r,
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldContainer() {
    return Container(
      height: widget.height,
      padding: widget.padding,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.defaultBorderRadius),
        color: appnewColors.bg3,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isShowBackButton ? _buildBackButton() : const SizedBox(),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              keyboardAppearance: Brightness.dark,
              maxLines: 1,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.inputKeyWordsLength),
              ],
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff999999),
                ),
              ),
            ),
          ),
          if (widget.isshowClear && _showClear)
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 8.w),
              child: IconButton(
                icon: Image.asset(
                  Assets.homeIconGameCloes,
                  width: 15.r,
                  height: 15.r,
                ),
                onPressed: _clearInput,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
        ],
      ),
    );
  }

  void _clearInput() {
    _controller.clear();
    widget.clearCallback?.call();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }
}
