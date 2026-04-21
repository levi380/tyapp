import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/handicap_settings/widgets/handicap_settings_item.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/handicap_settings/widgets/handicap_settings_title_widget.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';
import '../../../utils/change_skin_tone_color_util.dart';

import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';

import 'handicap_settings_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5b682c84-d24f-4fa7-830c-023cfe22939a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口设置】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口设置 视图 HandicapSettingsView 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口设置 视图 HandicapSettingsView
    - HandicapSettingsView
    ```
    ///头部组件
    _title(context),

    ///列表组件
    _item(),
    ```
    】】】
 *
 */
class HandicapSettingsView extends StatefulWidget {
  const HandicapSettingsView({Key? key}) : super(key: key);

  @override
  State<HandicapSettingsView> createState() => _HandicapSettingsViewState();
}

class _HandicapSettingsViewState extends State<HandicapSettingsView> {
  final logic = Get.find<HandicapSettingsLogic>();
  final state = Get.find<HandicapSettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HandicapSettingsLogic>(builder: (logic) {
      return Scaffold(
        body: _body(),
      );
    });
  }

  Widget _body() {
    return Container(
      color: context.isDarkMode
          ? ChangeSkinToneColorUtil.instance()
              .getDarkBackgroundColor(noChange: true)
          : Colors.white,
      child: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              ///头部组件
              _title(context),

              ///分割线
              Container(
                height: 10.h,
                color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
              ),

              ///列表组件
              _item(),
              Expanded(
                child: Container(
                  height: 10.h,
                  color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
                ),
              ),
            ],
          ),

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
        ],
      )),
    );
  }

  ///头部组件
  Widget _title(BuildContext context) {
    return HandicapSettingsTitleWidget(
      ///盘口设置
      title: LocaleKeys.footer_menu_odds_set.tr,
    );
  }

  ///列表组件
  Widget _item() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: logic.handicapList.map((item) {
        return HandicapSettingsItem(
          title: item.label.tr,
          isSelected: TYUserController.to.curOdds == item.value,
          onTap: () =>
              logic.updateHandicapType(item.handicapType.toInt(), item.value),
        );
      }).toList(),
    );
  }
}
