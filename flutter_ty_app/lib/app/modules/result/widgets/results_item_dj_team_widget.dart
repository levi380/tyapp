import '../../../../main.dart';
import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞赛果列表战斗 组件   ResultsItemDjTeamWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞赛果列表战斗 组件   ResultsItemDjTeamWidget
    - ResultsItemDjTeamWidget
    ```
    ResultsItemDjTeamWidget(
      isDark: isDark,
      teamText: dataItem.list[index].man,
      scoreText: TYFormatScore.formatTotalScore(
      dataItem.list[index]).away
    )
    ```
    】】】
 *
 */
class ResultsItemDjTeamWidget extends StatelessWidget {
  const ResultsItemDjTeamWidget({
    super.key,
    required this.isDark,
    required this.teamText,
    required this.scoreText,
  });


  final bool isDark;
  final String teamText;
  final String scoreText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.w,
      ),
      height: 34.h,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        mainAxisAlignment:
        MainAxisAlignment.start,
        children: [
          Text(
            teamText,
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
          const Expanded(child: SizedBox()),
          Text(
            scoreText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? Colors.white
                  : const Color(0xFF303442),
              fontSize: isIPad ? 14.sp : 12.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'DIN Alternate',
            ),
          )
        ],
      ),
    );
  }
}