import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/odds_util.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../global/data_store_controller.dart';

/// 优惠赔率
class DiscountOddsWidget extends StatefulWidget {
  const DiscountOddsWidget({
    super.key,
    required this.ol,
    required this.match,
    required this.hps,
    required this.hl,
    required this.fullscreen,
    this.status = 0,
    this.status2 = 0,
    required this.selected,
    this.ishomeList = false,
  });

  final MatchHpsHlOl ol;
  final MatchEntity match;
  final MatchHps hps;
  final MatchHpsHl hl;
  final bool fullscreen;
  final int status;
  final int status2;
  final bool selected;
  final bool ishomeList;
  @override
  State<DiscountOddsWidget> createState() => _DiscountOddsWidgetState();
}

class _DiscountOddsWidgetState extends State<DiscountOddsWidget> {
  @override
  Widget build(BuildContext context) {

    DataStoreController dataController = DataStoreController.to;
    return  GetBuilder<DataStoreController>(
        id: dataController.getOid(widget.ol.oid),
        builder: (controller) {
          // AppLogger.debug("数据仓库 = " + widgets.ol.oid);
          MatchHpsHlOl ol = DataStoreController.to.getOlById(
              widget.ol.oid) ?? widget.ol;
          _oddsChange(ol);

          return
            Column(children:
            _buildContent(ol)
              ,);
        });
  }

  _buildContent(MatchHpsHlOl ol) {
    OddsButtonState state = OddsUtil.betState(
        widget.match.mhs, widget.hl.hs, ol, widget.hps.hsw,
        csid: widget.match.csid);
    if (state == OddsButtonState.lock) {
      return _buildLock(ol);
    } else if (state == OddsButtonState.open) {
      return <Widget>[
        // _buildOddsName(ol),
        // 赔率值
        _buildOddsValue(ol),
      ];
    } else {
      return _buildLock(ol);
    }
  }

