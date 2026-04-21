import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../utils/betsUtils.dart';
import 'dashed_line_painter_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)串关折叠控件视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT

    - 主要功能根据 `Expand` 状态显示不同的内容，允许用户展开或收起信息。
    - `ShowAllSingleView`：接收两个参数：
    - `Expand`：布尔值，指示当前是否展开。
    - `onTap`：可选的回调函数，用于处理点击事件。
    - `build` 方法返回一个可点击的行，包含一个状态指示器和一个按钮。
    - 使用 `Column` 组件显示展开状态的指示器。
    - 如果 `Expand` 为 `true`，显示一个空的 `SizedBox`；否则，绘制一条虚线和一个圆形图标。
    - 使用 `InkWell` 包裹按钮区域，支持点击反馈。
    - 点击按钮时执行 `onTap` 回调，若未提供则无操作。
    - 按钮文本根据 `Expand` 状态切换，支持国际化。
    - 根据当前主题（暗黑模式或亮色模式）设置按钮颜色。
    - 使用 `ShapeDecoration` 设置按钮的背景和边框样式。
    】】】
 *
 */
class ShowAllSingleView extends StatelessWidget {
  const ShowAllSingleView({
    Key? key,
    required this.Expand,
    this.onTap,
  }) : super(key: key);

  final bool Expand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    ///产品要求，4260需求回退，暂时不上线，等待通知......()
    ///单个圆圈大小
    //int ovalBorderSize = 16;
    //int ovalBorderSizeB = 4;

    ///单个圆圈大小
    int ovalBorderSizeA = 6;
    int ovalBorderSizeB = 10;

    var color = Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Expand
                  ? SizedBox(
                      height: ovalBorderSizeB.h,
                      width: ovalBorderSizeA.w,
                    )
                  : RepaintBoundary(
                      child: CustomPaint(
                        size: Size(1, ovalBorderSizeB.h),
                        painter: DashedLinePainter(
                          color: color,
                        ),
                      ),
                    ),
            ),
            if (!Expand)
              Container(
                width: ovalBorderSizeA.w,
                height: ovalBorderSizeA.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: color,
                    ),
                  ),
                ),
              ),

            ///产品要求，4260需求回退，暂时不上线，等待通知......()
           //  ImageView(
           //    BetsUtils.getBetResultIcon(0),
           //    width: ovalBorderSize.h,
           //    height: ovalBorderSize.h,
           //  ),
          ],
        ),
        SizedBox(
          width: 4.w,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r)),
            ),
            //    margin: const EdgeInsets.only(top: 8),
            child: Text(
              Expand
                  ? LocaleKeys.bet_record_pack_up.tr
                  : LocaleKeys.bet_record_pack_down.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
