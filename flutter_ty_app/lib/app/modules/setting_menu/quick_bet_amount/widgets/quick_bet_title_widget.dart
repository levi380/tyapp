import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额  快速投注标题组件 组件 QuickBetTitleWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额  快速投注标题组件 组件 QuickBetTitleWidget
    - QuickBetTitleWidget
    ```
      QuickBetTitleWidget(
          /// 主题色
          isDark: context.isDarkMode,
          /// 标题
          title: LocaleKeys.bet_one_click_bet.tr,
      )
    ```
    】】】
 *
 */

class QuickBetTitleWidget extends StatelessWidget {
  const QuickBetTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 0,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.w,
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF303442),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF303442),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: SizedBox(
                  width: 25.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
