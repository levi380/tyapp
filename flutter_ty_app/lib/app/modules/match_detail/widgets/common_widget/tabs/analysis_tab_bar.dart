import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'analysis_tab.dart';
import 'horizontal_tab_bar.dart';

enum AnalysisTabBarOutlineType {
  // 填充样式
  filled,
  // 胶囊样式
  capsule,
  // 滑塊
  slider,
}

class AnalysisTabBar extends StatefulWidget {
  const AnalysisTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.decoration,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorWidth,
    this.indicatorHeight,
    this.labelColor,
    this.unselectedLabelColor,
    this.isScrollable = false,
    this.unselectedLabelStyle,
    this.labelStyle,
    this.width,
    this.height,
    this.indicatorPadding,
    this.labelPadding,
    this.indicator,
    this.physics,
    this.onTap,
    this.outlineType = AnalysisTabBarOutlineType.filled,
    this.showIndicator = false,
    this.dividerColor,
    this.dividerHeight = 0.5,
    this.selectedBgColor,
    this.unSelectedBgColor,
    this.tabAlignment,
    this.autoIndicatorWidth = false,
    this.sliderRadius,
    this.showGap = false,
    this.gap,
    this.padding,
    this.onPreCheck,
  }) : assert(
          backgroundColor == null || decoration == null,
          'Cannot provide both a backgroundColor and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        );

  /// tab数组
  final List<AnalysisTab> tabs;

  /// tab控制器
  final TabController? controller;

  /// tabBar修饰
  final Decoration? decoration;

  /// tabBar背景色，当outlineType为card时控制选中tab颜色
  final Color? backgroundColor;

  /// tabBar下标颜色
  final Color? indicatorColor;

  /// tabBar下标高度
  final double? indicatorHeight;

  /// tabBar下标宽度
  final double? indicatorWidth;

  /// tabBar 已选标签颜色
  final Color? labelColor;

  /// tabBar未选标签颜色
  final Color? unselectedLabelColor;

  /// 是否滚动
  final bool isScrollable;

  /// 已选label字体
  final TextStyle? labelStyle;

  /// unselectedLabel字体
  final TextStyle? unselectedLabelStyle;

  /// tabBar宽度
  final double? width;

  /// tabBar高度
  final double? height;

  /// 引导padding
  final EdgeInsets? indicatorPadding;

  /// 自定义引导控件
  final Decoration? indicator;

  /// 是否展示引导控件
  final bool showIndicator;

  /// 自定义滑动
  final ScrollPhysics? physics;

  /// 点击事件
  final Function(int)? onTap;

  /// 前置检查
  final bool Function(int index)? onPreCheck;

  /// tab间距
  final EdgeInsetsGeometry? labelPadding;

  // 左右兩邊padding
  final EdgeInsetsGeometry? padding;

  /// 选项卡样式
  final AnalysisTabBarOutlineType outlineType;

  /// 分割线颜色
  final Color? dividerColor;

  /// 分割线高度,小于等于0则不展示分割线
  final double dividerHeight;

  /// 被选中背景色，只有outlineType为capsule时有效
  final Color? selectedBgColor;

  /// 未选中背景色，只有outlineType为capsule时有效
  final Color? unSelectedBgColor;

  final TabAlignment? tabAlignment;

  // 自動計算寬度
  final bool autoIndicatorWidth;
  final double? sliderRadius;

  // 是否展示分割线
  final bool showGap;
  final double? gap;

  @override
  State<StatefulWidget> createState() => _TDTabBarState();
}

class _TDTabBarState extends State<AnalysisTabBar> {
  @override
  void initState() {
    super.initState();
    widget.controller!.animation?.addListener(_handleTabAnimation);
  }

  void _handleTabAnimation() {
    setState(() {
      // 强制刷新以重新计算 indicator 宽度
    });
  }

  @override
  void dispose() {
    widget.controller?.animation?.removeListener(_handleTabAnimation);
    super.dispose();
  }

  /// 默认高度
  static const double _defaultHeight = 40;

