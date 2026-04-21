import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import '../../../../main.dart';
import '../main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 floatingActionButtonWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 底部菜单悬浮按钮 floatingActionButtonWidget
    - floatingActionButtonWidget
    ```
    底部菜单悬浮按钮
    ```
    】】】
 *
 */

class floatingActionButtonWidget extends StatelessWidget {
  const floatingActionButtonWidget({
    super.key,
    required this.controller,
  });

  final MainTabController controller;

  @override
  Widget build(BuildContext context) {
    if (bottomHideSwitch == true) {
      return Container(
        height: 0.5,
      );
    } else if (europeanCup == true) {
      return GestureDetector(
        onTap: () => controller.toEuropeanCup(),
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDarkMode
                ? const Color(0xE5181A21)
                : const Color(0xffFFFAFA),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 5.h, bottom: 5),
            child: ImageView(
              europeanCup2,
              width: 33.w,
              height: 26.w,
            ),
          ),
        ),
      );
    } else if (footballBasketballTemplate == true) {
      return GestureDetector(
        onTap: () => controller.toFootballBasketballTemplate(),
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDarkMode
                ? const Color(0xE5181A21)
                : const Color(0xffFFFAFA),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 5.h, bottom: 5),
            child: ImageView(
              footballBasketballTemplate2,
              width: 33.w,
              height: 26.w,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
