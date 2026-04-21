import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_sport_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/bottom_wait_list_widget/widget/vr_common_odds_box.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';

import '../../../../../main.dart';
import '../../../../utils/odds_util.dart';
import 'waiting_balls_teams_ratio_widget_ext.dart';
import '../../vr_sport_state.dart';

/// VR 篮球 / 足球 等待中底部盘口 Widget
class WaitingBallsTeamsRatioWidget extends StatefulWidget {
  const WaitingBallsTeamsRatioWidget({
    super.key,
    required this.type,
    required this.vrMatch,
    required this.lockOdds,
  });

  /// 1 足球 2 篮球
  final int type;

  /// VR 赛事数据
  final VrMatchEntity vrMatch;

  /// 是否锁盘
  final bool lockOdds;

  @override
  State<WaitingBallsTeamsRatioWidget> createState() =>
      WaitingBallsTeamsRatioWidgetState();
}

class WaitingBallsTeamsRatioWidgetState
    extends State<WaitingBallsTeamsRatioWidget> {

  /// 当前已选中的赔率（index -> ol）
  /// TODO：后续可考虑收敛到 Controller 或 MatchEntity 中
  final Map<int, MatchHpsHlOl?> selOls = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.vrMatch.matchs.length,
            (index) => buildMatchItem(
          widget.vrMatch.matchs[index],
          index: index,
          onOlTap: (ol) {
            /// 只有串关模式才记录选中态
            if (ShopCartController.to.currentBetController
            is! VrMixBetController) return;

            selOls[index] = ol;
            if (mounted) setState(() {});
          },
        ),
      ),
    );
  }


  Widget buildMatchItem(
      MatchEntity match, {
        ValueChanged<MatchHpsHlOl?>? onOlTap,
        int? index,
      }) {
    final hpns = widget.vrMatch.hpns;

    /// 胜负盘
    final winAllHps = hpns.isNotEmpty
        ? match.hps.firstWhereOrNull((e) => e.hpn == hpns[0])
        : null;

    /// 让分盘
    final fieldGoalHps = hpns.length >= 2
        ? match.hps.firstWhereOrNull((e) => e.hpn == hpns[1])
        : null;

    /// 大小盘
    final fullFieldSizeHps = hpns.length >= 3
        ? match.hps.firstWhereOrNull((e) => e.hpn == hpns[2])
        : null;

    /// 是否专业版
    late bool isProfess;
    try {
      isProfess = TyHomeController.to.homeState.isProfess;
    } catch (_) {
      isProfess = true;
    }

    return GestureDetector(
      onTap: () {
        /// 跳转 VR 赛事详情
        Get.toNamed(
          Routes.vrSportDetail,
          arguments: {
            'vrMatch': widget.vrMatch,
            'match': match,
            'isBalls': widget.type <= 2,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: index != 0
                  ? Get.isDarkMode
                  ? Colors.white.withValues(alpha: 0.08)
                  : AppColor.dividerColorLight
                  : Colors.transparent,
            ),
          ),
        ),
        child: Column(
          children: [
            buildTotalGuessEntrance(match.mc, isProfess),
            isProfess
                ? buildTeamsAndRatios(
              match: match,
              teams: match.teams,
              malu: match.malu ?? '',
              mhlu: match.mhlu ?? '',
              winAllHps: winAllHps,
              fieldGoalHps: fieldGoalHps,
              fullFieldSizeHps: fullFieldSizeHps,
              onOlTap: onOlTap,
            )
                : buildBeginnerRatios(
              match,
              match.teams,
              match.mhlu,
              match.malu,
              winAllHps,
              onOlTap: onOlTap,
            ),
            SizedBox(height: 4.w),
          ],
        ),
      ),
    );
  }

  /// 总竞猜入口
  Widget buildTotalGuessEntrance(num mcCount, bool isProfess) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isProfess ? 22.w : 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$mcCount${mcCount > 0 ? '+' : ''}',
            style: TextStyle(
              fontSize: 10.sp.scale,
              color: Get.isDarkMode
                  ? AppColor.colorWhite.withValues(alpha: 0.3)
                  : '#AFB3C8'.hexColor,
            ),
          ),
          ImageView(
            VRSportState.vrArrowRight,
            width: 12.w,
            height: 12.w,
            color: Get.isDarkMode ? null : '#AFB3C8'.hexColor,
          ),
        ],
      ),
    );
  }
  
  /// 专业版：队伍 + 多盘口
  Widget buildTeamsAndRatios({
    required MatchEntity match,
    List<String> teams = const [],
    String malu = '',
    String mhlu = '',
    MatchHps? winAllHps,
    MatchHps? fieldGoalHps,
    MatchHps? fullFieldSizeHps,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(teams.length, (index) {
            /// 强弱队判断
            int result = MatchUtil.getHandicapIndexBy(match);

            Color mhnColor = result == 1
                ? const Color(0xff74c4ff)
                : context.isDarkMode
                ? Colors.white.withValues(alpha: 0.9)
                : const Color(0xFF303442);

            Color manColor = result == 2
                ? const Color(0xff74c4ff)
                : context.isDarkMode
                ? Colors.white.withValues(alpha: 0.9)
                : const Color(0xFF303442);

            return buildTeam(
              teamName: teams[index],
              textColor: index == 0 ? mhnColor : manColor,
              teamLogoSrc: index == 1 ? malu : mhlu,
            ).marginOnly(bottom: index == 0 ? 15 : 7);
          }),
        ).expanded(),
        buildRatios(
          match: match,
          winAllHps: winAllHps,
          fieldGoalHps: fieldGoalHps,
          fullFieldSizeHps: fullFieldSizeHps,
          onOlTap: onOlTap,
        ).expanded(),
      ],
    );
  }


  /// vr新手版 赔率样式
  Widget buildBeginnerRatios(
      MatchEntity match,
      List<String> teams,
      String mhlu,
      String malu,
      MatchHps? winAllHps, {
        ValueChanged<MatchHpsHlOl?>? onOlTap,
      }) {
    final winAllHl = winAllHps?.hl.firstOrNull;
    final winAllOls = winAllHl?.ol ?? <MatchHpsHlOl>[];
    // var mWidth = 200.0.w.ceil() * 1.0;

    ///公共组件 vr赛事队伍判断强弱
    int result = MatchUtil.getHandicapIndexBy(match);
    Color mhnColor = result == 1
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha:0.8999999761581421)
        : const Color(0xFF303442); //主队
    Color manColor = result == 2
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha:0.8999999761581421)
        : const Color(0xFF303442); //客队

    ///赛事颜色(添加强弱判断)
    // Color? textColor = index == 0 ? mhnColor : manColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  teams.firstOrNull ?? '',
                  style: TextStyle(
                    fontSize: 12.sp.scale,
                    color: mhnColor,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                ImageView(
                  mhlu == '' ?
                  VRSportState.defaultTeamLogo
                      : mhlu,
                  cdn: true,
                  width: 20.w,
                  height: 20.w,
                  errorWidget: ImageView(
                    VRSportState.defaultTeamLogo,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),

              ],
            ),
            Text(
              'VS',
              style: TextStyle(
                fontSize: 12.sp.scale,
                color: manColor,
              ),
            ).marginSymmetric(horizontal: 16.w),
            Row(
              children: [
                ImageView(
                  malu == '' ?
                  VRSportState.defaultTeamLogo
                      : malu,
                  cdn: true,
                  width: 20.w,
                  height: 20.w,
                  errorWidget: ImageView(
                    VRSportState.defaultTeamLogo,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  teams.lastOrNull ?? '',
                  style: TextStyle(
                    fontSize: 12.sp.scale,
                    color: manColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ).marginSymmetric(vertical: 4.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            winAllOls.length,
                (index) {
              final ol = winAllOls[index];
              final olOvStr =
              TYFormatOddsConversionMixin.computeValueByCurOddType(
                  ol.ov,
                  ol.ov2,
                  winAllHps?.hpid ?? '',
                  winAllHps?.hsw.split(',') ?? [],
                  int.tryParse(match.csid) ?? 0,
                  ol.cds
              );



              return VrCommonOddsBox(
                onTap: () {
                  if (widget.lockOdds) return;
                  if (winAllHps != null && winAllHl != null) {
                    OddsButtonState state = OddsUtil.betState(
                        match.mhs, winAllHl.hs, ol, winAllHps.hsw,
                        csid: match.csid);
                    if (state == OddsButtonState.open) {
                      onOlTap?.call(ol);
                      ShopCartController.to.addBet(
                          match,
                          winAllHps,
                          winAllHl,
                          ol,
                          betType: OddsBetType.vr,
                          vrNo: widget.vrMatch.no
                      );
                    }
                  }
                },
                padding: EdgeInsets.symmetric(vertical: 2.w),
                ol: ol,
                childBuilder: (isSelected) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 35.h,

                      ///新手版
                      minWidth: isIPad
                          ? (MediaQuery.of(context).size.width - 50.w) /
                          winAllOls.length
                          : 90.w,
                    ),
                    child: widget.lockOdds
                        ? Icon(
                      Icons.lock,
                      color: '#AFB3C8'.hexColor,
                      size: 20.w,
                    ).center
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ol.on,
                          style: TextStyle(
                            fontSize: 10.sp.scale,
                            color: isSelected
                                ? Get.isDarkMode
                                ? Colors.white
                                : '#127DCC'.hexColor
                                : '#AFB3C8'.hexColor,
                            height: 14 / 10,
                          ),
                        ),
                        olOvStr == ""
                            ? buildLock()
                            : Text(
                          olOvStr,
                          style: TextStyle(
                            fontSize: 12.sp.scale,
                            color: isSelected
                                ? Get.isDarkMode
                                ? Colors.white
                                : '#127DCC'.hexColor
                                : Get.isDarkMode
                                ? AppColor.colorWhite
                                : '#303442'.hexColor,
                            fontWeight: FontWeight.w700,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 32.w, minWidth: 90.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ol.on,
                        style: TextStyle(
                          fontSize: 10.sp.scale,
                          color: '#AFB3C8'.hexColor,
                          height: 14 / 10,
                        ),
                      ),
                      Text(
                        olOvStr,
                        style: TextStyle(
                          fontSize: 12.sp.scale,
                          color: Get.isDarkMode
                              ? AppColor.colorWhite
                              : '#303442'.hexColor,
                          fontWeight: FontWeight.w700,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ).marginOnly(left: index == 0 ? 0 : 2.w);
            },
          ),
        ),
        SizedBox(height: 2.w),
      ],
    );
  }
}
