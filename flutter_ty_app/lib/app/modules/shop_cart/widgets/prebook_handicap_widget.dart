

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../widgets/image_view.dart';
import '../single_bet/single_prebook/single_prebook_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 预约赔率Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 预约赔率部件
    加减预约赔率
    】】】
 *
 */
class PrebookHandicapWidget extends StatelessWidget {
  PrebookHandicapWidget( {Key? key})
      : super(key: key);

  final logic = Get.find<SinglePrebookController>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.fromLTRB( 14.w, 0,14.w,8.h),
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: ShapeDecoration(
        color: themeData.shopcartContentBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const ImageView(
                'assets/images/shopcart/icon_addreduce1.png',
                width: 16,
              ),
            ),
            onTap: () {
              logic.reduceHandicap();
            },
          ),

          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Obx(()=>
                    Text(
                      logic.preHandicap.value,
                      style: TextStyle(
                        color: themeData.shopcartTextColor,
                        fontSize: 18.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                ),
              ],
            ),
          ),


          InkWell(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const ImageView(
                'assets/images/shopcart/icon_addreserve1.png',
                width: 16,
              ),
            ),
            onTap: () {
              logic.addHandicap();
            },
          ),
        ],
      ),
    );
  }
}
