import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额  单关串关头部组件 组件 SinglelevelComboTitleWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额  单关串关头部组件 组件 SinglelevelComboTitleWidget
    - SinglelevelComboTitleWidget
    ```
      SinglelevelComboTitleWidget(
        ///主题色
        isDark: context.isDarkMode,
        ///标题
        title: LocaleKeys.app_h5_filter_single.tr,
      )
    ```
    】】】
 *
 */

class SinglelevelComboTitleWidget extends StatelessWidget {
  const SinglelevelComboTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: Row(
        children: [
          ImageView(
            'assets/images/icon/title_tag.png',
            width: 3.w,
            height: 30.h,
          ),
          Container(
            width: 8.w,
          ),
          Text(
            title,
            style: TextStyle(
              color:
                  context.isDarkMode ? Colors.white : const Color(0xFF303442),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
