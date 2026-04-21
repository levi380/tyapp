import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/mix_bet/mix_bet_controller.dart';
import 'package:get/get.dart';

import '../../../widgets/image_view.dart';
import '../shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关悬浮球Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关悬浮球部件
      串关投注框收敛时显示。红标显示串关数量。点击展开投注框。
    】】】
 *
 */
class ShopCartBall extends StatelessWidget {
  ShopCartBall({Key? key}) : super(key: key);

  final logic = ShopCartController.to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // 串关列表下，展示串关入口（右下角按钮）
          if (logic.currentBetController is MixBetController) {}
          // 串关显示投注界面
          logic.currentBetController?.showBet(queryAmount: true);
        },
        // 串关悬浮球UI
        child: Stack(
          children: [
            // 按钮主体
            Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.w, left: 4.w),
              margin: EdgeInsets.all(5.w),
              decoration: ShapeDecoration(
                // 设置渐变背景
                gradient: const LinearGradient(
                  begin: Alignment(-0.04, 1.00),
                  end: Alignment(0.04, -1),
                  colors: [Color(0xFF179CFF), Color(0xFF45B0FF)],
                ),
                // 设置圆角样式
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(40.w),
                ),
                // 设置阴影
                shadows: const [
                  BoxShadow(
                    color: Color(0x333C71FA),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              // 按钮是整个图片
              child: ImageView(
                Get.locale?.languageCode == 'zh' ||
                        Get.locale?.languageCode == 'tw'
                    ? 'assets/images/shopcart/shrink2.png'
                    : 'assets/images/shopcart/shrink_p2.png',
                width: 40.w,
                boxFit: BoxFit.fitWidth,
              ),
            ),
            // 按钮右上角数字
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(
                        color: const Color(0XFFFFFFFF),
                      ),
                      color: const Color(0XFFE95B5B)),
                  child: Text(
                    logic.currentBetController?.itemCount.toString() ?? '',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: const Color(0XFFFFFFFF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
          ],
        ));
  }
}
