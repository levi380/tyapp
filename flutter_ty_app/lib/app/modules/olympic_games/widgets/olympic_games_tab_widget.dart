
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f0701ec9-2638-410f-a016-bc358835db9d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  奥运会专题页】】】
    【【【 AUTO_PARAGRAPH_TITLE 奥运会专题页 底部菜单小组件 OlympicGamesTabWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 奥运会专题页 底部菜单小组件 OlympicGamesTabWidget
    - OlympicGamesTabWidget
    】】】
 *
 */
class OlympicGamesTabWidget extends StatelessWidget {
  const OlympicGamesTabWidget({
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
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animation == true
                ? RotationTransition(
              turns:
                Tween(begin: 0.0, end: 1.0).animate(animate!),
                child: ImageView(
                  context.isDarkMode ? 'assets/images/icon/main_tab5_night.svg':'assets/images/icon/main_tab5.png',
                  width: 24.w,
                  height: 24.w,
                  color: const Color(0xFF1B1B1B),
                ),
            ):
            ImageView(
              imageUrl,
              width: 24.w,
              height: 24.w,
              color: const Color(0xFF1B1B1B),
            ),
            Container(
              height: 5.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 2.w,right: 2.w),
              width: MediaQuery.of(context).size.width / tabNum,
              child:  Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:   TextStyle(
                  color: const Color(0xFF1B1B1B),
                  fontSize: 12.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
