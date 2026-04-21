import '../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-score.dart';
import '../../../services/models/res/match_entity.dart';
import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情比分 组件 DetailsTitleScoreWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情比分  组件 DetailsTitleScoreWidget
    - DetailsTitleScoreWidget
    ```
    /// 赛果详情比分组件
    DetailsTitleScoreWidget(matchItem: matchItem, isDark: isDark)
    ```
    】】】
 *
 */
class DetailsTitleScoreWidget extends StatelessWidget {
  const DetailsTitleScoreWidget({
    super.key,
    required this.matchItem,
    required this.isDark,

  });


  final MatchEntity matchItem;
  final bool isDark;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.match_info_match_end.tr,
          style: TextStyle(
            color: isDark
                ? Colors.white
                : const Color(0xFF303442),
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 10.w,
        ),
        Text(
          TYFormatScore
              .formatTotalScore(
              matchItem)
              .text,
          style: TextStyle(
            color: isDark
                ? Colors.white
                : const Color(0xFF303442),
            fontSize: 22.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}