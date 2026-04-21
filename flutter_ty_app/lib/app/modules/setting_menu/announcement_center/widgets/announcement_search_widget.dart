import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import 'announcement_search_bar_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 搜索框布局组件 AnnouncementSearchWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 搜索框布局组件 AnnouncementSearchWidget
    - AnnouncementSearchWidget
    ```
    AnnouncementSearchWidget(
    ///主题
    isDark: context.isDarkMode,

    ///搜索布局开关
    searchBox: controller.searchBox,

    ///悬浮日期字段
    sendTimeOther: controller.sendTimeOther,

    ///搜索输入框内容
    debounceSearch: (value) => controller.debounceSearch(value),

    ///清楚输入框
    onClearSearchText: () => controller.onClearSearchText(),

    ///搜索控制器
    searchController: controller.searchController,

    ///搜索焦点控制器
    focusNode: controller.focusNode,

    ///取消隐藏搜索
    onCancel: () => controller.onCancel(),
    )
    ```
    】】】
 *
 */

class AnnouncementSearchWidget extends StatelessWidget {
  const AnnouncementSearchWidget({
    super.key,
    required this.isDark,
    required this.searchBox,
    required this.sendTimeOther,
    required this.debounceSearch,
    required this.onClearSearchText,
    required this.searchController,
    this.hintText,
    required this.focusNode,
    this.onSubmitted,
    required this.onCancel,
  });

  final bool isDark;
  final bool searchBox;
  final String sendTimeOther;
  final void Function(dynamic) debounceSearch;
  final VoidCallback? onClearSearchText;
  final dynamic searchController;
  final FocusNode focusNode;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onCancel;

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: context.isDarkMode ? Color(0xFF1E2029) : Color(0xFFF2F2F6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (searchBox == false)
            Container(
              alignment: Alignment.center,
              height: 28.h,
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                sendTimeOther,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (searchBox == true)
            Expanded(
              child: AnnouncementSearchBarWidget(
                isDark: context.isDarkMode,
                debounceSearch: (value) => debounceSearch(value),
                onClearSearchText: onClearSearchText,
                searchController: searchController,
                focusNode: focusNode,
              ),
            ),
          searchBox == false
              ? GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 15.w),
                    child: ImageView(
                      context.isDarkMode
                          ? 'assets/images/announcement_search1_dark.png'
                          : 'assets/images/announcement_search1_light.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.zr_cp_settings_Menu_zr_cancel.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha: 0.90)
                            : const Color(0xFF303442),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
