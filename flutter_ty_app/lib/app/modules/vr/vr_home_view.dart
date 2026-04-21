import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/balance_icon_button.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/global_expand_toggle_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/basket_going_sport_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/going_sport_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_menu_tab_bar.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/bottom_wait_list_widget/waiting_sport_widget.dart';
import 'package:flutter_ty_app/app/widgets/common_app_bar.dart';
import 'package:flutter_ty_app/app/widgets/loading.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../main.dart';
import '../../utils/change_skin_tone_color_util.dart';

import '../../widgets/fireworks/fireworks_animation.dart';
import '../../widgets/fireworks/fireworks_controller.dart';
import '../main_tab/main_tab_controller.dart';
import 'vr_home_controller.dart';
import 'widgets/head_going_sport_widget/vr_common_going_sports_widget.dart';
import 'widgets/vr_home_bottom_nav_bar.dart';
import 'vr_sport_state.dart';

///vr体育 入口
class VrHomeView extends GetView<VrTyHomeController> {
  const VrHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<VrTyHomeController>()) {
      Get.lazyPut(() => VrTyHomeController());
    }
    // PreloadImg.preloadOnVrSport(context);
    return GetBuilder<VrTyHomeController>(
      /// 每次模式切换都会变
      // key: ValueKey(Get.isDarkMode),
      init: VrTyHomeController(),
      builder: (_) => Stack(
        children: [
          _buildBackground(context),
          Scaffold(
            backgroundColor: !Get.isDarkMode
                ? '#F2F2F6'.hexColor
                : ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(),

            appBar: CommonAppBar.arrowBack(
              onBack: () {
                Get.back();

                ///底部菜单刷新
                MainTabController.to.update();
                MainTabController.to.startAutoScroll();
              },
              context,
              title: LocaleKeys.common_virtual_sports.tr,
              actions: [
                const BalanceIconButton(),
              ],
            ),

            ///浮动按钮
            floatingActionButton: footballBasketballTemplate == true
                ? _floatingActionButton()
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: VrHomeBottomNavBar(controller: controller),
            body: controller.vrSportsMenus.isEmpty

                ///无数据加载loading
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity != null) {
                        final isLeft = details.primaryVelocity! < 0;
                        controller.onListSwipe(isLeft);
                      }
                    },
                    child: Loading(
                      backHeader: false,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///vr赛事菜单头部tab 和 联赛头部
                      GetBuilder<VrTyHomeController>(
                        id: 'sport_menus',
                        builder: (controller) {
                          return VrSportMenuTabBar(
                            key: controller.tabBarKey,
                            vrSportMenus: controller.vrSportsMenus,
                            onMenuChanged: controller.onMenuChanged,
                          );
                        },
                      ),

                      ///vr全部联赛 展开收起
                      GetBuilder<VrTyHomeController>(
                        id: 'all_expand_toggle',
                        builder: (_) => GlobalExpandToggleWidget.all(
                          key: ValueKey(
                              'all_expand_toggle_${controller.isAllExpand}'),
                          isExpand: controller.isAllExpand,
                          onExpandChanged: controller.onAllExpandChanged,
                        ),
                      ),
                      const SizedBox(height: 1),

                      ///赛事列表 + 左右滑动包裹
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity != null) {
                              final isLeft = details.primaryVelocity! < 0;
                              controller.onListSwipe(isLeft);
                            }
                          },
                          child: GetBuilder<VrTyHomeController>(
                            id: 'match_list',
                            builder: (_) {
                              if (controller.isMatchesLoading) {
                                ///无列表数据加载loading
                                return Loading(
                                  backHeader: false,
                                );
                              }

                              ///数据加载失败
                              if (controller.isLoadFailed) {
                                return NoData(
                                  top: VRSportState.noDataTop.h,
                                  content: LocaleKeys.common_no_network.tr,
                                  // type: NoDataType.noWifi,
                                  // onRefresh: () {
                                  //   controller.onNextMatchCountdownEnd();
                                  // },
                                ).center;
                              }

                              ///空数据页面
                              if (controller.matches.isEmpty) {
                                return NoData(
                                  top: VRSportState.noDataTop.h,
                                  content: LocaleKeys.common_no_data.tr,
                                  // type: NoDataType.noMatch,
                                ).center;
                              }
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                        horizontal: VRSportState.listPaddingH.w)
                                    .copyWith(
                                        bottom: VRSportState.listPaddingBottom
                                            .toDouble()),
                                itemCount: controller.matches.length,
                                itemBuilder: (context, index) {
                                  if (index >= controller.matches.length) {
                                    return const SizedBox();
                                  }

                                  /// 未开始的第一个和第二个其实是重复的，所以不能用 index + 1
                                  /// 所以序列1 给到当前轮 和 赛事状态 头部显示
                                  if (index == 0) {
                                    return buildFristMatchItem(index);
                                  }

                                  final vrMatch = controller.matches[index];
                                  final isExpand = controller.isAllExpand ||
                                      vrMatch.isExpand;

                                  ///剩余赛事列表
                                  return WaitingSportWidget(
                                    key: ValueKey(
                                        'waiting_match_${vrMatch.batchNo}_$isExpand'),
                                    title: controller.subMenu?.name ?? '',
                                    isExpand: isExpand,
                                    type: controller.topMenu?.type ?? 1,
                                    vrMatch: vrMatch,
                                    onToggleExpand: (isExpand) {
                                      controller.onItemToggleExpand(
                                          isExpand, index);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),

          /// 需求4186    足球篮球专题页入口
          if (footballBasketballTemplate == true)
            _footballAndBasketballSpecialPage(),

          Obx(() => MainTabController.to.isFireworksPaly.value &&
                  FireworksController.to.isFireworksActivityValid(
                      MainTabController.to.activityEntity,
                      FireworksController.to.serverNow)
              ? FireworksAnimation(
                  id: MainTabController.to.fireworksId.value,
                  beginTime: MainTabController.to.beginTime.value,
                  endTime: MainTabController.to.endTime.value,
                  type: MainTabController.to.fireworksType.value,
                  number: MainTabController.to.fireworksNumber,
                  championName: MainTabController.to.championName.value,
                  championIcon: MainTabController.to.championIcon.value,
                )
              : Container()),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Stack(
      children: [
        if (Get.isDarkMode) VRSportState.darkBackground(),
        Container(decoration: const BoxDecoration(color: AppColor.vrSportBg)),
      ],
    );
  }

  Widget buildFristMatchItem(int index) {
    final vrMatch = controller.matches[index];

    /// 未开始的第一个和第二个其实是重复的，所以不能用 index + 1
    final nextVrMatch = controller.matches
        .firstWhereOrNull((element) => element.batchNo != vrMatch.batchNo);
    // index + 1 < controller.matches.length
    //     ? controller.matches[index + 1]
    //     : null;
    final isExpand = controller.isAllExpand || vrMatch.isExpand;

    ///当前轮  第几轮 和 当前赛事状态 头部
    return VrCommonGoingSportsWidget(
      onToggleExpand: (isExpand) {
        controller.onItemToggleExpand(isExpand, index);
      },
      title: controller.subMenu?.name ?? '',
      subtitle: vrMatch.no,
      batchNo: vrMatch.batchNo,
      time: vrMatch.mgt,
      cusTime: controller.curMatchFinished ? LocaleKeys.list_match_end.tr : '',
      isExpand: isExpand,
      index: index,
      lod: vrMatch.lod,
      child: controller.topMenu?.type == 2

          ///篮球的开赛的视频播放 和 其他游戏开赛的视频 是区分开的
          ///头部也是分开的
          ? BasketGoingSportWidget(
              key: ValueKey(
                  'basket_going_match_${vrMatch.batchNo}_${vrMatch.lod}'),
              type: controller.topMenu?.type ?? 1,
              vrMatch: vrMatch,
              nextVrMatch: nextVrMatch,
              getVirtualReplay: controller.getVirtualReplay,
              onNextMatchCountdownEnd: controller.onNextMatchCountdownEnd,
              onVideoPlayFinished: controller.onVideoPlayFinished,
              onGetMatchScore: controller.getMatchScore,
            )
          :

          ///其他开始赛事直播头部
          GoingSportWidget(
              key: ValueKey('going_match_${vrMatch.batchNo}'),
              type: controller.topMenu?.type ?? 1,
              vrMatch: vrMatch,
              nextVrMatch: nextVrMatch,
              getVirtualReplay: controller.getVirtualReplay,
              onNextMatchCountdownEnd: controller.onNextMatchCountdownEnd,
              onVideoPlayFinished: controller.onVideoPlayFinished,
              onGetMatchScore: controller.getMatchScore,
            ),
    );
  }

  ///浮动按钮
  Widget _floatingActionButton() {
    return VRSportState.floatingSpecialButton(
      onTap: () => controller.toFootballBasketballTemplate(),
    );
  }

  ///足球篮球专题页入口
  Widget _footballAndBasketballSpecialPage() {
    return controller.footballBasketballTemplateIsNearEdge == true
        ? Positioned(
            right: -20,
            bottom: bottomHideSwitch == true ? 360 : 100,
            child: GestureDetector(
              onTap: () => controller.onTap(),
              onPanUpdate: (details) => controller.onPanUpdate(details),
              child: Container(
                width: 52.w,
                height: 52.w,
                child: PageView.builder(
                  itemCount: controller.queryLeagueTemplateListData.length,
                  controller: controller.pageController,
                  onPageChanged: (page) => controller.onPageChanged(page),
                  itemBuilder: (context, index) {
                    return ImageView(
                      controller.queryLeagueTemplateListData[index]
                          .activityTemplateImageH5Sdk,
                      cdn: true,
                      width: 52.w,
                      height: 52.w,
                    );
                  },
                ),
              ),
            ),
          )
        : Positioned(
            left: controller.footballBasketballTemplatePosition.dx,
            top: controller.footballBasketballTemplatePosition.dy,
            child: Draggable(
              feedback: Container(
                width: 100.w,
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onPreviousPage(),
                      child: ImageView(
                        'assets/images/icon/footballBasketballTemplate_5.png',
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toFootballBasketballTemplate(),
                      child: Container(
                        width: 52.w,
                        height: 52.w,
                        child: PageView.builder(
                          itemCount:
                              controller.queryLeagueTemplateListData.length,
                          controller: controller.pageController,
                          onPageChanged: (page) =>
                              controller.onPageChanged(page),
                          itemBuilder: (context, index) {
                            return ClipOval(
                              child: ImageView(
                                controller.queryLeagueTemplateListData[index]
                                    .activityTemplateImageH5Sdk,
                                cdn: true,
                                width: 52.w,
                                height: 52.w,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onNextPage(),
                      child: ImageView(
                        'assets/images/icon/footballBasketballTemplate_4.png',
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 100.w,
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onPreviousPage(),
                      child: ImageView(
                        'assets/images/icon/footballBasketballTemplate_5.png',
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.toFootballBasketballTemplate(),
                      child: Container(
                        width: 52.w,
                        height: 52.w,
                        child: PageView.builder(
                          itemCount:
                              controller.queryLeagueTemplateListData.length,
                          controller: controller.pageController,
                          onPageChanged: (page) =>
                              controller.onPageChanged(page),
                          itemBuilder: (context, index) {
                            return ImageView(
                              controller.queryLeagueTemplateListData[index]
                                  .activityTemplateImageH5Sdk,
                              cdn: true,
                              width: 52.w,
                              height: 52.w,
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onNextPage(),
                      child: ImageView(
                        'assets/images/icon/footballBasketballTemplate_4.png',
                        width: 22.w,
                        height: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) =>
                  controller.onFootballBasketballTemplateDragEnd(details),
            ),
          );
  }
}
