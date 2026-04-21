import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_landscape_result_view.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/widgets/number_keyboard_landscape.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../../core/format/common/module/format-currency.dart';
import '../../../global/ty_user_controller.dart';
import '../../../widgets/image_view.dart';
import '../../../../generated/locales.g.dart';
import '../model/shop_cart_type.dart';
import '../widgets/balance_refresh_widget.dart';
import 'single_bet_controller.dart';

part 'single_bet_landscape_view.part.dart';
part 'single_bet_landscape_view_input.part.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全屏投注Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全屏投注弹窗
      适配横屏，屏幕高度较小
    】】】
 *
 */
class SingleBetLandscapeComponent<T extends BaseBetController>
    extends StatelessWidget {
  SingleBetLandscapeComponent({Key? key}) : super(key: key);

  final logic =
      ShopCartController.to.currentBetController as SingleBetController;
  final state = ShopCartController.to.state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.itemCount > 0) {
        return Stack(
          children: [
            //灰色背景
            GestureDetector(
              onTap: () {
                logic.closeBet();
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withValues(alpha: 0.0),
              ),
            ),

            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: 375,
                  height: 1.sh,
                  child: Stack(children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          logic.closeBet();
                        },
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 375,
                        //height: 275,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: const ShapeDecoration(
                                  color: Color(0xFF353537),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xFF555547), // 中心最亮的颜色
                                      Color(0xFF353537), // 其他颜色
                                    ],
                                    stops: [0.1, 1.0],
                                    radius: 0.7,
                                    center: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                            Obx(() {
                              if (logic.betStatus.value ==
                                  ShopCartBetStatus.Normal) {
                                return _buildBetView(context);
                              } else if (logic.betStatus.value ==
                                      ShopCartBetStatus.Betting ||
                                  logic.betStatus.value ==
                                      ShopCartBetStatus.Success ||
                                  logic.betStatus.value ==
                                      ShopCartBetStatus.Failure) {
                                return SingleBetLandscapeResultView();
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ))
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        logic.closeBet();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        //child: const ImageView('assets/images/shopcart/icon_close_white.svg', width: 18,height: 18,),
        child: const Icon(
          Icons.close_outlined,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildBetView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBetItem(),
        _buildInputWidget(),
        _buildKeyboardWidget(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _buildAutoAcceptTips() {
    showToastWidget(
      Stack(children: [
        //灰色背景
        GestureDetector(
          onTap: () {
            dismissAllToast(showAnim: true);
          },
          child: Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.black.withValues(alpha: 0.4),
          ),
        ),
        Center(
          child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF303442),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: 0.4.sw,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.app_combine_bets_tips.tr,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 18.0.scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocaleKeys.app_combine_bets_msg2.tr,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14.0.scale,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      dismissAllToast(showAnim: true);
                    },
                    child: Text(
                      LocaleKeys.ac_rules_understand.tr,
                      style: TextStyle(
                        color: Color(0xFF179CFF),
                        fontSize: 16.0.scale,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ]),
      duration: const Duration(hours: 1),
      handleTouch: true,
    );
  }
}
