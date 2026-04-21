part of 'bet_item_widget.dart';

extension BetItemWidgetClosedEx on BetItemWidget{
  List<Widget> _buildClosedItem(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return [
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (playOptionName != null)
                    Expanded(
                        child: Text(
                          playOptionName!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: themeData.shopcartLabelColor,
                            fontSize: isIPad ? 16.sp : 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  //投注成功后的玩法名称用接口返回的
                  else
                  //Vr 单独处理
                    if(shopCartItem.betType == OddsBetType.vr
                        && ShopCartUtilHandicap.isVrRankHandicap(shopCartItem.sportId,shopCartItem.playId)
                    )
                      _buildVrHandicap(context,isClosed: true)
                    else
                      Expanded(
                        child:Obx(()=>Text(
                          '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: themeData.shopcartLabelColor,
                            fontSize: isIPad ? 16.sp : 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            ///盘口关闭
            Text(
              LocaleKeys.bet_close.tr,
              style: TextStyle(
                color: themeData.shopcartLabelColor,
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0XFF179CFF),
                      // Set the color of the bottom border
                      width: 2, // Set the width of the bottom border
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (shopCartItem.matchType == 2) ...[
                                  Text(
                                    '「${LocaleKeys.new_menu_1.tr}」',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  shopCartItem.playName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: themeData.shopcartLabelColor,
                                    fontSize: isIPad ? 16.sp : 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                if (shopCartItem.sportId == '1') ...[
                                  Text(
                                    shopCartItem.markScore,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: isIPad ? 16.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  '「${TYUserController.to.curOddsLabel(shopCartItem.oddsHsw).tr}」',
                                  style: TextStyle(
                                    color: themeData.shopcartLabelColor,
                                    fontSize: isIPad ? 16.sp : 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (shopCartItem.home.isNotEmpty) ...[
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
                    ],
                    ...[
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Row(children: [
                          Expanded(
                            child: Text(
                              shopCartItem.tidName,
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
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}