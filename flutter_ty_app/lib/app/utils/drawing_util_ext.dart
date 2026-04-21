import 'package:flutter/material.dart';
import 'dart:math' as math;


/// 圆形绘制工具类
class CircleDrawingUtils {
  /// 绘制基础圆形
  static Widget drawBasicCircle({
    required double radius,
    Color color = Colors.blue,
    double strokeWidth = 2.0,
  }) {
    return CustomPaint(
      painter: CirclePainter(
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
      ),
      size: Size(radius * 2, radius * 2),
    );
  }

  /// 绘制渐变圆形
  static Widget drawGradientCircle({
    required double radius,
    List<Color> colors = const [Colors.blue, Colors.purple],
  }) {
    return CustomPaint(
      painter: GradientCirclePainter(
        radius: radius,
        colors: colors,
      ),
      size: Size(radius * 2, radius * 2),
    );
  }

  /// 绘制虚线圆形
  static Widget drawDashedCircle({
    required double radius,
    Color color = Colors.red,
    double strokeWidth = 3.0,
    List<double> dashPattern = const [10, 5],
  }) {
    return CustomPaint(
      painter: DashedCirclePainter(
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
        dashPattern: dashPattern,
      ),
      size: Size(radius * 2, radius * 2),
    );
  }

  /// 绘制动画圆形
  static Widget drawAnimatedCircle({
    required double radius,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 2),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return CustomPaint(
          painter: AnimatedCirclePainter(
            radius: radius,
            color: color,
            progress: value,
          ),
          size: Size(radius * 2, radius * 2),
        );
      },
    );
  }
}
/// 圆形绘制器
class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;

  CirclePainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 渐变圆形绘制器
class GradientCirclePainter extends CustomPainter {
  final double radius;
  final List<Color> colors;

  GradientCirclePainter({
    required this.radius,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: colors,
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 虚线圆形绘制器
class DashedCirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  DashedCirclePainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 绘制虚线圆形
    final path = Path()..addOval(rect);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 动画圆形绘制器
class AnimatedCirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double progress;

  AnimatedCirclePainter({
    required this.radius,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 绘制圆弧动画
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 几何图形工具类
class GeometryUtils {
  /// 计算圆的面积
  static double calculateCircleArea(double radius) {
    return math.pi * radius * radius;
  }

  /// 计算圆的周长
  static double calculateCircleCircumference(double radius) {
    return 2 * math.pi * radius;
  }

  /// 计算两点之间的距离
  static double calculateDistance(Offset point1, Offset point2) {
    return math.sqrt(
      math.pow(point2.dx - point1.dx, 2) + math.pow(point2.dy - point1.dy, 2),
    );
  }

  /// 判断点是否在圆内
  static bool isPointInCircle(Offset point, Offset center, double radius) {
    return calculateDistance(point, center) <= radius;
  }
}

/// 颜色工具类
class ColorUtils {
  /// 生成随机颜色
  static Color generateRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withValues(alpha:1.0);
  }

  /// 生成彩虹色
  static List<Color> generateRainbowColors(int count) {
    final colors = <Color>[];
    for (int i = 0; i < count; i++) {
      final hue = (i * 360 / count) % 360;
      colors.add(HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor());
    }
    return colors;
  }

  /// 颜色混合
  static Color blendColors(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio)!;
  }
}

/// 动画工具类
class AnimationUtils {
  /// 创建脉冲动画
  static Animation<double> createPulseAnimation(
      AnimationController controller) {
    return Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  /// 创建旋转动画
  static Animation<double> createRotationAnimation(
      AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));
  }

  /// 创建缩放动画
  static Animation<double> createScaleAnimation(
      AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    ));
  }
}

/// 数学工具类
class MathUtils {
  /// 角度转弧度
  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  /// 弧度转角度
  static double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  /// 限制数值范围
  static double clamp(double value, double min, double max) {
    return math.max(min, math.min(max, value));
  }

  /// 线性插值
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// 计算阶乘
  static int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }

  /// 计算斐波那契数列
  static int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}