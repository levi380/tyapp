import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/pin_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/sport_item_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';
import '../../../../global/config_controller_ext.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../main_tab/main_tab_controller.dart';
import '../../../setting_menu/setting_menu_controller.dart';
import '../../states/home_state.dart';
import 'menu_item_left.dart';

///球种菜单
class SportMenuTab extends StatefulWidget {
  const SportMenuTab({
    super.key,
    required this.menu,
    required this.sportId,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final MainMenu menu;
  final String sportId;

  @override
  State<SportMenuTab> createState() => _SportMenuTabState();
}

class _SportMenuTabState extends State<SportMenuTab> {
  String sportId = '101';

  @override
  void initState() {
    super.initState();
    sportId = widget.sportId;
    EventBus().on<EventPayLoad>().listen((payload) async {
      if (payload.eventType == EventType.leagueSearchContent) {
        Map value = payload.data;
        String? searchText = value['searchText'];
        SportMenu? sportMenu = value['sportMenu'];
        if (ObjectUtil.isEmpty(sportMenu)) {
          return;
        }

        ///底部菜单刷新
        MainTabController.to.update();
        if (ObjectUtil.isNotEmpty(searchText)) {
          TyHomeController.to.homeState.searchText = searchText ?? '';
          TyHomeController.to.homeState.isSearch = true;
          if (sportId != sportMenu?.mi) {
            TyHomeController.to.changeSport(sportMenu!.mi, sportMenu.euid);
          } else {
            TyHomeController.to.search(searchText ?? '');
          }
        } else {
          /// 二级菜单清除掉上次搜索的数据
          TyHomeController.to.homeState.isSearch = false;
          TyHomeController.to.homeState.searchText = '';
          if (sportId == sportMenu?.mi) {
            TyHomeController.to.search('');
          } else {
            TyHomeController.to.changeSport(sportMenu!.mi, sportMenu.euid);
          }
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void didUpdateWidget(SportMenuTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sportId != oldWidget.sportId ||
        widget.menu.mi != oldWidget.menu.mi) {
      sportId = widget.sportId;
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (TyHomeController.to.sportSelectKey != null &&
            TyHomeController.to.sportSelectKey?.currentContext != null) {
          ///菜单滑动到居中位置
          Scrollable.ensureVisible(
              TyHomeController.to.sportSelectKey!.currentContext!,
              alignment: 0.5,
              duration: HomeState.menuScrollDuration,
              curve: Curves.easeInOut);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int currentIndex = TyHomeController.to.homeSportMenuState.sportMenuList
          .indexWhere((element) => element.mi == widget.sportId);
      return Stack(
        children: [
          Container(
            height: 50.h,
            alignment: Alignment.center,
            child: TyHomeController
                        .to.homeSportMenuState.sportMenuList.isEmpty ||
                    TyHomeController
                            .to.homeSportMenuState.sportMenuList.length ==
                        0
                ? const SizedBox()
                : ScrollIndexWidget(
                    scrollDirection: Axis.horizontal,
                    isStopCallback: false,
                    callBack: (int firstIndex, int lastIndex) {
                      ///判断球种滚动和边界 显示最左边或者最右边
                      int currentIndex = TyHomeController
                          .to.homeSportMenuState.sportMenuList
                          .indexWhere(
                              (element) => element.mi == widget.sportId);
                      if (currentIndex == -1) return;

                      ///判断当前选中球种 靠左还是靠右
                      if (currentIndex <= firstIndex) {
                        TyHomeController.to.homeSportMenuState.leftShow.value =
                            true;
                        TyHomeController.to.homeSportMenuState.rightShow.value =
                            false;
                      } else if (currentIndex >= lastIndex) {
                        TyHomeController.to.homeSportMenuState.leftShow.value =
                            false;
                        TyHomeController.to.homeSportMenuState.rightShow.value =
                            true;
                      } else {
                        TyHomeController.to.homeSportMenuState.leftShow.value =
                            false;
                        TyHomeController.to.homeSportMenuState.rightShow.value =
                            false;
                      }
                    },
                    child: DefaultTabController(
                      length: TyHomeController
                          .to.homeSportMenuState.sportMenuList.length,
                      initialIndex: max(0, currentIndex),
                      child: TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.zero,

                        /// 去掉tabbar的所有指示器分割线
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(),
                        indicatorWeight: 0,
                        tabs: TyHomeController
                            .to.homeSportMenuState.sportMenuList
                            .asMap()
                            .entries
                            .map((e) => Tab(child: _buildSportMenuTab(e.key)))
                            .toList(),
                      ),
                    ),
                  ),
          ),

          ///显示左边
          if (TyHomeController.to.homeSportMenuState.leftShow.value)
            Align(
              alignment: Alignment.centerLeft,
              child: Builder(
                builder: (context) {
                  final sportInfo = TyHomeController
                      .to.homeSportMenuState.sportMenuList
                      .firstWhere((element) => element.mi == sportId);
                  return GetBuilder<CollectionController>(
                    id: sportInfo.mi,
                    builder: (logic) {
                      return MenuItemLeft(
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi ==
                                SportConfig.FavoritesPage.sportId.toString()
                            ? logic.collectionCount
                            : sportInfo.count,
                        isSelected: true,
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),

          ///显示右边
          if (TyHomeController.to.homeSportMenuState.rightShow.value)
            Align(
              alignment: Alignment.centerRight,
              child: Builder(builder: (context) {
                final sportInfo = TyHomeController
                    .to.homeSportMenuState.sportMenuList
                    .firstWhere((element) => element.mi == sportId);
                return GetBuilder<CollectionController>(
                    id: sportInfo.mi,
                    builder: (logic) {
                      return MenuItemLeft(
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi ==
                                SportConfig.FavoritesPage.sportId.toString()
                            ? logic.collectionCount
                            : sportInfo.count,
                        isSelected: true,
                        onTap: () {},
                      );
                    });
              }),
            )
        ],
      );
    });
  }

  Widget _buildSportMenuTab(int index) {
    final sportInfo =
        TyHomeController.to.homeSportMenuState.sportMenuList[index];
    if (sportInfo.mi == SportConfig.FavoritesPage.sportId.toString() &&
        ConfigController.to.accessConfig.value.collectSwitch == false) {
      return const SizedBox();
    }
    if (sportInfo.mi == SportConfig.MatchAllPage.sportId.toString() &&
        ConfigController.to.accessConfig.value.playAllShow == false) {
      return const SizedBox();
    }

    /// 电子篮球和电子足球用户开关
    if ((TYUserController.to.userInfo.value?.openElectronicBasketball ?? 1) !=
            1 &&
        sportInfo.mi == '191') {
      return const SizedBox();
    }
    if ((TYUserController.to.userInfo.value?.openElectronicFootball ?? 1) !=
            1 &&
        sportInfo.mi == '190') {
      return const SizedBox();
    }

    /// 电竞开关
    if ((TYUserController.to.userInfo.value?.openEsport ?? 1) != 1 &&
        sportInfo.mi == '2000') {
      return const SizedBox();
    }

    /// 注单暂时隐藏
    // if (sportInfo.mi == '6000') {
    //
    //   return const SizedBox();
    // }

    // VR体育开关
    if ((TYUserController.to.userInfo.value?.openVrSport ?? 1) != 1 &&
        sportInfo.mi == SportConfig.VirtualSportsPage.sportId.toString()) {
      return const SizedBox();
    }

    return GetBuilder<CollectionController>(
        id: sportInfo.mi,
        builder: (collectionCtr) {
          if (sportInfo.mi ==
                  SportConfig.VirtualSportsPage.sportId.toString() &&
              !TyHomeController.to.showVrSportMenu) {
            return const SizedBox();
          }
          bool isSelected = sportInfo.mi == sportId &&
              (TyHomeController.to.homeState.listType == MatchListType.home ||
                  TyHomeController.to.homeState.listType ==
                      MatchListType.champion);

          // AppLogger.debug("sportInfo.mi = ${sportInfo.mi} isSelected = $isSelected");

          return MenuItem(
            key: isSelected
                ? TyHomeController.to.sportSelectKey
                : ValueKey(sportInfo.mi),
            title: ConfigController.to.getName(sportInfo.mi),
            index: sportInfo.iconIndex,
            count: sportInfo.mi == SportConfig.FavoritesPage.sportId.toString()
                ? collectionCtr.collectionCount
                : sportInfo.count,
            isSelected: isSelected,
            onTap: () async {
              /// 如果是收藏或注单
              if (sportInfo.mi ==
                      SportConfig.FavoritesPage.sportId.toString() ||
                  sportInfo.mi == SportConfig.BettingPage.sportId.toString()) {
                if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) {
                  return;
                }
              }

              if (!RouteCheckUtil.checkIsLogin() && widget.menu.isToday) {
                index = index - 4;
              } else if (!RouteCheckUtil.checkIsLogin() && widget.menu.isPlay) {
                index = index - 2;
              }

              ///底部菜单刷新
              MainTabController.to.update();

              if (sportInfo.mi ==
                  SportConfig.FavoritesPage.sportId.toString()) {
                SettingMenuController.to.showMatchFilter = false;
              } else {
                SettingMenuController.to.showMatchFilter = true;
              }

              ///DJView页面
              if (sportInfo.mi == '2000') {
                TyHomeController.to.homeState.listType = MatchListType.home;
                TyHomeController.to.closePipVideo();
                await Get.toNamed(Routes.DJView);
                AppLogger.debug("退出电竞页面 == ");
                PinController.to?.refreshPin();
                return;
              }
              //vr页面
              if (sportInfo.mi ==
                  SportConfig.VirtualSportsPage.sportId.toString()) {
                TyHomeController.to.closePipVideo();
                await Get.toNamed(Routes.vrHomePage);
                return;
              }
              TyHomeController.to.homeSportMenuState.leftShow.value = false;
              TyHomeController.to.homeSportMenuState.rightShow.value = false;

              /// 二级菜单清除掉上次搜索的数据
              TyHomeController.to.homeState.isSearch = false;
              TyHomeController.to.homeState.searchText = '';
              TyHomeController.to.changeSport(sportInfo.mi, sportInfo.euid);
            },
          );
        });
  }
}
