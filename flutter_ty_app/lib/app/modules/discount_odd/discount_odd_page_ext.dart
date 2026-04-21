import '../match_detail/constants/detail_constant.dart';
import 'discount_odd_page.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/routes/route_manager.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/odds_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../config/analytic/analytics_utils.dart';
import '../../utils/match_util.dart';
import '../../utils/time_zone/timeZoneUtils.dart';
import '../../utils/utils.dart';
import 'dicount_detail_odds_widget.dart';
import 'controllers/discount_odd_controller.dart';

extension DiscountOddPageExt on DiscountOddPage{

  Widget buildMatch(MatchEntity matchEntity, BuildContext context) {
    final DataStoreController dataController = DataStoreController.to;
    List<Widget> widgets = [];
    // if(match.dom == 1){
    for (final hps in matchEntity.hps) {
      final hl = hps.hl.safeFirst;
      if (hl == null) continue;
      final ols = hl.ol;
      if (ols.isEmpty) continue;
      for (final ol in ols) {
        widgets.add(buildOdd(context, matchEntity, ol, hps, hl));
      }
    }
    // }


    return GetBuilder<DataStoreController>(
        init: dataController,
        id: dataController.getMatchId(matchEntity.mid),
        builder: (logic) {
          Set<String> foldSet =    DiscountOddController.to.state.foldList;
          bool isFold = foldSet.contains(matchEntity.tid);
          return Column(children: [
            if (!isFold)
              Divider(
                height: 0.4.w,
                color: Get.isDarkMode
                    ? Colors.white.withAlpha(10)
                    : const Color(0xffE4E6ED),
              ),
            if (!isFold) _buildTeam(matchEntity, context),
            if (!isFold) buildTime(context, matchEntity),
            if (!isFold && widgets.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: widgets,
              ),
          ]);
        });
  }

