import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../../../../../utils/format_score_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 手球比分模板
    】】】
 *
 */
class ScoreChild11 extends StatefulWidget {
  final MatchEntity match;

  const ScoreChild11({Key? key, required this.match}) : super(key: key);

  @override
  _StageChildWidgetState createState() => _StageChildWidgetState();
}

class _StageChildWidgetState extends State<ScoreChild11> {
  final List<String> mscArray = ["S1", "S2", "S7", "S170"];
  final List<String> collectionA = [
    '6',
    '31',
    '7',
    '41',
    '100',
    '32',
    '33',
    '42',
    '110',
    '34',
    '50',
    '120',
    '999'
  ];
  final List<String> collectionB = [
    '41',
    '100',
    '32',
    '33',
    '42',
    '110',
    '34',
    '50',
    '120',
    '999'
  ];
  final List<String> collectionC = ['110', '34', '50', '120', '999'];

  late String? addScore;
  late String? shootScore;

  @override
  void initState() {
    super.initState();
    initEvent();
  }

  List<String> scoreArr = [];

  List<String> initEvent() {
    List<String> msc = List<String>.from(widget.match.msc);
    msc.sort((a, b) =>
        int.parse(a.split("|")[0].substring(1)).compareTo(
            int.parse(b.split("|")[0].substring(1))));

    for (var item in msc) {
      String numIndex = item.split("|")[0];
      if (numIndex == 'S7') {
        addScore = item.split("|")[1];
      }
      if (numIndex == 'S170') {
        shootScore = item.split("|")[1];
      }
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }
    return scoreArr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(width: 16),
          // if (scoreArr.length > 1 &&
          //     collectionA.contains(widget.match.mmp)) Text('match_info.half'),
          //
          // if (scoreArr.isNotEmpty &&
          //     collectionB.contains(widget.match.mmp)) Text('/ match_info.full'),
          //
          // if (hasStrValue(addScore) &&
          //     collectionC.contains(widget.match.mmp)) Text('/ match_info.add'),
          //
          // if (hasStrValue(shootScore) &&
          //     collectionC.contains(widget.match.mmp)) Text(
          //     '/ match_info.shoot_out'),

          // SizedBox(height: 4),


          if (scoreArr.length > 1 &&
              collectionA.contains(widget.match.mmp))
            Text(
            ' ${FormatScore.scoreFormat(scoreArr[1])}',
              style: TextStyle(
                color:  Colors.white,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            ),

          if (scoreArr.isNotEmpty &&
              collectionB.contains(widget.match.mmp))

            Text('  ${FormatScore.scoreFormat(scoreArr[0])}',
              style: TextStyle(
                color:  Colors.white,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            ),

          if (hasStrValue(addScore) && collectionC.contains(widget.match.mmp))
            Text('  ${ FormatScore.scoreFormat(addScore!)}',
              style: TextStyle(
                color:  Colors.white,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            ),

          if (hasStrValue(shootScore) && collectionC.contains(widget.match.mmp))
            Text('  ${ FormatScore.scoreFormat(shootScore!)}',
              style: TextStyle(
                color:  Colors.white,
                // color:  Get.theme.scoreDetailColor,
                fontSize: Get.theme.fontSize_12,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
