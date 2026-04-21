

import 'package:flutter_ty_app/app/modules/dj/views/dj_view_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/menu/hot_league_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../controllers/dj_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 视图界面】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 底部tab
    - 列表分组数据计算
    - 列表内容渲染
    # `_sliverList`

    ```
    - 根据ms区分未开赛，进行中，全部
    - ms == 0 未开赛
    - ms == 1 进行中
    ```

    ```
    switch (sectionGroupEnum) {
    case SectionGroupEnum.IN_PROGRESS:

    case SectionGroupEnum.NOT_STARTED:

    case SectionGroupEnum.ALL:

    case SectionGroupEnum.Pin:
    }
    ```

    ` - 点击 未开赛/进行中 折叠/展开 每个联赛分组`

    ```dart
    data.forEach((matchEntity) {
    DJController.to
    .clickCollop(isExpand, matchEntity, sectionGroupEnum);
    });
    ```

    # `_buildTopBar`

    `- 构建顶部布局，标题，日期，游戏`

    ```
    /// 电竞标题控件
    const DJHeaderWidget(),
    ///日期控件
    SimpleDateMenuWidget(
    djDateEntity: controller.DJState.djDateEntity ?? [],
    onValueChanged: (DjDateEntityEntity date) {
    AppLogger.debug('index: ${date.menuName}');
    AppLogger.debug('djDateEntity = ${date.toString()}');
    controller.changeTime(date);
    },
    ),

    ///游戏控件
    GameMenuWidget(
    gameId: controller.DJState.gameId,
    onValueChanged: (mi) {
    controller.DJState.gameId = mi;
    controller.changeGame(mi, ConfigController.to.getDjEuid(mi));
    },
    gameList: Game.leagueList,
    ),
    ```

    # `dealListLogic`

    ` - 设置列表布局`

    】】】
 *
 */
class DJView extends StatelessWidget {
  DJView({Key? key, this.leagueController}) : super(key: key);

  final controller = Get.find<DJController>();
  final bottomController = Get.find<MainTabController>();
  final DJHotLeagueController? leagueController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DJController>(
      builder: (controller) {
        return  Stack(
          children:[
            Scaffold(
              body: GetBuilder<DJController>(
                init: DJController(),
                initState: (_) => Get.put(DJHotLeagueController(), permanent: true),
                builder: (controller) => Container(
                  decoration: context.isDarkMode
                      ? BoxDecoration(color: ChangeSkinToneColorUtil.instance().getDarkBackgroundColor())
                      : const BoxDecoration(color: Color(0xfff2f2f6)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          ///顶部布局，标题，日期，游戏
                          buildTopBar(controller),
                          ///电竞列表
                          Expanded(child: dealListLogic(controller)),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              ///浮动按钮
              floatingActionButton: footballBasketballTemplate == true ?floatingActionButton():null,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: bottomHideSwitch
                  ? Container(
                height: 0.5,
              )
                  :  _buildBottomBar(context),
            ),

            /// 需求4186    足球篮球专题页入口
            if (footballBasketballTemplate == true)
              footballAndBasketballSpecialPage(),

            ///烟花特效
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
          ] ,
        );
      },
    );

  }



  ///底部菜单tab抽离
  Widget _buildBottomBar(BuildContext context) {
    final items = [
      _tabItem(
        context,
        title: LocaleKeys.menu_itme_name_results.tr,
        imageLight: controller.DJState.mainTab1Light,
        imageDark: controller.DJState.mainTab1Dark,
        onTap: () => bottomController.logicToTargetPage(0),
      ),
      _tabItem(
        context,
        title: LocaleKeys.footer_menu_set_menu.tr,
        imageLight: controller.DJState.mainTab2Light,
        imageDark: controller.DJState.mainTab2Dark,
        onTap: () {
          SettingMenuController.to.showMatchFilter = false;
          bottomController.openDjSettingsMenu();
        },
      ),
      _tabItem(
        context,
        title: LocaleKeys.app_h5_cathectic_open_bets.tr,
        imageLight: controller.DJState.mainTab3Light,
        imageDark: controller.DJState.mainTab3Dark,
        onTap: () => bottomController.logicToTargetPage(2),
      ),
      _tabItem(
        context,
        title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
        imageLight: controller.DJState.mainTab4Light,
        imageDark: controller.DJState.mainTab4Dark,
        onTap: () => bottomController.logicToTargetPage(3),
      ),
      GetBuilder<MainTabController>(
        id: 'dailyActivities',
        builder: (controller) => TabWidget(
          onTap: () => controller.logicToTargetPage(4),
          title: LocaleKeys.footer_menu_refresh.tr,
          imageUrl: context.isDarkMode
              ? this.controller.DJState.mainTab5Dark
              : this.controller.DJState.mainTab5Light,
          animation: true,
          dailyActivities: controller.dailyActivities,
          animate: controller.animationController,
        ),
      )
    ];

    return footballBasketballTemplate == true ? Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xE5181A21)
            : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withAlpha(90)
                : Colors.grey.withAlpha(90),
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
            //赛果
            TabWidget(
              onTap: () => bottomController.logicToTargetPage(0),
              title: LocaleKeys.menu_itme_name_results.tr,
              imageUrl: context.isDarkMode
                  ? controller.DJState.mainTab1Dark
                  : controller.DJState.mainTab1Light,
              dailyActivities: false,
            ),
            //设置菜单
            TabWidget(
              onTap: () {
                bottomController.logicToTargetPage(1);
              },
              title: LocaleKeys.footer_menu_set_menu.tr,
              imageUrl: context.isDarkMode
                  ? controller.DJState.mainTab2Dark
                  : controller.DJState.mainTab2Light,
              dailyActivities: false,
            ),
            GestureDetector(
              onTap: () => controller.toFootballBasketballTemplate(),
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: ImageView(
                  controller.DJState.footballBasketballTemplate1,
                  width: 72.w,
                  height: 30.w,
                ),
              ),
            ),
            //未结注单
            TabWidget(
              onTap: () => bottomController.logicToTargetPage(2),
              title: LocaleKeys.app_h5_cathectic_open_bets.tr,
              imageUrl: context.isDarkMode
                  ? controller.DJState.mainTab3Dark
                  : controller.DJState.mainTab3Light,
              dailyActivities: false,
            ),
            //已结注单
            TabWidget(
              onTap: () => bottomController.logicToTargetPage(3),
              title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
              imageUrl: context.isDarkMode
                  ? controller.DJState.mainTab4Dark
                  : controller.DJState.mainTab4Light,
              dailyActivities: false,
            ),
          ]),
    )
        :
    Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xE5181A21) : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.black : Colors.grey,
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }

  Widget _tabItem(
      BuildContext context, {
        required String title,
        required String imageLight,
        required String imageDark,
        required VoidCallback onTap,
      }) {
    return TabWidget(
      onTap: onTap,
      title: title,
      imageUrl: context.isDarkMode ? imageDark : imageLight,
      dailyActivities: false,
    );
  }


}
