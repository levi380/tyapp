import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 下拉赛事选择项
    】】】
 *
 */
class AnalyzeBattlePositionItem extends StatelessWidget {
  final Up? entity;
  final int? colorType;
  AnalyzeBattlePositionItem(
    this.entity, {
    this.colorType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 39.w,
          height: 39.w,
          decoration: BoxDecoration(
            color: getColor(colorType ?? entity?.colorType ?? 3),
            borderRadius: BorderRadius.circular(36.w),
            border: Border.all(
              color: Colors.white,
              width: 2.w,
            ),
          ),
          child: Text(
            "${entity?.shirtNumber ?? 0}",
            style: TextStyle(
              fontSize: isIPad ? 20.sp : 16.sp,
              fontWeight: FontWeight.w700,
              color: getTextColor(colorType ?? entity?.colorType ?? 3),
            ),
          ),
        ),
        SizedBox(
          height: 2.w,
        ),
        Container(
          width: 80.w,
          alignment: Alignment.center,
          child: Text(
            entity?.thirdPlayerName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: isIPad ? 16.sp : 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  getColor(int colorType) {
    if (colorType == 0) {
      return MatchStatisticMatchHistoryState.battlePositionColorType0;
    } else if (colorType == 1) {
      return MatchStatisticMatchHistoryState.battlePositionColorType1;
    } else if (colorType == 2) {
      return MatchStatisticMatchHistoryState.battlePositionColorType2;
    } else if (colorType == 3) {
      return MatchStatisticMatchHistoryState.battlePositionColorType3;
    } else {
      return MatchStatisticMatchHistoryState.battlePositionColorType1;
    }
  }

  getTextColor(int colorType) {
    if (colorType == 0) {
      return Colors.white;
    } else if (colorType == 1) {
      return Colors.white;
    } else if (colorType == 2) {
      return MatchStatisticMatchHistoryState.battlePositionTextColorType2;
    } else if (colorType == 3) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }
}
