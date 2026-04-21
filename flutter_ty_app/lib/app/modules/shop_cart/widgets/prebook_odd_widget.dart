import 'dart:io';

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
class PrebookOddWidget extends StatelessWidget {
  PrebookOddWidget(this.textEditingController, this.focusNode, {Key? key})
      : super(key: key);

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final logic = Get.find<SinglePrebookController>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0),
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
              logic.reduceOdd();
            },
          ),
          /*
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '@',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 2),
                Obx(()=>
                    Text(
                      logic.prebookOdd.value,
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
           */
          Row(
            children: [
              IntrinsicWidth(
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  //enabled: enabled,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700),
                  //autofocus: true,
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  showCursor: true,
                  readOnly: true,
                  cursorColor: Colors.blue,
                  // cursorHeight导致安卓光标不居中
                  cursorHeight: Platform.isIOS ? 16.sp : null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    prefix: Padding(
                      padding:
                          const EdgeInsets.only(right: 4.0), // 控制 @ 和文字之间的距离
                      child: Text(
                        '@',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
              logic.addOdd();
            },
          ),
        ],
      ),
    );
  }
}
