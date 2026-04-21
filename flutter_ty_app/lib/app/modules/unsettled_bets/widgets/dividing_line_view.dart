
import '../../login/login_head_import.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-注单信息Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于在界面中显示一条水平分隔线，帮助区分不同的内容区域。
    - `DividingLineView`：无参数构造函数，用于创建分隔线视图。
    - 返回一个包含分隔线的容器。
    - 使用 `Row` 组件和 `Expanded` 组件确保分隔线占据可用宽度。
    - 分隔线的高度为 1 像素，颜色根据当前的主题（深色模式或浅色模式）进行调整。
    】】】
 *
 */

class DividingLineView extends StatelessWidget {
  const DividingLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 1.h,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.07999999821186066)
                  : const Color(0xFFE4E6ED),
            ),
          ),
        ],
      ),
    );
  }
}
