import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';

import '../controllers/pin_controller.dart';

class PinWidget extends StatelessWidget {
  const PinWidget(
      {super.key,
      this.matchEntity,
      required this.isLeague,
      this.width,
      this.tid,
      this.isNoob = false,
      this.isDjInCommon = false});

  final MatchEntity? matchEntity;
  final String? tid;
  final bool isLeague;
  final bool isNoob;
  final double? width;
  //是否是常规列表里的电竞联赛/赛事，请求参数需添加matchType:1
  final bool isDjInCommon;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(builder: (logic) {
      bool isPin = false;
      if (isLeague) {
        isPin = logic.isLeaguePin(tid?.toInt() ?? 0);
      } else {
        isPin = logic.isMatchPin(matchEntity!);
      }

      String imgPath =
          isNoob ? 'assets/images/noob_no_pin.png' : 'assets/images/no_pin.png';
      if (isPin) {
        imgPath =
            isNoob ? 'assets/images/noob_pin.png' : 'assets/images/pin.png';
      } else {
        imgPath = isNoob
            ? 'assets/images/noob_no_pin.png'
            : 'assets/images/no_pin.png';
      }

      return InkWell(
        onTap: () {
          if (isLeague) {
            logic.toggleLeaguePin(tid!,isDjInCommon:isDjInCommon);

            // 点击将该赛事置顶埋点
            Analytics.track(AnalyticsEvent.btn_pin_top_1, pagePath: '', clickTarget: (AnalyticsEvent.btn_pin_top_1).toString());
          } else {
            // 点击将该赛事置顶埋点
            Analytics.track(AnalyticsEvent.btn_pin_top_2, pagePath: '', clickTarget: (AnalyticsEvent.btn_pin_top_2).toString());

            logic.toggleMatchPin(matchEntity!,isDjInCommon:isDjInCommon);
          }
        },
        child: ImageView(
          imgPath,
          width: width ?? 14.w,
          height: width ?? 14.w,
          onTap: () {
            if (isLeague) {
              logic.toggleLeaguePin(tid!,isDjInCommon:isDjInCommon);
            } else {
              logic.toggleMatchPin(matchEntity!,isDjInCommon:isDjInCommon);
            }
          },
        ).paddingSymmetric(horizontal: 10),
      );
    });
  }
}
