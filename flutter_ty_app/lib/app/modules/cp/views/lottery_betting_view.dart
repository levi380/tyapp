import 'package:flutter/cupertino.dart';

import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/controllers/cp_controller.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/sport_menu_tab.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/lottery_betting/widgets/lottery_betting_main_menu_widget.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../widget/lottery_betting_switch_container_widget.dart';

class LotteryBettingView extends GetView<CpController> {
  const LotteryBettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpController>(
      init: CpController(),
      builder: (_) => Scaffold(
        body: Container(
          decoration: context.isDarkMode
              ? null
              : BoxDecoration(color: CpState.cpViewBgColor),
          child: Column(
            children: [
              // 顶部菜单切换
              _buildTopBar(context),
              SizedBox(height: CpState.cpViewOtherTicketTopMargin),
              GetBuilder<CpController>(
                id: 'game_cate_grid_list',
                builder: (_) {
                  if (controller.isLoading) {
                    return const CupertinoActivityIndicator().center;
                  }
                  if (controller.isLoadFailed) {
                    return NoData(
                      top: CpState.cpViewNoDataTopMargin,
                      content: LocaleKeys.common_no_network.tr,
                    ).center;
                  }
                  if (controller.showCateList.isEmpty) {
                    return NoData(
                      top: CpState.cpViewNoDataTopMargin,
                      content: LocaleKeys
                          .zr_cp_Lottery_Bet_Slips_no_games_available.tr,
                    ).center;
                  }
                  return Row(
                    children: [
                      if (controller.selTabIndex != 0) ...[
                        SizedBox(width: CpState.gameGridHPadding),
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
                  margin: EdgeInsets.only(left: CpState.lotteryBettingBackMarginLeft),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: CpState.lotteryBettingBackIconSize,
                    color: (Get.isDarkMode
                        ? CpState.lotteryBettingBackIconColorDark
                        : CpState.lotteryBettingBackIconColorLight),
                  ),
                ),
              ),
              LotteryBettingMainMenuWidget(
                onValueChanged: (MainMenu menu) {
                  homeController.changeMenu(menu);
                  SecondaryController.clearMap();
                },
              ).expanded(),
              SizedBox(width: CpState.lotteryBettingTopBarSpacing),
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
      width: CpState.gameCateListWidth,
      height: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: CpState.gameCateListPaddingBottom),
        itemCount: controller.showCateList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: CpState.gameCateListItemHeight,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: CpState.gameCateListItemHPadding),
              child: Text(
                '全部(${controller.showCateList.length}款)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CpState.gameCateListAllTextColor,
                  fontSize: CpState.gameCateListAllTextSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (index - 1 > controller.showCateList.length) {
            return const SizedBox();
          }
          final iSelected = controller.selCateIndex == index - 1;
          return InkWell(
            onTap: () => controller.onCateChanged(index - 1),
            child: Container(
              height: CpState.gameCateListItemHeight,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: CpState.gameCateListItemHPadding),
              child: Row(
                children: [
                  ImageView(
                    CpState.hotGameIconPath,
                    width: CpState.hotGameIconSize,
                    height: CpState.hotGameIconSize,
                    color: iSelected ? CpState.hotGameSelectedColor : null,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '热门游戏',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      // 选中颜色：
                      color:
                          iSelected ? CpState.hotGameSelectedColor : CpState.hotGameUnselectedTextColor,
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
      padding: EdgeInsets.symmetric(horizontal: CpState.gameGridHPadding).copyWith(bottom: CpState.gameGridBPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: controller.selTabIndex == 0 ? 3 : 2,
        mainAxisSpacing: CpState.gameGridMainAxisSpacing,
        crossAxisSpacing: CpState.gameGridCrossAxisSpacing,
      ),
      itemCount: controller.showCateList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: CpState.gameGridItemBgColor,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                // w: 71 h: 52
                child: ImageView(
                  CpState.gameDemoImgPath,
                  width: CpState.gameDemoImgWidth,
                  height: CpState.gameDemoImgHeight,
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
                        fontSize: CpState.gameNameTextSize,
                        fontWeight: FontWeight.w500,
                        color: CpState.gameNameTextColor,
                      ),
                    ),
                    Text(
                      '5分钟1期',
                      style: TextStyle(
                        fontSize: CpState.gameDescTextSize,
                        color: CpState.gameDescTextColor,
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
                      ? CpState.favSelLightPath
                      // TODO: 是否收藏
                      : CpState.favSelLightPath,
                  width: CpState.favIconSize,
                  height: CpState.favIconSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
