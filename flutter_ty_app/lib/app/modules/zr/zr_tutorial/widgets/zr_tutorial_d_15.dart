
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_15_a.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_15_b.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_15_c.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d_15_d.dart';
import '../../../../../generated/locales.g.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  玩法判定 庄龙宝&闲龙宝 ZrTutorialD15Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 玩法判定 庄龙宝&闲龙宝 ZrTutorialD15Widget
    - ZrTutorialD15Widget
    ```
    ///15.庄龙宝&闲龙宝
    ZrTutorialD15Widget(
      isDark: isDark,
    ),
    ```
    】】】
 *
 */
class ZrTutorialD15Widget extends StatelessWidget {
  const ZrTutorialD15Widget({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 50.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents48.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.8999999761581421)
                  : const Color(0xFF333333),
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents49.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ZrTutorialD15AWidget(
          isDark: isDark,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents50.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ZrTutorialD15BWidget(
          isDark: isDark,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents51.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ZrTutorialD15CWidget(
          isDark: isDark,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents52.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ZrTutorialD15DWidget(
          isDark: isDark,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents53.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.zr_cp_footer_menu_zr_zrtext_3_contents54.tr,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withValues(alpha:0.5)
                  : const Color(0xFF8D8D8D),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
