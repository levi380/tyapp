import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';

import '../../../login/login_head_import.dart';

/**
 * 返回顶部按钮组件
 *
 * 功能说明：
 * 1. 当列表滚动到一定位置时显示"返回顶部"按钮
 * 2. 点击按钮平滑滚动到列表顶部
 * 3. 带有滑入/滑出动画效果
 * 4. 支持深色/浅色主题切换
 *
 * 使用场景：
 * - 赛事详情页长列表滚动时提供快捷返回顶部功能
 */
class ScrollToTop extends StatelessWidget {
  const ScrollToTop({super.key, required this.controller});

  /// 赛事详情控制器，包含滚动控制器和状态管理
  final MatchDetailController controller;

  // ============= 常量定义 =============

  /// 动画持续时间（毫秒）
  static const int _kAnimationDuration = 300;

  /// 按钮距离右侧边距
  static const double _kRightMargin = 40;

  /// 按钮距离底部边距
  static const double _kBottomMargin = 110;

  /// 按钮大小
  static const double _kButtonSize = 32;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _kRightMargin.w,
      bottom: _kBottomMargin.w,
      child: _buildAnimatedButton(),
    );
  }

  /// 构建带动画的按钮
  Widget _buildAnimatedButton() {
    return Obx(() {
      final bool shouldShow = controller.detailState.showTopBtn.value;

      return AnimatedSlide(
        duration: const Duration(milliseconds: _kAnimationDuration),
        // 显示时偏移为0，隐藏时向下偏移一个单位（完全移出屏幕）
        offset: shouldShow ? Offset.zero : const Offset(0, 1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: _kAnimationDuration),
          opacity: shouldShow ? 1.0 : 0.0,
          child: _buildButtonContent(shouldShow),
        ),
      );
    });
  }

  /// 构建按钮内容
  Widget _buildButtonContent(bool shouldShow) {
    // 如果不显示，返回空容器（但动画组件仍然存在以保持动画效果）
    if (!shouldShow) return Container();

    return InkWell(
      onTap: _handleTap,
      child: _buildButtonImage(),
    );
  }

  /// 处理点击事件
  void _handleTap() {
    // 滚动到列表顶部
    controller.detailState.scrollController.jumpTo(0);
    // 隐藏返回顶部按钮
    controller.detailState.showTopBtn.value = false;
  }

  /// 构建按钮图片（根据主题切换）
  Widget _buildButtonImage() {
    return ImageView(
      _getButtonImagePath(),
      width: _kButtonSize.w,
      height: _kButtonSize.w,
    );
  }

  /// 获取按钮图片路径（深色/浅色主题）
  String _getButtonImagePath() {
    final bool isDarkMode = Get.isDarkMode;

    return isDarkMode
        ? 'assets/images/icon/analyze_arrow_top-night.png'
        : 'assets/images/icon/analyze_arrow_top.png';
  }
}