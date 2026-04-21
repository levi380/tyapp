
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 普通赛果列表 组件   ResultsItemTeamScoreWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 普通赛果列表 组件   ResultsItemTeamScoreWidget
    - ResultsItemTeamScoreWidget
    ```
    ResultsItemTeamScoreWidget(
      teamName: dataItem.list[index].mhn,
      fullScore: TYFormatScore.formatTotalScore(dataItem.list[index]).home,
      penaltyScore: TYFormatScore.formatScorePenaltyScore(
      dataItem.list[index].msc,0).toString(),
      isDark: isDark,
      sportId: sportId,
      showPenalty: showMsc(int.tryParse(dataItem.list[index].csid) ?? 0)
    )
    ```
    】】】
 *
 */
class ResultsItemTeamScoreWidget extends StatelessWidget {
  const ResultsItemTeamScoreWidget({
    super.key,
    required this.teamName,
    required this.fullScore,
    required this.penaltyScore,
    required this.isDark,
    required this.sportId,
    required this.showPenalty,
  });

  final bool isDark;
  final bool showPenalty;
  final String teamName;
  final String fullScore;
  final String penaltyScore;
  final String sportId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(
              right: 20.w,
            ),
            height: 34.h,
            alignment: Alignment.centerLeft,
            child: Text(
              teamName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                color: isDark
                    ? Colors.white
                    : const Color(0xFF303442),
                fontSize: isIPad ? 14.sp : 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Expanded(
          flex: sportId.contains('101') || sportId.contains('190') ? 3 : 2,
          child: Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      fullScore,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : const Color(0xFF303442),
                        fontSize: isIPad ? 14.sp : 12.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DIN Alternate',
                      ),
                    ),
                  ),
                ),

                ///主队 点球比分
                ///85144 【日常】【线上】【SDK】DX APP，赛果 - 其他球种（非足球类），列表不应显示“点球比分”栏位
                if(sportId.contains('101') || sportId.contains('190'))
                  Visibility(
                    visible: showPenalty,
                    child: Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          penaltyScore,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF66BAFD),
                            fontSize: isIPad ? 14.sp : 12.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DIN Alternate',
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}