import '../../login/login_head_import.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-串关虚线折叠Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于在画布上绘制垂直的虚线，支持自定义颜色。
    - `DashedLinePainter`：接收一个参数：
    - `color`：类型为 `Color`，用于设置虚线的颜色。
    - **`paint` 方法**
    - 使用 `Canvas` 绘制虚线。
    - 创建 `Paint` 对象，设置颜色、线宽、样式和其他属性。
    - 定义虚线的高度和间隔，通过循环在指定位置绘制虚线。
    - **`shouldRepaint` 方法**
    - 返回 `false`，表示当绘制的内容没有变化时，不需要重新绘制。
    】】】
 *
 */
class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = true;

    double dashHeight = 5;
    double dashSpace = 5;
    double startX = size.width / 2;

    for (double i = 0; i < size.height; i += dashHeight + dashSpace) {
      canvas.drawLine(Offset(startX, i), Offset(startX, i + dashHeight), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
