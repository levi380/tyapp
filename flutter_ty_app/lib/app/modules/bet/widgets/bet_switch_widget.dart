import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../db/app_cache.dart';
import '../../../utils/systemchrome.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widgets/menu/switch_button.dart';
import '../../zr/widgets/switch_button_long.dart';
import '../controllers/bet_record_controller.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 注单类型选择Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 注单类型选择。全部、体育、真人、彩票
    】】】
 *
 */
class BetSwitchWidget extends StatelessWidget {
  const BetSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        height: 32.h,
        //color: Theme.of(context).betTabBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              bool zrSwitch =
              (ConfigController.to.accessConfig.value.zrSwitchConfig.zr &&
                  ConfigController.to.accessConfig.value.zrSwitchConfig.zrSdk &&
                  ConfigController.to.accessConfig.value.zrSwitchConfig.zrSwitch);
              ///cp开关
              bool cpSwitch =
              (ConfigController.to.accessConfig.value.zrSwitchConfig.cp &&
                  ConfigController.to.accessConfig.value.zrSwitchConfig.cpSdk &&
                  ConfigController.to.accessConfig.value.zrSwitchConfig.cpSwitch);
              return SwitchButtonLong(
                value: BetRecordController.to.state.orderType,
                data: [
                  if(zrSwitch || cpSwitch) LocaleKeys.app_h5_match_all.tr,
                  LocaleKeys.bet_record_ty.tr,
                  if(zrSwitch) LocaleKeys.bet_record_zr.tr,
                  if(cpSwitch) LocaleKeys.bet_record_cp.tr
                ],
                width: (Get.width - 24.w) * 2 / 3,
                onChanged: (value) {
                  // onNewChange(value);
                  BetRecordController.to.changeOrderType(value);
                },
              );
            }),
            SwitchButton(
              onChild: Text(
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_daytime.tr,
                strutStyle:
                const StrutStyle(forceStrutHeight: true, height: 1.1),
              ),
              value: TyHomeController.to.homeState.isLight,
              offChild: Text(
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_night.tr,
                strutStyle:
                const StrutStyle(forceStrutHeight: true, height: 1.1),
              ),
              onChanged: (value) {
                Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
                BoolKV.theme.save(!value);
                TyHomeController.to.homeState.isLight = value;
                BetRecordController.to.update();
                SystemUtils.isDarkMode(!value);
              },
              fitHeight: true,
            ),
          ],
        ).marginOnly(bottom: 4.h));
  }
}
