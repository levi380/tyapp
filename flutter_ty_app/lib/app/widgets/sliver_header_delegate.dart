import 'package:flutter/material.dart';

/// SliverHeader 的 builder 定义
///   是否与下方内容发生重叠
typedef SliverHeaderBuilder = Widget Function(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
    );

/// 通用 SliverPersistentHeaderDelegate 实现
class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {

  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((_, __, ___) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : maxHeight = height,
        minHeight = height,
        builder = ((_, __, ___) => child);

  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  }) : assert(minHeight <= maxHeight && minHeight >= 0);

  /// Header 最大高度
  final double maxHeight;

  /// Header 最小高度
  final double minHeight;

  /// Header 构建函数
  final SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final Widget child = builder(context, shrinkOffset, overlapsContent);

    /// 强制 Header 占满 Sliver 给定的布局空间
    return SizedBox.expand(child: child);
  }

  /// Header 的最大高度
  @override
  double get maxExtent => maxHeight;

  /// Header 的最小高度
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.builder != builder;
  }
}
