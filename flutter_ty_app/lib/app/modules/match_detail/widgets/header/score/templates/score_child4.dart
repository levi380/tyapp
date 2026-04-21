import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 冰球比分模板
    】】】
 *
 */

const stageExtraTime = "S7";
const stagePenalty = "S170";

class ScoreChild4 extends StatelessWidget {
  ScoreChild4({super.key, required this.match});

  final MatchEntity match;

  @override
  Widget build(BuildContext context) {
    // 赛果详情不显示    // matchResultsDetails
    // 详情显示
    bool showLabel = ![Routes.matchResultsDetails].contains(Get.currentRoute);

    // 加时赛
    // mmp 32 等待加时  40 加时赛  110加时赛结束
    // msc S7表示公共加时赛比分

    ///小节比分
    List<String> scoreList = getScoreArray(match);
    ///加时比分
   String extraScore = getExtraTime(match);
   ///点球大战比分
   String penaltyScore = getPenaltyScore(match);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  常规三节赛事
        // mmp （13 第一节）（14 301 第二节）（15 302 第三节）（16 303 第四节）
        if (mmpArr.contains(match.mmp) && showLabel)
          ...scoreList.asMap().entries.map((entry) {
            int index = entry.key + 1;
            String e = entry.value;
            return Text(
              FormatScore.scoreFormat(e),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: index == scoreList.length && match.mo != 1
                    ? Get.theme.scoreDetailColor
                    : Colors.white,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: index == scoreList.length
                    ? FontWeight.w700
                    : FontWeight.w600,
              ),
            ).marginOnly(right: 10.w);
          }).toList(),

        // 加时赛||点球大战
        if (mmpArr1.contains(match.mmp) || mmpArr2.contains(match.mmp))
          // 区分model_a or model_b
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ...scoreList.map((e) {
                    return Text(
                      FormatScore.scoreFormat(e),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.theme.fontSize_12,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w600,
                      ),
                    ).marginOnly(right: 10.w);
                  }).toList(),
                  ///冰球加时赛比分
                  if (extraScore != "")
                    Text(
                      "${LocaleKeys.match_info_add.tr}:${FormatScore.scoreFormat(extraScore)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Get.theme.scoreDetailColor,
                        fontSize: Get.theme.fontSize_12,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    ).marginOnly(right: 10.w),
                  if (penaltyScore != "")
                    Text(
                      "${LocaleKeys.match_info_add.tr}:${FormatScore.scoreFormat(penaltyScore)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Get.theme.scoreDetailColor,
                        fontSize: Get.theme.fontSize_12,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    ).marginOnly(right: 10.w),
                ],
              ),
            ],
          ),
      ],
    );
  }

  ///@description 冰球比分集合
  ///@return {Array} 冰球比分
  List<String> getScoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> sortedMsc = List<String>.from(match.msc);
    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    sortedMsc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    // 循环只取出接口返回的比分里面符合冰球球阶段的比分
    for (String item in sortedMsc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }

  ///@description 公共加时赛比分
  ///@return {String} 加时赛比分
  String getExtraTime(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc;

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == stageExtraTime) {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }

  ///@description 获取点球大战的比分
  ///@return {String} 获取点球大战的比分
  String getPenaltyScore(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc;

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == stagePenalty) {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }
}

// 冰球比分: 第一节比分, 第二节比分, 第三节比分
List<String> mscArray = ['S120', 'S121', 'S122'];

// mmp 冰球赛事阶段: 1第一节 2第二节 3第三节 301第一节休息, 302第二节休息
List<String> mmpArr = ['1', '2', '3', '301', '302', '999'];

// 加时赛阶段
List<String> mmpArr1 = ["32", "40", "110", '999'];

// 点球阶段
List<String> mmpArr2 = ["34", "50", "120", '999'];
