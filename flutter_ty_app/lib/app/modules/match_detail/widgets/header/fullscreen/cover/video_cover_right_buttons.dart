import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../widgets/image_view.dart';

/**
 * 【【【 AUTO_DOCUMENT_MENU 全屏右侧功能按钮组 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 全屏视频右侧功能按钮 】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 视频全屏右侧垂直按钮组件 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 全屏视频播放器右侧垂直排列的功能按钮组
 * - 根据场景动态显示投注、动画、视频等不同功能按钮
 * - 采用垂直居中布局，方便用户在横屏状态下操作
 * - 使用SafeArea确保在刘海屏等异形屏上的显示安全
 * - 支持多语言国际化，图标与文字搭配显示
 * 】】】
 */
class VideoCoverRightButtons extends StatelessWidget {
  /// 是否显示投注功能按钮
  /// 投注功能允许用户在全屏状态下直接进入投注界面
  final bool showBettingButton;

  /// 是否显示动画功能按钮
  /// 动画功能提供比赛动画回放或实时动画展示
  final bool showAnimationButton;

  /// 是否显示视频功能按钮
  /// 视频功能提供实时视频直播或回放
  final bool showVideoButton;

  /// 投注按钮点击回调
  /// 触发后会打开全屏投注界面
  final VoidCallback onBettingTap;

  /// 动画按钮点击回调
  /// 触发后会加载或切换到比赛动画模式
  final VoidCallback onAnimationTap;

  /// 视频按钮点击回调
  /// 触发后会加载或切换到视频直播模式
  final VoidCallback onVideoTap;

  const VideoCoverRightButtons({
    super.key,
    required this.showBettingButton,
    required this.showAnimationButton,
    required this.showVideoButton,
    required this.onBettingTap,
    required this.onAnimationTap,
    required this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // SafeArea确保内容不会被系统状态栏、刘海或水滴屏遮挡
      // 在横屏模式下特别重要，因为状态栏可能出现在侧边
      child: Container(
        // 高度设置为屏幕高度的1/2，确保按钮组在垂直方向居中
        height: 1.sh / 2,
        // 右侧外边距30，为手指操作留出足够空间
        margin: const EdgeInsets.only(right: 30),
        child: Column(
          // 主轴居中：确保按钮组在垂直方向居中显示
          mainAxisAlignment: MainAxisAlignment.center,
          // 交叉轴起点对齐：按钮组向左对齐，图标和文字靠左排列
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 条件渲染投注按钮
            if (showBettingButton)
              _buildRightButton(
                icon: "assets/images/detail/fullscreen-oddsinfo.svg",
                text: LocaleKeys.app_betting.tr,
                onTap: onBettingTap,
                bottomMargin: 10, // 下边距10，与下一个按钮保持间距
              ),
            // 条件渲染动画按钮
            if (showAnimationButton)
              _buildRightButton(
                icon: "assets/images/detail/fullscreen-animate.svg",
                text: LocaleKeys.match_info_animation.tr,
                onTap: onAnimationTap,
                bottomMargin: 30, // 较大间距30，将视频相关按钮分组显示
              ),
            // 条件渲染视频按钮
            if (showVideoButton)
              _buildRightButton(
                icon: "assets/images/detail/fullscreen-live.svg",
                text: LocaleKeys.match_info_video.tr,
                onTap: onVideoTap,
                bottomMargin: 16, // 基础间距16
              ),
            // 注意：按钮渲染顺序与视觉显示顺序一致
            // 顶部：投注按钮（如果有）
            // 中部：动画按钮（如果有）
            // 底部：视频按钮（如果有）
          ],
        ),
      ),
    );
  }

  /// 【【【构建右侧功能按钮通用方法】】】
  /// 统一构建右侧垂直按钮的样式和交互
  /// @param icon 按钮图标路径，使用SVG格式确保清晰度
  /// @param text 按钮文字，支持多语言国际化
  /// @param onTap 点击回调函数
  /// @param bottomMargin 底部外边距，用于控制按钮间距
  /// 设计特点：
  /// - 图标固定宽度32px，保持视觉一致性
  /// - 图标与文字间距4px，紧凑而不拥挤
  /// - 使用InkWell提供Material Design水波纹反馈
  /// - 文字单行显示，超出部分显示省略号
  /// - 整体采用最小宽度布局，避免不必要的空间占用
  Widget _buildRightButton({
    required String icon,
    required String text,
    required VoidCallback onTap,
    double bottomMargin = 0,
  }) {
    return InkWell(
      onTap: onTap,
      // 使用最小宽度布局，确保按钮宽度自适应内容
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 图标部分
          ImageView(
            icon,
            boxFit: BoxFit.fill, // 填充整个图标区域
            width: 32, // 固定图标大小，确保视觉一致性
          ).marginOnly(right: 4), // 图标与文字间距4px
          // 文字部分
          Text(
            text,
            maxLines: 1, // 单行显示，避免文字换行影响布局
            overflow: TextOverflow.ellipsis, // 超出显示省略号
            style: _rightButtonTextStyle,
          ),
        ],
      ).marginOnly(bottom: bottomMargin), // 控制按钮之间的垂直间距
    );
  }

  /// 【【【右侧按钮文字样式】】】
  /// 设计规范：
  /// - 颜色：白色90%不透明度（RGBA白色，alpha 0.9）
  ///   90%不透明度确保文字在深色背景下清晰可读，同时保持一定透明感
  /// - 字号：12px，适合侧边栏按钮尺寸
  /// - 字体：PingFang SC，中文字体，确保中文字符显示美观
  /// - 字重：500（中等），提供足够的视觉重量但不过于粗重
  /// - 使用withValues方法：框架提供的颜色透明度调节方法
  static final TextStyle _rightButtonTextStyle = TextStyle(
    color: Colors.white.withValues(alpha: 0.9),
    fontSize: 12,
    fontFamily: 'PingFang SC',
    fontWeight: FontWeight.w500,
  );
}