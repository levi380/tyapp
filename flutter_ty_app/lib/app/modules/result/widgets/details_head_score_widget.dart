import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/format_score_util.dart';
import '../../login/login_head_import.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'HeaderModel.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情头部  组件 DetailsHeadScoreWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情头部  组件 DetailsHeadScoreWidget
    - DetailsHeadScoreWidget
    ```
    DetailsHeadScoreWidget(detailData: detailData, headerMap: headerMap)
    ```
    】】】
 *
 */
class DetailsHeadScoreWidget extends StatelessWidget {
  DetailsHeadScoreWidget({
    super.key,
    required this.detailData,
    required this.headerMap,
  });

  final MatchEntity? detailData;
  final HeaderModel headerMap;

  @override
  Widget build(BuildContext context) {
    List<String> scoreArray = footballScoreArray(detailData ?? MatchEntity());
    String score = FormatScore.scoreFormat(scoreArray.safeFirst ?? "");
// String home = detailData == null ? '' : TYFormatScore.formatTotalScore(
//     detailData!)
//     .home;
// String away = detailData == null ? '' : TYFormatScore.formatTotalScore(
//     detailData!)
//     .away;
    return Container(
      // width: isIPad ? 300.w : 160.w,
      constraints:
          BoxConstraints(minWidth: 1.w, maxWidth: isIPad ? 300.w : 160.w),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: isIPad ? 10.h : 10.h),
          // 比赛分数or开赛时间
          Column(
            children: [
              Text(
                // headerMap.score,
                // (home.length > 0 && away.length > 0) ? "$home-$away" : '',
                score,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isIPad ? 28.sp : 21.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                headerMap.time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "(" + LocaleKeys.mmp_3_999_app_h5.tr + ")",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: FontWeight.w300,
                ),
              ),
              if (detailData != null)
                MatchDetailScore(
                  match: detailData!,
                  isResult: true,
                ).marginOnly(left: 4.w),
            ],
          ),
        ],
      ),
    );
  }

  final List<String> mscArray = ["S1", "S2", "S7", "S170"];
  List<String> footballScoreArray(MatchEntity match) {
    List<String> msc = List.from(match.msc);

    /// 按照比分阶段的数字进行升序排列
    msc.sort((a, b) {
      int numA = int.parse(a.split("|")[0].substring(1));
      int numB = int.parse(b.split("|")[0].substring(1));
      return numA.compareTo(numB);
    });
    List<String> scoreArr = [];

    /// 循环只取出接口返回的比分里面符合足球阶段的比分
    msc.forEach((item) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    });

    return scoreArr;
  }
}
