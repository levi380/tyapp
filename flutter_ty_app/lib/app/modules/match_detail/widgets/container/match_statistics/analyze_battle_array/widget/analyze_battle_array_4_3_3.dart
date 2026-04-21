import 'dart:math';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
import 'analyze_battle_position_item.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 4-3-3  主场
    】】】
 *
 */
class AnalyzeBattleArray433Widget extends StatelessWidget {
  final List<List<Up>> dataList;
  final bool isHomeTeam;
  AnalyzeBattleArray433Widget(this.dataList,
      {super.key, this.isHomeTeam = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: isHomeTeam ? 40.w : 0.w, bottom: isHomeTeam ? 0.w : 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: dataList.map((e) {
          double maxWidth = 1.sw * 0.88;
          int colorType = Random().nextInt(3);
          if ((85.w * e.length) > maxWidth) {
            double xWidth = maxWidth;

            return Container(
              height: 120.w,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Stack(
                children: e.map((childE) {
                  double x = e.indexOf(childE) * (xWidth / e.length * 7 / 8) +
                      ((maxWidth - (xWidth / e.length * 7 / 8) * e.length) / 2);
                  double y = e.length.isEven
                      ? ((((e.length.toDouble() - 1) / 2).toDouble()) -
                                  e.indexOf(childE))
                              .abs() *
                          (30.w)
                      : ((((e.length ~/ 2)) - e.indexOf(childE)).abs() *
                          (30.w));
                  return Positioned(
                      bottom: y,
                      left: x,
                      child: Center(
                        child: AnalyzeBattlePositionItem(
                          childE,
                          colorType: childE.colorType ?? colorType,
                        ),
                      ));
                }).toList(),
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: e.map((childE) {
              return AnalyzeBattlePositionItem(childE,
                  colorType: childE.colorType ?? colorType);
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