  ///赛事队伍显示 布局
  Widget _buildTeam(MatchEntity matchEntity, BuildContext context) {
    // int result = MatchUtil.getHandicapIndexBy(matchEntity);
    int result = 0;
    Color mhnColor = result == 1
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442); //主队
    Color manColor = result == 2
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442); //客队
    return GestureDetector(
      onTap: () {
        // 赔率增值赛事卡片  点击查看该赛事详情
        ///埋点
        Analytics.handleHpidTracking("card_match_odds");
        RouteManager.goMatchDetail(
            mid: matchEntity.mid,
            csid: matchEntity.csid,
            isESports: MatchUtil.isEsport(matchEntity),
            cid: ADDED_ODDS_CATEGORY_ID,
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      matchEntity.mhn,
                      style: TextStyle(
                          color: mhnColor,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  ImageView(
                    (matchEntity.mhlu as List).safeFirst == "" ||
                        (matchEntity.mhlu as List).safeFirst == null
                        ? 'assets/images/home/home_team_logo.svg'
                        : (matchEntity.mhlu as List).safeFirst,
                    width: 20.w,
                    height: 20.w,
                    cdn: true,
                    errorWidget: ImageView(
                      'assets/images/home/home_team_logo.svg',
                      width: 20.w,
                      height: 20.w,
                    ),
                  ),
                  Container(
                      width: 4.w,
                      height: 4.w,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w)),
                        // color: set_serving_side(matchEntity, 'home')
                        //     ? const Color(0xff4ab06a)
                        //     : Colors.transparent,
                      )),
                ],
              ),
            ),
            Container(
              width: 20.w,
              height: 20.w,
              alignment: Alignment.center,
              child: Text(
                'VS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 4.w,
                      height: 4.w,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w)),
                        // color: set_serving_side(matchEntity, 'away')
                        //     ? const Color(0xff4ab06a)
                        //     : Colors.transparent,
                      )),
                  ImageView(
                    (matchEntity.malu as List).safeFirst == "" ||
                        (matchEntity.malu as List).safeFirst == null
                        ? 'assets/images/home/away_team_logo.svg'
                        : (matchEntity.malu as List).safeFirst,
                    width: 20.w,
                    height: 20.w,
                    cdn: true,
                    errorWidget: ImageView(
                      'assets/images/home/away_team_logo.svg',
                      width: 20.w,
                      height: 20.w,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(
                      matchEntity.man,
                      style: TextStyle(
                          color: manColor,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildOdd(BuildContext context, MatchEntity match, MatchHpsHlOl ol,
      MatchHps hps, MatchHpsHl? hl /*String hpn*/) {
    String hpn = hps.hpn;
    String ot = ol.otv;
    // String ov = BasketballAppreciationOddsController.to.formatNumber(ol?.ov);
    // String dov = BasketballAppreciationOddsController.to.formatNumber(ol.dov);
    // var valueol =  ol;
    //
    // String ov =   TYFormatOddsConversionMixin.computeValueByCurOddType(
    //     valueol.ov,
    //     valueol.ov2,
    //     hps.hpid,
    //     hps.hsw.split(','),
    //     int.tryParse(match.csid) ?? 0);
    //
    // String dov =   TYFormatOddsConversionMixin.computeValueByCurOddType(
    //     valueol.dov,
    //     valueol.ov2,
    //     hps.hpid,
    //     hps.hsw.split(','),
    //     int.tryParse(match.csid) ?? 0);

    OddsButtonState state =
    OddsUtil.betState(match.mhs, hl!.hs, ol, hps.hsw, csid: match.csid);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (state == OddsButtonState.lock) {
              return;
            }
            ShopCartController.to.addBet(match, hps, hl, ol);
          },
          child: Column(children: [
            SizedBox(
              height: 5.w,
            ),
            Container(
              height: 40.w,
              // height: 50.w,
              decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.08)
                      : Color(0xFFD1EBFF),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  border: Border.all(
                      width: 1.w, color: Colors.black.withValues(alpha: 0.04))),
              margin: EdgeInsets.only(left: 8.w, right: 8.w),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      //flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r))),
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          hpn + " " + ot,
                          style: TextStyle(
                            // color: mhnColor,
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha: 0.9)
                                : Colors.black,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF179CFF),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r))),
                      padding:
                      EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w),
                      child: discountDetailOddssWidget(
                        ol: ol,
                        match: match,
                        hps: hps,
                        hl: hl,
                        fullscreen: false,
                        selected: false,
                        // status: status,
                        status2: 0,
                      ),
                    )

                    /*  Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withValues(alpha:0.2),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r))),
                    padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w),
                    child: state == OddsButtonState.lock?ImageView(
                      'assets/images/detail/match-icon-lock.svg',
                      width: isIPad
                          ? 25
                          : 16,
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ov,
                          style: TextStyle(
                            // color: mhnColor,

                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.3)
                                : Colors.grey,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          child: ImageView(
                              "assets/images/discount_odd/arrow_right.png"),
                        ),
                        Text(
                         dov,
                          style: TextStyle(
                            // color: mhnColor,
                            color: context.isDarkMode
                                ? Color(0xff127DCC)
                                : Colors.lightBlueAccent,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          child:
                              ImageView("assets/images/icon/up.png"),
                        ),
                      ],
                    ),
                  ),
                ),*/
                  ],
                ),
              ),
            ),
          ]),
        ),
        /// 优惠赔率置顶图标
        Positioned(
          top: 2.w,
          right: 8.w,


          child: ImageView(
            'assets/images/icon/up2.gif',
            width: 22.w,
            height: 12.w,
            onTapDown: (TapDownDetails details) {
              ToastUtils.showDiscountOddsToast(details);
            },
          ),
        )
      ],
    );
  }

  String getName(List<MatchEntity> matchDiscount) {
    // String title = ConfigController.to.originData.spList
    //      .firstWhereOrNull((element) =>
    //  element.csid == (matchDiscount.safeFirst?.csid ?? ''))
    //      ?.csna ??
    //      '';
    String csid = matchDiscount.safeFirst?.csid ?? '';
    String sportId = ((int.tryParse(csid) ?? 0) + 100).toString();
    return ConfigController.to.getName(sportId);
  }

  buildTime(BuildContext context, MatchEntity match) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 3.h, 0, 8.h),
      alignment: Alignment.center,

      //height: 20.w,
      child: Text(
        DateUtil.formatDateMs(
            TimeZoneUtils.convertTimeToTimestamp(match.mgt,
                isMilliseconds: true, returnMilliseconds: true) ??
                0,
            format: isZh() ? LocaleKeys.time11.tr : LocaleKeys.time4.tr,
            isUtc: true) +
            "(" +
            TimeZoneUtils.getTimeZoneString() +
            ")",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10.sp.scale,
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.5)
              : const Color(0xffAFB3C8),
        ),
      ),
    );
  }
}