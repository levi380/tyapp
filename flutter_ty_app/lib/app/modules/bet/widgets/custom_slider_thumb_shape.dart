import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bet_record_controller.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 部分提前结算滑动条Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 部分提前结算滑动条,滑动修改部分提前结算金额
    】】】
 *
 */
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2.0;
    final double trackLeft = offset.dx; // 调整左边距
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) * 3 / 4;
    final double trackWidth = parentBox.size.width; // 调整右边距
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final double thumbAmount;
  final double min;
  final double max;

  CustomSliderThumbCircle(
      {required this.thumbRadius,
      required this.thumbAmount,
      this.min = 0.0,
      this.max = 1.0});
  final logic = Get.find<BetRecordController>();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    // Draw an ellipse instead of a circle
    final Rect rect = Rect.fromCenter(
        center: center, width: thumbRadius * 1.5, height: thumbRadius);
    final RRect rRect =
        RRect.fromRectAndRadius(rect, Radius.circular(thumbRadius / 2));
    canvas.drawRRect(rRect, paint);
    // 绘制数值
    {
      final TextSpan span = TextSpan(
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        text:
            '${(value * (thumbAmount - thumbAmount * min) + thumbAmount * min).toStringAsFixed(2)}',
      );

      final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout();
      final double textWidth = tp.width + 16; // 文字背景宽度
      final double textHeight = tp.height; // 文字背景高度

      final Offset textCenter = Offset(center.dx - (textWidth / 2),
          center.dy - thumbRadius - textHeight + 4);

      final Rect textRect = Rect.fromLTWH(
        textCenter.dx,
        textCenter.dy,
        textWidth,
        textHeight,
      );

      final RRect textRRect =
          RRect.fromRectAndRadius(textRect, Radius.circular(4));
      canvas.drawRRect(textRRect, paint);

      tp.paint(canvas, Offset(textRect.left + 8, textRect.top - 1));

      // 绘制小箭头
      final Path arrowPath = Path()
        ..moveTo(center.dx - 3, textRect.bottom)
        ..lineTo(center.dx + 3, textRect.bottom)
        ..lineTo(center.dx, textRect.bottom + 3)
        ..close();

      canvas.drawPath(arrowPath, paint);
    }
  }
}
