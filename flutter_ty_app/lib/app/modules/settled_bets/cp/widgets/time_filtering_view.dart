
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注TimeFiltering视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    】】】
 *
 */
class TimeFilteringView extends StatelessWidget {
  TimeFilteringView({
    required this.type,
    required this.onChanged,
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  final int type;
  final ValueChanged<int> onChanged;
  final String startTime, endTime;

  bool get _isEnglish => ['en'].contains(Get.locale?.languageCode);

  bool get isZh => ['zh', 'hk'].contains(Get.locale?.languageCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.h,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:
                    0.07999999821186066,
                  )
                : const Color(
                    0xFFE4E6ED,
                  ),
          ),
        ),
      ),
      child: Row(
        children: [
          _single(
            1,
            LocaleKeys.zr_cp_top_navigation_bar_today.tr,
          ),
          _single(
            2,
            LocaleKeys.zr_cp_top_navigation_bar_yesterday.tr,
          ),
          _single(
            3,
            LocaleKeys.zr_cp_top_navigation_bar_Last_7_days.tr,
          ),
          _single(
            5,
            LocaleKeys.zr_cp_settings_Menu_zr_customize.tr,
          ),
        ],
      ),
    );
  }

  /**
   * 适配中英文
   */
  int fitWidth(int singleType) {
    if (_isEnglish) {
      if (singleType == 2||singleType == 5) {
        return 6;
      }
    } else if (isZh) {
      if (singleType == 3||singleType == 5) {
        return 6;
      }
    }
    return 5;
  }

  Widget _single(int singleType, String title) {
    return Flexible(
      flex: fitWidth(singleType),
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 3.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: singleType == 5 && type == 5
                    ? Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              startTime,
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white.withValues(alpha:
                                        singleType == type
                                            ? 0.8999999761581421
                                            : 0.4000000059604645)
                                    : Color(singleType == type
                                        ? 0xFF303442
                                        : 0xFF949AB6),
                                fontSize:  10.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ).paddingOnly(
                                bottom: 2.h),
                            Text(
                              endTime,
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white.withValues(alpha:
                                        singleType == type
                                            ? 0.8999999761581421
                                            : 0.4000000059604645)
                                    : Color(singleType == type
                                        ? 0xFF303442
                                        : 0xFF949AB6),
                                fontSize: 10.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white.withValues(alpha:singleType == type
                                      ? 0.8999999761581421
                                      : 0.4000000059604645)
                                  : Color(singleType == type
                                      ? 0xFF303442
                                      : 0xFF949AB6),
                              fontSize:  isZh ? 14.sp : 12.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: singleType == type
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 1.0.h),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
              Container(
                height: 3.h,
                width: 42.w,
                decoration: ShapeDecoration(
                  color: singleType != type
                      ? null
                      : Get.isDarkMode
                          ? const Color(
                              0xFF127DCC,
                            )
                          : const Color(
                              0xff179CFF,
                            ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        2,
                      ),
                      topRight: Radius.circular(
                        2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
