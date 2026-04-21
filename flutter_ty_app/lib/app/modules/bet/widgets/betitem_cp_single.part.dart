
part of 'betitem_cp_single.dart';

extension BetItemCpSingleStateEx on BetItemCpSingleState{
  // type = 1 时 显示 投注额、可赢额 其他显示 投注额、中奖金额、完成期数、取消期数、完成金额、取消金额
  List<Widget> _buildInfoList() {
    if (widget.orderItem.type == "1") {
      // 未开奖展示
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 投注额
                  Text(
                    LocaleKeys.bet_record_bet_val.tr,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${FormatMoney.formatMoney2(widget.orderItem.betMoney)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    style: TextStyle(
                      color: Theme.of(context).betMainText,
                      fontSize: 16.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16.w),
                padding: EdgeInsets.only(left: 16.w),
                decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Theme.of(context).betPanelLineColor, width: 0.5.w),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 可赢额
                    Text(
                      LocaleKeys.app_h5_cathectic_winnable.tr,
                      style: TextStyle(
                        color: Theme.of(context).betSubText,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${FormatMoney.formatMoney2(widget.orderItem.maxWinAmount)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 16.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ];
    } else {
      // 已开奖展示
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 投注额
                Text(
                  LocaleKeys.bet_record_bet_val.tr,
                  style: TextStyle(
                    color: Theme.of(context).betSubText,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "${FormatMoney.formatMoney2(widget.orderItem.totalBetAmount)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                  style: TextStyle(
                    color: Theme.of(context).betMainText,
                    fontSize: 16.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.only(left: 16.w),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).betPanelLineColor, width: 0.5.w),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 中奖金额
                  Text(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_winning_amount.tr,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${FormatMoney.formatMoney2(widget.orderItem.totalWinAmount.toDouble())} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    style: TextStyle(
                      color: const Color(0xFFF76565),
                      fontSize: 16.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.only(left: 16.w),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).betPanelLineColor, width: 0.5.w),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 完成期数
                  Text(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_number_of_periods_completed.tr,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.orderItem.finishPlanNoCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).betMainText,
                      fontSize: 16.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 取消期数
                Text(
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_cancel_period.tr,
                  style: TextStyle(
                    color: Theme.of(context).betSubText,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.orderItem.cancelPlanNoCount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).betMainText,
                    fontSize: 16.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.only(left: 16.w),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).betPanelLineColor, width: 0.5.w),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 完成金额
                  Text(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_amount_completed.tr,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${FormatMoney.formatMoney2(widget.orderItem.finishAmount)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    style: TextStyle(
                      color: Theme.of(context).betMainText,
                      fontSize: 16.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.only(left: 16.w),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Theme.of(context).betPanelLineColor, width: 0.5.w),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 取消金额
                  Text(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_cancellation_amount.tr,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${FormatMoney.formatMoney2(widget.orderItem.cancelWinAmount.toDouble())} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    style: TextStyle(
                      color: Theme.of(context).betMainText,
                      fontSize: 16.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ];
    }
  }
}