import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_painter.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast.dart';

import '../../../../../../vr/vr_sport_detail/import_head.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 水平方向的带箭头 Toast
    】】】
 *
 */
class HorizontalArrowToast extends StatelessWidget {
  final String message;
  final Offset targetPosition;
  final ToastAlignment alignment;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double arrowWidth;
  final double arrowHeight;

  const HorizontalArrowToast({
    Key? key,
    required this.message,
    required this.targetPosition,
    required this.alignment,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.elevation,
    required this.arrowWidth,
    required this.arrowHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (alignment == ToastAlignment.right) _buildArrow(),
        _buildToastContent(),
        if (alignment == ToastAlignment.left) _buildArrow(),
      ],
    );
  }

  Widget _buildToastContent() {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        constraints: const BoxConstraints(
          maxWidth: 200,
          minWidth: 60,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return CustomPaint(
      size: Size(arrowHeight, arrowWidth), // 交换宽高
      painter: ArrowPainter(
        direction: alignment == ToastAlignment.left
            ? ArrowDirection.right
            : ArrowDirection.left,
        color: backgroundColor,
      ),
    );
  }
}