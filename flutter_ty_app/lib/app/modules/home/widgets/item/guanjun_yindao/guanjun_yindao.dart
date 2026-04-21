import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/champion_odds_button.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../vr/vr_sport_detail/import_head.dart';

class GuanjunYindao extends StatelessWidget {
  GuanjunYindao({super.key, required this.tid, required this.mid});

  final MAX_ITEM_COUNT = 6;
  bool isExpand = true;
  final String mid;
  bool showMore = true;
  final String tid;

  Widget _buildHeader(BuildContext context, MatchEntity? match) {
    final matchHps = (match?.hps.isNotEmpty ?? false) ? match!.hps.first : null;
    if (matchHps == null) return SizedBox();
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.only(bottom: 2.w, top: 2.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
            // bottom: BorderSide(
            //   color: context.isDarkMode
            //       ? Colors.white.withValues(alpha:0.07999999821186066)
            //       : const Color(0xFFE4E6F0),
            //   width: 1,
            // ),
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   child: Text(
          //     matchHps!.hps,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       color: context.isDarkMode
          //           ? Colors.white.withValues(alpha:0.8999999761581421)
          //           : const Color(0xFF303442),
          //       fontSize: isIPad ? 14.sp.scale : 12.sp.scale,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),

          ///冠军引导盘头部
          Expanded(
            flex: 1,
            child: Row(
              children: [
                ImageView(
                  Get.locale?.languageCode == "zh"
                      ? 'assets/images/detail/outright_prefix.svg'
                      : 'assets/images/detail/outright_prefix_en.svg',
                  width: 15.w,
                ).marginOnly(right: 4.w),
                Expanded(
                  child: Text(
                    // match!.tn,
                    match?.tn ?? match?.onTn ?? "",
                    // MatchUtil.getOutrightDisplayMatchTn(match?.tn ?? match!.onTn),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12.sp.scale,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xff303442),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${DateUtil.formatDateMs(TimeZoneUtils.convertTimeToTimestamp(matchHps.hmed, isMilliseconds: true, returnMilliseconds: true),

                      ///冠军时间格式化
                      format: LocaleKeys.time7.tr, isUtc: true) + "(" + TimeZoneUtils.getTimeZoneString() + ")"}${LocaleKeys.match_main_cut_off.tr}' +
                  'dasdashdahskdhhash',
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.30000001192092896)
                    : const Color(0xFFAFB3C8),
                fontSize: isIPad ? 12.sp.scale : 10.sp.scale,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          /* !match.isExpand?Container():*/
          Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            child: ImageView(
              isExpand == true
                  ? context.isDarkMode
                      ? 'assets/images/league/item_expand_darkmode.png'
                      : 'assets/images/league/item_expand.png'
                  : context.isDarkMode
                      ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                      : 'assets/images/league/ico_arrowright_nor.png',
              width: 12.w,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TyHomeController controller = TyHomeController.to;
    MatchEntity? match = controller.homeState.outrightDisplayMap[tid];
    // AppLogger.debug("插入数据仓库 = 显示 = tid = "+tid.toString()+" match = "+ match.toString());

    if (match == null) {
      return Container();
    }

    double width = (Get.width - 26.w - 8.w) / 2;
    double height = 40.w;
    MatchEntity matchEntity =
        // logic.getMatchById(match.mid ?? "") ??
        match;
    MatchHps? matchHps = matchEntity.hps[0];
    String hid = matchHps.hid;
    isExpand = !FoldMatchManager.isFoldByHid(mid, hid);
    showMore = !FoldMatchManager.isFoldByHidMore(mid, hid);
    // AppLogger.debug("插入数据仓库 = isExpand =  "+ isExpand.toString());
    // AppLogger.debug("插入数据仓库 = showMore =  "+ showMore.toString());
    // AppLogger.debug("插入数据仓库 = 显示 =  "+ matchEntity.toString());
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  bool isFold = !isExpand;
                  FoldMatchManager.setFoldByHid(mid, hid, !isFold);
                  TyHomeController.to.update();
                },
                child: _buildHeader(context, matchEntity)),
            if (isExpand)
              GridView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.w,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: width / height,
                ),
                itemBuilder: (BuildContext context, int index) {
                  MatchHpsHlOl ol = matchHps.ol.elementAt(index);
                  return InkWell(
                      onTap: () {
                        ShopCartController.to.addBet(
                          matchEntity,
                          matchHps,
                          null,
                          matchHps.ol.elementAt(index),
                          betType: OddsBetType.guanjun,
                        );
                      },
                      child: ChampionOddsButton(
                        key: ValueKey(
                            ol.oid + matchHps.mid + matchHps.index.toString()),
                        match: matchEntity,
                        hps: matchHps,
                        ol: ol,
                        // fullscreen: fullscreen,
                        betType: OddsBetType.guanjun,
                        direction: OddsTextDirection.horizontal,
                      )
                      // BetButton(
                      //   width: width,
                      //   direction: BetButtonLayoutDirection.horizontal,
                      //   matchHpsHlOl: matchHps!.ol.elementAt(index),
                      // ),
                      );
                },
                itemCount: matchHps.ol.length > MAX_ITEM_COUNT
                    ? (isExpand && showMore
                        ? MAX_ITEM_COUNT
                        : matchHps.ol.length)
                    : matchHps.ol.length,
              ),
            SizedBox(
              height: 5.w,
            ),
            if (isExpand && showMore && (matchHps.ol.length) > MAX_ITEM_COUNT)
              GestureDetector(
                onTap: () {
                  // AppLogger.debug(" match!.isExpand  === "+ isExpand.toString() );
                  bool isFold = !showMore;
                  FoldMatchManager.setFoldByHidMore(mid, hid, !isFold);
                  TyHomeController.to.update();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(999)),
                  padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 7.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.footer_menu_more.tr,
                        style: TextStyle(
                          fontSize: 12.sp.scale,
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha: 0.9)
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 8.w,
                        height: 8.w,
                        alignment: Alignment.center,
                        child: ImageView(
                          color:
                              context.isDarkMode ? Colors.white : Colors.black,
                          context.isDarkMode
                              ? 'assets/images/league/item_expand_darkmode.png'
                              : 'assets/images/league/item_expand.png',
                          width: 12.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isExpand)
              SizedBox(
                height: 10.w,
              ),
          ],
        ),
      ),
    );
  }
}
