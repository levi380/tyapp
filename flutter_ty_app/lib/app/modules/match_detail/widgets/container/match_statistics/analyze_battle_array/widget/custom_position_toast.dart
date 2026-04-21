import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/custom_position_toast_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/positioned_toast.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 带箭头的 Toast 主类-位置类
    】】】
 *
 */

class CustomPositionToast {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    AlignmentGeometry alignment = Alignment.bottomCenter,
    EdgeInsetsGeometry margin = const EdgeInsets.all(20.0),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double borderRadius = 8.0,
    double elevation = 6.0,
  }) {
    // 移除之前可能存在的 Toast
    _removeExistingToast();

    // 创建 OverlayEntry
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => PositionedToast(
        message: message,
        duration: duration,
        alignment: alignment,
        margin: margin,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        elevation: elevation,
        onDismiss: () {
          _removeExistingToast();
        },
      ),
    );

    // 保存当前的 OverlayEntry
    _currentEntry = overlayEntry;

    // 显示 Toast
    overlayState.insert(overlayEntry);
  }

  static OverlayEntry? _currentEntry;

  static void _removeExistingToast() {
    if (_currentEntry != null) {
      _currentEntry!.remove();
      _currentEntry = null;
    }
  }

  /**
   * 关闭当前显示的Toast
   */
  static void dismiss() {
    _removeExistingToast();
  }

  // 便捷方法 - 顶部 Toast
  static void showTop({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      duration: duration,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 100.0),
    );
  }

  // 便捷方法 - 中间 Toast
  static void showCenter({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      duration: duration,
      alignment: Alignment.center,
    );
  }

  // 便捷方法 - 底部 Toast
  static void showBottom({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(
      context: context,
      message: message,
      duration: duration,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 100.0),
    );
  }

  // 便捷方法 - 自定义位置 Toast
  static void showCustom({
    required BuildContext context,
    required String message,
    required Offset position,
    required bool isLeft,
    Duration duration = const Duration(seconds: 2),
  }) {
    _removeExistingToast();

    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomPositionToastWidget(
        message: message,
        duration: duration,
        position: position,
        isLeft: isLeft,
        onDismiss: () {
          _removeExistingToast();
        },
      ),
    );

    _currentEntry = overlayEntry;
    overlayState.insert(overlayEntry);
  }

  // 便捷方法 - 自定义位置 Toast
  static void showCustomWidget({
    required BuildContext context,
    required Widget contentWidget,
    required Offset position,
    required bool isLeft,
    Duration duration = const Duration(seconds: 2),
  }) {
    _removeExistingToast();

    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomPositionToastWidget(
        message: "",
        contentWidget: contentWidget,
        duration: duration,
        position: position,
        isLeft: isLeft,
        onDismiss: () {
          _removeExistingToast();
        },
      ),
    );

    _currentEntry = overlayEntry;
    overlayState.insert(overlayEntry);
  }
}

