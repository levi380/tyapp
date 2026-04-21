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
    【【【 AUTO_PARAGRAPH_TITLE 体育注单item显示时间信息展示Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示信息文本、日期时间和菜品名称，适应不同的主题模式和样式。
    - `InformationTimeView`：接收三个参数：
    - `information`：字符串类型，表示需要展示的信息。
    - `dateTime`：字符串类型，表示日期和时间。
    - `dish`：字符串类型，表示菜品名称。
    - 返回一个包含信息文本、日期时间和菜品名称的 `Container`，使用 `Row` 布局：
    - **信息文本**：使用 `Expanded` 组件，支持溢出处理。
    - **日期时间和菜品**：使用 `RichText` 组件，允许不同样式的文本在同一行展示。
    - 根据主题模式（明亮或暗黑）动态调整文本颜色。
    - 使用 `maxLines` 和 `overflow` 属性控制信息文本的显示行为。
    】】】
 *
 */
class InformationTimeView extends StatelessWidget {
  const InformationTimeView({
    Key? key,
    required this.information,
    required this.dateTime,
    required this.timeZone,
    this.dish = '',
  }) : super(key: key);
  final String information;
  final String dateTime;
  final String timeZone;
  final String dish;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: dateTime,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : const Color(0xFF303442),
                    fontSize:
                    isIPad ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (timeZone.isNotEmpty)
                  TextSpan(
                    text: " " + '($timeZone)',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.8999999761581421)
                          : const Color(0xFF303442),
                      fontSize:
                        isIPad ? 12.sp : 10.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (dish.isNotEmpty)
                  TextSpan(
                    text: dish,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.7)
                          : const Color(0xFF616783),
                      fontSize:
                         isIPad ? 12.sp : 10.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
