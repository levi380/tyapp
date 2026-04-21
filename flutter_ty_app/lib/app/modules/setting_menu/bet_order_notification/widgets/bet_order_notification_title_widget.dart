import 'package:flutter_ty_app/app/config/getx_navigation.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知头部 组件 BetOrderNotificationTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知头部 组件
    - BetOrderNotificationTitleWidget
    - 设置菜单 注单通知头部 组件
    】】】
 *
 */

class BetOrderNotificationTitleWidget extends StatelessWidget {
  const BetOrderNotificationTitleWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.subtitle,
  });

  final bool isDark;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () => Get_TY.back(),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: context.isDarkMode
                          ? Colors.white
                          : const Color(0xFF179CFF),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white
                            : const Color(0xFF179CFF),
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: Colors.white.withValues(alpha: 0.0),
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.0),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
