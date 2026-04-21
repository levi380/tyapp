import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import '../../../../widgets/image_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单金额区间小组件  AmountRangeWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单金额区间小组件  AmountRangeWidget
    - AmountRangeWidget
    ```
    AmountRangeWidget(
      isDark: controller.isDarkMode,
      title: LocaleKeys.zr_cp_settings_Menu_cp_sided_betting.tr,
      xList: controller.doubleBetRangeList,
      id: controller.doubleSidedPlayId,
      onTap: (configId) => controller.onDoubleSidedPlay(configId),
    )
    ```
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
      color:
          isDark ? CpState.amountRangeBgColorDark : Colors.white,
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
                      ? CpState.amountRangeTitleColorDark
                      : CpState.amountRangeTitleColorLight,
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
                                          ? CpState.amountRangeBorderColorSel
                                          : CpState.amountRangeBorderColorUnselDark
                                      : selected
                                          ? CpState.amountRangeBorderColorSel
                                          : CpState.amountRangeBorderColorUnselLight,
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
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselDark
                                          : selected
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselLight,
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
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselDark
                                          : selected
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselLight,
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
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselDark
                                          : selected
                                              ? CpState.amountRangeTextColorSel
                                              : CpState.amountRangeTextColorUnselLight,
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
                                CpState.amountRangeSelIcon,
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
