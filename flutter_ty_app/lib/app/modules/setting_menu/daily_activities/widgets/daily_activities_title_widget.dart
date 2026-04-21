import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-4e9be854-24f7-4038-82b7-1ee2bd55e911-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 活动界面】】】
    【【【 AUTO_PARAGRAPH_TITLE 活动界面 控制器  头部组件 DailyActivitiesController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 活动界面 控制器 头部组件  DailyActivitiesController
    - DailyActivitiesController
    】】】
 *
 */
class DailyActivitiesTitleWidget extends StatelessWidget {
  const DailyActivitiesTitleWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Get.back(),
              onDoubleTap: () {
                // Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 35.w,
                color: Colors.white.withValues(alpha: 0.0),
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
