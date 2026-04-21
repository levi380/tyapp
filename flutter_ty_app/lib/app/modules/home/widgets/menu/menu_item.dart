import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/sport_icon.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
        required this.title,
        required this.index,
        required this.count,
        required this.isSelected,
        required this.onTap});

  final String title;
  final int index;
  final int? count;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: EdgeInsets.only(left: 4.w, right: 4.w),
              height: 45.h,

              /// 悬浮效果需要背景色,这个不要改，改了会影响悬浮效果。改你主界面的背景色就行了
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50.w,
                        ),
                        sportIcon(
                          index: index,
                          width: 24.w,
                          height: 24.w,
                          isSelected: isSelected,
                        ),

                        ///75856 【日常】【生产】 SDK表头注单错误显示数量
                        ///菜单下的注单不显示数量 直接从 MenuItem判断标题
                        if (count != null && title != LocaleKeys.app_bet.tr)
                          Positioned(
                            top: 0.w,
                            right: count.toString().length > 1 ? -1.w : -3.w,
                            child: SizedBox(
                              width: 17.w,
                              child: Text(
                                count.toString(),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Akrobat',
                                  height: 1.0,
                                  color: isSelected
                                      ? context.isDarkMode
                                      ? Colors.white.withValues(alpha:0.9)
                                      : const Color(0xff303442)
                                      : context.isDarkMode
                                      ? Colors.white.withValues(alpha:0.3)
                                      : const Color(0xffAFB3C8),
                                  fontSize: 10.sp.scale,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: isSelected
                            ? context.isDarkMode
                            ? Colors.white.withValues(alpha:0.9)
                            : const Color(0xff303442)
                            : context.isDarkMode
                            ? Colors.white.withValues(alpha:0.3)
                            : const Color(0xffAFB3C8),
                        fontSize: isIPad ? 14.sp.scale : 10.sp.scale,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 1,
                        ),
                    // minFontSize: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}