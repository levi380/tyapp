
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/switch_button.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../utils/systemchrome.dart';

class SwitchContainerWidget extends StatelessWidget {
  const SwitchContainerWidget({
    Key? key,
    required this.onNewChange,
    required this.onHotChange,
  }) : super(key: key);
  final ValueChanged<bool> onNewChange;
  final ValueChanged<bool> onHotChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment:
            isIPad ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          ///菜单专业版&新手版
          Expanded(
            child: SwitchButton(
              value: TyHomeController.to.homeState.isProfess,
              onChild: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_pro_v.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
              ),
              offChild: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_new_v.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
              ),
              onChanged: (value) {
                onNewChange(value);
              },
            ),
          ),
          SizedBox(
            width: 5.w,
          ),

          ///热门&时间
          Expanded(
            child: Obx(() {
              return SwitchButton(
                hasIcon: true,
                value: TyHomeController.to.homeState.isHot,
                onChild: Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    LocaleKeys.footer_menu_hot.tr),
                offChild: Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // LocaleKeys.setting_menu_time.tr,
                    LocaleKeys.footer_menu_time.tr),
                onChanged: (value) {
                  onHotChange(value);
                },
                enable: ConfigController.to.accessConfig.value.sortCut,
              );
            }),
          ),
          SizedBox(
            width: 5.w,
          ),

          ///白天&黑夜
          Expanded(
            child: SwitchButton(
              onChild: Text(
                style:
                    const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_daytime.tr,
              ),
              value: TyHomeController.to.homeState.isLight,
              offChild: Text(
                style:
                    const TextStyle(fontWeight: FontWeight.w500, height: 1.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.footer_menu_night.tr,
              ),
              onChanged: (value) {
                ///更改主题
                Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
                BoolKV.theme.save(!value);
                TyHomeController.to.homeState.isLight = value;
                // AppLogger.debug("==========>夜间 日间主题埋点  value ${value}  result  ${value?AnalyticsEvent.btn_daymode:AnalyticsEvent.btn_nightmode} ");
                Analytics.track(value?AnalyticsEvent.btn_daymode:AnalyticsEvent.btn_nightmode, pagePath: '', clickTarget: (value?AnalyticsEvent.btn_daymode:AnalyticsEvent.btn_nightmode).toString());
                // TyHomeController.to.update();
                Get.forceAppUpdate();
                SystemUtils.isDarkMode(!value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
