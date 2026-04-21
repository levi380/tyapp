part of 'single_bet_landscape_view.dart';

extension SingleBetLandscapeComponentInputEx on SingleBetLandscapeComponent{
  Widget _buildInputWidget() {
    String hint = LocaleKeys.bet_input_v2.tr;
    TextStyle hintStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.2),
      fontSize: 14.0.scale,
      fontFamily: 'PingFang SC',
      fontWeight: FontWeight.w400,
    );
    if (TYUserController.to.balanceAmount.value <= 0) {
      hint = LocaleKeys.bet_message_m_0402035.tr;
      hintStyle = TextStyle(
        color: Colors.white.withValues(alpha: 0.3),
        fontSize: 14.0.scale,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w400,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${LocaleKeys.common_money.tr}: ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12.0.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          TYFormatCurrency.formatCurrency(
                              TYUserController.to.balanceAmount.value),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 13.0.scale,
                            fontFamily: 'Akrobat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${LocaleKeys.common_unit.tr}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12.0.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(width: 4),
                    const BalanceRefreshWidget(width: 16, height: 16),
                  ],
                ),
                Expanded(
                  child: GetBuilder(
                      id: "input",
                      init: logic,
                      builder: (controller) {
                        double maxValue =
                            double.tryParse(logic.maxValue) ?? 0.0;
                        double minValue =
                            double.tryParse(logic.minValue) ?? 0.0;
                        //maxValue = min(maxValue,UserController.to.balanceAmount.value);
                        return Obx(() {
                          double inputAmount = logic.inputAmount.value;
                          String limit;
                          if (inputAmount < minValue ||
                              logic.amountController.text.isEmpty) {
                            limit =
                            '${TYFormatCurrency.formatCurrency(minValue)}-${TYFormatCurrency.formatCurrency(maxValue)}';
                          } else {
                            limit =
                            '${TYFormatCurrency.formatCurrency(maxValue)}';
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${LocaleKeys.bet_bet_val2.tr}: ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.0.scale,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  limit,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 13.0.scale,
                                    fontFamily: 'Akrobat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                ' ${LocaleKeys.common_unit.tr}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.0.scale,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        });
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.amountController,
                    focusNode: logic.amountFocusNode,
                    style: TextStyle(
                        fontSize: 14.0.scale,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500),
                    //autofocus: true,
                    enableInteractiveSelection: false,
                    showCursor: true,
                    readOnly: true,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        hintText: hint,
                        hintStyle: hintStyle),
                  ),
                ),
                Text(
                  LocaleKeys.common_unit.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14.0.scale,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child:Obx(() {
                    double profitAmount = logic.profitAmount(0);
                    String winTotal =
                    TYFormatCurrency.formatCurrency(profitAmount);
                    double oddFinally = double.tryParse(
                        logic.itemList.safeFirst?.oddFinally.value ??
                            "0)") ??
                        0.0;
                    bool isNotNegativeOdd = oddFinally > -0.000001;
                    double betAmount =
                        ((profitAmount.abs()) * 100).ceilToDouble() / 100;
                    String inputTotal =
                    TYFormatCurrency.formatCurrency(betAmount);
                    if (!isNotNegativeOdd) {
                      winTotal =
                          TYFormatCurrency.formatCurrency(logic.inputTotal);
                    }
                    return Column(
                      children: [
                        //负数赔率
                        if (!isNotNegativeOdd)
                          Row(
                            crossAxisAlignment: isNotNegativeOdd
                                ? CrossAxisAlignment.baseline
                                : CrossAxisAlignment.center, // 根据文本基线对齐
                            textBaseline: isNotNegativeOdd
                                ? TextBaseline.alphabetic
                                : null, // 设置基线对齐方式
                            children: [
                              Text(
                                '${LocaleKeys.app_place_bet.tr}: ',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.0.scale,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                inputTotal,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 13.0.scale,
                                  fontFamily: 'Akrobat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                LocaleKeys.common_unit.tr,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.0.scale,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: isNotNegativeOdd
                                        ? CrossAxisAlignment.baseline
                                        : CrossAxisAlignment.center, // 根据文本基线对齐
                                    textBaseline: isNotNegativeOdd
                                        ? TextBaseline.alphabetic
                                        : null, // 设置基线对齐方式
                                    children: [
                                      Text(
                                        '${LocaleKeys.app_h5_bet_win_amount.tr}: ',
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 12.0.scale,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        winTotal,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 13.0.scale,
                                          fontFamily: 'Akrobat',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        LocaleKeys.common_unit.tr,
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 12.0.scale,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(width: 4),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageView(
                        'assets/images/shopcart/fullscreen-bet-question-icon.svg',
                        width: 16,
                        onTap: () {
                          _buildAutoAcceptTips();
                        },
                      ),
                      const SizedBox(width: 2),
                      InkWell(
                        onTap: () {
                          TYUserController.to.setUserBetPrefer(TYUserController
                              .to.userInfo.value!.userBetPrefer ==
                              BetAcceptOdds.acceptAll.code?BetAcceptOdds.acceptBetter.code:BetAcceptOdds.acceptAll.code);
                        },
                        child: SizedBox(
                          width: 130,
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          LocaleKeys.bet_bet_auto_msg_1.tr,
                                          style: TextStyle(
                                            color: Colors.white
                                                .withValues(alpha: 0.7),
                                            fontSize: 12.0.scale,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))),
                                const SizedBox(width: 2),
                                GetBuilder<TYUserController>(
                                    id: "auto_accept",
                                    init: TYUserController.to,
                                    builder: (controller) {
                                      return Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            color: TYUserController.to.userInfo
                                                .value?.userBetPrefer !=
                                                BetAcceptOdds.acceptAll.code
                                                ? const Color(0xFF179CFF)
                                                : Colors.transparent,
                                            border: TYUserController.to.userInfo
                                                .value?.userBetPrefer !=
                                                BetAcceptOdds.acceptAll.code
                                                ? Border.all(
                                                color:
                                                const Color(0xFF179CFF),
                                                width: 1)
                                                : Border.all(
                                                color: Colors.grey,
                                                width: 1),
                                            borderRadius:
                                            BorderRadius.circular(4)),
                                        child: TYUserController.to.userInfo
                                            .value?.userBetPrefer !=
                                            BetAcceptOdds.acceptAll.code
                                            ? ImageView(
                                            'assets/images/shopcart/check.png',
                                            width: 14.sp)
                                            : Container(),
                                      );
                                    }),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardWidget() {
    return Obx(() {
      return NumberKeyboardLandscape(
        onTextInput: (myText) {
          logic.insertText(myText);
        },
        onBackspace: () {
          logic.backspace();
        },
        onBet: () async {
          await logic.doBet();
        },
        isBetEnabled: !logic.isSpecialState,
      );
    });
  }
}