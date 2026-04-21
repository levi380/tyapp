import 'dart:collection';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../main.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../logic/bold_util.dart';
import '../../../../logic/other_player_name_to_playid.dart';
import 'bodan_Item_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-06de67a4-485b-4b00-91a1-b8c4546e388e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 子玩法 】】】
    【【【 AUTO_PARAGRAPH_TITLE 波胆UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 波胆空数据填充
    - 波胆赔率数据填充
    】】】
 *
 */
MatchHpsHlOl? first;
MatchHpsHlOl? last;

bodanBuildGroud(MatchHps boldHps, int type, MatchEntity match, int maxLine,
    double btnHeight) {
  LinkedHashMap<int, MatchHpsTitle> map = LinkedHashMap();
  Map<int, List<MatchHpsHlOl>> olMap = {};
  boldHps.hl.safeFirst?.title.forEach((element) {
    map[element.otd] = element;
  });

  if (map.isEmpty) {
    map[1] = MatchHpsTitle()
      ..osn = match.mhn
      ..otd = 1;
    map[2] = MatchHpsTitle()
      ..osn = match.man
      ..otd = 2;

    map[0] = MatchHpsTitle()
      ..osn = '半场平局'
      ..otd = 0;
  }
  olMap = BoldUtil.getFromBoldMatchHps(boldHps);

  ///空数据填充
  if (olMap.isEmpty) {
    olMap[1] = [
      MatchHpsHlOl(),
      MatchHpsHlOl(),
      MatchHpsHlOl(),
    ];
    olMap[2] = [
      MatchHpsHlOl(),
      MatchHpsHlOl(),
      MatchHpsHlOl(),
    ];
    olMap[0] = [
      MatchHpsHlOl(),
      MatchHpsHlOl(),
      MatchHpsHlOl(),
    ];
  }

  olMap.values.forEach((element) {
    if (element.length > maxLine) {
      maxLine = element.length;
    }
  });

  if (type == 0) {
    first = olMap[-1]?.first;
    TyHomeController.to.setFirstMap(first);
  } else {
    last = olMap[-1]?.first;
    TyHomeController.to.setLastMap(last);
  }
  //计算宽度
  double width = ((Get.width - 28.w - 12.w) / 2).toInt().toDouble();

  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BodanItemWidget(
            match: match,
            title: map[1]?.osn ?? '',
            list: olMap[1] ?? [],
            hps: boldHps,
            type: type,
            maxLine: maxLine,
          ),
          SizedBox(
            width: 2.w,
          ),
          BodanItemWidget(
              match: match,
              title: type == 0
                  ? LocaleKeys.football_playing_way_full_time_draw.tr
                  : LocaleKeys.football_playing_way_half_time_draw.tr,
              list: olMap[0] ?? [],
              hps: boldHps,
              maxLine: maxLine,
              type: type),
          SizedBox(
            width: 2.w,
          ),
          BodanItemWidget(
            match: match,
            title: map[2]?.osn ?? '',
            list: olMap[2] ?? [],
            hps: boldHps,
            type: type,
            maxLine: maxLine,
          ),
        ],
      ),
      if (first != null || last != null)
        OddsButton(
          //type: 3,///波胆 其他
          playId: playIdConfig.hpsBold,
          name: LocaleKeys.list_other.tr,
          //IPad单独适配
          height: (isIPad ? btnHeight.w : btnHeight) + (TyTextScaler.instance().isScale ? 6  :0),
          width: width,
          radius: 4.w,
          match: match,
          hl: boldHps.hl.safeFirst,
          hps: boldHps,
          ol: olMap[-1]?.first,
          betType: MatchUtil.isEsport(match)
              ? OddsBetType.esport
              : OddsBetType.common,
          nameColor: const Color(0xff3AA6FC),
        ).marginOnly(top: 2.w)
    ],
  );
}
