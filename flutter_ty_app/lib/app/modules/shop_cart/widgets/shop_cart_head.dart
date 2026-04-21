import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../global/ty_user_controller.dart';

import 'balance_refresh_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注框顶部Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注框顶部部件
      包括：单关、串关图标
          商户名称
          账户余额
    】】】
 *
 */
class ShopCartHead extends StatelessWidget {
  const ShopCartHead(this.headType, this.hasDiscountOdds, {Key? key}) : super(key: key);
  final String headType;
  final bool hasDiscountOdds;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String? language = StringKV.language.get();
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 8.h),
      height: 28.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(language=="CN" || language=="TW" || language=="GB")
                    Container(
                      width: 24.w,
                      height: 24.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(1),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF179CFF),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.20,
                            color: Colors.white.withValues(alpha:0.2),
                          ),
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          headType,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontFamily: 'FZLanTingHeiS-B-GB',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 24.w,
                      height: 24.w,
                      alignment: Alignment.center,
                      child:ImageView('assets/images/shopcart/shopcart_head.png',
                        width: 24.w,
                        height: 24.w,
                      ),

                    ),
                  const SizedBox(width: 4),

                  if (hasDiscountOdds)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF179CFF)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Text(
                          //LocaleKeys.league_search_odd_promotion_count.tr,
                          LocaleKeys.discount_odd_odds_value_increase.tr,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF179CFF),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child:Text(
                        TYUserController.to.getTitle(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 28.h,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: ShapeDecoration(
              color: themeData.shopcartContentBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(()=>Text(
                    TYFormatCurrency.formatCurrency(TYUserController.to.balanceAmount.value),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: 18.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,

                    ),
                  )
                ),
                const SizedBox(width: 4),
                BalanceRefreshWidget(width:20.w,height:20.w),

              ],
            ),
          )
        ],
      ),
    );
  }
}