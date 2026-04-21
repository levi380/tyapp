import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/bet/views/bet_record_view.dart';
import 'package:flutter_ty_app/app/modules/cp/views/cp_view.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/home/models/refresh_status.dart';
import 'package:flutter_ty_app/app/modules/home/views/champion_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/home/views/common_match_list_view.dart';
import 'package:flutter_ty_app/app/modules/home/views/skeleton_match_listView.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/date_time_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/league/hot_league_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/main_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/sport_menu_tab.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../main.dart';

import '../../../utils/systemchrome.dart';
import '../../../widgets/empty/no_data_collection.dart';
import '../../main_tab/main_tab_controller.dart';
import '../../pip_video/pip_video_view.dart';
import '../../zr/views/zr_view.dart';
import '../controllers/home_controller.dart';
import '../states/home_state.dart';
import '../controllers/secondary_expand_controller.dart';

import '../widgets/menu/switch_container_widget.dart';
import '../widgets/menu/zr_cp_munu.dart';
import '../widgets/wh_widget.dart';
import 'olympic_button.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cbc3e951-c5bb-4085-897a-4f0557560b2d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 菜单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 首页UI页面 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # HomeView 功能注释总结

    ## 1. 类定义
    - **`HomeView`**: 无状态组件，构建应用的主页视图。

    ## 2. `build` 方法
    - **功能**:
    - 使用 `GetBuilder` 管理状态。
    - 初始化 `TyHomeController`。
    - 根据控制器的状态构建不同的视图。

    ## 3. 视图构建
    - **`VisibilityDetector`**:
    - **功能**: 检测组件的可见性。
    - **操作**: 如果组件可见，触发数据获取（如收藏计数）。

    ## 4. `_buildBody` 方法
    - **功能**:
    - 根据 `homeState` 的状态返回不同的视图组件。
    - 支持不同类型的展示逻辑，如真人展示、彩票展示、搜索结果等。

    ## 5. `_buildTopBar` 方法
    - **功能**:
    - 构建顶部菜单。
    - 包含主菜单、日期时间选择、运动类型选择等交互组件。


    】】】
 *
 */
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget _buildBody(TyHomeController controller) {
    /// 真人展示逻辑
    if (controller.homeState.listType == MatchListType.zr) {
      return Obx(() {
        /// 商户开关 zr
        /// 总控开关 accessConfig.value.zrSwitch
        if (TYUserController.to.userInfo.value?.zr == 1) {
          return const ZrView();
        } else {
          ///维护中
          return const WhWidget();
        }
      });
    }

    /// 彩票展示逻辑
    /// 商户开关 cp
    /// 总控开关 accessConfig.value.cpSwitch
    if (controller.homeState.listType == MatchListType.cp) {
      return Obx(() {
        if (TYUserController.to.userInfo.value?.cp == 1) {
          return const CpView();
        } else {
          ///维护中
          return const WhWidget();
        }
      });
    }
    if (controller.homeState.sportId ==
        SportConfig.BettingPage.sportId.toString()) {
      return const BetRecordView();
    }

    if (controller.homeState.isSearch) {
      if (controller.homeState.combineList.isEmpty) {
        ///搜索无数据
        return NoData(
          content: LocaleKeys.league_search_no_data.tr,
          top: HomeState.homeViewTopPadding.w,
        );
      } else {
        ///搜索列表数据
        return CommonMatchListView(
          key: ObjectKey(controller.homeState.matchListReq),
        );
      }
    } else {
      switch (controller.homeState.refreshStatus) {
        case RefreshStatus.isLoading:

          ///刷新loading 骨架图
          return SkeletonMatchListView(
              isNews: !(BoolKV.userVersion.get() ?? true));
        case RefreshStatus.loadSuccess:

          ///刷新成功 冠军和足球基本列表
          return controller.homeState.menu.isChampion
              ? const ChampionMatchListView()
              : const CommonMatchListView();
        case RefreshStatus.loadNoData:

          /// 收藏列表无数据填充
          if (controller.homeState.sportId ==
              SportConfig.FavoritesPage.sportId.toString()) {
            return NoDataCollect(content: LocaleKeys.msg_msg_nodata_08.tr);
          }

          ///列表无数据填充
          return NoData(
            content: LocaleKeys.league_search_no_data.tr,
            top: HomeState.homeViewTopPadding.w,
          );

        ///網路中斷了
        case RefreshStatus.loadFailed:
          return NoData(content: LocaleKeys.common_no_network.tr);
      }
    }
  }

  ///顶部主菜单
  Widget _buildTopBar(TyHomeController controller) {
    SystemUtils.isDarkMode(Get.isDarkMode);
    return Container(
      color: Get.isDarkMode
          ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
          : AppColor.bgColorLight,
      child: Column(
        children: [
          if (Get.context != null)
            Get.mediaQuery.viewPadding.top.verticalSpaceFromWidth,
          Stack(
            children: [
              if (MainTabController.to.isNewYearSwitch.value)
                Opacity(
                    opacity: Get.isDarkMode
                        ? HomeState.skeletonOpacityLight
                        : 1, // 设置透明度，0.0为完全透明，1.0为不透明
                    child: ImageView(
                      isIPad
                          ? 'assets/images/icon/ipad_toptab_2025_2.png'
                          : 'assets/images/icon/toptab_2025_2.png',
                      height: HomeState.homeViewImageHeight.w,
                      width: Get.width,
                      boxFit: BoxFit.fill,
                    )),
              Column(
                children: [
                  ///主菜单切换
                  MainMenuWidget(
                    onValueChanged: (MainMenu menu) {
                      controller.changeMenu(menu);
                      SecondaryController.clearMap();
                    },
                  ).marginOnly(
                      top: MainTabController.to.isNewYearSwitch.value ? 5 : 0),

                  ///日期时间切换: 只有在主列表时才会显示，zr和cp不显示,热门也不显示
                  if ((controller.homeState.listType == MatchListType.home) ||
                      controller.homeState.listType == MatchListType.champion)
                    DateTimeMenuWidget(
                      menu: controller.homeState.menu,
                      onDateTimeChanged: (int? value) {
                        controller.changeDateTime(value);
                      },
                    ),

                  ///球类列表切换
                  SportMenuTab(
                    scrollController: controller.sportMenuController,
                    menu: controller.homeState.menu,
                    sportId: controller.homeState.sportId,
                  ),
                ],
              )
            ],
          ),

          ///真人彩票菜单切换
          const ZRCpMenu(),

          /// 排序 黑夜白天 切换: 冠军显示，注单，真人，彩票不显示
          if (!controller.homeState.menu.isChampion &&
              ![SportConfig.BettingPage.sportId.toString()]
                  .contains(controller.homeState.sportId) &&
              ((controller.homeState.listType == MatchListType.home ||
                  controller.homeState.listType == MatchListType.champion)))
            SwitchContainerWidget(
              onNewChange: (bool value) {
                controller.changeNew(value);
              },
              onHotChange: (bool value) {
                controller.changeHot(value);
              },
            ),

          // /// 排序 黑夜白天 切换
          // if (!controller.homeState.menu.isChampion)
          //   SwitchContainerWidget(
          //     onNewChange: (bool value) {
          //       controller.changeNew(value);
          //     },
          //     onHotChange: (bool value) {
          //       //if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) return;
          //       controller.changeHot(value);
          //     },
          //   ),

          ///球队联赛菜单切换 搜索数据
          if (!controller.homeState.menu.isChampion &&
              ![
                SportConfig.BettingPage.sportId.toString(),
                SportConfig.FavoritesPage.sportId.toString()
              ].contains(controller.homeState.sportId) &&
              (controller.homeState.listType == MatchListType.home ||
                  controller.homeState.listType == MatchListType.champion))
            HotLeagueWidget(),
          4.verticalSpaceFromWidth,
        ],
      ),
    );
  }

  ///抽离公共主页结构 。避免二个Scaffold + body组成
  Widget _buildScaffoldBody(TyHomeController controller, BuildContext context) {
    return Container(
      decoration: context.isDarkMode
          ? BoxDecoration(
              color:
                  ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(),
              // image: DecorationImage(
              //   image: NetworkImage(
              //     OssUtil.getServerPath(
              //       // 'assets/images/home/color_background_skin.png',
              //       ChangeSkinToneColorUtil.instance().getModeStatus().bgUri,
              //     ),
              //   ),
              //   fit: BoxFit.cover,
              // ),
            )
          : const BoxDecoration(
              color: Colors.white,
            ),
      child: Column(
        children: [
          ///顶部菜单切换
          _buildTopBar(controller),
          Expanded(child: _buildBody(controller)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PerfMonitor().recordPage("HomePage");
    return GetBuilder<TyHomeController>(
      init: TyHomeController(),
      //TyHomeController随MainTabController改变
      tag: MainTabController.to.uuid,
      builder: (controller) {
        return Stack(
          children: [
            VisibilityDetector(
              key: ValueKey("homeView"),
              onVisibilityChanged: (VisibilityInfo info) {
                //判断是否可见
                controller.visiable = info.visibleFraction == 1;
              },
              child: olympicGames == true
                  ? Scaffold(
                      floatingActionButton: OlympicAnimationButton(context),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,

                      ///公共主页结构 ---- 专题页显示
                      body: _buildScaffoldBody(controller, context),
                    )
                  : Scaffold(
                      ///公共主页结构 ----- 常规界面入口
                      body: _buildScaffoldBody(controller, context),
                    ),
            ),
            // 视频动画（画中画）
            if (controller.homeState.isShowPipVideo)
              PipVideoView(
                onClose: () {
                  controller.closePipVideo();
                },
              ),
          ],
        );
      },
    );
  }
}
