
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../main.dart';
import '../../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 篮球玩法头部 VrLqItemSubTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 篮球玩法头部 VrLqItemSubTitleWidget
    - VrLqItemSubTitleWidget
    ```
    ///篮球玩法头部
    VrLqItemSubTitleWidget(
      isDark: isDark,
      isExpand: isExpand,
      title: LocaleKeys.msc_S1.tr,
    )
    ```
    】】】
 *
 */

class VrLqItemSubTitleWidget extends StatelessWidget {
  const VrLqItemSubTitleWidget({
    super.key,
    required this.isDark,
    required this.isExpand,
    required this.title,
  });

  final bool isDark;
  final bool isExpand;
  final String title;

  @override
  Widget build(BuildContext context) {
    return isExpand
        ? Container(
            width: double.maxFinite,
            height: 20.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDark
                  ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(
                      colorStyle_1: Color(0xFF2B2D33),
                      colorStyle_2: Color(0xFF23292D),
                      colorStyle_3: Color(0xFF26242A))
                  : const Color(0xFFF8F9FA),
              border: Border(
                top: BorderSide(
                  width: 0.50,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.30000001192092896)
                      : const Color(0xFFE4E6ED),
                ),
                bottom: BorderSide(
                  width: 0.50,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.30000001192092896)
                      : const Color(0xFFE4E6ED),
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 8.w, right: 8.w),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.90)
                            : const Color(0xFF303442),
                        fontSize: isIPad ? 12.sp : 10.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
