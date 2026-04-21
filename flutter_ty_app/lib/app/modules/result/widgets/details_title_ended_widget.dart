import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情  头部组件  热门赛事推荐 已完赛 DetailsTitleEndedWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情  头部组件  已完赛 DetailsTitleEndedWidget
    - DetailsTitleEndedWidget
    】】】
 *
 */
class DetailsTitleEndedWidget extends StatelessWidget {
  const DetailsTitleEndedWidget({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFF2F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 4.h, bottom: 4.h, left: 5.w, right: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              isDark
                  ? 'assets/images/icon/finished1.png'
                  : 'assets/images/icon/finished.png',
              cdn: true,
              width: 18.w,
              height: 18.w,
            ),
            Container(
              width: 2.w,
            ),
            Container(
              width: Get.locale?.countryCode == 'TW' ||
                  Get.locale?.countryCode == 'CN' ? 40.w : 50.w,
              child: Text(
                LocaleKeys.list_match_end.tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.30)
                      : const Color(0xFFAFB3C8),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
