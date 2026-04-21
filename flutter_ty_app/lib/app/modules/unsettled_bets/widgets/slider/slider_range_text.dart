import 'package:flutter/material.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义部分提前兑现滑块绘制底部游标Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于在滑块组件上绘制范围文本，显示当前值、最小值和最大值，支持多段滑块。
    - `SliderRangeTextPainter`：接收最大值、最小值、当前值、段数、文字样式等参数，以便于灵活配置。
    - `maxValue`：滑块的最大值。
    - `minValue`：滑块的最小值。
    - `currentValue`：当前选中的值。
    - `padding`：左右内边距。
    - `divisions`：滑块的分段数。
    - `nodeValueStyle`：默认文字样式。
    - `selectStyle`：当前选中值的文字样式（可选）。
    - `Canvas canvas`：绘图的画布。
    - `Size size`：绘图区域的大小。
    - **功能**：
    - 计算每个段的值和对应的文本位置，绘制文本到画布上。
    - 使用 `TextPainter` 来布局和绘制文本。
    - 根据当前值选择不同的文字样式。
    - `CustomPainter oldDelegate`：旧的绘制对象。
    - **功能**：
    - 返回 `false`，表示不需要重绘。
    】】】
 *
 */
/// 绘制底部游标
class SliderRangeTextPainter extends CustomPainter {
  // 最大值
  final double maxValue;

  // 最小值
  final double minValue;

  // 当前选中值
  final double currentValue;

  // 左右padding
  final double padding;

  // 段数
  final int divisions;

  // 文字样式
  final TextStyle nodeValueStyle;

  // 滑块所在刻度样式
  final TextStyle? selectStyle;

  SliderRangeTextPainter({
    required this.maxValue,
    required this.minValue,
    required this.divisions,
    required this.nodeValueStyle,
    required this.currentValue,
    this.padding = 0,
    this.selectStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width - padding * 2;
    double range = ((maxValue - minValue) / divisions);
    double min = minValue;
    for (int i = 0; i <= divisions; i++) {
      double value = min + range * i;
      String textStr = "${(value * 100).toStringAsFixed(0)}%";

      TextPainter textPainter = TextPainter();
      final TextSpan textSpan = TextSpan(
        text: textStr,
        style: currentValue == value ? selectStyle : nodeValueStyle,
      );
      textPainter.text = textSpan;
      textPainter.textDirection =
          i == divisions ? TextDirection.rtl : TextDirection.ltr;
      textPainter.textAlign = i == divisions ? TextAlign.end : TextAlign.center;
      textPainter.layout(maxWidth: 35);

      // 文字位移宽度： 前移本身长度的1/2
      // double space = i == 0
      //     ? 0
      //     : (i == divisions
      //         ? -textPainter.width
      //         : -(textPainter.width / 2)); //textPainter.width: 文字长度
      double space = -(textPainter.width / 2);
      textPainter.paint(
        canvas,
        Offset(i * (width / divisions) + space + padding, 0),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
