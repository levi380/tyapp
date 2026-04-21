import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单显示注单信息展示Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于显示一条信息及其对应的结果，支持动态颜色和样式设置，适用于各种信息展示场景。
    - `InformationView`：接收多个参数，包括信息文本、结果文本、颜色类型和其他样式属性。
    - `build` 方法返回一个 `Container`，内部包含一个 `Row` 组件，展示信息和结果。
    - 根据 `titleColorType` 和 `InformationColorType` 设置文本颜色，支持多种颜色选项（黑色、灰色、蓝色、红色）。
    - 在暗黑模式下，调整特定颜色以确保可读性。
    - 使用 `Row` 组件将信息和结果并排展示，信息部分使用 `Expanded` 组件以填充可用空间。
    - 支持文本溢出处理，确保在空间不足时显示省略号。
    - 根据设备类型（如 iPad）调整字体大小。
    - `isAmount` 参数决定结果文本的字体粗细，提供视觉上的差异。
    - 统一使用 `PingFang SC` 字体，确保视觉一致性。
    】】】
 *
 */


class InformationResultsView extends StatelessWidget {
  const InformationResultsView({
    Key? key,
    required this.information,
    this.results = '',
    this.outcome = '',
    this.titleColorType = 0,
    this.resultsColorType = 0,
    this.InformationColorType = 0,
    this.top = 8,
    this.isAmount = false,
  }) : super(key: key);
  final String information;
  final String results;
  final String outcome;

  final int top;

  /*
  titleColorType,InformationColorType
   0 ： 默认的黑色
   1 ： 灰色
   2 ： 蓝色
   3 ： 红色
   */
  final int titleColorType, resultsColorType,InformationColorType;
  ///当是金额
  final bool isAmount;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
       Color(0xFF303442),
       Color(0xFFAFB3C8),
       Color(0xFF179CFF),
       Color(0xFFF53F3F),
       Color(0xFF4EBE41)
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withValues(alpha:0.8999999761581421);
      listColor[2] = const Color(0xFF127DCC);
    }
    return Container(
      margin: EdgeInsets.only(top: top.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: listColor[titleColorType],
                fontSize: isIPad ?  14.sp :12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                results,
                style: TextStyle(
                  color: listColor[resultsColorType],
                  fontSize: isIPad ?  14.sp :12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isAmount ? FontWeight.w500 : FontWeight.w400,
                ),
              ).marginOnly(right: 5.w),
              Text(
                outcome,
                style: TextStyle(
                  color: listColor[InformationColorType],
                  fontSize: isIPad ?  14.sp :12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isAmount ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
