


import '../../../login/login_head_import.dart';
import '../../states/zr_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  头部选择玩法组件 ZrTabBarWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  头部选择玩法组件 ZrTabBarWidget
    - ZrTabBarWidget
    ```
    ZrTabBarWidget(
      title: controller.tabList[index],
      isSelected: controller.currentIndex == index ? true : false,
      isDark: context.isDarkMode,
    )
    ```
    】】】
 *
 */
class ZrTabBarWidget extends StatelessWidget {
  const ZrTabBarWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
  });

  final String title;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 12.w,
      ),
      decoration: getShapeDecoration(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20.w, right: 20.w,),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark
                ? Colors.white
                : isSelected
                    ? Colors.white
                    : ZrState.textColorTitle,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
          ),
        ),
      ),
    );
  }

  getShapeDecoration() {
    if (isDark) {
      return isSelected
          ? ShapeDecoration(
              color: Colors.white.withValues(alpha:0.07999999821186066),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withValues(alpha:0.11999999731779099),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withValues(alpha:0.20000000298023224),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            );
    } else {
      return isSelected
          ? ShapeDecoration(
              color: ZrState.textColorTitle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x051B1E26),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: ZrState.textColorTitle),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x051B1E26),
                  blurRadius: 12.r,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            );
    }
  }
}
