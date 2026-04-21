import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../model/bet_count_model.dart';
import '../shop_cart_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关问号Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关问号部件
      点击显示2串1、3串4等选项的解释
    】】】
 *
 */
class BetQuestionWidget extends StatelessWidget {
  BetQuestionWidget(this.betCountModel, {Key? key}) : super(key: key);

  final BetCountModel betCountModel;

  @override
  Widget build(BuildContext context) {
    return ImageView(
      'assets/images/shopcart/icon_question_nor2.png',
      width: 20,
      color: Get.theme.shopcartLabelColor,
      onTap: betCountModel.id.isNotEmpty
          ? () {
              _buildBetTips(context, betCountModel);
            }
          : null,
    );
  }

  void _buildBetTips(BuildContext context, BetCountModel betCountModel) {
    ThemeData themeData = Theme.of(context);
    BetTipsModel? betTipsModel = ShopCartUtil.betTipsMap[betCountModel.id];
    if (betTipsModel != null) {
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
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
          Center(
            child: Container(
                decoration: BoxDecoration(
                  color: themeData.shopcartTipsBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: 0.7.sw,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      //'${LocaleKeys.app_h5_bet_toltip1.tr} ${betCountModel.name.replaceAll('串', LocaleKeys.app_h5_bet_toltipc.tr)}',
                      '${LocaleKeys.app_h5_bet_toltip1.tr} ${betCountModel.localeName.tr}',
                      style: TextStyle(
                        color: themeData.shopcartTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          betTipsModel.tipsTitle.tr,
                          style: TextStyle(
                            color: themeData.shopcartLabelColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          betTipsModel.tipsContent.tr,
                          style: TextStyle(
                            color: themeData.shopcartLabelColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
                        style: const TextStyle(
                          color: Color(0xFF179CFF),
                          fontSize: 16,
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
}
