import 'package:common_utils/common_utils.dart';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';

import '../../../../generated/locales.g.dart';

import '../../../routes/route_manager.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/odds_util.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';
import '../../../utils/ty_text_scaler.dart';
import '../../../utils/utils.dart';
import '../../discount_odd/discount_odd_bean.dart';
import '../../discount_odd/widget/added_odds_widget.dart';
import '../../match_detail/constants/detail_constant.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../../shop_cart/shop_cart_controller.dart';
import 'item/logo_placeholder_widget.dart';


class DiscountOddWidget extends StatefulWidget {
  const DiscountOddWidget({super.key, required this.controller});
  final TyHomeController controller;

  @override
  State<DiscountOddWidget> createState() => _DiscountOddWidgetState();
}

class _DiscountOddWidgetState extends State<DiscountOddWidget> {
  static const int maxDiscountCardCount = 6;
  ///卡片宽度
  final double _cardWidth =  0.66.sw;
  ///卡片间距
  final double _cardMargin = 4.0.w;

  ///左右滑动按钮图片
  final String leftArrowUrl = 'assets/images/icon/left_arrow.png';
  final String rightArrowUrl = 'assets/images/icon/right_arrow.png';

  late final ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<MatchEntity> matchDiscount = widget.controller.homeState.matchtDiscount;
    String count = widget.controller.homeState.discountCount.toString();
    List<DiscountOddBean> discountOddBeans = [];

    List<DiscountOddBean> doc1List = [];
    List<DiscountOddBean> doc2List = [];
    matchDiscount.forEach((MatchEntity match) {
      for (int j = 0; j < match.hps.length; j++) {
        MatchHps hps = match.hps[j];
        MatchHpsHl? hl = hps.hl.safeFirst;
        List<MatchHpsHlOl>? ols = hl?.ol;
        for (int k = 0; k < ols!.length; k++) {
          MatchHpsHlOl ol = ols[k];
          ///根据doc 进行分组 doc等于1 一组  等于0为一组
          if(ol.doc == 1){
            doc1List.add(DiscountOddBean(match, ol, hps, hl));
          }else{
            doc2List.add(DiscountOddBean(match, ol, hps, hl));
          }
        }
      }
    });
    discountOddBeans = [...doc1List, ...doc2List];