  /// 计算文本渲染宽度
  /// text: 待测量文本（null/空字符串返回0）
  /// style: 文本样式（继承主题字体尺寸）
  /// 排版控制：letterSpacing=0消除字间距，height=1.0避免行高影响
  /// 默认最大行数排版为1行
  double _measureTextWidth(
    String? text,
    TextStyle? style,
    BuildContext context,
  ) {
    if (text == null || text.isEmpty) return 0;
    final effectiveStyle = (style ?? TextStyle()).copyWith(
      // fontSize: TDTheme.of(context).fontBodyLarge?.size.sp,
      letterSpacing: 0,
      height: 1.0,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: effectiveStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? _defaultHeight.h,
          padding: widget.outlineType == AnalysisTabBarOutlineType.slider
              ? EdgeInsets.all(2.w)
              : null,
          decoration: widget.decoration ??
              (widget.outlineType == AnalysisTabBarOutlineType.slider
                  ? BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.sliderRadius ?? 10.r),
                      ),
                    )
                  : BoxDecoration(
                      color: widget.backgroundColor,
                      border: widget.dividerHeight <= 0
                          ? null
                          : Border(
                              bottom: BorderSide(
                                color: widget.dividerColor ??
                                    const Color(0xFFE5EBF1),
                                width: widget.dividerHeight,
                              ),
                            ),
                    )),
          child: TDHorizontalTabBar(
            physics: widget.physics,
            isScrollable: widget.isScrollable,
            indicator: widget.indicator ?? _getIndicator(context),
            indicatorColor: widget.indicatorColor,
            unselectedLabelColor: widget.unselectedLabelColor,
            labelColor: widget.labelColor,
            labelStyle: widget.labelStyle ?? _getLabelStyle(context),
            labelPadding: widget.labelPadding ?? const EdgeInsets.all(2),
            unselectedLabelStyle:
                widget.unselectedLabelStyle ?? _getUnSelectLabelStyle(context),
            tabs: widget.tabs,
            indicatorPadding: widget.indicatorPadding ?? EdgeInsets.zero,
            outlineType: widget.outlineType,
            controller: widget.controller,
            backgroundColor: widget.backgroundColor,
            selectedBgColor: widget.selectedBgColor,
            unSelectedBgColor: widget.unSelectedBgColor,
            tabAlignment: widget.tabAlignment,
            onTap: (index) {
              widget.onTap?.call(index);
              setState(() {});
            },
            onPreCheck: widget.onPreCheck,
            padding: widget.padding,
            sliderRadius: widget.sliderRadius,
            showGap: widget.showGap,
            gap: widget.gap,
          ),
        ),
      ],
    );
  }

  TextStyle _getUnSelectLabelStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      // fontSize: TDTheme.of(context).fontBodySmall?.size ?? 14,
      color: const Color(0xFF292929),
    );
  }

  TextStyle _getLabelStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      // fontSize: TDTheme.of(context).fontBodySmall?.size ?? 14,
      color: const Color(0xFF292929),
    );
  }

  // 根据动画位置插值 indicator 宽度
  Decoration _getIndicator(BuildContext context) {
    if (!widget.showIndicator) return TDNoneIndicator();

    final animation = widget.controller?.animation;
    final value = animation?.value ?? widget.controller!.index.toDouble();

    int current = value.floor();
    int next = value.ceil();

    double t = value - current;

    double currentWidth = _measureTextWidth(
      widget.tabs[current].text,
      widget.labelStyle ?? _getLabelStyle(context),
      context,
    );

    double nextWidth = _measureTextWidth(
      widget.tabs[next].text,
      widget.labelStyle ?? _getLabelStyle(context),
      context,
    );

    double interpolatedWidth = lerpDouble(currentWidth, nextWidth, t)!;

    return TDTabBarIndicator(
      context: context,
      indicatorHeight: widget.indicatorHeight,
      indicatorWidth:
          widget.autoIndicatorWidth ? interpolatedWidth : widget.indicatorWidth,
      indicatorColor: widget.indicatorColor,
    );
  }
}

/// TDesign自定义下标
class TDTabBarIndicator extends Decoration {
  final BuildContext? context;
  final double? indicatorWidth;
  final double? indicatorHeight;
  final Color? indicatorColor;

  const TDTabBarIndicator({
    this.context,
    this.indicatorWidth,
    this.indicatorHeight,
    this.indicatorColor,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _TDTabBarIndicatorPainter(this, onChanged!);
}

class _TDTabBarIndicatorPainter extends BoxPainter {
  /// 下标宽度
  static const double _defaultIndicatorWidth = 16;

  /// 下标高度
  static const double _defaultIndicatorHeight = 3;

  final TDTabBarIndicator decoration;

  final _paint = Paint();

  _TDTabBarIndicatorPainter(this.decoration, VoidCallback onChanged) {
    /// 下标颜色
    _paint.color = decoration.indicatorColor ?? Colors.blue;
    _paint.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.drawLine(
      Offset(
        offset.dx + (configuration.size!.width - _indicatorWidth()) / 2,
        configuration.size!.height - _indicatorHeight() / 2,
      ),
      Offset(
        offset.dx + (configuration.size!.width + _indicatorWidth()) / 2,
        configuration.size!.height - _indicatorHeight() / 2,
      ),
      _paint..strokeWidth = _indicatorHeight(),
    );
  }

  double _indicatorHeight() =>
      decoration.indicatorHeight ?? _defaultIndicatorHeight;

  double _indicatorWidth() =>
      decoration.indicatorWidth ?? _defaultIndicatorWidth;
}

/// TDesign自定义下标 竖向
class TDTabBarVerticalIndicator extends Decoration {
  final BuildContext? context;
  final double? indicatorWidth;
  final double? indicatorHeight;

  const TDTabBarVerticalIndicator({
    this.context,
    this.indicatorWidth,
    this.indicatorHeight,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _TDTabBarVerticalIndicatorPainter(this, onChanged!);
}

class _TDTabBarVerticalIndicatorPainter extends BoxPainter {
  /// 下标宽度
  static const double _defaultIndicatorWidth = 1.5;

  /// 下标高度
  static const double _defaultIndicatorHeight = 54;

  final TDTabBarVerticalIndicator decoration;

  final _paint = Paint();

  _TDTabBarVerticalIndicatorPainter(this.decoration, VoidCallback onChanged) {
    /// 下标颜色
    _paint.color = Colors.blue;
    _paint.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.drawLine(
      Offset(
        0 + _indicatorWidth() / 2,
        offset.dx + (configuration.size!.width - _indicatorHeight()) / 2,
      ),
      Offset(
        0 + _indicatorWidth() / 2,
        offset.dx + (configuration.size!.width + _indicatorHeight()) / 2,
      ),
      _paint..strokeWidth = _indicatorWidth(),
    );
  }

  double _indicatorHeight() =>
      decoration.indicatorHeight ?? _defaultIndicatorHeight;

  double _indicatorWidth() =>
      decoration.indicatorWidth ?? _defaultIndicatorWidth;
}

/// TDesign不展示下标
class TDNoneIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _TDNoneIndicatorPainter();
}

class _TDNoneIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {}
}
