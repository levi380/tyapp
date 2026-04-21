
part of 'betitem_all_mix.dart';

extension BetItemAllMixEx on BetItemAllMix{
  Widget _buildItemExpanded(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    DateTime time = DateTime.fromMillisecondsSinceEpoch(int.tryParse(orderItem.betTime)??0);
    String betTime = DateFormat('yyyy/MM/dd HH:mm:ss').format(time);
    return Container(
      decoration: ShapeDecoration(
        color: themeData.betItemBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                onTap: (){
                  logic.changeExpanded(exapnd: !isExpanded,orderId: orderItem.orderNo);
                },
                child:Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                getOrderStatus(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: getOrderStatusColor(context),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Transform.rotate(
                                angle: pi / 2,
                                child: ImageView('assets/images/bets/right_expand.png', width: 14.w,color: themeData.betItemExpandColor,),
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageView(context.isDarkMode
                                ? 'assets/images/bets/level_icon_night.png'
                                : 'assets/images/bets/level_icon_daytime.png', width: 12.w),
                            SizedBox(width: 4.w),
                            Expanded(
                              child:Text(
                                orderItem.seriesValue,
                                style: TextStyle(
                                  color: themeData.betItemTitleColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        //...orderItem.orderMixExtendVOList.map((e) => _buildOrderItemExpanded(context,e)).toList(),
                        ..._buildOrderItemExpanded(context,orderItem),
                      ]
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr,
                                    style: TextStyle(
                                      color: themeData.betItemTextColor2,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    orderItem.betAmount,
                                    style: TextStyle(
                                      color: themeData.betItemTitleColor,
                                      fontSize: 16.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Container(
                            width: 0.50,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 0.50,
                                  height: double.infinity,
                                  decoration: BoxDecoration(color: themeData.betItemDividerColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.zr_cp_Lottery_Bet_Slips_winning.tr,
                                    style: TextStyle(
                                      color: themeData.betItemTextColor2,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    orderItem.maxWinAmount,
                                    style: TextStyle(
                                      color: themeData.betItemTitleColor,
                                      fontSize: 16.sp,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      height: 0.50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.50,
                              decoration: BoxDecoration(color: themeData.betItemDividerColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: buildBetNum(context, orderItem.orderNo),
                          ),
                          buildTimeAndOdd(
                              betTime,
                              '(${odds_type_name[orderItem.orderMixExtendVOList.safeFirst?.marketType]?.tr??""})',
                              themeData
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (getEarlySettlementFeature() ||
                  getExhibitEarlySettlement()) ...[
                SizedBox(height: 4.h),

                ///提前兑现说明
                const RuleStatementView(),
              ],
              if (getEarlySettlementFeature())
                EarlySettlementFeatureView(
                  data: h5OrderItem!,
                  index: index,
                ),
              ///产品要求，4260需求回退，暂时不上线，等待通知......
              ///提前结算,结算信息的view（已结和未结都有）
              // if (getExhibitEarlySettlement())
              //   EarlyRedemptionDetailsView(
              //     data: h5OrderItem!,
              //     index: index,
              //     onTap: () {
              //       /// 提前兑现折叠
              //       logic.betTylogic.onPreSettleExpand(index);
              //     },
              //   ),
            ],
          ),

        ],
      ),

    );
  }
  List<Widget> _buildOrderItemExpanded(BuildContext context,AllOrderListList allOrderListList){
    List<Widget> widgetList = [];
    ThemeData themeData = Theme.of(context);
    for(int i=0;i<allOrderListList.orderMixExtendVOList.length && ((i<3 && !isMixExpanded) || isMixExpanded)  ;i++) {
      AllOrderListListOrderMixExtendVOList orderMixItem = allOrderListList.orderMixExtendVOList[i];
      String eov = orderMixItem.eov ?? "";
      DateTime time = DateTime.fromMillisecondsSinceEpoch(int.tryParse(orderMixItem.beginTime)??0);
      String beginTime = DateFormat('yyyy-MM-dd HH:mm').format(time);
      widgetList.add(Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: themeData.betItemContentBgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  InformationVrIconView(vrIcons: logic.betTylogic.getVrIcon(orderMixItem.sportId,orderMixItem.playOptions)),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${getMatchType(orderMixItem)} ${orderMixItem.playName} ${orderMixItem.marketValue}',
                            style: TextStyle(
                              color: themeData.betItemTitleColor,
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(width:4.w),
                        if (eov.isEmpty)
                          Text(
                            '@${orderMixItem.odds}',
                            style: TextStyle(
                              color: themeData.betItemTitleColor,
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          )
                        else
                          InformationEovView(oddFinally: orderItem.orderMixExtendVOList.safeFirst?.odds??"",eov: eov,),
                      ],
                    )


                  ),
                  Text(
                    LocaleKeys.bet_record_bet_no_status17.tr,
                    style: TextStyle(
                      color: themeData.betItemTitleColor,
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: themeData.betItemTabSelectedColor,
                        width: 2),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(orderMixItem.scoreBenchmark.isNotEmpty)
                    ...[
                      Container(
                        child: Text(
                          '${LocaleKeys.bet_record_settle_num.tr} (${orderMixItem.scoreBenchmark.replaceFirst(':', '-')})',
                          style: TextStyle(
                            color: themeData.betItemTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,

                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  if ([1009, 1010, 1011, 1002].contains(orderMixItem.sportId))  //Vr
                    Container(
                      child: Text(
                        LocaleKeys.common_virtual_sports.tr,
                        style: TextStyle(
                          color: themeData.betItemTextColor,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    )
                  else
                    Container(
                      child: Text(
                        orderMixItem.matchInfo.replaceFirst(" v ", " VS ").replaceAll(RegExp(r'\(.*?\)'), ''),
                        style: TextStyle(
                          color: themeData.betItemTextColor,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Container(
                    child: Text(
                      orderMixItem.sportName + " | " + orderMixItem.matchName,
                      style: TextStyle(
                        color: themeData.betItemTextColor,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    child: Text(
                      LocaleKeys.common_match_time.tr + " " + beginTime,
                      style: TextStyle(
                        color: themeData.betItemTextColor,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ));
    }

    if(allOrderListList.orderMixExtendVOList.length >3) {
      widgetList.add(Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.all(2.w),
        decoration: ShapeDecoration(
          color: themeData.betItemContentBgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w)),
        ),
        child: InkWell(
          onTap: () {
            logic.changeMixExpanded(!isMixExpanded, allOrderListList.orderNo);
          },
          child: Text(
            isMixExpanded ? LocaleKeys.bet_record_pack_up.tr : LocaleKeys
                .bet_record_pack_down.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.betItemTextColor,
              fontSize: 10.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,

            ),
          ),

        ),
      ));
    }
    return widgetList;
  }
}