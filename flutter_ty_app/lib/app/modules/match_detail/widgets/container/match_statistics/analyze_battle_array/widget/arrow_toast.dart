import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 带箭头的 Toast 主类
    】】】
 *
 */
class ArrowToast {
  static OverlayEntry? _currentEntry;

  static void show({
    required BuildContext context,
    required String message,
    required Offset targetPosition, // 目标位置坐标
    ToastAlignment alignment = ToastAlignment.bottom,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double borderRadius = 8.0,
    double elevation = 6.0,
    double arrowWidth = 12.0,
    double arrowHeight = 8.0,
    double distance = 8.0, // Toast 与目标位置的距离
  }) {
    // 移除之前可能存在的 Toast
    _removeExistingToast();

    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ArrowToastWidget(
        message: message,
        targetPosition: targetPosition,
        alignment: alignment,
        duration: duration,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        elevation: elevation,
        arrowWidth: arrowWidth,
        arrowHeight: arrowHeight,
        distance: distance,
        onDismiss: () {
          _removeExistingToast();
        },
      ),
    );

    _currentEntry = overlayEntry;
    overlayState.insert(overlayEntry);
  }

  static void _removeExistingToast() {
    if (_currentEntry != null) {
      _currentEntry!.remove();
      _currentEntry = null;
    }
  }

  // 便捷方法 - 在点击位置显示带箭头的 Toast
  static void showAtPosition({
    required BuildContext context,
    required String message,
    required Offset position,
    ToastAlignment alignment = ToastAlignment.bottom,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      targetPosition: position,
      alignment: alignment,
      duration: duration,
    );
  }
}

// Toast 对齐方式
enum ToastAlignment {
  top,    // 箭头朝下，Toast 在目标上方
  bottom, // 箭头朝上，Toast 在目标下方
  left,   // 箭头朝右，Toast 在目标左侧
  right,  // 箭头朝左，Toast 在目标右侧
}