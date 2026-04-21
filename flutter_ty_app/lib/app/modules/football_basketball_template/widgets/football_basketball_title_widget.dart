
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../football_basketball_template_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e3715fb6-bb30-4171-bb1e-edfc0b937ce1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  篮球足球运营模版】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球足球运营模版头部小组件 FootballBasketballTitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球足球运营模版头部小组件 FootballBasketballTitleWidget
    - FootballBasketballTitleWidget
    ```
    FootballBasketballTitleWidget(
      controller: controller,
    )
    ```
    】】】
 *
 */

class FootballBasketballTitleWidget extends StatelessWidget {
  const FootballBasketballTitleWidget({
    super.key,
    required this.controller,
  });

  final FootballBasketballTemplateController controller;

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
              onTap: () => controller.toQuitAPP(),
              onDoubleTap: () {
                Get.back();
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
