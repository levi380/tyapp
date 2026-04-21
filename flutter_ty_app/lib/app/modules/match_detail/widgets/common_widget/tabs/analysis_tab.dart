import 'package:flutter/material.dart';

import '../../../../../utils/platform_util.dart';

/**
 * 分析页选项卡枚举
 *
 * 选项卡尺寸：
 * - large: 大尺寸（字体16）
 * - small: 小尺寸（字体14）
 */
enum AnalysisTabSize { large, small }

/**
 * 选项卡样式类型
 *
 * - filled: 填充样式（默认）
 * - capsule: 胶囊样式（带左右外边距）
 * - card: 卡片样式
 */
enum AnalysisTabOutlineType {
  filled,   // 填充样式
  capsule,  // 胶囊样式
  card,     // 卡片
}

/**
 * 分析页自定义选项卡组件
 *
 * 功能说明：
 * 1. 继承自Flutter原生Tab，扩展了更多自定义属性
 * 2. 支持三种样式类型：填充式、胶囊式、卡片式
 * 3. 支持两种尺寸：大号(16px)、小号(14px)
 * 4. 支持图标+文字组合、纯图标、纯文字
 * 5. 支持禁用状态、角标提示
 * 6. 支持自定义高度和内边距
 *
 * 使用场景：
 * - 分析页的选项卡切换
 * - 需要自定义样式的TabBar
 */
class AnalysisTab extends Tab {
  // ============= 原生Tab属性重写 =============

  /// 文字内容
  @override
  final String? text;

  /// 子widget（优先级高于text）
  @override
  final Widget? child;

  /// 图标
  @override
  final Widget? icon;

  /// 图标间距
  @override
  final EdgeInsetsGeometry iconMargin;

  /// tab整体高度（优先级高于自动计算）
  @override
  final double? height;

  // ============= 扩展属性 =============

  /// 中间内容高度（预留字段，目前未使用）
  final double? contentHeight;

  /// 文本外边距（预留字段，目前未使用）
  final EdgeInsetsGeometry? textMargin;

  /// 是否可用，默认true（禁用时不可点击）
  final bool enable;

  /// 选项卡尺寸（影响字体大小）
  final AnalysisTabSize size;

  /// 选项卡样式类型
  final AnalysisTabOutlineType outlineType;

  /// 右上角气泡提示文本（显示未读数、角标等）
  final String? badgeText;

  // ============= 常量定义 =============

  /// 纯文字/纯图标选项卡默认高度
  static const double _kDefaultTabHeight = 48.0;

  /// 图标+文字组合选项卡默认高度
  static const double _kTextAndIconTabHeight = 72.0;

  /// 胶囊样式左右外边距
  static const double _kCapsuleHorizontalMargin = 16.0;

  /// 大尺寸字体大小
  static const double _kLargeFontSize = 16.0;

  /// 小尺寸字体大小
  static const double _kSmallFontSize = 14.0;

  /// Android平台文本高度修正系数
  static const double _kAndroidLineHeight = 1.15;

  const AnalysisTab({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.height,
    this.contentHeight,
    this.textMargin,
    this.size = AnalysisTabSize.small,
    this.outlineType = AnalysisTabOutlineType.filled,
    this.enable = true,
    this.iconMargin = const EdgeInsets.only(bottom: 4.0, right: 4.0),
    this.badgeText,
  }) : super(
    text: text,
    child: child,
    icon: icon,
    height: height,
    iconMargin: iconMargin,
  );

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    // 1. 计算选项卡高度
    final double calculatedHeight = _calculateHeight();

    // 2. 构建标签内容
    final Widget label = _buildLabel(context);

    // 3. 判断是否为胶囊样式
    final bool isCapsuleOutlineType = outlineType == AnalysisTabOutlineType.capsule;

    // 4. 返回可点击容器
    return IgnorePointer(
      ignoring: !enable, // 禁用状态下忽略点击
      child: Container(
        alignment: Alignment.center,
        margin: isCapsuleOutlineType
            ? const EdgeInsets.symmetric(horizontal: _kCapsuleHorizontalMargin)
            : null,
        height: height ?? calculatedHeight,
        child: Center(widthFactor: 1.0, child: label),
      ),
    );
  }

  // ============= 高度计算 =============

  /// 计算选项卡默认高度
  double _calculateHeight() {
    // 纯图标或无内容
    if (icon == null) {
      return _kDefaultTabHeight;
    }

    // 纯图标（无文字）
    if (text == null && child == null) {
      return _kDefaultTabHeight;
    }

    // 图标+文字组合
    return _kTextAndIconTabHeight;
  }

  // ============= 标签构建 =============

  /// 构建标签内容
  Widget _buildLabel(BuildContext context) {
    // 无图标：只有文字
    if (icon == null) {
      return _buildLabelText(context);
    }

    // 无文字：只有图标
    if (text == null && child == null) {
      return icon!;
    }

    // 图标+文字组合
    return _buildIconWithLabel(context);
  }

  /// 构建图标+文字组合
  Widget _buildIconWithLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        icon ?? Container(),
        SizedBox(
          width: iconMargin.horizontal,
          height: iconMargin.vertical,
        ),
        _buildLabelText(context),
      ],
    );
  }

  /// 构建标签文本
  Widget _buildLabelText(BuildContext context) {
    // 优先使用自定义child
    if (child != null) {
      return DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(
          fontSize: _kSmallFontSize, // 默认字体14
        ),
        child: child!,
      );
    }

    // 使用text构建
    return Text(
      text!,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: _getFontSize(context),
        height: _getLineHeight(), // Android平台特殊处理
      ),
    );
  }

  // ============= 样式计算 =============

  /// 获取字体大小
  double _getFontSize(BuildContext context) {
    // 优先使用上级TextStyle的字体大小
    final defaultTextStyle = DefaultTextStyle.of(context);
    if (defaultTextStyle.style.fontSize != null) {
      return defaultTextStyle.style.fontSize!;
    }

    // 根据尺寸返回默认字体大小
    return size == AnalysisTabSize.large
        ? _kLargeFontSize
        : _kSmallFontSize;
  }

  /// 获取行高（Android平台需要特殊处理）
  double? _getLineHeight() {
    return PlatformUtil.isAndroid ? _kAndroidLineHeight : null;
  }
}