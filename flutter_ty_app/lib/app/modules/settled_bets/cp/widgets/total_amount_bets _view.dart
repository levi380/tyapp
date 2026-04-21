
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票追号记录列表头部统计注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票追号记录列表头部统计注单Widget
    】】】
 *
 */
class TotalAmountBetsView extends StatelessWidget {
  final List<double> statistics;

  const TotalAmountBetsView({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            LocaleKeys.zr_cp_Lottery_Bet_Slips_total_number_of_bets.tr,
            statistics[0].toInt().toString(),
          ),
          _div(),
          _single(
            LocaleKeys.zr_cp_Lottery_Bet_Slips_total_stake.tr,
            statistics[1].toString(),
          ),
          _div(),
          _single(
            LocaleKeys.zr_cp_Lottery_Bet_Slips_total_valid_bets.tr,
            statistics[2].toString(),
          ),
          _div(),
          _single(
            LocaleKeys.zr_cp_Lottery_Bet_Slips_total_winning_amount.tr,
            statistics[3].toString(),
            isSpecial: true,
          ),
        ],
      ),
    );
  }

  Widget _single(String title, String number, {bool isSpecial = false}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.isDarkMode
                  ? Colors.white.withValues(alpha:
                      0.5,
                    )
                  : const Color(
                      0xFF7981A3,
                    ),
              height: 1,
              fontSize:  10.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginZero.marginOnly(
                bottom: 2.h,
              ),
          Text(
            number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSpecial
                  ? const Color(0xFFF53F3F)
                  : Get.isDarkMode
                      ? Colors.white.withValues(alpha:0.8999999761581421)
                      : const Color(0xFF303442),
              fontSize:  14.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha:
                0.07999999821186066,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
