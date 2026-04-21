import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 置顶按钮组件 AnnouncementPinButtonWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 置顶按钮组件 AnnouncementPinButtonWidget
    - AnnouncementPinButtonWidget
    ```
    AnnouncementPinButtonWidget(
      isDark: context.isDarkMode,
      scrollToFirstItem: () => controller.scrollToFirstItem(),
      scrollToTheLastPage: () =>
      controller.scrollToTheLastPage(controller.nbList.length),
    )
    ```
    】】】
 *
 */

class AnnouncementPinButtonWidget extends StatelessWidget {
  const AnnouncementPinButtonWidget({
    super.key,
    required this.isDark,
    required this.scrollToFirstItem,
    required this.scrollToTheLastPage,
  });

  final bool isDark;
  final VoidCallback? scrollToFirstItem;
  final VoidCallback? scrollToTheLastPage;

  Widget build(BuildContext context) {
    return Positioned(
      right: 14.w,
      bottom: 60.h,
      child: Column(
        children: [
          GestureDetector(
            onTap: scrollToFirstItem,
            child: ImageView(
              context.isDarkMode
                  ? 'assets/images/announcement_back_dark.png'
                  : 'assets/images/announcement_back_light.png',
              width: 48.w,
              height: 48.w,
            ),
          ),
          Container(
            height: 10.h,
          ),
          GestureDetector(
            onTap: scrollToTheLastPage,
            child: Transform.rotate(
              angle: 3.14159,
              child: ImageView(
                context.isDarkMode
                    ? 'assets/images/announcement_back_dark.png'
                    : 'assets/images/announcement_back_light.png',
                width: 48.w,
                height: 48.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
