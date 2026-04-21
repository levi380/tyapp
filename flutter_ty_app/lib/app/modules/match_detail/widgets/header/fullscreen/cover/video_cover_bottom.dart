import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../widgets/image_view.dart';

/**
 * 【【【 AUTO_DOCUMENT_MENU 全屏底部控制栏组件 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 全屏视频底部控制栏 】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 视频全屏底部控制组件 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 全屏视频播放器底部的控制栏组件
 * - 提供信息查看、音量控制、退出全屏等功能
 * - 使用半透明渐变背景提升视觉层次感
 * - 响应式布局适配不同屏幕尺寸
 * 】】】
 */
class VideoCoverBottom extends StatelessWidget {
  /// 是否显示音量控制按钮
  /// 注：某些场景下（如非视频模式）可能不需要音量控制
  final bool showVolumeButton;

  /// 当前是否为静音状态
  /// true: 静音状态，显示关闭声音图标
  /// false: 非静音状态，显示开启声音图标
  final bool isMuted;

  /// 信息按钮点击回调
  /// 通常用于显示比赛规则、说明等信息
  final VoidCallback onInfoTap;

  /// 音量控制按钮点击回调
  /// 用于切换静音/非静音状态
  final VoidCallback onVolumeTap;

  /// 退出全屏按钮点击回调
  /// 用于退出全屏模式，返回正常视图
  final VoidCallback onExitFullScreen;

  const VideoCoverBottom({
    super.key,
    required this.showVolumeButton,
    required this.isMuted,
    required this.onInfoTap,
    required this.onVolumeTap,
    required this.onExitFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110, // 固定高度，确保控制栏有足够的触摸区域
      width: 1.sw, // 使用屏幕宽度，确保全屏覆盖
      // 底部渐变背景：从底部的完全不透明渐变到顶部的完全透明
      // 这种设计既提供操作区域，又不完全遮挡视频内容
      decoration: BoxDecoration(gradient: _bottomGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, // 内容底部对齐
        children: [
          Container(
            // 内边距设计：水平36像素，垂直16像素
            // 足够的间距确保按钮易于点击且不拥挤
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 两端对齐
              children: [
                // 信息按钮 - 左侧
                GestureDetector(
                  onTap: onInfoTap,
                  child: const ImageView(
                    'assets/images/detail/info.svg', // 信息图标
                    width: 24, // 固定图标大小
                  ),
                ),
                // 右侧功能按钮组
                Row(
                  children: [
                    // 条件渲染音量按钮：只有需要时才显示
                    if (showVolumeButton) _buildVolumeButton(),
                    // 固定间距，分隔两个按钮
                    const SizedBox(width: 20),
                    // 退出全屏按钮
                    _buildExitFullScreenButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 【【【构建音量控制按钮】】】
  /// 根据静音状态显示不同的图标
  /// - 静音状态：显示 sound_close.svg（关闭声音）
  /// - 非静音状态：显示 sound.svg（开启声音）
  /// 使用InkWell提供Material Design水波纹效果
  Widget _buildVolumeButton() {
    return InkWell(
      onTap: onVolumeTap,
      child: ImageView(
        // 根据静音状态切换图标
        isMuted
            ? 'assets/images/detail/sound_close.svg'
            : 'assets/images/detail/sound.svg',
        width: 24, // 统一图标大小
      ),
    );
  }

  /// 【【【构建退出全屏按钮】】】
  /// 提供退出全屏播放的功能
  /// 使用固定大小的SizedBox包装，确保点击区域一致性
  Widget _buildExitFullScreenButton() {
    return InkWell(
      onTap: onExitFullScreen,
      child: const SizedBox(
        width: 24,
        height: 24,
        child: ImageView(
          'assets/images/detail/un-full-screen.svg', // 退出全屏图标
          width: 24,
        ),
      ),
    );
  }

  /// 【【【底部渐变背景样式】】】
  /// 线性渐变从底部中心到顶部中心
  /// 颜色值说明：
  /// 位置0.0: RGB(0,0,0) 不透明度1.0 -> 完全不透明的黑色
  /// 位置0.3: RGB(0,0,0) 不透明度0.87 -> 87%不透明的黑色
  /// 位置0.6: RGB(0,0,0) 不透明度0.4 -> 40%不透明的黑色
  /// 位置1.0: RGB(0,0,0) 不透明度0.0 -> 完全透明
  /// 这种渐变设计在提供操作背景的同时，渐隐到视频内容
  static const LinearGradient _bottomGradient = LinearGradient(
    begin: Alignment.bottomCenter, // 渐变起始点：底部中心
    end: Alignment.topCenter,      // 渐变结束点：顶部中心
    colors: [
      Color.fromRGBO(0, 0, 0, 1),      // 完全不透明的黑色
      Color.fromRGBO(0, 0, 0, 0.87),   // 87%不透明的黑色
      Color.fromRGBO(0, 0, 0, 0.4),    // 40%不透明的黑色
      Color.fromRGBO(0, 0, 0, 0),      // 完全透明
    ],
  );
}