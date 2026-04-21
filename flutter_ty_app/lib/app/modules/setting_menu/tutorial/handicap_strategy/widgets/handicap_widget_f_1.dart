import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 让球攻略  1/1.5 球  HandicapFWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 让球攻略  1/1.5 球 HandicapFWidget
    - HandicapFWidget
    】】】
    ```
    ///  1/1.5 球
    HandicapFWidget(
    isDark: isDark,
    index: index,
    );
    ```
 *
 */
class HandicapF1Widget extends StatelessWidget {
  const HandicapF1Widget({
    super.key,
    required this.isDark,
    required this.index,
  });

  final bool isDark;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                ImageView(
                  isDark
                      ? 'assets/images/icon/icon_teamlogo_dark.png'
                      : 'assets/images/icon/icon_teamlogo_light.png',
                  width: 32.w,
                  height: 32.w,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 4.h,
                  ),
                  width: 110.w,
                  child: Text(
                    LocaleKeys.app_h5_handicap_tutorial_bet_home_team.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0x19F53F3F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0x19F53F3F)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF53F3F),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                                  .withValues(alpha: 0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 32.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.h, right: 8.h),
                        width: 9.19,
                        height: 3,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                      ),
                      Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                                  .withValues(alpha: 0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 32.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 4.h,
                    ),
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_home_team_handicap.tr
                          .replaceAll('%s', '1/1.5'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.4000000059604645)
                            : const Color(0xFFAFAFAF),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ImageView(
                  isDark
                      ? 'assets/images/icon/icon_teamlogo_dark.png'
                      : 'assets/images/icon/icon_teamlogo_light.png',
                  width: 32.w,
                  height: 32.w,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 4.h,
                  ),
                  width: 110.w,
                  child: Text(
                    LocaleKeys.app_h5_handicap_tutorial_bet_away_team.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0x1900B42A),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50.w, color: Color(0x1900B42A)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00B42A),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Container(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07999999821186066)
              : const Color(0xFFFBFBFB),
          margin: EdgeInsets.only(
            top: 12.h,
          ),
          height: 1.h,
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: Text(
            LocaleKeys.app_h5_handicap_tutorial_note_5.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8D8D8D),
              fontSize: 13.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                ImageView(
                  isDark
                      ? 'assets/images/icon/icon_teamlogo_dark.png'
                      : 'assets/images/icon/icon_teamlogo_light.png',
                  width: 32.w,
                  height: 32.w,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 4.h,
                  ),
                  width: 110.w,
                  child: Text(
                    LocaleKeys.app_h5_handicap_tutorial_bet_home_team.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0x1900B42A),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50.w, color: Color(0x1900B42A)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_all_lose.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00B42A),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                                  .withValues(alpha: 0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 32.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.h, right: 8.h),
                        width: 9.19,
                        height: 3,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF333333),
                      ),
                      Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                                  .withValues(alpha: 0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 32.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 4.h,
                    ),
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_home_team_handicap.tr
                          .replaceAll('%s', '1/1.5'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.4000000059604645)
                            : const Color(0xFFAFAFAF),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ImageView(
                  isDark
                      ? 'assets/images/icon/icon_teamlogo_dark.png'
                      : 'assets/images/icon/icon_teamlogo_light.png',
                  width: 32.w,
                  height: 32.w,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 4.h,
                  ),
                  width: 110.w,
                  child: Text(
                    LocaleKeys.app_h5_handicap_tutorial_bet_away_team.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xFF333333),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0x19F53F3F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0x19F53F3F)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.app_h5_handicap_tutorial_all_win.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF53F3F),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
