import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../utils/ty_text_scaler.dart';

/**
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5b682c84-d24f-4fa7-830c-023cfe22939a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口设置】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口设置 头部组件 HandicapSettingsTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口设置 头部组件 HandicapSettingsTitleWidget
    - HandicapSettingsTitleWidget
    ```
     HandicapSettingsTitleWidget(
      ///投注组件传入名称
       title: LocaleKeys.footer_menu_odds_set.tr,
    )
    ```
    】】】
 *
 */
class HandicapSettingsTitleWidget extends StatelessWidget {
  const HandicapSettingsTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode
          ? Colors.white.withValues(alpha: 0.03999999910593033)
          : Colors.white,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.w,
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFF303442),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFF303442),
              fontSize: TyTextScaler.instance().scale(14.sp),
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
        ],
      ).marginOnly(left: 14.w, right: 14.w),
    );
  }
}
