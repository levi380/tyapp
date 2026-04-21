import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/sport_icon.dart';

import '../../../../../main.dart';
import '../../../../utils/change_skin_tone_color_util.dart';

class MenuItemLeft extends StatelessWidget {
  const MenuItemLeft(
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 3, right: 3),
            width: 70.w,
            height: 48.h,
            /// 悬浮效果需要背景色,这个不要改，改了会影响悬浮效果。改你主界面的背景色就行了
            color:Get.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(): AppColor.bgColorLight,
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
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: sportIcon(
                          index: index,
                          width: 24.w,
                          height: 24.w,
                          isSelected: isSelected,
                        ),
                      ),
                      if (count != null)
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: isSelected
                          ? context.isDarkMode
                              ? Colors.white.withValues(alpha:0.9)
                              : const Color(0xff303442)
                          : context.isDarkMode
                              ? Colors.white.withValues(alpha:0.3)
                              : const Color(0xffAFB3C8),
                      fontSize: isIPad ? 12.sp.scale : 10.sp.scale,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      height: 1),
                  // minFontSize: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
