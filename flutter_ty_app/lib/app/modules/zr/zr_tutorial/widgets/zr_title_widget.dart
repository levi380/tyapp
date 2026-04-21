import '../../../login/login_head_import.dart';
import '../../states/zr_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE  头部组件 ZrTitleWidget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 头部组件 ZrTitleWidget
    - ZrTitleWidget
    ```
    ZrTitleWidget(
      title: LocaleKeys.zr_cp_Lottery_Bet_Slips_wagering_tutorial.tr,
      isDark: context.isDarkMode,
    )
    ```
    】】】
 *
 */
class ZrTitleWidget extends StatelessWidget {
  const ZrTitleWidget({
    super.key,
    required this.title,
    required this.isDark,
  });

  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ZrState.titleBarHeight,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color: context.isDarkMode
                    ? Colors.white
                    : ZrState.textColorPrimary,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white
                    : ZrState.textColorPrimary,
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
