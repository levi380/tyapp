import 'package:flutter/cupertino.dart';

enum DashedLineDirection { horizontal, vertical }

class DashedLine extends StatelessWidget {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashSpace;
  final DashedLineDirection direction;

  const DashedLine({
    super.key,
    required this.color,
    this.thickness = 1,
    this.dashWidth = 6,
    this.dashSpace = 3,
    this.direction = DashedLineDirection.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: direction == DashedLineDirection.horizontal
          ? Size(double.infinity, thickness)
          : Size(thickness, double.infinity),
      painter: _DashedLinePainter(
        color: color,
        strokeWidth: thickness,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        direction: direction,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final DashedLineDirection direction;

  _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    if (direction == DashedLineDirection.horizontal) {
      double startX = 0;
      final y = size.height / 2;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      double startY = 0;
      final x = size.width / 2;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(x, startY),
          Offset(x, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
