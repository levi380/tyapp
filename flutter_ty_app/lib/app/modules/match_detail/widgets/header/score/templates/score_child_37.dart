import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/format_score_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 板球比分模板
    - S371	第一局比分
    - S372	第二局比分
    】】】
 *
 */
class ScoreChild37 extends StatefulWidget {
  final MatchEntity match;

  const ScoreChild37({Key? key, required this.match}) : super(key: key);

  @override
  _StageChildWidgetState createState() => _StageChildWidgetState();
}

class _StageChildWidgetState extends State<ScoreChild37> {
  final List<String> mscArray = ["S371", "S372"];

  @override
  void initState() {
    super.initState();
    initEvent();
  }

  List<String> scoreArr = [];

  List<String> initEvent() {
    List<String> msc = List<String>.from(widget.match.msc);
    msc.sort((a, b) => int.parse(a.split("|")[0].substring(1))
        .compareTo(int.parse(b.split("|")[0].substring(1))));

    for (var item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }
    return scoreArr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 第一局
        if (scoreArr.isNotEmpty)
          Text(
            FormatScore.scoreFormat(scoreArr[0]),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: Get.theme.fontSize_12,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
        // 第二局
        if (scoreArr.length > 1)
          Text(
            FormatScore.scoreFormat(scoreArr[1]),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.theme.scoreDetailColor,
              fontSize: Get.theme.fontSize_12,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(right: 10.w),
      ],
    );
  }
}
