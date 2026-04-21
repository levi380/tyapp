import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../utils/ty_text_scaler.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 TabMenuWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 底部菜单小组件 TabMenuWidget
    - TabMenuWidget
    ```
    TabMenuWidget(
      top: 30.h,
      left: 85.w,
      onTap: () {
      controller.logicToTargetPage(1);
      },
      title: LocaleKeys.footer_menu_set_menu.tr,
      imageUrl: 'assets/images/icon/main_tab_menu2.png',
    )
    ```
    】】】
 *
 */

class TabMenuWidget extends StatelessWidget {
  const TabMenuWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.top,
    required this.left,
    this.onTap,
    required,
    this.animation = false,
    this.animate,
  });

  final String title;
  final String imageUrl;
  final double top;
  final double left;
  final VoidCallback? onTap;
  final bool animation;
  final AnimationController? animate;

  ///菜单数量
  final int tabNum = 5;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              animation == true
                  ? RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(animate!),
                      child: ImageView(
                        imageUrl,
                        width: 30.w,
                        height: 30.w,
                      ),
                    )
                  : ImageView(
                      imageUrl,
                      width: 30.w,
                      height: 30.w,
                    ),
              Container(
                height: 2.h,
              ),
              Container(
                width: 90.w,
                alignment: Alignment.center,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF949AB6),
                    fontSize: TyTextScaler.instance().scale(12.sp),
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
