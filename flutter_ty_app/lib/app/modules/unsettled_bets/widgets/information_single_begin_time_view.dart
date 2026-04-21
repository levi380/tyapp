import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单串关显示开赛时间信息展示Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于显示一条信息及其对应的结果，支持动态颜色和样式设置，适用于各种信息展示场景。
    - `InformationView`：接收多个参数，包括信息文本、结果文本、颜色类型和其他样式属性。
    - 支持文本溢出处理，确保在空间不足时显示省略号。
    - 根据设备类型（如 iPad）调整字体大小。
    - `isAmount` 参数决定结果文本的字体粗细，提供视觉上的差异。
    - 统一使用 `PingFang SC` 字体，确保视觉一致性。
    】】】
 *
 */

class InformationSingleBeginTimeView extends StatelessWidget {
  const InformationSingleBeginTimeView({
    Key? key,
    required this.dateTime,
    this.top = 8,
  }) : super(key: key);

  final String dateTime;
  final int top;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top.h),
      alignment: Alignment.topLeft,
      child: Text(
        dateTime,
        style: TextStyle(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.30000001192092896)
              : const Color(0xFFAFB3C8),
          fontSize: isIPad ? 14.sp : 12.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
