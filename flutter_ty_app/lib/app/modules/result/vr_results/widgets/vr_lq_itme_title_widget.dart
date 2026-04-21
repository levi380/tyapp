import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 篮球联赛头部 VrLqItemTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 篮球联赛头部 VrLqItemTitleWidget
    - VrLqItemTitleWidget
    ```
    ///篮球联赛头部
    VrLqItemTitleWidget(
      isDark: isDark,
      title: recordsList.isNotEmpty ? recordsList[0].tournamentName : '',
      onExpandItem: onExpandItem,
      isExpand: isExpand,
    )
    ```
    】】】
 *
 */

class VrLqItemTitleWidget extends StatelessWidget {
  const VrLqItemTitleWidget({
    super.key,
    required this.isDark,
    this.onExpandItem,
    required this.isExpand,
    required this.title,
  });

  final bool isDark;
  final VoidCallback? onExpandItem;
  final bool isExpand;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onExpandItem,
      child: Container(
        decoration: isDark
            ? ShapeDecoration(
                color: ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor(
                        colorStyle_1: Color(0xFF2B2D33),
                        colorStyle_2: Color(0xFF23292D),
                        colorStyle_3: Color(0xFF26242A)),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.1.h,
                    color: Colors.white.withValues(alpha: 0.03999999910593033),
                  ),
                  borderRadius: isExpand
                      ? BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )
                      : BorderRadius.circular(8),
                ),
                shadows: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ])
            : ShapeDecoration(
                color: const Color(0xFFF8F9FA),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: Colors.white),
                  borderRadius: isExpand
                      ? BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )
                      : BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
        height: 30.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageView(
                  'assets/images/icon/title_tag.png',
                  width: 2.w,
                  height: 15.w,
                ),
                Container(
                  width: 8.w,
                ),
                SizedBox(
                  width: 300.w,
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: Transform.rotate(
                angle: isExpand ? 0 : -pi / 2,
                child: ImageView(
                  isDark
                      ? 'assets/images/icon/results_folding_dark.png'
                      : 'assets/images/icon/results_folding_light.png',
                  width: 13.w,
                  height: 13.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
