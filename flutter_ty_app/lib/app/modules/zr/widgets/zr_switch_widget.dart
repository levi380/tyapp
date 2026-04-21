import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/switch_button_long.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/switch_button_short.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../utils/systemchrome.dart';

class ZrSwitchWidget extends StatelessWidget {
  const ZrSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrController>(
        init: ZrController(),
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            color: context.isDarkMode ? const Color(0xE5181A21) : Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///切换不同布局模式'现场', '荷官', '路纸', '极简'
                SwitchButtonLong(
                  value: logic.state.pageIndex,
                  data:  [
                    LocaleKeys.zr_cp_settings_Menu_zr_on_site.tr,
                    LocaleKeys.zr_cp_settings_Menu_zr_dealer.tr,
                    LocaleKeys.zr_cp_settings_Menu_zr_road_paper.tr,
                    LocaleKeys.zr_cp_settings_Menu_zr_minimalist.tr,],
                  onChanged: (value) {
                    // onNewChange(value);
                    // ZrController.to.state.isLoading = true;
                    AppLogger.debug("value = $value");
                    ZrController.to.state.pageIndex = value;
                    ZrController.to.update();
                  },
                ),
                ///切换全部/历史
                SwitchButtonShort(
                  value: ZrController.to.state.isAll,
                  onChild: Text(
                    style: const TextStyle(fontWeight: FontWeight.w500,height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    LocaleKeys.zr_cp_top_navigation_bar_all.tr,
                  ),
                  offChild: Text(
                    style: const TextStyle(fontWeight: FontWeight.w500,height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    LocaleKeys.zr_cp_settings_Menu_zr_history.tr,
                  ),
                  onChanged: (value) {
                    //切换 全部/历史
                    ZrController.to.state.isLoading = true;
                    ZrController.to.state.processList = [];
                    AppLogger.debug("value = $value");
                    ZrController.to.state.isAll = value;
                    ZrController.to.update();
                  },
                ),

                ///切换日间/夜间 模式
                SwitchButtonShort(
                  onChild: Text(
                    style: const TextStyle(fontWeight: FontWeight.w500,height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    LocaleKeys.footer_menu_daytime.tr,
                  ),
                  value: TyHomeController.to.homeState.isLight,
                  offChild: Text(
                    style: const TextStyle(fontWeight: FontWeight.w500,height: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    LocaleKeys.footer_menu_night.tr,
                  ),
                  onChanged: (value) {
                    //切换日间、夜间模式
                    Get.changeThemeMode(
                        value ? ThemeMode.light : ThemeMode.dark);
                    BoolKV.theme.save(!value);
                    TyHomeController.to.homeState.isLight = value;
                    TyHomeController.to.update();
                    ZrController.to.update();

                    SystemUtils.isDarkMode(!value);
                  },
                ),
              ],
            ),
          );
        });
  }
}
