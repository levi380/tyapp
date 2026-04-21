import 'package:common_utils/common_utils.dart';
import '../../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 注单项标题和数值展示 subItemTitle】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - `title`: 显示的标题文本。
    - `val`: 显示的数值文本。
    - `color`: 可选，文本颜色，若未提供则根据主题进行适配。

    ## 描述
    用于统一展示注单项的标题和数值，支持不同的文本颜色和对齐方式。

    ## 方法

    ### 1. `subItemTitle`
    - 创建一个包含标题和数值的行组件，支持自定义颜色。

    ### 2. `_buildTextContainer`
    - 构建文本容器，设置最大宽度、最小宽度以及文本样式。

    ## 其他说明
    - 支持文本的最大行数和溢出处理。
    - 根据当前主题（暗黑/亮色模式）自动调整文本颜色。

    】】】
 *
 */

///注单item文字统一组件
Widget subItemTitle(BuildContext context,String title, String val, {Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildTextContainer(
        context: context,
        title: title,
        alignment: TextAlign.left,
        maxWidth: (MediaQuery.of(context).size.width - 24) / 4,
      ),
      _buildTextContainer(
        context: context,
        title: val,
        alignment: TextAlign.right,
        maxWidth: (MediaQuery.of(context).size.width - 24) / 2,
        color: ObjectUtil.isNotEmpty(color)
            ? color
            : context.isDarkMode
            ? Colors.white.withValues(alpha:0.8999999761581421)
            : const Color(0xFF303442),
      ),
    ],
  );
}
Widget _buildTextContainer({
  required BuildContext context,
  required String title,
  required TextAlign alignment,
  required double maxWidth,
  Color? color,
}) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: maxWidth,
      minWidth: 80.w,
    ),
    child: Text(
      title,
      textAlign: alignment,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? (context.isDarkMode
            ? Colors.white.withValues(alpha:0.8999999761581421)
            : const Color(0xFF303442)),
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}