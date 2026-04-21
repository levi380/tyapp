import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';

import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../../widgets/hit_test_blocker.dart';
import '../../../widgets/lazy_indexed_stack.dart';
import '../../../widgets/loading.dart';
import '../../main_tab/main_tab_controller.dart';
import '../../shop_cart/shop_cart_controller.dart';
import '../constants/detail_constant.dart';
import '../controllers/match_detail_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/match_tools_methods.dart';
import '../widgets/common_widget/scroll_to_top.dart';
import '../widgets/guide/fullscreen_guide.dart';
import '../widgets/bottom_nav/common_bottom.dart';
import '../widgets/header/header_background.dart';
import '../widgets/header/common_header.dart';
import '../widgets/header/header_video_info.dart';
import '../widgets/tab/main_tab_widget.dart';

// 详情入口
class MatchDetailView extends StatelessWidget {
  const MatchDetailView({super.key, required this.tag});

  /// tag 使用mid
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        //关闭购物车之后再退出
        canPop: !ShopCartController.to.state.showShopCart.value,
        onPopInvoked: (didPop) {
          if (ShopCartController.to.state.showShopCart.value) {
            ShopCartController.to.currentBetController?.closeBet();
          }
        },
        child: GetBuilder<MatchDetailController>(
          tag: tag,
          builder: (controller) {
            MatchEntity? match = controller.detailState.match;
            // 数据仓库没有match
            if (match == null) {
              if (controller.detailState.detailLoading) {
                // return const CupertinoActivityIndicator().center;
                return const Loading(
                  backHeader: true,
                );
              } else {
                return NoData(
                  content: LocaleKeys.analysis_football_matches_no_data.tr,
                  backHeader: true,
                );
              }
            }
            return OrientationBuilder(builder: (context, orientation) {
              handleOrientation(controller, orientation);
              return Scaffold(
                body: Stack(
                  children: [
                    /// 背景图、动画、视频组件
                    HitTestBlocker(
                      child: HeaderBackground(
                        match: match,
                        controller: controller,
                        tag: tag,
                        // fullscreen: controller.detailState.fullscreen.value,
                      ),
                    ),

                    HitTestBlocker(
                      child: Visibility(
                        visible: !controller.detailState.fullscreen.value,
                        // 保持动画、状态、不占空间
                        maintainAnimation: true,
                        maintainSize: false,
                        maintainState: true,
                        child: _buildContainers(match, controller),
                      ),
                    ),

                    _buildFireworks(),

                    // 全屏引导 视频
                    FullscreenGuide(
                      controller: controller,
                    ),

                    // 回顶部
                    ScrollToTop(controller: controller),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildFireworks() {
    final mainTab = MainTabController.to;
    final fireworks = FireworksController.to;
    return Obx(() => mainTab.isFireworksPaly.value &&
            fireworks.isFireworksActivityValid(
                mainTab.activityEntity, fireworks.serverNow)
        ? FireworksAnimation(
            id: mainTab.fireworksId.value,
            beginTime: mainTab.beginTime.value,
            endTime: mainTab.endTime.value,
            type: mainTab.fireworksType.value,
            number: mainTab.fireworksNumber,
            championName: mainTab.championName.value,
            championIcon: mainTab.championIcon.value,
          )
        : const SizedBox.shrink());
  }

  Widget _buildContainers(MatchEntity match, MatchDetailController controller) {
    //状态栏 height
    // final double statusBarHeight = Get.mediaQuery.padding.top;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // 监听滚动距离 只处理垂直事件
        controller.calShowTop(notification);

        // 顶部悬停时 获取悬停标志
        controller.calAppbarPin(notification);

        return false;
      },
      child: ExtendedNestedScrollView(
        key: controller.detailState.matchScrollerViewGlobalKey,
        controller: controller.detailState.scrollController,
        headerSliverBuilder: (BuildContext c, bool f) {
          return [
            /// 头部 展示比分、视频、动画等
            CommonHeader(
              controller: controller,
              tag: tag,
            ),
          ];
        },

        /// 悬停高度
        pinnedHeaderSliverHeightBuilder: () {
          return controller.detailState.pinnedHeaderHeight.value;
        },

        /// AutomaticKeepAliveClientMixin	ScrollPosition 不会被释放
        onlyOneScrollInBody: true,
        physics: const ClampingScrollPhysics(),
        body: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                : Get.theme.detailBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /// 视频说明
              HeaderVideoInfo(
                controller: controller,
              ),

              ///悬停内容 tab组件
              MainTabWidget(
                controller: controller,
                tag: tag,
              ),
              Expanded(
                child: GetBuilder<MatchDetailController>(
                  tag: tag,
                  id: matchBetMainTabGetBuildId,
                  builder: (controller) {
                    final children = controller.detailState.mainTabs
                        .map((e) => e.childBuilder(tag))
                        .toList(growable: false);
                    return LazyIndexedStack(
                      index: controller.detailState.curMainTab.value,
                      children: children,
                    );
                  },
                ),
              ),

              /// 底部导航 普通赛事详情 和电竞显示、横屏不显示
              if ([Routes.matchDetail, Routes.DJView]
                      .contains(Get.currentRoute) &&
                  !controller.detailState.fullscreen.value &&
                  controller.detailState.showBottom)
                CommonBottom(
                  controller: controller,
                  tag: tag,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
