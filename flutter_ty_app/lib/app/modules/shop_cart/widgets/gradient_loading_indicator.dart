import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientLoadingIndicator extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final Duration duration;

  const GradientLoadingIndicator({
    super.key,
    required this.color,
    this.strokeWidth = 4.0,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<GradientLoadingIndicator> createState() =>
      _GradientLoadingIndicatorState();
}

class _GradientLoadingIndicatorState extends State<GradientLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: widget.duration)..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 渐变从蓝色到透明
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: math.pi * 2,
      colors: [
        widget.color,
        widget.color.withValues(alpha: 0.0),
      ],
      stops: const [0.25, 1.0],
      transform: const GradientRotation(-math.pi / 2),
    );

    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        painter: _RingPainter(
          gradient: gradient,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;

  _RingPainter({required this.gradient, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
