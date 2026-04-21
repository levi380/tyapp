part of 'betitem_all_single.dart';

extension BetItemAllSingleEx on BetItemAllSingle{
  Widget _buildItemExpanded(BuildContext context){
    ThemeData themeData = Theme.of(context);
    //DateTime time = DateTime.fromMillisecondsSinceEpoch(int.tryParse(orderItem.betTime)??0);
    //String betTime = DateFormat('yyyy/MM/dd HH:mm:ss').format(time);
    String betTime = TimeZoneUtils.convertTimeToTimestamp(orderItem.betTime,
        isMilliseconds: true);
    int chType = orderItem.orderMixExtendVOList.safeFirst?.matchType??0;
    //String langCode = Get.locale?.languageCode ?? "";
    String langCode = "zs";//返回值中没有langCode字段
    String matchType = getBetType(chType, langCode);
    String eov = orderItem.orderMixExtendVOList.safeFirst?.eov ?? "";
    String matchInfo = orderItem.orderMixExtendVOList.safeFirst?.matchInfo??'';
    if ([1009, 1010, 1011, 1002].contains(orderItem.orderMixExtendVOList.safeFirst?.sportId??0)){
      //matchInfo = orderItem.orderMixExtendVOList.safeFirst?.batchNo??"";
      matchInfo = LocaleKeys.common_virtual_sports.tr;
    }
    List<String> vrIcon = logic.betTylogic.getVrIcon(orderItem.orderMixExtendVOList.safeFirst?.sportId??0,orderItem.orderMixExtendVOList.safeFirst?.playOptions??'');
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
                              ],
                            ),
                            if((orderItem.orderMixExtendVOList.safeFirst?.beginTime??'').isNotEmpty)
                              ...[SizedBox(height: 4.h),
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
                                        TimeZoneUtils.convertTimeToTimestamp(orderItem.orderMixExtendVOList.safeFirst?.beginTime??'',
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
                              ],
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
                                          '$matchType ${orderItem.orderMixExtendVOList.safeFirst?.playName??""}',
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
                                            ' @${orderItem.orderMixExtendVOList.safeFirst?.odds??""}',
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
                                            child:Text(
                                              orderItem.orderMixExtendVOList.safeFirst?.marketValue??"",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: themeData.betItemTitleColor,
                                                fontSize: 14.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          )
                                        else
                                          Text(
                                            orderItem.orderMixExtendVOList.safeFirst?.marketValue??"",
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
                                            '${orderItem.orderMixExtendVOList.safeFirst?.sportName??""}  |  ${orderItem.orderMixExtendVOList.safeFirst?.matchName??""}',
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
                                            fontSize:12.sp,
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
                    ///提前结算
                    _earlyRedemptionView(),
                  ],
                ),
              ),

            ]
        )
    );
  }
}