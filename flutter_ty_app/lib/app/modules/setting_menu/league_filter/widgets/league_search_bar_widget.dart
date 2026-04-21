


import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索框组件 LeagueSearchBarWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索框组件 LeagueSearchBarWidget
    - LeagueSearchBarWidget
    ```
    ///字母排序列表
    LeagueSearchBarWidget(
      isDark: context.isDarkMode,
      debounceSearch: (value) => controller.debounceSearch(value),
      onClearSearchText: () => controller.onClearSearchText(),
      searchController: controller.searchController,
      focusNode: controller.focusNode,
    )
    ```
    】】】
 *
 */

class LeagueSearchBarWidget extends StatefulWidget {
  
  const LeagueSearchBarWidget({
    super.key,
    required this.isDark,
    required this.debounceSearch,
    required this.onClearSearchText,
    required this.searchController,
    this.hintText,
    required this.focusNode,
    this.onSubmitted,
  });

  final bool isDark;
  final void Function(dynamic) debounceSearch;
  final VoidCallback? onClearSearchText;
  final dynamic searchController;
  final FocusNode focusNode;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;

  @override
  State<LeagueSearchBarWidget> createState() => _LeagueSearchBarWidgetState();
}

class _LeagueSearchBarWidgetState extends State<LeagueSearchBarWidget> {

  bool isShowClearIcon = false;
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(() {
      setState(() {
        isShowClearIcon = widget.searchController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      margin: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
      ),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: widget.isDark
            ? Colors.white.withValues(alpha:0.03999999910593033)
            : const Color(0xFFF2F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        alignment: Alignment.center,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) => widget.debounceSearch(value),
          controller: widget.searchController,
          focusNode: widget.focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSubmitted,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          cursorColor: const Color(0xFF179CFF),
          style: TextStyle(
            color: widget.isDark ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
          // onChanged: (c) => controller.onChanges(c),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText ?? LocaleKeys.filter_match_key.tr,
            hintStyle: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.20000000298023224)
                  : const Color(0xFFC9CDDB),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              height: 1,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.only(
              top: 0.w,
              bottom: 0.w,
              left: 0.w,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withValues(alpha:0.0)),
            ),
            icon: ImageView(
              "assets/images/icon/icon_fesearch_nor.png",
              height: 22.w,
              width: 22.w,
            ),
            suffixIcon: GestureDetector(
              onTap: widget.onClearSearchText,
              child: Container(
                alignment: Alignment.centerRight,
                width: 20.w,
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: isShowClearIcon
                    ? ImageView(
                        "assets/images/icon/league-close-icon.svg",
                        height: 15.w,
                        width: 15.w,
                      )
                    : Container(
                        width: 15,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
