import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知 组件 AmountRangeWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知 组件
    - AmountRangeWidget
    - 设置菜单 注单通知 组件
    】】】
 *
 */
class AmountRangeWidget extends StatelessWidget {
  const AmountRangeWidget({
    super.key,
    required this.isDark,
    required this.title,
    required this.onTap,
    required this.xList,
    required this.id,
  });

  final bool isDark;
  final String title;
  final dynamic xList;
  final int id;
  final void Function(dynamic) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark
          ? Colors.white.withValues(alpha: 0.03999999910593033)
          : Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                top: 10.h,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 32.h,
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: xList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool selected = id == xList[index].configId ? true : false;
                    return InkWell(
                      onTap: () => onTap(xList[index].configId),
                      child: Stack(
                        children: [
                          Container(
                            width: 110.w,
                            margin: EdgeInsets.only(left: 0.w, right: 10.w),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.w,
                                  color: isDark
                                      ? selected
                                          ? const Color(0xFF179CFF)
                                          : Colors.white.withValues(
                                              alpha: 0.07999999821186066)
                                      : selected
                                          ? const Color(0xFF179CFF)
                                          : const Color(0xFFF2F2F6),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    xList[index].doublePlayBetMin.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isDark
                                          ? selected
                                              ? const Color(0xFF179CFF)
                                              : Colors.white
                                                  .withValues(alpha: 0.5)
                                          : selected
                                              ? const Color(0xFF179CFF)
                                              : const Color(0xFF7981A3),
                                      fontSize: 16.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      color: isDark
                                          ? selected
                                              ? const Color(0xFF179CFF)
                                              : Colors.white
                                                  .withValues(alpha: 0.5)
                                          : selected
                                              ? const Color(0xFF179CFF)
                                              : const Color(0xFF7981A3),
                                      fontSize: 16.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    xList[index].doublePlayBetMax.toString(),
                                    style: TextStyle(
                                      color: isDark
                                          ? selected
                                              ? const Color(0xFF179CFF)
                                              : Colors.white
                                                  .withValues(alpha: 0.5)
                                          : selected
                                              ? const Color(0xFF179CFF)
                                              : const Color(0xFF7981A3),
                                      fontSize: 16.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (selected)
                            Container(
                              alignment: Alignment.bottomRight,
                              width: 110.w,
                              child: ImageView(
                                'assets/images/shopcart/text_selected1.png',
                                width: 20.w,
                                height: 20.h,
                              ),
                            )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
