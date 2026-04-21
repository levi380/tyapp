import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import '../../../../main.dart';
import '../../login/login_head_import.dart';
import 'handicap_information_view.dart';
import 'information_line_view.dart';
import 'information_single_together_view.dart';
import 'information_vr_icon_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(已结算)串关列表控件视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示与单场赛事相关的市场价值、赔率、玩法、分数基准等信息。
    - 构造函数
    - `SingleTogetherView`：接收多个参数以初始化组件，包括：
    - `marketValue`：市场价值。
    - `oddFinally`：最终赔率。
    - `playName`：玩法名称。
    - `scoreBenchmark`：分数基准。
    - `matchInfo`：比赛信息。
    - `settleScore`：结算分数（可选）。
    - `betResult`：投注结果（可选）。
    - `sportName`：体育名称。
    】】】
 *
 */

class SingleTogetherSettledView extends StatelessWidget {
  const SingleTogetherSettledView({
    Key? key,
    required this.height,
    required this.marketValue,
    required this.oddFinally,
    required this.eov,
    required this.scoreBenchmark,
    required this.betResultColor,
    required this.playName,
    required this.matchName,
    required this.matchInfo,
    required this.settleScore,
    required this.betResult,
    required this.sportName,
    this.vrRankIconUrl = const [],
  }) : super(key: key);
  final String marketValue,
      oddFinally,
      eov,
      matchName,
      playName,
      scoreBenchmark,
      matchInfo,
      settleScore,
      betResult,
      sportName;

  final List<String> vrRankIconUrl;

  final bool betResultColor;
  final int height;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: height.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ///vr图标Widget
                if (vrRankIconUrl.isNotEmpty)
                  InformationVrIconView(vrIcons: vrRankIconUrl),
                Expanded(
                  child: Text(
                    marketValue,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xFF303442),
                      fontSize: isIPad ? 16.sp : 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                HandicapInformationView(
                  oddFinally: oddFinally,
                  eov: eov,
                ),
              ],
            ).marginOnly(left: 5.w).expanded(flex: 9),
            InformationLineView(
              top: 0,
              information: playName,
              multiLine: false,
              Type: 0,
            ).expanded(flex: 9),
            ///判断是不是有下注比分
            if (scoreBenchmark.isNotEmpty)
              InformationLineView(
                top: 0,
                information: scoreBenchmark,
                Type: 0,
              ).marginOnly(left: 5.w).expanded(flex: 9),
            ///判断是不是有比赛结果比分
            if (settleScore.isNotEmpty)
              InformationSingleTogetherView(
                top: 0,
                information: settleScore,
                outcome: betResult,
                InformationColorType: betResultColor ? 3 : 0,
              ).marginOnly(left: 5.w).expanded(flex: 12),

            ///比赛队伍信息
            _matchInformation().marginOnly(left: 5.w).expanded(flex: 10),

              ///比赛赛事信息
              InformationLineView(
                top: 0,
                Type: 1,
                information: matchName,
              ).marginOnly(left: 5.w).expanded(flex: 10),

            //  InformationLineView(
            //    top: 0,
            //    multiLine: false,
            //    information: sportName,
            //  ).marginOnly(left: 5.w).expanded(flex: 1),
          ],
        ),
    );
  }

  ///当没有结果比分的时候换一种样式展示
  Widget _matchInformation() {
    if (settleScore.isNotEmpty) {
      return InformationLineView(
        top: 0,
        information: matchInfo,
        Type: 1,
        multiLine: false,
      );
    } else {
      return InformationSingleTogetherView(
        top: 0,
        titleColorType: 1,
        information: matchInfo,
        outcome: betResult,
        InformationColorType: betResultColor ? 3 : 0,
      );
    }
  }
}
