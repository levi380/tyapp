
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票追号记录列表信息视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，是一个无状态组件，用于显示信息和结果的行。它支持多种样式配置，包括颜色、字体大小和粗细。
    - 属性
    - information: 类型为 `String`，显示的主要信息内容。
    - outcome: 类型为 `String`，显示的结果信息，默认为空字符串。
    - bottom_nav: 类型为 `int`，设置底部间距，默认为8。
    - titleFontSize: 类型为 `int`，设置主要信息的字体大小，默认为12。
    - titleColorType: 类型为 `int`，设置主要信息的颜色类型，取值范围：
    - `0`: 默认黑色
    - `1`: 灰色
    - `2`: 蓝色
    - `3`: 红色
    - InformationColorType: 类型为 `int`，设置结果信息的颜色类型，取值与 `titleColorType` 相同。
    - isLeftThickness: 类型为 `bool`，控制主要信息的字体粗细，默认为 `false`。
    - isRightThickness: 类型为 `bool`，控制结果信息的字体粗细，默认为 `false`。
    - 方法
    - Container: 设置底部间距。
    - Row: 水平排列主要信息和结果信息。
    - Expanded: 使主要信息占据可用空间，支持文本溢出处理。
    - Text: 显示主要信息和结果信息，字体样式和颜色根据属性动态变化。
    - UI 结构
    - 颜色列表: 根据 `titleColorType` 和 `InformationColorType` 选择颜色，支持暗黑模式下的颜色调整。
    - 文本样式: 动态设置字体颜色、大小和粗细。
    】】】
 *
 */
class AdditionalInformationView extends StatelessWidget {
  const AdditionalInformationView({
    Key? key,
    required this.information,
    this.outcome = '',
    this.titleColorType = 0,
    this.InformationColorType = 0,
    this.bottom = 8,
    this.isLeftThickness = false,
    this.isRightThickness = false,
    this.titleFontSize = 12,
  }) : super(key: key);
  final String information;
  final String outcome;

  ///bottom_nav  间隔的间距
  ///titleFontSize  字体大小
  final int bottom, titleFontSize;

  /// titleColorType,InformationColorType
  ///  0 ： 默认的黑色
  ///  1 ： 灰色
  ///  2 ： 蓝色
  ///  3 ： 红色
  final int titleColorType, InformationColorType;

  ///字体粗细
  final bool isLeftThickness, isRightThickness;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
      const Color(0xFF303442),
      const Color(0xFFAFB3C8),
      const Color(0xFF179CFF),
      const Color(0xFFF53F3F)
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withValues(alpha:0.8999999761581421);
      listColor[2] = const Color(0xFF127DCC);
    }
    return Container(
      margin: EdgeInsets.only(bottom: bottom.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: listColor[titleColorType],
                fontSize: titleFontSize.sp,
                fontFamily: 'PingFang SC',
                fontWeight: isLeftThickness ? FontWeight.w500 : FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            outcome,
            style: TextStyle(
              color: listColor[InformationColorType],
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: isRightThickness ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
