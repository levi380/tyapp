import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../widgets/image_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单item优惠赔率样式展示Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示重要信息、结果和可选的分数基准，具有明显的视觉效果。
    - `InformationImportantView`：接收二个参数：
    - `oddFinally`：字符串类型，表示最终赔率。
    - `eov`：字符串类型，表示优惠赔率之前的赔率。
    - 返回一个包含重要信息的 `Container`，具有圆角和背景色：
    - **结果文本**：展示 `oddFinally`，使用白色字体。
    - **结果文本**：展示 `eov`，使用白色字体。
    】】】
 *
 */

class InformationEovView extends StatelessWidget {
  const InformationEovView({
    Key? key,
    required this.oddFinally,
    required this.eov,
  }) : super(key: key);

  final String  oddFinally, eov;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFD1EBFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "@",
            style: TextStyle(
              color: const Color(0xFF303442).withValues(alpha:0.8),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ).marginOnly(right: 1.h),
          Text(
            eov,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF303442).withValues(alpha:0.6),
              fontSize: 14.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
              height: 1.4,
            ),
          ).marginOnly(right: 1.5.h),
          ImageView(
            'assets/images/bets/preferential_icon.png',
            width: 10.w,
            height: 10.h,
          ).marginOnly(right: 1.5.h),
          Text(
            oddFinally,
            style: TextStyle(
              color: const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'Akrobat',
              height: 1.4,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ).marginOnly(right: 1.5.h),
          ImageView(
            //context.isDarkMode
            //    ? 'assets/images/bets/preferential_odds_night.png'
            //    : 'assets/images/bets/preferential_odds_daytime.png',
            'assets/images/icon/up.png',
            width: 16.w,
            height: 16.h,
          ),
        ],
      ),
    );
  }

}
