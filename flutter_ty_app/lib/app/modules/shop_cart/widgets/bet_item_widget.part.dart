part of 'bet_item_widget.dart';

extension BetItemWidgetEx on BetItemWidget{
  Widget _buildOddsValue(BuildContext context){
    ThemeData themeData = Theme.of(context);
    //投注成功后的玩法名称用接口返回的
    if (orderDetailResp != null) {
      return Obx(() {
        Color oddColor;
        String oddsUpDownImageName;
        if (orderDetailResp!.newOddsValues.value ==
            orderDetailResp!.oddsValues) {
          oddColor = themeData.shopcartTextColor;
          oddsUpDownImageName = '';
        } else if ((double.tryParse(
            orderDetailResp!.newOddsValues.value) ??
            0) >
            (double.tryParse(orderDetailResp!.oddsValues) ?? 0)) {
          oddColor = const Color(0xFFF53F3F);
          oddsUpDownImageName = 'assets/images/detail/odds_up.svg';
        } else {
          oddColor = const Color(0xFF00B42A);
          oddsUpDownImageName = 'assets/images/detail/odds_down.svg';
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '@',
                  style: TextStyle(
                    color: themeData.shopcartTextColor,
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                if (orderDetailResp!.orgOddFinally.isNotEmpty) ...[
                  Text(
                    orderDetailResp!.orgOddFinally,
                    style: TextStyle(
                      color: themeData.shopcartDiscountOddsColor,
                      fontSize: isIPad ? 24.sp : 22.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.lineThrough, // 添加中划线
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  ImageView(
                    "assets/images/discount_odd/arrow_right.png",
                    width: 10,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
                Text(
                  orderDetailResp!.newOddsValues.value,
                  style: TextStyle(
                    color: oddColor,
                    fontSize: isIPad ? 24.sp : 22.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (orderDetailResp!.orgOddFinally.isNotEmpty) ...[
                  SizedBox(
                    width: 2,
                  ),
                  ImageView(
                    "assets/images/icon/up.png",
                    width: 16.sp,
                  ),
                ],
              ],
            ),

            ///升降图标
            Visibility(
                visible: oddsUpDownImageName.isNotEmpty,
                child: Row(
                  children: [
                    const SizedBox(width: 2),
                    ImageView(
                      oddsUpDownImageName,
                      width: 10.w,
                    ),
                  ],
                ))
          ],
        );
      });
    }else {

      ///投注弹框 赔率变更
      return Obx(() {
        Color oddColor = shopCartItem.oddStateType.value ==
            OddStateType.oddUp
            ? const Color(0xFFF53F3F)
            : shopCartItem.oddStateType.value == OddStateType.oddDown
            ? const Color(0xFF00B42A)
            : themeData.shopcartTextColor;
        String oddsUpDownImageName = shopCartItem.oddStateType.value ==
            OddStateType.oddUp
            ? 'assets/images/detail/odds_up.svg'
            : shopCartItem.oddStateType.value == OddStateType.oddDown
            ? 'assets/images/detail/odds_down.svg'
            : '';
        String oddValue = shopCartItem.oddFinally.value;
        String oddOrgValue = "";
        if (shopCartItem.discountOdds > 0) {
          oddOrgValue = oddValue;
          oddValue =
              TYFormatOddsConversionMixin.computeValueByCurOddType(
                  shopCartItem.discountOdds,
                  null,
                  shopCartItem.playId,
                  shopCartItem.oddsHsw.split(','),
                  int.tryParse(shopCartItem.sportId) ?? 0,
                  shopCartItem.cds);
        }
        if (logic is ComboCourageBetController &&
            (logic as ComboCourageBetController).isOddsTooLow()) {
          oddValue = "--";
          oddColor = themeData.shopcartTextColor;
          oddsUpDownImageName = "";
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (oddValue.isNotEmpty)
                  Text(
                    '@',
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: 16.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                SizedBox(
                  width: 2,
                ),
                if (shopCartItem.discountOdds > 0) ...[
                  Text(
                    oddOrgValue,
                    style: TextStyle(
                      color: themeData.shopcartDiscountOddsColor,
                      fontSize: isIPad ? 24.sp : 22.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.lineThrough, // 添加中划线
                    ),
                  ),
                  SizedBox(width: 2),
                  ImageView(
                    "assets/images/discount_odd/arrow_right.png",
                    width: 10,
                  ),
                  SizedBox(width: 2),
                ],
                Text(
                  oddValue,
                  style: TextStyle(
                    color: oddColor,
                    fontSize: isIPad ? 24.sp : 22.sp,
                    fontFamily: 'Akrobat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (shopCartItem.discountOdds > 0) ...[
                  SizedBox(width: 2),
                  ImageView(
                    "assets/images/icon/up.png",
                    width: 16.sp,
                  ),
                ],
              ],
            ),

            ///升降图标
            Visibility(
                visible: oddsUpDownImageName.isNotEmpty && oddValue.isNotEmpty,
                child: Row(
                  children: [
                    const SizedBox(width: 2),
                    ImageView(
                      oddsUpDownImageName,
                      width: 10.w,
                    ),
                  ],
                ))
          ],
        );
      });
    }
  }

  List<Widget> _buildLeagueName(BuildContext context){
    ThemeData themeData = Theme.of(context);
    if (logic is SingleBetController ||
        logic is VrMixBetController) {
      return [
        SizedBox(
            height: 6 -
                (orderDetailResp == null
                    ? max(
                    0,
                    (24 -
                        getTextHeight(
                            shopCartItem.tidName,
                            isIPad ? 16.sp : 12.sp,
                            context)) /
                        2)
                    : 0)),
        SizedBox(
          width: double.infinity,
          child: Row(children: [
            Expanded(
              child: Text(
                shopCartItem.tidName + " " + shopCartItem.vrNo,
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: isIPad ? 16.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (orderDetailResp == null)
              CountDownWidget(
                logic!.countDownSeconds(shopCartItem),
                loop: !(logic is VrMixBetController ||
                    logic is VrSingleBetController),
              ),
            if (logic is VrMixBetController)
              SizedBox(
                width: 20,
              ),
          ]),
        ),
      ];
    }else if (logic is MixBetController) {
      // 投注成功后显示联赛
      return [
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: Row(children: [
            Expanded(
              child: Text(
                shopCartItem.tidName + " " + shopCartItem.vrNo,
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ]),
        ),
      ];
    }else{
      return [];
    }
  }

  List<Widget> _buildMatchInfo(BuildContext context){
    ThemeData themeData = Theme.of(context);
    String orderDetailMarkScore = "";
    if (orderDetailResp != null && orderDetailResp!.sportId == '1') {
      orderDetailMarkScore =
          orderDetailResp!.scoreBenchmark.replaceAll(":", "-");
      if (orderDetailMarkScore.isNotEmpty) {
        orderDetailMarkScore = "($orderDetailMarkScore)";
      }
    }
    if((orderDetailResp?.matchInfo??'').isNotEmpty) {
      return [
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: Row(
              children: [
                Expanded(child: Text(
                  //如果在playOptionName后面已经显示比分（orderDetailMarkScore），则这里把末尾的比分去掉
                  (orderDetailMarkScore.isNotEmpty
                      ? orderDetailResp!.matchInfo.replaceFirst(
                      RegExp(r'\(\d+-\d+\)$'), '')
                      : orderDetailResp!.matchInfo)
                      + orderDetailResp!.vrNo,
                  style: TextStyle(
                    color: themeData.shopcartLabelColor,
                    fontSize: isIPad ? 16.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ),
              ]
          ),
        ),
      ];
    }else if (shopCartItem.home.isNotEmpty) {
      return [
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: Row(children: [
            Expanded(
              child: Text(
                '${shopCartItem.home} VS ${shopCartItem.away}',
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: isIPad ? 16.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ]),
        ),
      ];
    }else{
      return [];
    }
  }

  double getTextHeight(String text, double fontSize, BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout();

    return textPainter.size.height;
  }

  Widget _buildPlayOption(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(playOptionName != null)
          Expanded(
              child: Text(
                playOptionName!,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: themeData.shopcartTextColor,
                  fontSize: isIPad ? 16.sp : 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              )
          )
        //投注成功后的玩法名称用接口返回的
        else if (orderDetailResp != null)
          Obx(()
          {
            if(orderDetailResp!.newHandicapHv.value.isEmpty || orderDetailResp!.newHandicapHv.value == orderDetailResp!.oldHandicapHv) {

              return Expanded(
                  child: Text(
                    orderDetailResp!.playOptionName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: isIPad ? 16.sp : 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  )
              );

            }else{
              return Expanded(
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text:orderDetailResp!.handicap ,
                          style: TextStyle(
                            color: themeData.shopcartTextColor,
                            fontSize: isIPad ? 16.sp : 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text:' ' + orderDetailResp!.newHandicapHv.value,
                          style: TextStyle(
                            color: Color(0XFF303442),
                            backgroundColor: Color(0XFFFFD184),
                            fontSize: isIPad ? 16.sp : 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                  ),
                ),
              );
            }
          }
          )
        else
        //Vr 单独处理
          if(shopCartItem.betType == OddsBetType.vr
              && ShopCartUtilHandicap.isVrRankHandicap(shopCartItem.sportId,shopCartItem.playId)
          )
            _buildVrHandicap(context)
          else
            Expanded(
              child:Obx(()=>Text(
                '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: themeData.shopcartTextColor,
                  fontSize: isIPad ? 16.sp :14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              ),
            ),
      ],
    );
  }

  Widget _buildVrHandicap(BuildContext context, {bool isClosed = false}) {
    ThemeData themeData = Theme.of(context);
    final handicapHvArray = shopCartItem.handicapHv.value.split(',');
    final handicapArray = shopCartItem.handicap.split(',');
    List<Widget> handicapList = [];
    for (int i = 0; i < handicapArray.length; i++) {
      final text = handicapArray[i];
      String hv = '';
      if (i < handicapHvArray.length) {
        hv = handicapHvArray[i];
      }
      handicapList.add(Row(
        children: [
          if (hv.isNotEmpty)
            ImageView(
              VrRankIconUtils.getRankIcon(shopCartItem.sportId.toInt(), hv),
              width: 20.w,
              height: 20.w,
            ),
          const SizedBox(width: 2),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isClosed
                  ? themeData.shopcartLabelColor
                  : themeData.shopcartTextColor,
              fontSize: isIPad ? 16.sp : 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handicapList,
    );
  }
}