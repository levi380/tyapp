import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../utils/amount_util.dart';
import '../vr_sport_state.dart';


class BalanceIconButton extends StatelessWidget {
  const BalanceIconButton({
    super.key,
    this.balance = '1,000,000.00',
    this.onTap,
  });

  final VoidCallback? onTap;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GetBuilder<TYUserController>(
        builder: (controller) {
          return Container(
            height: 22.w,
            padding: EdgeInsets.only(
              left: 6.w,
              right: 6.w,
            ),
            margin: EdgeInsets.only(left: 8.w),
            decoration: ShapeDecoration(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.03999999910593033)
                  : const Color(0xFFF2F2F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                TYUserController.to.getBalance();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: TYUserController.to.currCurrency() == 'USDT',
                    child: ImageView(VRSportState.currencyUSDT,
                        width: 16.w, height: 16.w),
                  ),
                  Visibility(
                    visible: TYUserController.to.currCurrency() == 'RMB',
                    child: ImageView(VRSportState.currencyRMB,
                        width: 16.w, height: 16.w),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  Container(
                    ///80498产品要求 余额过长省略显示
                    alignment: Alignment.center,
                    child: Text(
                      ///未登录 默认显示0.00
                      RouteCheckUtil.checkIsLogin() == false
                          ? '0.00'
                          : controller.balance.value != null
                          ? controller.toAmountSplit(AmountUtil.numberFormat(
                          controller.balance.value!.amount))
                          : '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? const Color(0xE5FFFFFF)
                            : const Color(0xFF303442),
                        fontSize: 14.sp.scale,
                        fontFamily: 'DIN Alternate',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
