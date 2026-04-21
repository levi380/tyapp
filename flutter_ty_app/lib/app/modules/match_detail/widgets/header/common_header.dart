import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'flexible/animate.dart';
import 'flexible/common.dart';
import 'flexible/live.dart';
import 'header_appbar.dart';

/**
 * 赛事详情页头部组件
 *
 * 【【【 AUTO_DOCUMENT_UUID cc-795f9e8c-f579-4618-9f7c-3858c8af2e2b 】】】
 * 【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 详情头部】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 包含赛事头部、动画头部、视频头部
 * 】】】
 *
 * 该组件负责根据不同的比赛状态展示不同类型的头部：
 * - 普通头部（HeaderType.normal）：常规比赛详情头部
 * - 直播头部（HeaderType.live）：正在直播的比赛头部，包含直播相关信息
 * - 动画头部（HeaderType.animate）：带有动画效果的比赛头部
 * - 精彩回放头部（HeaderType.replay）：回放比赛的头部（预留）
 */
class CommonHeader extends StatelessWidget {
  const CommonHeader({super.key, required this.controller, this.tag});

  /// 赛事详情控制器，管理比赛数据和状态
  final MatchDetailController controller;

  /// 组件标识，用于区分不同页面的相同组件
  final String? tag;

  @override
  Widget build(BuildContext context) {
    // 比赛数据为空时返回空组件
    if (controller.detailState.match == null) {
      return const SliverToBoxAdapter();
    }

    // 根据头部类型计算固定头部高度
    // - 动画头部：使用动态高度值
    // - 其他头部：使用预设的标准高度
    double fixedHeaderHeight =
    controller.detailState.headerType.value == HeaderType.animate
        ? controller.detailState.animateHeaderHeight.value
        : controller.detailState.obtyHeaderHeight;

    return SliverAppBar(
      /// 自定义头部导航栏，包含返回按钮和标题
      title: HeaderAppbar(
        tag: tag,
      ),
      titleSpacing: 0,

      /// 标题居中对齐
      centerTitle: true,

      /// 禁用系统默认的返回按钮，使用自定义的HeaderAppbar
      automaticallyImplyLeading: false,

      /// 滚动时头部悬停固定在顶部
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,

      /// 展开高度 = 固定头部高度 - 状态栏高度（避免被状态栏遮挡）
      expandedHeight:
      fixedHeaderHeight - controller.detailState.physicalPaddingTop,

      /// 自定义工具栏高度（固定值，从detail_constant导入）
      toolbarHeight: obtyAppbarHeight,

      /// 可伸缩空间，根据滚动位置变化
      flexibleSpace: FlexibleSpaceBar(
        // 不随滚动折叠
        collapseMode: CollapseMode.none,
        // 根据头部类型展示不同的背景内容
        background: _flexibleWidget(fixedHeaderHeight),
      ),
    );
  }

  /**
   * 根据头部类型动态构建对应的灵活空间组件
   *
   * 使用Obx监听响应式状态变化，当headerType改变时自动更新UI
   *
   * @param fixedHeaderHeight 固定的头部高度
   * @return 对应类型的头部组件
   */
  Widget _flexibleWidget(double fixedHeaderHeight) {
    return Obx(() {
      final detailState = controller.detailState;
      return Stack(
        children: [
          /// 普通头部：默认显示的常规比赛信息
          Visibility(
            visible: detailState.headerType.value == HeaderType.normal,
            maintainState: true,    // 保持状态不销毁
            maintainAnimation: true, // 保持动画不中断
            child: CommonFlexibleSpace(
              tag: tag,
            ),
          ),

          /// 直播头部：显示直播相关信息，固定在底部
          if (detailState.headerType.value == HeaderType.live)
            Positioned(
              bottom: 0,  // 底部对齐
              height: fixedHeaderHeight,
              child: LiveFlexibleSpace(
                tag: tag,
              ),
            ),

          /// 动画头部：包含动画效果，固定在顶部
          if (detailState.headerType.value == HeaderType.animate)
            Positioned(
              top: 0,     // 顶部对齐
              height: fixedHeaderHeight,
              child: AnimateFlexibleSpace(
                tag: tag,
              ),
            ),

          /// 精彩回放头部
          if (detailState.headerType.value == HeaderType.replay) Container(),
        ],
      );
    });
  }
}