import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/// VR赛马视图通用装饰组件
/// 提供统一的背景色、圆角、内边距等样式
class VrHorseViewCommonDecoration extends StatelessWidget {
  const VrHorseViewCommonDecoration({
    super.key,
    this.borderRadius = 0,
    this.padding,
    this.height,
    required this.child,
    this.color,
  });

  /// 子组件
  final Widget child;

  /// 圆角半径
  final double borderRadius;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 高度
  final double? height;

  /// 背景颜色
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? '#F3FAFF'.hexColor,
      ),
      child: child,
    );
  }
}