    return discountOddBeans.length == 0
        ? SizedBox.shrink()
        : SizedBox(
      width: 1.sw,
      child: Column(
        children: [
          Container(
            height: 1,
            width: double.maxFinite,
            color: context.isDarkMode
                ? Color(0xff127DCC)
                : const Color(0xFF179CFF),
          ),
          GestureDetector(
            onTap: () {
              widget.controller.homeState.isFold = !widget.controller.homeState.isFold;
              widget.controller.update();
            },
            child: Container(
              height: 24.w,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
              ),
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.04)
                    : Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  Row(
                    children: [
                      ImageView(
                        "assets/images/icon/up.png",
                        width: 14.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        LocaleKeys.discount_odd_odds_value_increase.tr ,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize:TyTextScaler.instance().scale(12.sp,addSize: 1),
                            fontFamily: 'PingFang SC',
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.8999999761581421)
                                : const Color(0xff303442),
                            height: 1),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.discountOdd);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE95B5B),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.80, color: Colors.white),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 3.20,
                                offset: Offset(0, 1.60),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: Transform.translate(
                                        // 数字向下偏移0.5px
                                        offset: Offset(0, 0.5),
                                        child: Text(
                                          '$count',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: TyTextScaler.instance().scale(12.sp, addSize: 1),
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 3,
                                                color: Color(0xFF000000).withValues(alpha: 0.25),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '+',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: TyTextScaler.instance().scale(12.sp, addSize: 1),
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 3),
                                            blurRadius: 3,
                                            color: Color(0xFF000000).withValues(alpha: 0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                  SizedBox(width: 15.w,),
                  GestureDetector(
                    onTap: () {
                      // if(controller.homeState.sportId=="102") {
                      //   // 篮球赔率优惠页面
                      //   Get.toNamed(Routes.basketballAppreciationOddsPage);
                      // }else{
                      //   Get.toNamed(Routes.discountOdd);
                      // }
                      Get.toNamed(Routes.discountOdd)?.then((_){
                        widget.controller.homeState.isHot =  BoolKV.sort.get() ?? true;;
                        widget.controller.update();

                      });
                    },
                    child: Container(
                      height: 20.w,
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? Color(0xff179CFF).withValues(alpha:0.2)
                            : const Color(0xffD1EBFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          left: 6.w,
                          right: 4.w,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.discount_odd_all_odds.tr + "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Color(0xff127DCC)
                                    : const Color(0xFF179CFF),
                                fontSize: TyTextScaler.instance().scale(12.sp,addSize: 1),
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.controller.homeState.isFold
              ? SizedBox.shrink()
              : Container(
            width: 1.sw,
            // height: isIPad ?110.w :115,
            height: 115.w,
            ///优惠盘口列表
            child: Stack(
              children: [
                ListView.builder(
                  // padding: EdgeInsets.symmetric(horizontal: 5), // 给两边按钮留出空间
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    itemCount: discountOddBeans.length > maxDiscountCardCount
                        ? maxDiscountCardCount
                        : discountOddBeans.length,
                    itemBuilder: (BuildContext context, int i) {
                      DiscountOddBean discount = discountOddBeans[i];
                      MatchEntity matchEntity = discount.matchEntity;
                      MatchEntity match = matchEntity;
                      String hpn = discount.hps.hpn;
                      var valueol = discount.ol;
                      String ot = valueol.otv;

                      ///优惠赔率背景
                      String imageName = '';
                      ///足球图片
                      if(["1"].contains(match.csid)){
                        imageName = 'football';
                      }else if(["2"].contains(match.csid)){
                        ///篮球图片
                        imageName = 'baskball';
                      }
                      String number= "${["zh","hk","tw"].contains(getLang())?"已受":""}${widget.controller.getOddCountBeanEntity(discount.ol.oid)?.orderCountAlias??0}k ${LocaleKeys.league_search_odd_promotion_count.tr}";
                      if(["vi"].contains(getLang())){
                        number= "Đã ${widget.controller.getOddCountBeanEntity(discount.ol.oid)?.orderCountAlias??0}k cược";
                      }
                      return Container(
                        width: _cardWidth,
                        decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha:0.04)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12.r)),
                        margin: EdgeInsets.symmetric(
                            vertical: 4.w, horizontal: _cardMargin),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Visibility(
                                visible:imageName.length != 0,
                                child: ImageView(
                                  boxFit: BoxFit.fill,
                                  Get.isDarkMode
                                      ? 'assets/images/$imageName-dark.png'
                                      : 'assets/images/$imageName-light.png',
                                  // width: 100,
                                  height: double.maxFinite,
                                  // width: 0.66.sw,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.w, horizontal: 10.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [

                                      ///  4325需求--------
                                      LogoPlaceholderWidget(
                                          imageUrl: matchEntity.lurl,
                                          width: 16.w,
                                          height: 16.w,
                                          base64Placeholder: 'placeholder_team.base64',
                                          cdn: true
                                      ),

                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      ///------------------ 4325需求

                                      Expanded(
                                        child: Text(
                                          "*" + match.tn,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:  TyTextScaler.instance().scale(13,addSize: 1),
                                              overflow: TextOverflow.ellipsis,

                                              fontFamily: 'PingFang SC',
                                              color: context.isDarkMode
                                                  ? Colors.white.withValues(alpha:
                                              0.8999999761581421)
                                                  : const Color(0xff303442),
                                              height: 1),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ImageView(
                                            'assets/images/home/activity_fire.png',
                                            width: 10.w,
                                            height: 10.w,
                                            cdn: true,
                                            errorWidget: ImageView(
                                              'assets/images/home/home_team_logo.svg',
                                              width: 10.w,
                                              height: 10.w,
                                            ),
                                          ),

                                          Text(
                                            number,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:  TyTextScaler.instance().scale(11,addSize: 1),
                                                fontFamily: 'PingFang SC',
                                                color:const Color(0xffE5B262),


                                                height: 1),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.w,),

                                  SizedBox(
                                    height: 5.w,
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        // crossAxisAlignment:
                                        // CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(child:
                                          GestureDetector(
                                            onTap: (){
                                              toMatchDetail(match);
                                            },
                                            child: Row(
                                              children: [
                                                ImageView(
                                                  // 'assets/images/home/home_team_logo.svg'
                                                  (match.mhlu as List).safeFirst ==
                                                      "" ||
                                                      (match.mhlu as List)
                                                          .safeFirst ==
                                                          null
                                                      ? 'assets/images/home/home_team_logo.svg'
                                                      : (match.mhlu as List).safeFirst,
                                                  width: 14.w,
                                                  height: 14.w,
                                                  cdn: true,
                                                  errorWidget: ImageView(
                                                    'assets/images/home/home_team_logo.svg',
                                                    width: 14.w,
                                                    height: 14.w,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    match.mhn,
                                                    style: TextStyle(
                                                      // color: mhnColor,
                                                      fontSize: TyTextScaler.instance().scale(12,addSize: 1),
                                                      fontFamily: 'PingFang SC',
                                                      fontWeight: FontWeight.w400,
                                                      // height: 1
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                              ],
                                            ),
                                          )
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              hpn,
                                              style: TextStyle(
                                                // color: mhnColor,
                                                  color: context.isDarkMode
                                                      ? Colors.white
                                                      .withValues(alpha:0.5)
                                                      : Colors.grey,
                                                  fontSize: TyTextScaler.instance().scale(11,addSize: 1),
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                  overflow: TextOverflow.ellipsis,
                                                  height: 1),
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 6,),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            ///跳转详情
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: (){
                                                toMatchDetail(match);
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  ImageView(
                                                    // 'assets/images/home/away_team_logo.svg',
                                                    (match.malu as List).safeFirst ==
                                                        "" ||
                                                        (match.malu as List)
                                                            .safeFirst ==
                                                            null
                                                        ? 'assets/images/home/away_team_logo.svg'
                                                        : (match.malu as List).safeFirst,
                                                    width: 14.w,
                                                    height: 14.w,
                                                    cdn: true,
                                                    errorWidget: ImageView(
                                                      'assets/images/home/away_team_logo.svg',
                                                      width: 14.w,
                                                      height: 14.w,
                                                    ),

                                                  ),

                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      match.man,
                                                      style: TextStyle(
                                                        // color: mhnColor,
                                                          fontSize: TyTextScaler.instance().scale(12,addSize: 1),
                                                          fontFamily: 'PingFang SC',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1),
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 200.w,
                                            ),
                                            child: Text(
                                              ot,
                                              style: TextStyle(
                                                // color: mhnColor,
                                                  color: context.isDarkMode
                                                      ? Color(0xff127DCC)
                                                      : Colors.lightBlueAccent,
                                                  fontSize: TyTextScaler.instance().scale(12,addSize: 1),
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                  overflow: TextOverflow.ellipsis,
                                                  height: 1),
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:   Padding(padding: EdgeInsets.only(left: 0.w,top: 4.w),child: Text(
                                          DateUtil.formatDateMs(
                                              TimeZoneUtils.convertTimeToTimestamp(match.mgt,
                                                  isMilliseconds: true,
                                                  returnMilliseconds:true)?? 0, format: isZh() ?
                                          LocaleKeys.time11.tr : LocaleKeys.time4.tr,   isUtc: true)+"("+TimeZoneUtils.getTimeZoneString()+")",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            overflow: TextOverflow.ellipsis,
                                            color: context.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xffAFB3C8),
                                          ),
                                        ),),),
                                      GestureDetector(
                                        onTap: (){
                                          ///列表优惠赔率进行投注
                                          addBet(discount,valueol,match);
                                        },
                                        behavior: HitTestBehavior.translucent,
                                        child:    DiscountOddsWidget(
                                          ol: discount.ol,
                                          match: match,
                                          hps: discount.hps,
                                          hl: discount.hl!,
                                          fullscreen: false,
                                          selected: false,
                                          ishomeList: true,
                                          // status: status,
                                          status2: 0,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                      //   }
                      // );
                    }),
                /// 左滑按钮
                Visibility(
                  ///当优惠赔率数量大于1时才显示左右滑动按钮
                  visible: discountOddBeans.length > 1,
                  child: Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _scrollLeft,
                        child: ImageView(
                          leftArrowUrl,
                          width: 16.w,
                          height: 35.h,
                        ),
                      ),
                    ),
                  ),
                ),
                /// 右滑按钮
                Visibility(
                  ///当优惠赔率数量大于1时才显示左右滑动按钮
                  visible: discountOddBeans.length > 1,
                  child: Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _scrollRight,
                        child: ImageView(
                          rightArrowUrl,
                          width: 16.w,
                          height: 35.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  ///列表优惠赔率 跳转详情
  void toMatchDetail(MatchEntity match){
    RouteManager.goMatchDetail(
        mid: match.mid,
        csid: match.csid,
        cid: ADDED_ODDS_CATEGORY_ID,
    );
  }
  ///列表优惠赔率 投注
  void addBet( DiscountOddBean discount,MatchHpsHlOl valueol,MatchEntity match){
    MatchHps hps = discount.hps;
    MatchHpsHl? hl = discount.hl;
    MatchHpsHlOl? ol = valueol;
    OddsButtonState state = OddsUtil.betState(
        match.mhs, hl!.hs, ol, hps.hsw,
        csid: match.csid);
    if (state == OddsButtonState.lock) {
      return;
    }
//TODO 投注
    ShopCartController.to
        .addBet(match, hps, hl, ol);
  }

  ///列表优惠赔率卡片 左滑动
  void _scrollLeft() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final target = (_scrollController.offset - (_cardWidth + _cardMargin * 2)).clamp(0.0, maxScroll);
    _scrollController.animateTo(
      target,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  ///列表优惠赔率卡片 右滑动
  //  void _scrollRight() {
  //   WidgetsBinding.instance.addPostFrameCallback((_){
  //     final maxScroll = _scrollController.position.maxScrollExtent;
  //     final target = (_scrollController.offset + (_cardWidth + _cardMargin * 2)).clamp(0.0, maxScroll);
  //     _scrollController.animateTo(
  //       target,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.ease,
  //     );
  //   });
  //  }

  void _scrollRight() {
    final double newOffset = _scrollController.offset + (_cardWidth + _cardMargin * 2);
    final double maxOffset = _scrollController.position.maxScrollExtent;
    final double target = newOffset.clamp(0.0, maxOffset);
    try {
      _scrollController.jumpTo(target);
    } catch (e) {
      print("ScrollController error: $e");
    }
  }
}
