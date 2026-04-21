
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/pin_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';

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
import 'menu_item_left.dart';

///球种菜单
class SportMenuWidget extends StatefulWidget {
  const SportMenuWidget({
    super.key,
    required this.menu,
    required this.sportId,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final MainMenu menu;
  final String sportId;

  @override
  State<SportMenuWidget> createState() => _SportMenuWidgetState();
}

class _SportMenuWidgetState extends State<SportMenuWidget> {
  String sportId =  SportConfig.football.sportId.toString();
  int index = 0;
  late StreamSubscription _sub;
  @override
  void initState() {
    super.initState();
    sportId = widget.sportId;
    _sub = EventBus().on<EventPayLoad>().listen(_handleEvent);

  }
  void _handleEvent(EventPayLoad payload) {
    if (payload.eventType != EventType.leagueSearchContent) return;
    final value = payload.data;
    final searchText = value['searchText'];
    final sportMenu = value['sportMenu'];

    if (searchText.isNullOrEmpty || sportMenu == null) return;

    MainTabController.to.update();
    TyHomeController.to.homeState
      ..searchText = searchText
      ..isSearch = true;
    TyHomeController.to.changeSport(sportMenu.mi, sportMenu.euid);
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(SportMenuWidget oldWidget) {
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
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Container(
            height: 50.h,
            alignment: Alignment.center,
            child: ScrollIndexWidget(
              scrollDirection: Axis.horizontal,
              isStopCallback: false,
              callBack: (int firstIndex, int lastIndex) {
                ///判断球种滚动和边界 显示最左边或者最右边
                int currentIndex = TyHomeController
                    .to.homeSportMenuState.sportMenuList
                    .indexWhere((element) => element.mi == widget.sportId);
                if (currentIndex == -1) return;

                ///判断当前选中球种 靠左还是靠右
                if (currentIndex <= firstIndex) {
                  TyHomeController.to.homeSportMenuState.leftShow.value = true;
                  TyHomeController.to.homeSportMenuState.rightShow.value =
                      false;
                } else if (currentIndex >= lastIndex) {
                  TyHomeController.to.homeSportMenuState.leftShow.value = false;
                  TyHomeController.to.homeSportMenuState.rightShow.value = true;
                } else {
                  TyHomeController.to.homeSportMenuState.leftShow.value = false;
                  TyHomeController.to.homeSportMenuState.rightShow.value =
                      false;
                }
              },
              child: ListView.builder(
                controller: widget.scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    TyHomeController.to.homeSportMenuState.sportMenuList.length,
                clipBehavior: Clip.none,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final sportInfo = TyHomeController
                      .to.homeSportMenuState.sportMenuList[index];
                  if (sportInfo.mi ==
                          SportConfig.FavoritesPage.sportId.toString() &&
                      ConfigController.to.accessConfig.value.collectSwitch ==
                          false) {
                    return const SizedBox();
                  }
                  if (sportInfo.mi ==
                          SportConfig.MatchAllPage.sportId.toString() &&
                      ConfigController.to.accessConfig.value.playAllShow ==
                          false) {
                    return const SizedBox();
                  }

                  /// 电子篮球和电子足球用户开关
                  if ((TYUserController.to.userInfo.value
                                  ?.openElectronicBasketball ??
                              1) !=
                          1 &&
                      sportInfo.mi == '191') {
                    return const SizedBox();
                  }
                  if ((TYUserController
                                  .to.userInfo.value?.openElectronicFootball ??
                              1) !=
                          1 &&
                      sportInfo.mi == '190') {
                    return const SizedBox();
                  }

                  /// 电竞开关
                  if ((TYUserController.to.userInfo.value?.openEsport ?? 1) !=
                          1 &&
                      sportInfo.mi ==
                          SportConfig.EsportsPage.sportId.toString()) {
                    return const SizedBox();
                  }

                  /// 注单暂时隐藏
                  // if (sportInfo.mi == '6000') {
                  //
                  //   return const SizedBox();
                  // }

                  // VR体育开关
                  if ((TYUserController.to.userInfo.value?.openVrSport ?? 1) !=
                          1 &&
                      sportInfo.mi ==
                          SportConfig.VirtualSportsPage.sportId.toString()) {
                    return const SizedBox();
                  }

                  return GetBuilder<CollectionController>(
                    id: sportInfo.mi,
                    builder: (collectionCtr) {
                      if (sportInfo.mi ==
                              SportConfig.VirtualSportsPage.sportId
                                  .toString() &&
                          !TyHomeController.to.showVrSportMenu) {
                        return const SizedBox();
                      }
                      bool isSelected = sportInfo.mi == sportId &&
                          (TyHomeController.to.homeState.listType ==
                                  MatchListType.home ||
                              TyHomeController.to.homeState.listType ==
                                  MatchListType.champion);

                      AppLogger.debug(
                          "sportInfo.mi = ${sportInfo.mi} isSelected = $isSelected");

                      return MenuItem(
                        key: isSelected
                            ? TyHomeController.to.sportSelectKey
                            : ValueKey(sportInfo.mi),
                        title: ConfigController.to.getName(sportInfo.mi),
                        index: sportInfo.iconIndex,
                        count: sportInfo.mi ==
                                SportConfig.FavoritesPage.sportId.toString()
                            ? collectionCtr.collectionCount
                            : sportInfo.count,
                        isSelected: isSelected,
                        onTap: () async {
                          /// 如果是收藏或注单
                          if (sportInfo.mi ==
                                  SportConfig.FavoritesPage.sportId
                                      .toString() ||
                              sportInfo.mi ==
                                  SportConfig.BettingPage.sportId.toString()) {
                            if (!RouteCheckUtil.checkNoLoginAndGoToLogin()) {
                              return;
                            }
                          }

                          if (!RouteCheckUtil.checkIsLogin() &&
                              widget.menu.isToday) {
                            index = index - 4;
                          } else if (!RouteCheckUtil.checkIsLogin() &&
                              widget.menu.isPlay) {
                            index = index - 2;
                          }



                          if (sportInfo.mi ==
                              SportConfig.FavoritesPage.sportId.toString()) {
                            SettingMenuController.to.showMatchFilter = false;
                          } else {
                            SettingMenuController.to.showMatchFilter = true;
                          }

                          ///DJView页面
                          if (sportInfo.mi ==
                              SportConfig.EsportsPage.sportId.toString()) {
                            TyHomeController.to.homeState.listType =
                                MatchListType.home;
                            await Get.toNamed(Routes.DJView);
                            AppLogger.debug("退出电竞页面 == ");
                            PinController.to?.refreshPin();
                            return;
                          }
                          //vr页面
                          if (sportInfo.mi ==
                              SportConfig.VirtualSportsPage.sportId
                                  .toString()) {
                            await Get.toNamed(Routes.vrHomePage);
                            return;
                          }
                          TyHomeController
                              .to.homeSportMenuState.leftShow.value = false;
                          TyHomeController
                              .to.homeSportMenuState.rightShow.value = false;

                          /// 二级菜单清除掉上次搜索的数据
                          TyHomeController.to.homeState.isSearch = false;
                          TyHomeController.to.homeState.searchText = '';
                          TyHomeController.to
                              .changeSport(sportInfo.mi, sportInfo.euid);
                          // WidgetsBinding.instance
                          //     .addPostFrameCallback((timeStamp) {
                          //   if (TyHomeController.to.sportSelectKey != null &&
                          //       TyHomeController
                          //               .to.sportSelectKey?.currentContext !=
                          //           null) {
                          //     ///菜单滑动到居中位置
                          //     Scrollable.ensureVisible(
                          //         TyHomeController
                          //             .to.sportSelectKey!.currentContext!,
                          //         alignment: 0.5,
                          //         duration: HomeState.menuScrollDuration,
                          //         curve: Curves.easeInOut);
                          //   }
                          // });

                          ///底部菜单刷新
                          MainTabController.to.update();
                        },
                      );
                    },
                  );
                },
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

}
