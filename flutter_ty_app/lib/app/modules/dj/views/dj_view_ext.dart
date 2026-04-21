import 'package:flutter_ty_app/app/modules/dj/views/dj_view.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/dj_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/hot_league_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/simple_date_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/views/skeleton_match_listView.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data_collection.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/dj_controller.dart';
import '../states/dj_state.dart';
import '../widgets/menu/game_menu_widget.dart';
import 'DJSilverList.dart';

extension DJViewExt on DJView {
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 电竞 】】】
      【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
      【【【 AUTO_PARAGRAPH_TITLE 视图界面】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 构建顶部布局，标题，日期，游戏
      】】】
   *
   */
  Widget buildTopBar(DJController controller) {
    return Container(
      color: Get.isDarkMode ? null : Colors.white,
      child: Column(
        children: [
          ScreenUtil().statusBarHeight.verticalSpace,

          /// 电竞标题控件
          const DJHeaderWidget(),

          ///日期控件
          SimpleDateMenuWidget(
            djDateEntity: controller.DJState.djDateEntity ?? [],
            onValueChanged: (DjDateEntityEntity date) {
              // AppLogger.debug('index: ${date.menuName}');
              AppLogger.debug('djDateEntity = ${date.toString()}');
              controller.changeTime(date);
            },
          ),

          ///游戏控件
          GameMenuWidget(
            gameId: controller.DJState.gameId,
            onValueChanged: (mi) {
              controller.changeGame(mi, ConfigController.to.getDjEuid(mi));
            },
            gameList: DjState.leagueList,
          ),
          Container(
            height: 4.h,
          ),
          HotLeagueWidgetDJ(),
          // GetBuilder<DJHotLeagueController>(
          //   init: DJHotLeagueController(),
          //   assignId: true,
          //   builder: (logic) {
          //     leagueController = logic;
          //     return controller.isCollect()
          //         ? Container()
          //         : logic.isSearch
          //             ? _search(logic)
          //             : _leagueSearch(logic);
          //   },
          // )
          // controller.isSearch ? _search() : _leagueSearch()
        ],
      ),
    );
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 电竞 】】】
      【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
      【【【 AUTO_PARAGRAPH_TITLE 视图界面】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 设置列表布局
      】】】
   *
   */
  dealListLogic(DJController controller) {
    if (controller.DJState.isLoading) {
      ///loading骨架图
      return SkeletonMatchListView(
        isNews: !TyHomeController.to.homeState.isProfess,
      );
    } else if (controller.DJState.djListEntity.isEmpty) {
      ///没有数据时显示 暂无数据，收藏显示收藏布局
      if (controller.isCollect()) {
        return NoDataCollect(content: LocaleKeys.msg_msg_nodata_08.tr);
      } else {
        return NoData(content: LocaleKeys.common_no_data.tr);
      }
    } else {
      return GetBuilder<TyHomeController>(
        // init: TyHomeController(),
        tag: MainTabController.to.uuid,
        builder: (tyHomeController) {
          ///有数据显示 未开赛，进行中，冠军显示 全部
          if (controller.isGuanjun()) {
            //冠军
            return CustomScrollView(
              slivers: [
                DJSilverList(
                  sectionGroupEnum: SectionGroupEnum.ALL,
                )
              ],
            );
          } else {
            return CustomScrollView(
              controller: controller.djScrollController,
              physics: ClampingScrollPhysics(),
              slivers: [
                // if (!controller.isCollect())
                DJSilverList(
                  sectionGroupEnum: SectionGroupEnum.Pin,
                ),
                DJSilverList(
                  sectionGroupEnum: SectionGroupEnum.IN_PROGRESS,
                ),
                DJSilverList(
                  sectionGroupEnum: SectionGroupEnum.NOT_STARTED,
                ),
              ],
            );
          }
        },
      );
    }
  }

  ///浮动按钮
  Widget floatingActionButton() {
    return GestureDetector(
      onTap: () => controller.toFootballBasketballTemplate(),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.isDarkMode
              ? const Color(0xE5181A21)
              : const Color(0xffFFFAFA),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 5.h, bottom: 5),
          child: ImageView(
            controller.DJState.footballBasketballTemplate2,
            width: 33.w,
            height: 26.w,
          ),
        ),
      ),
    );
  }

  ///足球篮球专题页入口
  Widget footballAndBasketballSpecialPage() {
    return controller.footballBasketballTemplateIsNearEdge == true
        ? Positioned(
            right: -20,
            bottom: bottomHideSwitch == true ? 360 : 80,
            child: GestureDetector(
              onTap: () => controller.onTap(),
              onPanUpdate: (details) => controller.onPanUpdate(details),
              child: Container(
                width: 52.w,
                height: 52.w,
                child: PageView.builder(
                  itemCount: controller.queryLeagueTemplateListData.length,
                  controller: controller.footballPageController,
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
                        controller.DJState.footballBasketballTemplate5,
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
                          controller: controller.footballPageController,
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
                        controller.DJState.footballBasketballTemplate4,
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
                        controller.DJState.footballBasketballTemplate5,
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
                          controller: controller.footballPageController,
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
                        controller.DJState.footballBasketballTemplate4,
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
