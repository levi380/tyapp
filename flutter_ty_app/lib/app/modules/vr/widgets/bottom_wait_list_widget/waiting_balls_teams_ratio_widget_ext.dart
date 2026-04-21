import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/bottom_wait_list_widget/widget/vr_common_odds_box.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../utils/odds_util.dart';
import 'waiting_balls_teams_ratio_widget.dart';
import '../../vr_sport_state.dart';

/// ------------------------------------------------------------
/// 单场 VR 赛事 Item
extension WaitingBallsTeamsRatioWidgetExt
on WaitingBallsTeamsRatioWidgetState {

  ///vr赛事Widget
  Widget buildTeam({
    required String teamLogoSrc,
    required String teamName,
    required Color textColor,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 0.w),
      child: Row(
        children: [
          ImageView(
            teamLogoSrc == '' ?
            VRSportState.defaultTeamLogo
                : teamLogoSrc,
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
            teamName,
            style: TextStyle(
              fontSize: 12.sp.scale,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatios({
    required MatchEntity match,
    required MatchHps? winAllHps,
    required MatchHps? fieldGoalHps,
    required MatchHps? fullFieldSizeHps,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final winAllHl = winAllHps?.hl.firstOrNull;
    final winAllOls = winAllHl?.ol ?? <MatchHpsHlOl>[];

    final fieldGoalHl = fieldGoalHps?.hl.firstOrNull;
    final fieldGoalOls = fieldGoalHl?.ol ?? <MatchHpsHlOl>[];

    final fullFieldSizeHl = fullFieldSizeHps?.hl.firstOrNull;
    var fullFieldSizeOls = fullFieldSizeHl?.ol ?? <MatchHpsHlOl>[];
    fullFieldSizeOls = fullFieldSizeOls.reversed.toList();
    return Row(
      children: [
        Column(
          children: List.generate(
            winAllOls.length,
                (index) => _buildRatioItem(
              match: match,
              hps: winAllHps,
              hl: winAllHl,
              ol: winAllOls[index],
              onOlTap: onOlTap,
              heightFactor: winAllOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
        SizedBox(width: 2.w),
        Column(
          children: List.generate(
            fieldGoalOls.length,
                (index) => _buildRatioItem(
              match: match,
              hps: fieldGoalHps,
              hl: fieldGoalHl,
              ol: fieldGoalOls[index],
              onOlTap: onOlTap,
              heightFactor: fieldGoalOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
        SizedBox(width: 2.w),
        Column(
          children: List.generate(
            fullFieldSizeOls.length,
                (index) => _buildRatioItem(
              match: match,
              hps: fullFieldSizeHps,
              hl: fullFieldSizeHl,
              ol: fullFieldSizeOls[index],
              onOlTap: onOlTap,
              heightFactor: fullFieldSizeOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
      ],
    );
  }

  Widget _buildRatioItem({
    required MatchEntity? match,
    required MatchHps? hps,
    required MatchHpsHl? hl,
    required MatchHpsHlOl? ol,
    double heightFactor = 1,
    EdgeInsetsGeometry? margin,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final bool isSelected = selOls.values.contains(ol);

    final olOvStr = TYFormatOddsConversionMixin.computeValueByCurOddType(
        ol?.ov ?? 0,
        ol?.ov2,
        hps?.hpid ?? '',
        hps?.hsw.split(',') ?? [],
        int.tryParse(match?.csid ?? '0') ?? 0,
        ol?.cds ?? ''
    );
    return Container(
      margin: margin,
      child: VrCommonOddsBox(
        onTap: () {
          if (widget.lockOdds) return;
          if (match != null && hps != null && hl != null && ol != null) {
            OddsButtonState state = OddsUtil.betState(
                match.mhs, hl.hs, ol, hps.hsw,
                csid: match.csid);
            if (state == OddsButtonState.open) {
              onOlTap?.call(ol);
              ShopCartController.to.addBet(
                  match,
                  hps,
                  hl,
                  ol,
                  betType: OddsBetType.vr,
                  vrNo: widget.vrMatch.no
              );
            }
          }
        },
        width: 200,
        height: 35.w * heightFactor,
        ol: ol,
        childBuilder: (isSelected) {
          if (widget.lockOdds) {
            return Icon(
              Icons.lock,
              color: '#AFB3C8'.hexColor,
              size: 20,
            ).center;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ol?.on ?? '',
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
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ol?.on ?? '',
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
      ),
    );
  }

// 锁
  buildLock() {
    return ImageView(
      VRSportState.matchIconLock,
      width: 16.w,
      height: 16.w,
    );
  }
}
