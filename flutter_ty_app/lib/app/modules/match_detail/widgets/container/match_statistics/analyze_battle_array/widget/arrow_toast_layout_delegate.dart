import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast.dart';

import '../../../../../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 带箭头的 Toast 主类-代理类
    】】】
 *
 */
class ArrowToastLayoutDelegate extends SingleChildLayoutDelegate {
  final Offset targetPosition;
  final ToastAlignment alignment;
  final double distance;
  final double arrowHeight;

  ArrowToastLayoutDelegate({
    required this.targetPosition,
    required this.alignment,
    required this.distance,
    required this.arrowHeight,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double dx = 0;
    double dy = 0;

    switch (alignment) {
      case ToastAlignment.top:
        dx = targetPosition.dx - childSize.width / 2;
        dy = targetPosition.dy - childSize.height - distance;
        break;
      case ToastAlignment.bottom:
        dx = targetPosition.dx - childSize.width / 2;
        dy = targetPosition.dy + distance;
        break;
      case ToastAlignment.left:
        dx = targetPosition.dx - childSize.width - distance;
        dy = targetPosition.dy - childSize.height / 2;
        break;
      case ToastAlignment.right:
        dx = targetPosition.dx + distance;
        dy = targetPosition.dy - childSize.height / 2;
        break;
    }

    // 确保 Toast 不会超出屏幕边界
    dx = dx.clamp(8.0, size.width - childSize.width - 8.0);
    dy = dy.clamp(8.0, size.height - childSize.height - 8.0);

    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant ArrowToastLayoutDelegate oldDelegate) {
    return targetPosition != oldDelegate.targetPosition ||
        alignment != oldDelegate.alignment ||
        distance != oldDelegate.distance;
  }
}