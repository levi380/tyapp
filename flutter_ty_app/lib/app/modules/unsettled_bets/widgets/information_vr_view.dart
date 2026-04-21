import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../main.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单item信息展示只允许一数据条样式Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示信息文本，支持多行或单行显示，适应不同的主题模式和样式。
    - `InformationLineView`：接收四个参数：
    - `information`：字符串类型，表示需要展示的信息。
    - `Type`：整数类型，表示文本颜色的索引，默认为 0。
    - `top`：整数类型，表示上边距，默认为 8。
    - `multiLine`：布尔类型，决定是否支持多行显示，默认为 `true`。
    - 返回一个包含信息文本的 `Container`：
    - **多行文本**：如果 `multiLine` 为 `true`，则展示 `information`。
    - **单行文本**：如果 `multiLine` 为 `false`，则限制为一行并处理溢出。
    - 根据主题模式（明亮或暗黑）动态调整文本颜色。
    - 使用 `maxLines` 和 `overflow` 属性控制文本的显示行为。
    】】】
 *
 */
class InformationVrView extends StatelessWidget {
  const InformationVrView({
    Key? key,
    required this.information,
    this.Type = 0,
    this.top = 8,
    required this.batchNo,
  }) : super(key: key);
  final String information, batchNo;
  final int Type, top;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
      Color(0xFF303442),
      Color(0xFFAFB3C8),
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withValues(alpha: 0.8999999761581421);
      listColor[1] = Colors.white.withValues(alpha: 0.30000001192092896);
    }

    return Container(
      margin: EdgeInsets.only(top: top.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: listColor[Type],
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            batchNo,
            style: TextStyle(
              color: listColor[Type],
              fontSize: isIPad ? 14.sp : 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
