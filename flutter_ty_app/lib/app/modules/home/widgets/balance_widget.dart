// Importing necessary packages and extensions
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';

// Importing controllers and utility classes
import '../../../global/ty_user_controller.dart';
import '../../../utils/amount_util.dart';
import '../../../utils/route_check_util.dart';
import '../../login/login_head_import.dart';

// BalanceWidget class definition
class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<TYUserController>(builder: (controller) {
      final String currency = TYUserController.to.currCurrency();
      final bool isLogin = RouteCheckUtil.checkIsLogin();
      final amount = controller.balance.value?.amount;

      /// 显示金额字符
      final String balanceText = !isLogin
          ? '0.00'
          : amount != null
          ? controller.toAmountSplit(AmountUtil.numberFormat(amount))
          : '-';

      /// 图标映射 方便后面新币种的扩展
      final Map<String, String> currencyIcon = {
        'USDT': 'assets/images/home/icon_trans_nor_USDT.svg',
        'RMB': 'assets/images/home/icon_trans_nor_RMB.svg',
      };

      final String? iconPath = currencyIcon[currency];

      return Container(
        height: 22.w,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        margin: EdgeInsets.only(left: 8.w),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.04)
              : const Color(0xFFF2F2F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => TYUserController.to.getBalance(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconPath != null)
                ImageView(
                  iconPath,
                  width: 16.w,
                  height: 16.w,
                ),
              SizedBox(width: 5.w),

              ///余额
              Text(
                balanceText,
                style: TextStyle(
                  color: context.isDarkMode
                      ? const Color(0xE5FFFFFF)
                      : const Color(0xFF303442),
                  fontSize: 14.sp.scale,
                  fontFamily: 'DIN Alternate',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

