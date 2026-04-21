import 'dart:math';
import 'package:flutter/material.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单注单预约预计可赢额的提示框Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于体育注单注单预约预计可赢额的提示框。
    - `RoundedTriangleIconView`：接收两个参数：
    - `size`：字符串类型，表示提示框的大小。
    - `color`：字符串类型，表示提示框背景颜色。
    - 根据当前主题模式（暗黑模式或亮色模式）设置文本颜色。
    - 返回一个提示框 `Container`：
    】】】
 *
 */
class RoundedTriangleIconView extends StatelessWidget {
  final double size;
  final Color color;

  RoundedTriangleIconView({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: InvertedTrianglePainter(color),
    );
  }
}

class InvertedTrianglePainter extends CustomPainter {
  final Color color;

  InvertedTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color // 设置颜色和透明度
      ..style = PaintingStyle.fill;

    final path = Path();

    // 计算三角形的三个顶点
    double height = size.height; // 三角形的高度
    double baseWidth = height * tan(65 * pi / 180); // 计算上边的宽度

    // 定义三角形的三个顶点
    Offset pointA = Offset(size.width / 2, height); // 底部中间点
    Offset pointB = Offset(size.width / 2 - baseWidth / 2, 0); // 左上角
    Offset pointC = Offset(size.width / 2 + baseWidth / 2, 0); // 右上角

    // 创建三角形路径
    path.moveTo(pointA.dx, pointA.dy);
    path.lineTo(pointB.dx, pointB.dy);
    path.lineTo(pointC.dx, pointC.dy);
    path.close(); // 关闭路径形成三角形

    // 绘制路径
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// final double size;
// final Color color;

// RoundedTriangleIconView({required this.size, required this.color});

// @override
// Widget build(BuildContext context) {
//   return CustomPaint(
//     size: Size(size, size),
//     painter: InvertedTrianglePainter(color),
//   );
// }
//

//lass InvertedTrianglePainter extends CustomPainter {
// final Color color;

// InvertedTrianglePainter(this.color);

// @override
// void paint(Canvas canvas, Size size) {
//   final Paint paint = Paint()
//     ..color = color.withOpacity(0.8) // 设置颜色和透明度
//     ..style = PaintingStyle.fill;

//   final path = Path();

//   // 创建一个倒立三角形的路径
//   path.moveTo(size.width / 2, size.height); // 底部中间点
//   path.lineTo(0, 0); // 左上角
//   path.lineTo(size.width, 0); // 右上角

//   // 关闭路径形成倒立三角形
//   path.close();

//   // 绘制路径
//   canvas.drawPath(path, paint);
// }

// @override
// bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
//