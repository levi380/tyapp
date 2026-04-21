// ignore: file_names

import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 子玩法UI  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 子玩法选中按钮UI 公共组件抽出
    】】】
 *
 */
class SecodaryItemWidget extends StatelessWidget {
  const SecodaryItemWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap,
      required this.isHot,
        this.showEight,
      }
      );

  final bool isSelected;
  final bool isHot;
  final VoidCallback onTap;
  final String title;
  final bool? showEight;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: InkWell(
            onTap: onTap,
            child: Container(
              //constraints: BoxConstraints(maxWidth: 50.w, minWidth: 40.h),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.03999999910593033)
                    : Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: isSelected
                    ? Border.all(
                        color: const Color(0xff3AA6FC),
                        width: 1.w,
                      )
                    : Border.all(
                        color: Colors.transparent,
                        width: 1.w,
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: showEight == true ? 8.sp.scale : 10.sp.scale,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? const Color(0xff3AA6FC)
                          : Color(context.isDarkMode ? 0xffe5ffffff : 0xff303442),
                    ),
                  ).marginSymmetric(horizontal: showEight == true ? 0.w : 5.w),
                  Icon(
                    isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: showEight == true ? 6.w : 10.w,
                    color: Color(isSelected ? 0xff3AA6FC : 0xff949AB6),
                  ),

                ],
              ),
            ),
          ),
        ),
        if (isHot)
        Positioned(
          right: -10.w, // 向右冒出去10像素
          top: -10.w,  // 向上冒出去10像素
          child: ImageView(
            'assets/images/hot.svg', // 你的泡泡图片
            width: 30.w,
            height: 18.w,
          ),
        ),
      ],
    );
  }
}
