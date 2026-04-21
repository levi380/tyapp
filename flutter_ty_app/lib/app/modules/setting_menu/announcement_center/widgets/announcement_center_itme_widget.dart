import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';

import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:intl/intl.dart';

import '../../../../services/models/res/get_notice_front_list_new_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 列表组件 AnnouncementCenterItemWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 列表组件 AnnouncementCenterItemWidget
    - AnnouncementCenterItemWidget
    ```
    AnnouncementCenterItemWidget(
    index: index,
    isDark: context.isDarkMode,
    getNoticeFrontListDataNb: controller.nbList[index],
    debounceSearch: (value) =>
    controller.debounceSearch(value),
    onClearSearchText: () => controller.onClearSearchText(),
    searchController: controller.searchController,
    focusNode: controller.focusNode,
    onCancel: () => controller.onCancel(),
    searchBox: controller.searchBox,
    nbListLength: controller.nbList.length,
    )

    ```
    】】】
 *
 */
class AnnouncementCenterItemWidget extends StatelessWidget {
  const AnnouncementCenterItemWidget({
    super.key,
    required this.isDark,
    required this.index,
    required this.getNoticeFrontListNewDataNb,
    required this.debounceSearch,
    required this.onClearSearchText,
    required this.searchController,
    this.hintText,
    required this.focusNode,
    this.onSubmitted,
    required this.onCancel,
    required this.searchBox,
    required this.nbListLength,
    required this.typeIndex,
  });

  final bool isDark;
  final int index;
  final int typeIndex;
  final GetNoticeFrontListNewDataNb getNoticeFrontListNewDataNb;

  final void Function(dynamic) debounceSearch;
  final VoidCallback? onClearSearchText;
  final dynamic searchController;
  final FocusNode focusNode;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onCancel;
  final bool searchBox;
  final int nbListLength;

  @override
  Widget build(BuildContext context) {
    final highlightedText = highlightMatches(
        getNoticeFrontListNewDataNb.context, searchController.text);
    final highlightedText1 = highlightMatches(
        getNoticeFrontListNewDataNb.context2, searchController.text);
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF272932) : Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///日期显示
          getNoticeFrontListNewDataNb.displayDate == true && index != 0
              ? Container(
                  height: 28.h,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8.w),
                  color: isDark ? Color(0xFF1E2029) : Color(0xFFF2F2F6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          formatDateTime(int.parse(
                              getNoticeFrontListNewDataNb.sendTimeOther)),
                          style: TextStyle(
                            color:
                                isDark ? Colors.white : const Color(0xFF303442),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : index != 0
                  ? Container(
                      color: isDark ? Color(0xFF1E2029) : Color(0xFFF2F2F6),
                      height: 8.h,
                    )
                  : Container(),

          ///列表
          Container(
            height: 48.h,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '【${getNoticeFrontListNewDataNb.noticeTypeName}】',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF303442),
                    fontSize: isIPad ? 16.sp : 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  DateUtil.formatDateMs(
                          TimeZoneUtils.convertTimeToTimestamp(
                                  getNoticeFrontListNewDataNb.sendTimeOther,
                                  isMilliseconds: true,
                                  returnMilliseconds: true) ??
                              0,
                          format: LocaleKeys.time6.tr,
                          isUtc: true) +
                      "(" +
                      TimeZoneUtils.getTimeZoneString() +
                      ")",
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.20)
                        : const Color(0xFFAFB3C8),
                    fontSize: isIPad ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: isDark ? const Color(0xFF383A42) : const Color(0xFFF2F2F6),
            height: 0.5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: HtmlWidget(
              highlightedText,
              textStyle: TextStyle(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.90)
                    : const Color(0xFF303442),
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (typeIndex == 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              child: HtmlWidget(
                highlightedText1,
                textStyle: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.90)
                      : const Color(0xFF616783),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          if (index == nbListLength - 1)
            Container(
              height: 10.h,
              color: isDark ? Color(0xFF1E2029) : Color(0xFFF2F2F6),
            ),
        ],
      ),
    );
  }

  ///搜索匹配字体高亮处理
  String highlightMatches(String text, String searchTerm) {
    if (searchTerm.isEmpty) return text;

    /// 使用正则表达式进行匹配
    final regex = RegExp(searchTerm, caseSensitive: false);
    return text.replaceAllMapped(regex, (match) {
      return '<span style="color: #FEAE2C;">${match.group(0)}</span>';
    });
  }

  ///格式化日期
  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
