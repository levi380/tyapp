import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';



/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)冠軍头部标题视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示两方的对战信息，包含信息标题和结果，适用于体育赛事等场景。
    - `TitleView`：接收两个参数 `information` 和 `outcome`，用于初始化组件的显示内容。
    - `build` 方法返回一个 `Row` 组件，包含左侧的信息、中央的“VS”标识和右侧的结果信息。
    - 根据 `context.isDarkMode` 判断当前主题，设置文本颜色。暗黑模式下使用半透明的白色，亮色模式下使用深灰色。
    - 使用 `Row` 组件将信息、对战标识和结果并排展示。
    - 左右两侧使用 `Expanded` 组件以平分可用空间，确保信息居中对齐。
    - 使用 `Text` 组件展示信息和结果，设置了字体、大小和粗细，确保文本在不同设备上的可读性。
    】】】
 *
 */


///注单赛事标题
class TitleChampionView extends StatelessWidget {
  const TitleChampionView({
    Key? key,
    required this.information,
    required this.outcome,
    this.appointmentMarking = false,
  }) : super(key: key);
  final String information, outcome;

  ///用来标记是不是预约注单成功的
  final bool appointmentMarking;

  @override
  Widget build(BuildContext context) {
    ///适配国际化的
    bool contain = ["vi", "pt"].contains(Get.locale?.languageCode ?? "");

    Color color = context.isDarkMode
        ? Colors.white.withValues(alpha:0.8999999761581421)
        : const Color(0xFF303442);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 5.w,
                  ),
                  child: Text(
                    information,
                    style: TextStyle(
                      color: color,
                      fontSize: 13.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Column(
                children: [
                  if (Get.locale?.languageCode == 'zh')
                    Container(
                      height: 2.h,
                    ),
                  Text(
                    "VS",
                    style: TextStyle(
                      color: color,
                      fontSize: 13.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                    child: Text(
                      outcome,
                      style: TextStyle(
                        color: color,
                        fontSize: 13.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        ),
        Visibility(
          visible: appointmentMarking,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: contain ? 55.w : 46.w,
                height: 22.h,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.w,
                      color:
                          Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                    ),
                    borderRadius: BorderRadius.circular(
                      5.r,
                    ),
                  ),
                ),
                child: Text(
                  '+' + LocaleKeys.bet_bet_book_confirm.tr,
                  style: TextStyle(
                    color: Color(
                      context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                    ),
                    fontSize:
                       contain ? 10.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
