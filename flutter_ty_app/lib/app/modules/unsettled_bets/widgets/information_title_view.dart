import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../main.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(预约中和已失效)冠军头部标题视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示两方的对战信息，包含信息标题和结果，适用于体育赛事等场景。
    - `TitleView`：接收两个参数 `appointmentMarking`，用于初始化组件的显示内容。
    - `build` 方法返回一个 `Row` 组件，包含左侧的信息、中央的“VS”标识和右侧的结果信息。
    - 根据 `context.isDarkMode` 判断当前主题，设置文本颜色。暗黑模式下使用半透明的白色，亮色模式下使用深灰色。
    - 使用 `Row` 组件将信息、对战标识和结果并排展示。
    - 左右两侧使用 `Expanded` 组件以平分可用空间，确保信息居中对齐。
    - 使用 `Text` 组件展示信息和结果，设置了字体、大小和粗细，确保文本在不同设备上的可读性。
    】】】
 *
 */

class InformationTitleView extends StatelessWidget {
  const InformationTitleView({
    Key? key,
    this.appointmentMarking = false,
  }) : super(key: key);

  ///用来标记是不是预约注单成功的
  final bool appointmentMarking;

  @override
  Widget build(BuildContext context) {
    Color color = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442);
    bool contain = ["vi", "pt"].contains(Get.locale?.languageCode ?? "");
    return Container(
      height: 36.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getSizedBox(contain),
          Text(
            LocaleKeys.app_outright_winner.tr,
            style: TextStyle(
              color: color,
              fontSize: isIPad ? 14.sp : 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          _appointmentMarking(context, contain),
        ],
      ),
    );
  }

  Widget _getSizedBox(bool contain) {
    int width = 0;
    if (appointmentMarking) {
      if (contain) {
        width = 55;
      } else {
        width = 46;
      }
    }
    return SizedBox(
      width: width.w,
    );
  }

  Widget _appointmentMarking(BuildContext context, bool contain) {
    return Visibility(
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
                  color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
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
                fontSize: contain ? 10.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
