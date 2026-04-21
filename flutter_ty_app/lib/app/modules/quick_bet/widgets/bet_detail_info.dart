import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../core/format/common/module/format-currency.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/utils.dart';
import '../../../utils/vr_rank_icon_utils.dart';
import '../../login/login_head_import.dart';
import '../../shop_cart/shop_cart_util.dart';
import '../quick_bet_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-0ff385d2-90ba-4fd9-bd7f-068a85286ade 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注弹窗-业务逻辑 】】】
    【【【 AUTO_PARAGRAPH_TITLE 主控制器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注详情

    】】】
 *
 */
class BetDetailInfo extends StatefulWidget {
  const BetDetailInfo({super.key, required this.item});

  final BetResultOrderDetailRespList item;

  @override
  State<BetDetailInfo> createState() => _BetDetailInfoState();
}

class _BetDetailInfoState extends State<BetDetailInfo> {
  @override
  Widget build(BuildContext context) {
    double betMoney = (double.tryParse(widget.item.betMoney) ?? 0.0) / 100;
    double maxWinMoney =
        (double.tryParse(widget.item.maxWinMoney) ?? 0.0) / 100;
    String marketType = getMarketType();
    String matchType = getMatchType();
    // print(widgets.item);
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF303442),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 4,
                        children: [
                          if (matchType.isNotEmpty)
                            Text(
                              matchType,
                              style: TextStyle(
                                color: const Color(0xFF127DCC),
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(
                            widget.item.playName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.90),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (marketType.isNotEmpty)
                            Text(
                              marketType,
                              style: TextStyle(
                                color: const Color(0xFF127DCC),
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      if ([Routes.vrSportDetail, Routes.vrHomePage]
                              .contains(Get.currentRoute) &&
                          ShopCartUtilHandicap.isVrRankHandicap(widget.item.sportId,widget.item.playId))
                        _buildVrHandicap(widget.item.sportId,widget.item)
                      else
                        Text(
                          widget.item.matchInfo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.90),
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (TyHomeController.to.homeState.menu.isChampion==false)

                      Text(
                        widget.item.matchName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.90),
                          fontSize: 12,
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              LocaleKeys.bet_bet_val.tr, // 投注金额
                              style: TextStyle(
                                color: Colors.white.withValues(
                                    alpha: 0.50) /* text-color-text-subtle */,
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        TYFormatCurrency.formatCurrency(betMoney),
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.90) /* text-color-text */,
                          fontSize: 16,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            // 可赢金额
                            Text(
                              LocaleKeys.app_h5_bet_win_amount.tr,
                              style: TextStyle(
                                color: Colors.white.withValues(
                                    alpha: 0.50) /* text-color-text-subtle */,
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        TYFormatCurrency.formatCurrency(maxWinMoney),
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.90) /* text-color-text */,
                          fontSize: 16,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            // 单号
                            Text(
                              LocaleKeys.app_order_number.tr,
                              style: TextStyle(
                                color: Colors.white.withValues(
                                    alpha: 0.50) /* text-color-text-subtle */,
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.item.orderNo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.90) /* text-color-text */,
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    QuickBetController.to.expandOrderNo.value = "";
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF127DCC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.app_h5_bet_bet_confirm.tr, // 注单已确认
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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

  String getMatchType() {
    String matchType = "";
    int chType = widget.item.matchType;
    if (chType == 1) {
      matchType = LocaleKeys.matchtype_1.tr;
    } else if (chType == 2) {
      matchType = LocaleKeys.new_menu_1.tr;
    } else if (chType == 3) {
      matchType = LocaleKeys.new_menu_4.tr;
    }
    if (matchType.isEmpty) return '';
    return '[$matchType]';
  }

  String getMarketType() {
    String marketType = '';
    String keType = widget.item.marketType;
    marketType = getOrderMarketType(keType);
    if (marketType.isNotEmpty) {
      marketType = '[' + marketType + ']';
    }
    return marketType;
  }

  _buildVrHandicap(String csid,BetResultOrderDetailRespList item) {
    List<String> handicapHvArray = item.playOptionName.split('/');
    if (handicapHvArray.length == 1) {
      handicapHvArray = [item.oldHandicapHv];
    }
    final handicapArray = item.handicap.split(',');
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
              getIconByRankIndex(csid,int.tryParse(hv) ?? 1002),
              width: 16,
            ),
          SizedBox(width: 2),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: (Get.isDarkMode)
                    ? Colors.white.withValues(alpha: 0.3)
                    : const Color(0xFFAFB3C8),
                fontSize: isIPad ? 14 : 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
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

  ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
  String getIconByRankIndex(String? csid, int index){
    String icon =   VrRankIconUtils.getRankIcon(int.tryParse(csid ?? '1002') ?? 1002,index.toString());
    if(icon.isEmpty){
      icon = 'assets/images/vr/vr_dog_horse_rank$index.png';
    }
    return icon;
  }
}