  /// 赔率名称
  Widget _buildOddsName(MatchHpsHlOl ol) {
    String name = "";
    String fei = OddsUtil.fei(ol, widget.hps);
    if (fei.isNotEmpty) {
      name += "$fei ";
    }

    String olName = OddsUtil.olName(ol, widget.hps, widget.match);
    name += olName;
    double sFontSize = widget.fullscreen
        ? 12
        : isIPad
        ? 16.sp
        : 12.sp;
    // if (['my'].contains(Get.locale?.languageCode)) {
    if (OddsUtil.isBurmese(name)) {
      sFontSize = widget.fullscreen
          ? 10
          : isIPad
          ? 14.sp
          : 8.sp;
    }
    // String otvName = OddsUtil.olOtvName(ol);
    return Text(
      // widgets.name ?? (ObjectUtil.isEmptyString(ol.on) ? ol.onb : ol.on),
      name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: sFontSize,
        color: widget.selected
            ? widget.fullscreen
            ? Colors.white.withValues(alpha:0.9)
            : Get.theme.addedOddsButtonNameFontColor
            : widget.fullscreen
            ? Colors.white.withValues(alpha:0.3)
            : Get.theme.addedOddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
        fontFamily: "PingFang SC",
      ),
    );
  }

  /// 赔率值
  Widget _buildOddsValue(MatchHpsHlOl ol) {
    double detailFontSize = widget.fullscreen ? 15 : (isIPad ? 18.sp : 15.sp);
    if (['my'].contains(Get.locale?.languageCode)) {
      detailFontSize = widget.fullscreen ? 13 : (isIPad ? 17.sp : 13.sp);
    }

    String oddsValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
        ol.ov,
        ol.ov2,
        widget.hps.hpid,
        widget.hps.hsw.split(','),
        int.tryParse(widget.match.csid) ?? 0,
        ol.cds
    );

    String dovValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
        ol.dov,
        ol.ov2,
        widget.hps.hpid,
        widget.hps.hsw.split(','),
        int.tryParse(widget.match.csid) ?? 0,
        ol.cds
    );
    // if (oddsValue == "") {
    //   // 赔率值空值封盘
    //   return _lockImage();
    // }
    return   Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(widget.ishomeList)
        Text(
          "@",
          maxLines: 1,
          style: TextStyle(
            fontSize: detailFontSize,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.9)
                : const Color(0xFF303442),
            fontWeight: FontWeight.w400,
            fontFamily: "PingFang SC",
            height: 0.9
          ),
        ).marginOnly(right: widget.fullscreen ? 2 : 2.w),

        Text(
          oddsValue,
          maxLines: 1,
          style: TextStyle(
              fontSize: detailFontSize,
              // 红升绿降
              color: status == 0
                  ? (widget.selected
                  ? widget.fullscreen
                  ? (widget.ishomeList ?Colors.white.withValues(alpha:0.9)   :Colors.white.withValues(alpha:0.5))
                  : (widget.ishomeList ?const Color(0xFFAFB3C8)   :Colors.white.withValues(alpha:0.5))

                  : widget.fullscreen
                  ? (widget.ishomeList ?Colors.white.withValues(alpha:0.9)   :Colors.white.withValues(alpha:0.5))
                  : (widget.ishomeList ?const Color(0xFFAFB3C8)   :Colors.white.withValues(alpha:0.5))

              )
                  : status == 10
                  ? const Color(0xFFE95B5B)
                  : const Color(0xFF4AB06A),
              fontWeight: FontWeight.w600,
              fontFamily: "Akrobat",
              decoration: TextDecoration.lineThrough),
        ),
        ImageView(
          "assets/images/discount_odd/arrow_right.png",
          width: widget.fullscreen ? 10 : 10.w,
        ).marginOnly(left: widget.fullscreen ? 2 : 2.w),
        Text(
          dovValue,
          maxLines: 1,
          style: TextStyle(
            fontSize: detailFontSize,
            // 红升绿降
            color: status2 == 0
                ? (widget.selected
                ? widget.fullscreen
                ? Color(0xFF127DCC)
                : (widget.ishomeList ? const Color(0xFF179CFF) : Colors.white)
                : widget.fullscreen
                ? Color(0xFF127DCC)
                :  (widget.ishomeList ? const Color(0xFF179CFF) : Colors.white))
                : status2 == 10
                ? const Color(0xFFE95B5B)
                : const Color(0xFF4AB06A),
            // color: (widget.selected
            //     ? widget.fullscreen
            //         ? Color(0xFF127DCC)
            //         : Get.theme.addedOddsButtonValueFontColor
            //     : widget.fullscreen
            //         ? Color(0xFF127DCC)
            //         : Get.theme.addedOddsButtonValueFontColor),
            fontWeight: FontWeight.w600,
            fontFamily: "Akrobat",
          ),
        ).marginOnly(
            left: widget.fullscreen ? 2 : 2.w,
            right: widget.fullscreen ? 2 : 2.w),

        ArrowWidget()
      ],
    ).marginOnly(
      left: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
      // right: (widgets.fullscreen ? 10 : (isIPad ? 15.w : 10.w))
    );
  }

  _buildLock(MatchHpsHlOl ol) {
    return <Widget>[
      // 赔率名称 详情页并且csid!=1 vr体育锁盘不展示赔率项名称

      Visibility(
        visible:(widget.match.csid != "1" && Get.currentRoute != Routes.vrSportDetail && widget.ishomeList == false) ,
        child:   _buildOddsName(ol),),

      // 锁
      _lockImage()
    ];
  }

  // 锁
  _lockImage() {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: widget.fullscreen
          ? 16
          : isIPad
          ? 25
          : 16,
    );
  }

  ArrowWidget() {
    if (status == 10 || status2 == 10){
      return ImageView(
        'assets/images/detail/odds_up.svg',
        width: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
      );
    }else if(status == -10 || status2 == -10){
      return ImageView(
        'assets/images/detail/odds_down.svg',
        width: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
      );
    }else{
      return ImageView(
        "assets/images/icon/up.png",
        width: widget.fullscreen ? 16 : 16.w,
      );
    }
  }


  int status = 0; // 10 红升  -10绿降
  int status2 = 0; // 10 红升  -10绿降
  int oldOv = 0; // 记录旧赔率
  int oldDov = 0; // 记录旧赔率
  Timer? timer;
  Timer? timer2;
  /// 变赔处理
  void _oddsChange(MatchHpsHlOl ol) {
    // AppLogger.debug("数据仓库 =  ol.ov " +ol.ov.toString());
    // AppLogger.debug("数据仓库 =  oldOv " +oldOv.toString());
    if (ol.ov != oldOv) {
      // 变赔
      status = 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            if (oldOv != 0 && (ol.ov / 1000).ceil() > (oldOv / 1000).ceil()) {
              status = 10;
              oldOv = ol.ov;
            } else if (oldOv != 0 &&
                (ol.ov / 1000).ceil() < (oldOv / 1000).ceil()) {
              status = -10;
              oldOv = ol.ov;
            } else {
              status = 0;
              oldOv = ol.ov;
            }
          });
          // GlobalTimer.getInstance().push(OddsChangeTimerTask(
          //     id: ol.oid,
          //     seconds: 3,
          //     callback: () {
          //       if (mounted) {
          //         // 三秒后清除相关符号
          //         setState(() {
          //           status = 0;
          //         });
          //       }
          //     }));
          timer?.cancel();
          timer = Timer.periodic(const Duration(seconds: 3), (t) {
            if (mounted) {
              // 三秒后清除相关符号
              setState(() {
                status = 0;
                t.cancel();
              });
            }
          });
        }
      });
    }

    // AppLogger.debug("数据仓库 =  ol.dov " +ol.dov.toString());
    // AppLogger.debug("数据仓库 =  oldDov " +oldDov.toString());
    if (ol.dov != oldDov) {
      // 变赔
      status2 = 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            if (oldDov != 0 &&
                (ol.dov / 1000).ceil() > (oldDov / 1000).ceil()) {
              status2 = 10;
              oldDov = ol.dov;
            } else if (oldDov != 0 &&
                (ol.dov / 1000).ceil() < (oldDov / 1000).ceil()) {
              status2 = -10;
              oldDov = ol.dov;
            } else {
              status2 = 0;
              oldDov = ol.dov;
            }
          });
          timer2?.cancel();
          timer2 = Timer.periodic(const Duration(seconds: 3), (t) {
            if (mounted) {
              // 三秒后清除相关符号
              setState(() {
                status2 = 0;
                t.cancel();
              });
            }
          });
        }
      });
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

}
