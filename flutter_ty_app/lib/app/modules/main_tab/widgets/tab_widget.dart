import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 TabWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 底部菜单小组件 TabWidget
    - TabWidget
    ```
    TabWidget(
      onTap: () => controller.logicToTargetPage(2),
      title: LocaleKeys.app_h5_cathectic_open_bets.tr,
      imageUrl: context.isDarkMode? 'assets/images/icon/main_tab3_night.svg': 'assets/images/icon/main_tab3.png',
      dailyActivities: false,
    )
    ```
    】】】
 *
 */

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    required,
    this.animation = false,
    this.animate,
    required this.dailyActivities,
  });

  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final bool animation;
  final bool dailyActivities;
  final AnimationController? animate;

  ///菜单数量
  final int tabNum = 5;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5.w,
            ),
            dailyActivities == true
                ? Column(
                    children: [
                      ImageView(
                        activityGif,
                        width: 55.w,
                        height: 55.w,
                      )
                    ],
                  )
                : Column(
                    children: [
                      animation == true
                          ? RotationTransition(
                              turns:
                                  Tween(begin: 0.0, end: 1.0).animate(animate!),
                              child: ImageView(
                                imageUrl,
                                width: 24.w,
                                height: 24.w,
                              ),
                            )
                          : Opacity(
                              opacity: imageUrl == tab2025 && context.isDarkMode
                                  ? 0.6
                                  : 1, // 设置透明度，0.0为完全透明，1.0为不透明
                              child: ImageView(
                                imageUrl,
                                width: imageUrl == tab2025 ? 40.w : 24.w,
                                height: 24.w,
                                boxFit: BoxFit.fill,
                              )),
                      Container(
                        height: 5.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2.w, right: 2.w),
                        width: MediaQuery.of(context).size.width / tabNum,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.isDarkMode
                                ? const Color(0xff40ffffff)
                                : const Color(0xff949AB6),
                            fontSize: 12.sp.scale,
                          ),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
