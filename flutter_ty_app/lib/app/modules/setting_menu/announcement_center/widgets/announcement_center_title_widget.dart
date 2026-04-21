import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 头部组件 AnnouncementCenterTitleWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 头部组件 AnnouncementCenterTitleWidget
    - AnnouncementCenterTitleWidget
    ```
    AnnouncementCenterTitleWidget(
    ///主题
    isDark: context.isDarkMode,

    ///标题 文字国际化 公告中心
    title: LocaleKeys.app_notice_center.tr,

    ///日期选择开关
    openDate: !controller.openDate,

    ///日期选择点击事件
    onOpenDate: () => controller.onOpenDate(),

    ///开始时间
    beginTime: controller.beginTime,

    ///结束时间
    endTime: controller.endTime,
    )
    ```
    】】】
 *
 */

///顶部导航
class AnnouncementCenterTitleWidget extends StatelessWidget {
  const AnnouncementCenterTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.openDate,
    this.onOpenDate,
    required this.beginTime,
    required this.endTime,
  });

  final bool isDark;
  final String title;
  final bool openDate;
  final VoidCallback? onOpenDate;
  final String beginTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: 0.5),
              width: isDark ? 0.2 : 0.4,
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
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                  onTap: onOpenDate,
                  child: Container(
                    height: 28.h,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: isDark
                          ? const Color(0xFFF30313A)
                          : const Color(0xFFF2F2F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      children: [
                        beginTime.isEmpty && endTime.isEmpty
                            ? ImageView(
                                'assets/images/announcement _date.png',
                                width: 16.w,
                                height: 16.w,
                              )
                            : Column(
                                children: [
                                  Text(
                                    formatDateTime(int.parse(beginTime)),
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(
                                              0xFF303442) /* text-color-text */,
                                      fontSize: 10.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    formatDateTime(int.parse(endTime)),
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(
                                              0xFF303442) /* text-color-text */,
                                      fontSize: 10.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                        Container(
                          width: 4.w,
                        ),
                        Transform.rotate(
                          angle: openDate ? 0 : -pi,
                          child: ImageView(
                            'assets/images/announcement _dates.png',
                            width: 16.w,
                            height: 16.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///格式化日期
  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
