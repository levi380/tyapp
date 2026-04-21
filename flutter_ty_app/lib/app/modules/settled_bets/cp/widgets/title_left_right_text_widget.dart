import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_color.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注LotteryLeftRightText视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    】】】
 *
 */
class LotteryLeftRightTextWidget extends StatefulWidget {
  const LotteryLeftRightTextWidget(
      {Key? key,
      this.leftString,
      this.rightString,
      this.leftTextStyle,
      this.rightTextStyle,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.mainAxisAlignment,
      this.backgroundColor,
      this.decoration,
      this.leftWidget,
      this.rightWidget,
      this.gap})
      : super(
          key: key,
        );

  /// 设置左边文字
  final String? leftString;

  /// 设置右边文字
  final String? rightString;

  /// 设置左边TextStyle
  final TextStyle? leftTextStyle;

  /// 设置右边TextStyle
  final TextStyle? rightTextStyle;

  /// 左边widget
  final Widget? leftWidget;

  /// 右边widget
  final Widget? rightWidget;

  /// 组件 宽度
  final double? width;

  /// 组件 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  /// 对其方式
  final MainAxisAlignment? mainAxisAlignment;

  /// 背景颜色
  final Color? backgroundColor;

  /// decoration 设置
  final BoxDecoration? decoration;

  /// 文本直接的间隔
  final double? gap;

  @override
  State<LotteryLeftRightTextWidget> createState() {
    return _LotteryLeftRightTextWidget();
  }
}

class _LotteryLeftRightTextWidget extends State<LotteryLeftRightTextWidget> {
  @override
  Widget build(BuildContext context) {
    final decoration =
        widget.decoration ?? BoxDecoration(color: widget.backgroundColor);

    return Container(
        padding: widget.padding,
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        decoration: decoration,
        child: contentWidget());
  }

  Widget contentWidget() {
    return Row(
      mainAxisAlignment:
          widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: <Widget>[
        widget.leftWidget ??
            Text(
              widget.leftString ?? '',
              style: widget.leftTextStyle ??
                  const TextStyle(color: AppColor.bgColorDark),
            ),
        SizedBox(
          width: widget.gap,
        ),
        widget.rightWidget ??
            Text(
              widget.rightString ?? '',
              style: widget.rightTextStyle ??
                  const TextStyle(color: AppColor.bgColorDark),
            )
      ],
    );
  }
}

enum MultiLineDescriptionOverflowType { end, middle }

class MultiLineColumnText extends StatelessWidget {
  final String title; //组件标题（必填）
  final String description; //组件描述（默认：""）
  final TextStyle? titleStyle; //标题文本Style
  final TextStyle? descriptionStyle; //描述文本Style
  final double? width; //文本宽度（默认：42.px）
  final MultiLineDescriptionOverflowType?
      desTextOverflowType; //描述文本省略风格（默认：尾部省略，可选中间省略）

  const MultiLineColumnText(
    this.title, {
    Key? key,
    this.description = '',
    this.titleStyle,
    this.descriptionStyle,
    this.width,
    this.desTextOverflowType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(
      title,
      style: titleStyle ??
          TextStyle(
              fontSize:  16.sp,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400),
      overflow: TextOverflow.ellipsis,
    );

    final descriptionText = _getDescriptionText(
      description,
      width ?? 42.w,
      descriptionStyle?.fontSize ?? 12,
      desTextOverflowType ?? MultiLineDescriptionOverflowType.end,
      descriptionStyle ??
          TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400),
    );

    return Container(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            0,
            0,
            0,
            0,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              0,
              0,
              0,
              0,
            ),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                SizedBox(
                  height: 20.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      descriptionText,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Text _getDescriptionText(
    String description,
    double width,
    double fontSize,
    MultiLineDescriptionOverflowType desTextOverflowType,
    TextStyle descriptionStyle) {
  Text descriptionText;
  final items = width ~/ fontSize;
  final textWidth = _getTextWidthWithTextStyle(description, descriptionStyle);
  if (textWidth > width &&
      desTextOverflowType == MultiLineDescriptionOverflowType.middle) {
    String newStr;
    String startStr;
    String endStr;
    startStr = description.substring(0, items - 3);
    endStr = description.substring(description.length - 2);
    newStr = '$startStr...$endStr';
    descriptionText = Text(
      newStr,
      style: descriptionStyle,
    );
  } else {
    descriptionText = Text(
      description,
      style: descriptionStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
  return descriptionText;
}

double _getTextWidthWithTextStyle(String text, TextStyle style) {
  final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
  return textPainter.size.width;
}
