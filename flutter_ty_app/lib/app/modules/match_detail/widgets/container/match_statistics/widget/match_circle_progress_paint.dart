
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';


/// 正面交手圆形进度条画笔
///
/// 绘制背景圆环与渐变进度弧；[progress] 为 0~1 比例
class MatchCircleProgressPaint extends CustomPainter {
  final double progress;
  final double width;
  final List<Color> colorsList;
  final Color? backgroundColor;
  final Color? progressColor;

  late final Paint paintBg;
  late final Paint paintProgress;
  late final Paint paintProgress2;

  MatchCircleProgressPaint(
    this.progress,
    this.width,
    this.colorsList, {
    this.backgroundColor,
    this.progressColor,
  }) {
    paintBg = Paint()
      ..strokeWidth = width
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    paintProgress = Paint()
      ..color = progressColor ??
          MatchStatisticMatchHistoryState.circleProgressDefaultProgressColor
      ..strokeWidth = width
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    paintProgress2 = Paint()
      ..color = progressColor ??
          MatchStatisticMatchHistoryState.circleProgressDefaultProgressColor
      ..strokeWidth = width
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width > size.height
        ? size.height / 2 - 5.w
        : size.width / 2 - 5.w;
    paintBg.shader = LinearGradient(
      colors: [
        MatchStatisticMatchHistoryState.circleProgressBackgroundGradientColor,
        MatchStatisticMatchHistoryState.circleProgressBackgroundGradientColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paintProgress2.shader = LinearGradient(
      colors: colorsList,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paintBg,
    );
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
    canvas.drawArc(rect, -3.14 / 2, 2 * 3.14 * progress, false, paintProgress2);
  }

  @override
  bool shouldRepaint(covariant MatchCircleProgressPaint oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.width != width ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        !listEquals(oldDelegate.colorsList, colorsList);
  }
}
