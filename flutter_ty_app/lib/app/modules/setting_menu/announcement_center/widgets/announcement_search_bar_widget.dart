import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 搜索框组件 AnnouncementSearchBarWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 搜索框组件 AnnouncementSearchBarWidget
    - AnnouncementSearchBarWidget
    ```
    AnnouncementSearchBarWidget(
    isDark: context.isDarkMode,
    debounceSearch: (value) => debounceSearch(value),
    onClearSearchText: onClearSearchText,
    searchController: searchController,
    focusNode: focusNode,
    )
    ```
    】】】
 *
 */

class AnnouncementSearchBarWidget extends StatefulWidget {
  const AnnouncementSearchBarWidget({
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
  State<AnnouncementSearchBarWidget> createState() =>
      _LeagueSearchBarWidgetState();
}

class _LeagueSearchBarWidgetState extends State<AnnouncementSearchBarWidget> {
  bool isShowClearIcon = false;

  @override
  void initState() {
    super.initState();
    // widgets.searchController.addListener(() {
    //   setState(() {
    //     isShowClearIcon = widgets.searchController.text.isNotEmpty;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: widget.isDark
            ? Colors.white.withValues(alpha: 0.08)
            : const Color(0xFFE4E6ED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      margin: EdgeInsets.only(
        top: 8.h,
        bottom: 8.h,
        left: 10.w,
        right: 10.w,
      ),
      child: Container(
        height: 28.h,
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        alignment: Alignment.center,
        child: TextField(
          maxLength: 20,
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
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.50)
                : const Color(0xFF303442),
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
          // onChanged: (c) => controller.onChanges(c),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintText: LocaleKeys.league_search_search_dj_placeholder.tr,
            hintStyle: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.50)
                  : const Color(0xFFAFB3C8),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.only(
              top: 0.w,
              bottom: 0.w,
              left: 0.w,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.0)),
            ),
            icon: ImageView(
              context.isDarkMode
                  ? "assets/images/announcement_search2_dark.png"
                  : "assets/images/announcement_search2_light.png",
              height: 16.w,
              width: 16.w,
            ),
            suffixIcon: GestureDetector(
              onTap: widget.onClearSearchText,
              child: Container(
                alignment: Alignment.centerRight,
                width: 20.w,
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: ImageView(
                  context.isDarkMode
                      ? "assets/images/announcement_search3_dark.png"
                      : "assets/images/announcement_search3_light.png",
                  height: 12.h,
                  width: 12.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
