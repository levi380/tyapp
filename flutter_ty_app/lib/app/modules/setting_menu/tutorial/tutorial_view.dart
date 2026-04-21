import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/widgets/tutorial_title_widget.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import 'big_and_small_ball_strategy/big_and_small_ball_strategy_view.dart';
import 'handicap_strategy/handicap_strategy_view.dart';
import 'tutorial_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 视图页面 TutorialPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 视图页面 TutorialPage
    - TutorialPage
    ```
    ///头部
    _title(),

    ```
    】】】
 *
 */
class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final controller = Get.find<TutorialController>();
  final logic = Get.find<TutorialController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode ?  ChangeSkinToneColorUtil.instance().getDarkBackgroundColor() : Color(0xFFF2F2F6),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Column(
                    children: [
                      ///头部
                      _title(),
                      Expanded(
                        child: logic.tutorial == 0
                            ? const HandicapStrategyPage()
                            : const BigAndSmallBallStrategyPage(),
                      ),
                    ],
                  ),
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
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return TutorialTitleWidget(
      title1: LocaleKeys.footer_menu_rangqiu.tr +
          LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
      title2: LocaleKeys.app_h5_handicap_tutorial_big_small_ball.tr +
          LocaleKeys.app_h5_handicap_tutorial_introdution.tr,
      scrollController: controller.scrollController,
      isDark: context.isDarkMode,
      onTutorial: (Tutorial) => controller.onTutorial(Tutorial),
      tutorial: logic.tutorial,
    );
  }

  @override
  void dispose() {
    Get.delete<TutorialController>();
    super.dispose();
  }
}
