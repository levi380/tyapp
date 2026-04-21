import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/sport_menu_tab.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../controllers/lottery_betting_controller.dart';
import '../widgets/lottery_betting_main_menu_widget.dart';
import '../widgets/lottery_betting_switch_container_widget.dart';

class LotteryBettingView extends GetView<LotteryBettingController> {
  const LotteryBettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryBettingController>(
      init: LotteryBettingController(),
      builder: (_) => Scaffold(
        bottomNavigationBar: _buildBottonNavBar(context),
        body: Container(
          decoration: context.isDarkMode
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/home/color_background_skin.png',
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(color: '#F2F2F2'.hexColor),
          child: Column(
            children: [
              // 顶部菜单切换
              _buildTopBar(context),
              const SizedBox(height: 8),
              GetBuilder<LotteryBettingController>(
                id: 'game_cate_grid_list',
                builder: (_) {
                  if (controller.isLoading) {
                    return const CupertinoActivityIndicator().center;
                  }
                  if (controller.isLoadFailed) {
                    return NoData(
                      top: 70.h,
                      content: LocaleKeys.common_no_network.tr,
                    ).center;
                  }
                  if (controller.lotteryBettingItems.isEmpty) {
                    return NoData(
                      top: 70.h,
                      content: LocaleKeys
                          .zr_cp_Lottery_Bet_Slips_no_games_available.tr,
                    ).center;
                  }
                  return Row(
                    children: [
                      if (controller.selTabIndex != 0) ...[
                        const SizedBox(width: 8),
                        _buildGameCateList(),
                      ],
                      _buildGameGrid().expanded(),
                    ],
                  );
                },
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final homeController = TyHomeController.to;
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Get.mediaQuery.viewPadding.top.verticalSpace,

          // 主菜单切换
          Row(
            children: [
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.w,
                    color: (Get.isDarkMode
                        ? AppColor.colorWhite
                        : AppColor.color303442),
                  ),
                ),
              ),
              LotteryBettingMainMenuWidget(
                onValueChanged: (MainMenu menu) {
                  homeController.changeMenu(menu);
                  SecondaryController.clearMap();
                },
              ).expanded(),
              SizedBox(width: 16.w),
            ],
          ),

          // 球类列表切换
          SportMenuTab(
            scrollController: homeController.sportMenuController,
            menu: homeController.homeState.menu,
            sportId: homeController.homeState.sportId,
          ),

          // 排序 黑夜白天 切换
          if (!homeController.homeState.menu.isChampion)
            LotteryBettingSwitchContainerWidget(
              childrenTitles: controller.tabTitles,
              selIndex: controller.selTabIndex,
              onNewChange: controller.onSelTabChangedNewChange,
            ),
          4.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildGameCateList() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
        color: AppColor.colorWhite,
      ),
      width: 116.w,
      height: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: controller.lotteryBettingCateItems.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 44.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '全部(${controller.lotteryBettingCateItems.length}款)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: '#7981A4'.hexColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (index - 1 > controller.lotteryBettingCateItems.length) {
            return const SizedBox();
          }
          final iSelected = controller.selCateIndex == index - 1;
          return InkWell(
            onTap: () => controller.onCateChanged(index - 1),
            child: Container(
              height: 44.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  ImageView(
                    'assets/images/lottery_betting_hot_game_demo_icon.png',
                    width: 20.w,
                    height: 20.w,
                    color: iSelected ? '#179CFF'.hexColor : null,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '热门游戏',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      // 选中颜色：
                      color:
                          iSelected ? '#179CFF'.hexColor : '#303442'.hexColor,
                      fontSize: 14.sp,
                    ),
                  ).flexible(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 30),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: controller.selTabIndex == 0 ? 3 : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: controller.lotteryBettingItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.colorWhite,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                // w: 71 h: 52
                child: ImageView(
                  'assets/images/lottery_demo_img.png',
                  width: 71.w,
                  height: 52.w,
                ),
              ),
              Positioned(
                left: 8,
                top: 8,
                // w: 71 h: 52
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '河内5分彩',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: '#303442'.hexColor,
                      ),
                    ),
                    Text(
                      '5分钟1期',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: '#7981A4'.hexColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 8,
                bottom: 8,
                child: ImageView(
                  Get.isDarkMode
                      // TODO: 是否收藏
                      ? 'assets/images/lottery_fav_sel_light.png'
                      // TODO: 是否收藏
                      : 'assets/images/lottery_fav_sel_light.png',
                  width: 20.w,
                  height: 20.w,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottonNavBar(BuildContext context) {
    return Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xE5181A21)
            : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.black : Colors.grey,
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 赛果
          TabWidget(
            onTap: () => controller.logicToTargetPage(0),
            title: LocaleKeys.menu_itme_name_results.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab1_night.svg'
                : 'assets/images/icon/main_tab1.png',
            dailyActivities: false,
          ),
          // 设置菜单
          TabWidget(
            onTap: () {
              controller.logicToTargetPage(1);
            },
            title: LocaleKeys.footer_menu_set_menu.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab2_night.svg'
                : 'assets/images/icon/main_tab2.png',
            dailyActivities: false,
          ),
          // 未结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(2),
            title: LocaleKeys.app_h5_cathectic_open_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab3_night.svg'
                : 'assets/images/icon/main_tab3.png',
            dailyActivities: false,
          ),
          // 已结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(3),
            title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab4_night.png'
                : 'assets/images/icon/main_tab4.png',
            dailyActivities: false,
          ),
          // 刷新
          TabWidget(
            onTap: () => controller.logicToTargetPage(4),
            title: LocaleKeys.footer_menu_refresh.tr,
            imageUrl: 'assets/images/icon/main_tab4.png',
            animation: true,
            dailyActivities: controller.dailyActivities,
            animate: controller.animationController,
          ),
        ],
      ),
    );
  }
}
