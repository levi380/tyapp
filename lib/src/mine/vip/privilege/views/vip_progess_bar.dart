import 'package:filbet/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

/// 半圆形进度条组件
/// 显示总进度和当前进度，带有刻度标记
class VipSemicircleProgressBar extends StatelessWidget {
  /// 总数
  final int total;

  /// 当前数
  final int current;

  /// 半圆大小
  final double size;

  /// 进度条宽度
  final double strokeWidth;

  /// 背景颜色
  final Color? backgroundColor;

  /// 进度条颜色（渐变起始色）
  final Color? progressColor;

  /// 刻度颜色
  final Color? tickColor;

  /// 刻度宽度
  final double tickWidth;

  /// 刻度长度
  final double tickLength;

  /// 数值文字样式
  final TextStyle? textStyle;

  /// 百分比文字样式
  final TextStyle? percentageTextStyle;

  /// 是否显示VIP文案
  final bool showVipText;

  /// VIP文案样式
  final TextStyle? vipTextStyle;

  const VipSemicircleProgressBar({
    Key? key,
    required this.total,
    required this.current,
    this.size = 120.0,
    this.strokeWidth = 6.0,
    this.backgroundColor,
    this.progressColor,
    this.tickColor,
    this.tickWidth = 4.0,
    this.tickLength = 5.0,
    this.textStyle,
    this.percentageTextStyle,
    this.showVipText = true,
    this.vipTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? current / (math.min(10, total)) : 0.0;

    return Container(
      width: size.w,
      height: (size / 2).h + 40.h, // 半圆高度 + 文字空间 + VIP文案空间
      child: CustomPaint(
        size: Size(size.w, (size / 2).h + 20.h), // 为VIP文案留出空间
        painter: SemicircleProgressPainter(
          progress: progress,
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor ?? appColors.white,
          progressColor: progressColor ?? appColors.white,
          tickColor: tickColor ?? appColors.white,
          tickWidth: tickWidth,
          tickLength: tickLength,
          total: total,
          showVipText: showVipText,
          vipTextStyle: vipTextStyle,
        ),
      ),
    );
  }
}

/// 半圆进度条绘制器
class SemicircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Color tickColor;
  final double tickWidth;
  final double tickLength;
  final int total;
  final bool showVipText;
  final TextStyle? vipTextStyle;

  SemicircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.tickColor,
    required this.tickWidth,
    required this.tickLength,
    required this.total,
    required this.showVipText,
    this.vipTextStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20); // 为VIP文案留出空间
    final radius = (size.width - strokeWidth) / 2;

    // 绘制背景半圆
    _drawBackgroundSemicircle(canvas, center, radius);

    // 绘制刻度
    _drawTicks(canvas, center, radius);

    // 绘制进度半圆
    _drawProgressSemicircle(canvas, center, radius);

    // 绘制VIP文案
    _drawVipTexts(canvas, center, radius);
  }

  void _drawBackgroundSemicircle(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, math.pi, math.pi, false, paint);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = tickColor
      ..style = PaintingStyle.fill;
// 绘制刻度圆点
    for (int i = 0; i <= total; i++) {
      final angle = math.pi + (i / total) * math.pi; // 从180度到360度
      final tickRadius = radius + strokeWidth / 2 + 8; // 半圆外围，距离边缘2像素

      final tickX = center.dx + tickRadius * math.cos(angle);
      final tickY = center.dy + tickRadius * math.sin(angle);

      // 绘制小圆点
      canvas.drawCircle(
        Offset(tickX, tickY),
        tickWidth / 2, // 圆点半径
        paint,
      );
    }
  }

  void _drawProgressSemicircle(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // 创建渐变
    final gradient = SweepGradient(
      colors: [progressColor, progressColor],
      startAngle: math.pi,
      endAngle: 2 * math.pi,
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    paint.shader = gradient.createShader(rect);

    // 绘制进度弧
    final sweepAngle = progress * math.pi;
    canvas.drawArc(rect, math.pi, sweepAngle, false, paint);
  }

  void _drawVipTexts(Canvas canvas, Offset center, double radius) {
    if (!showVipText) return;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final textStyle = vipTextStyle ??
        TextStyle(
          fontSize: 12.sp,
          color: appColors.inputTextStyleColor,
        );

    // 绘制VIP文案
    for (int i = 0; i <= total; i++) {
      final angle = math.pi + (i / total) * math.pi; // 从180度到360度
      final textRadius =
          radius + strokeWidth / 2 + 2 + tickWidth + 20; // 刻度外再往外8像素

      final textX = center.dx + textRadius * math.cos(angle);
      final textY = center.dy + textRadius * math.sin(angle);

      textPainter.text = TextSpan(
        text: 'v$i', // 显示v+刻度数值
        style: textStyle,
      );
      textPainter.layout();

      // 计算文字位置，使其居中
      final textOffset = Offset(
        textX - textPainter.width / 2,
        textY - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is SemicircleProgressPainter &&
        (oldDelegate.progress != progress ||
            oldDelegate.total != total ||
            oldDelegate.strokeWidth != strokeWidth ||
            oldDelegate.showVipText != showVipText);
  }
}
