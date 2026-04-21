import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索界面标题组件 TabBarWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索界面标题组件 TabBarWidget
    - TabBarWidget
    ```
    TabBarWidget()
    ```
    】】】
 *
 */

class TabBarWidget extends StatelessWidget {
  const TabBarWidget(
      {super.key, required this.tabs, required this.onValueChange});

  final List<String> tabs;
  final ValueChanged<int> onValueChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode
                ? const Color(0xFF272931)
                : const Color(0xFFE4E6ED),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        onTap: onValueChange,
        padding: EdgeInsets.zero,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1.5.w),
            topRight: Radius.circular(1.5.w),
          ),
          borderSide: BorderSide(
            color: const Color(0xFF179CFF),
            width: 3.0.w,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        indicatorSize: TabBarIndicatorSize.label,
        // 设置下
        labelColor: const Color(0xFF179CFF),
        unselectedLabelColor: context.isDarkMode
            ? Colors.white.withValues(alpha:0.9)
            : const Color(0xFF303442),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'PingFang SC',
        ),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'PingFang SC',
        ),
        tabs: tabs.map((e) => Tab(text: " $e ")).toList(),
      ),
    );
  }
}
