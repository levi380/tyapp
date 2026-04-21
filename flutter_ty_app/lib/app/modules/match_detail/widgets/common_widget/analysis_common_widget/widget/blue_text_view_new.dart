import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../../main.dart';
import '../../../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 5天 10天切换控件
    】】】
 *
 */
class BluetextNew extends StatelessWidget {
  const BluetextNew(
    this.text,
    this.width,
    this.height, {
    super.key,
    this.decoration,
  });

  final String text;
  final double width;
  final double height;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: decoration ??
          ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: Get.theme.secondTabPanelSelectedFontColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize:  isIPad?14.sp:10.sp,
          fontWeight: FontWeight.w400,
          color: Get.theme.secondTabPanelSelectedFontColor,
        ),
      ),
    );
  }
}
