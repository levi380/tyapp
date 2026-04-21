
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e3715fb6-bb30-4171-bb1e-edfc0b937ce1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  篮球足球运营模版】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球足球运营模版底部菜单小组件 FootballBasketballTabWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球足球运营模版底部菜单小组件 FootballBasketballTabWidget
    - FootballBasketballTabWidget
    】】】
 *
 */

class FootballBasketballItembWidget extends StatelessWidget {
  const FootballBasketballItembWidget({
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
            SizedBox(height: 5.w,),
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
                opacity: imageUrl=="assets/images/icon/tab_2025.png"&&context.isDarkMode ?0.6:1, // 设置透明度，0.0为完全透明，1.0为不透明
                child:ImageView(
                  imageUrl,
                  width: imageUrl=="assets/images/icon/tab_2025.png"?40.w:24.w,
                  height:24.w,
                  boxFit: BoxFit.fill,
                )),
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
                style:  TextStyle(
                  color: Color(0xffBECEF8),
                  fontSize: 12.sp.scale,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
