part of 'betitem_ty_single.dart';

extension BetItemTySingleEx on BetItemTySingle{
  Widget _buildItemExpanded(BuildContext context){
    ThemeData themeData = Theme.of(context);
    bool appointmentMarking = getPreOrder();
    var languageCode = Get.locale?.languageCode ?? "";
    String betTime = getModifyTime();
    int chType = orderItem.detailList.safeFirst?.matchType??0;
    String langCode = orderItem.langCode;
    String matchType = getBetType(chType, langCode);
    String eov = orderItem.detailList.safeFirst?.eov ?? "";
    String matchInfo = orderItem.detailList.safeFirst?.matchInfo??'';
    if ([1009, 1010, 1011, 1002].contains(orderItem.detailList.safeFirst?.sportId??0)){
      matchInfo = orderItem.detailList.safeFirst?.batchNo??"";
    }
    List<String> vrIcon = logic.betTylogic.getVrIcon(orderItem.detailList.safeFirst?.sportId??0,orderItem.detailList.safeFirst?.playOptions??'');
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
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          logic.changeExpanded(exapnd: !isExpanded,orderId: orderItem.orderNo);
                        },
                        child:Column(
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

                              SizedBox(height: 4.h),
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
                                      matchInfo,
                                      style: TextStyle(
                                        color: themeData.betItemTitleColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  appointmentMarking? Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.w,
                                          color: Color(
                                              context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                                        ),
                                        borderRadius: BorderRadius.circular(5.r),
                                      ),
                                    ),
                                    child: Text(
                                      '+' + LocaleKeys.bet_bet_book_confirm.tr,
                                      style: TextStyle(
                                        color:
                                        Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                                        fontSize: languageCode == 'vi' ? 10.sp : 12.sp ,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ) : Container()
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 16.w),
                                  Text(
                                    LocaleKeys.common_match_time.tr,
                                    style: TextStyle(
                                      color: themeData.betItemTextColor2,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child:Text(
                                      TimeZoneUtils.convertTimeToTimestamp(orderItem.detailList.safeFirst?.beginTime??'',
                                          isMilliseconds: true)
                                          .toString()
                                          .replaceAll("-", "/"),
                                      style: TextStyle(
                                        color: themeData.betItemTextColor2,
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 8.h),
                              Container(
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$matchType ${orderItem.detailList.safeFirst?.playName??""}',
                                            style: TextStyle(
                                              color: themeData.betItemTitleColor,
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          if (eov.isEmpty)
                                            Text(
                                              ' @${orderItem.detailList.safeFirst?.oddFinally??""}',
                                              style: TextStyle(
                                                color: themeData.betItemTitleColor,
                                                fontSize: 14.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            )
                                          else
                                            InformationEovView(oddFinally: orderItem.detailList.safeFirst?.oddFinally??"",eov: eov,),



                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InformationVrIconView(vrIcons: vrIcon),
                                          if(vrIcon.isEmpty)
                                            Expanded(
                                                child:Text(orderItem.detailList.safeFirst?.marketValue??"",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: themeData.betItemTitleColor,
                                                    fontSize: 14.sp,
                                                    fontFamily: 'PingFang SC',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                )
                                            )
                                          else
                                            Text(
                                              orderItem.detailList.safeFirst?.marketValue??"",
                                              textAlign: TextAlign.center,
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
                                    const SizedBox(height: 4),
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child:Text(
                                              '${orderItem.detailList.safeFirst?.sportName??""}  |  ${orderItem.detailList.safeFirst?.matchName??""}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: themeData.betItemTextColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        )
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
                                          //LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr,
                                          isPreBetAmount(),
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
                                          //TYFormatCurrency.formatCurrency(orderItem.orderAmountTotal),
                                          getOrderAmountTotal(),
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
                                          TYFormatCurrency.formatCurrency(orderItem.maxWinAmount),
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
                            decoration: BoxDecoration(),
                            child:Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: buildBetNum(context, orderItem.orderNo),
                                ),
                                SizedBox(width: 4.w),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        betTime,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: themeData.betItemTextColor2,
                                          fontSize: 12.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      if(isIPad)
                                        Text(
                                          ' ${TimeZoneUtils.getTimeZoneString()}',
                                          style: TextStyle(
                                            color: themeData.betItemTextColor2,
                                            fontSize: 10.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      Text(
                                        '(${odds_type_name[orderItem.detailList.safeFirst?.marketType]?.tr??""})',
                                        style: TextStyle(
                                          color: themeData.betItemTextColor2,
                                          fontSize: 10.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
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
                    ),
                    ///提前结算
                    _earlyRedemptionView(),
                  ],
                ),
              ),

            ]
        )
    );
  }

  ///提前结算
  Widget _earlyRedemptionView() {
    return Column(children: [
      ///提前兑现说明
      if (getEarlySettlementFeature() || getExhibitEarlySettlement()) ...[

        const RuleStatementView(),

        SizedBox(height: 4.h),
      ],

      ///提前结算功能
      if (getEarlySettlementFeature())
        EarlySettlementFeatureView(
          data: orderItem,
          index: index,
        ),

      ///产品要求，4260需求回退，暂时不上线，等待通知......
      ///提前结算,结算信息的view（已结和未结都有）
      //if (getExhibitEarlySettlement())
      //  EarlyRedemptionDetailsView(
      //    data: orderItem,
      //    index: index,
      //    onTap: () {
      //      /// 提前兑现折叠
      //      logic.betTylogic.onPreSettleExpand(index);
      //    },
      //  ),
    ]);
  }

}