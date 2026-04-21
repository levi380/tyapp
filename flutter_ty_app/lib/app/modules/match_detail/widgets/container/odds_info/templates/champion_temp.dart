import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item_util.dart';

import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/odds_button_enum.dart';
import '../champion_odds_button.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事详情】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 冠军玩法集模板
    】】】
 *
 */
class ChampionTemp extends StatelessWidget {
  const ChampionTemp({
    super.key,
    required this.matchHps,
    required this.fullscreen,
    required this.match,
  });

  final MatchHps matchHps;
  final bool fullscreen;
  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: fullscreen ? 8 : 8.sp,
              right: fullscreen ? 8 : 8.sp,
              bottom: fullscreen ? 8 : 8.sp,
              top: fullscreen ? 8 : 8.sp),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: childAspectRatio(2, fullscreen),
            ),
            itemBuilder: (BuildContext context, int index) {
              MatchHpsHlOl ol = matchHps.ol.elementAt(index);
              return ChampionOddsButton(
                key:
                    ValueKey(ol.oid + matchHps.mid + matchHps.index.toString()),
                match: match,
                hps: matchHps,
                ol: ol,
                fullscreen: fullscreen,
                betType: OddsBetType.guanjun,
                direction: OddsTextDirection.horizontal,
              );
            },
            itemCount: matchHps.ol.length,
          ),
        ),
      ],
    );
  }
}
