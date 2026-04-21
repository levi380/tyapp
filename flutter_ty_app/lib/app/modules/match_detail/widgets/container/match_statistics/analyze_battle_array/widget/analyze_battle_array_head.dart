import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/constants/base64_image_constant.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_3_4_2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_3_5_1.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_3_5_2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_4_3_1.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_4_3_2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/analyze_battle_array_other.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/widget_utils.dart';
import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../controllers/statistic/battle_array_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球阵容头部
    】】】
 *
 */
class AnalyzeBattleArrayHead extends StatelessWidget {
  AnalyzeBattleArrayHead({super.key, required this.controller});

  final BattleArrayController controller;

  @override
  Widget build(BuildContext context) {
    MatchDetailController detailController =
    Get.find<MatchDetailController>(tag: controller.tag);
    MatchEntity? match = detailController.detailState.match;
    List<Up> first = [];
    List<Up> second = [];
    List<Up> three = [];
    if (match?.csid == "2") {
      if ((controller.state.basketball_data?.length ?? 0) == 1) {
        first.add(controller.state.basketball_data?.first ?? Up());
      } else if ((controller.state.basketball_data?.length ?? 0) == 2) {
        first.add(controller.state.basketball_data?.first ?? Up());
        second.add(controller.state.basketball_data?[1] ?? Up());
      } else if ((controller.state.basketball_data?.length ?? 0) == 3) {
        first.add(controller.state.basketball_data?.first ?? Up());
        second.add(controller.state.basketball_data?[1] ?? Up());
        second.add(controller.state.basketball_data?[2] ?? Up());
      } else if ((controller.state.basketball_data?.length ?? 0) == 4) {
        first.add(controller.state.basketball_data?.first ?? Up());
        second.add(controller.state.basketball_data?[1] ?? Up());
        second.add(controller.state.basketball_data?[2] ?? Up());
        three.add(controller.state.basketball_data?.last ?? Up());
      } else if ((controller.state.basketball_data?.length ?? 0) == 5) {
        first.add(controller.state.basketball_data?.first ?? Up());
        second.add(controller.state.basketball_data?[1] ?? Up());
        second.add(controller.state.basketball_data?[2] ?? Up());
        three.add(controller.state.basketball_data?[3] ?? Up());
        three.add(controller.state.basketball_data?[4] ?? Up());
      }
    }

    if ((((controller.state.curMainTab == 0
        ? controller.state.line_up_data_home
        : controller.state.line_up_data_away) ==
        null) &&
        (match?.csid != "2")) ||
        (match?.csid == "2" && controller.state.basketball_data?.isEmpty == true)) {
      return Stack(
        children: [
          Container(
            width: controller.state.bgImgWidth,
            height: controller.state.bgImgHeight,
            child:WidgetUtils.base64ImageWidget(baseUrl: match?.csid == "2"?awayTeambg: homeTeambg),

          ),
          buildEmptyWidget(),
        ],

      );
    } else {
      List<List<Up>> dataList = (controller.state.curMainTab == 0
          ? controller.state.football_filtered_data_home
          : controller.state.football_filtered_data_away)
          .map((e) => e)
          .toList();

      String lineAway = (controller.state.curMainTab == 0)
          ? (controller.state.line_up_data_home?.homeFormation ?? "")
          : (controller.state.line_up_data_away?.awayFormation ?? "");
      Widget resultWidget = SizedBox();
      if (lineAway.startsWith("3-5-2") == true) {
        resultWidget = AnalyzeBattleArray352Widget(dataList);
      } else if (lineAway.startsWith("4-3-2") == true) {
        resultWidget = AnalyzeBattleArray432Widget(dataList);
      } else if (lineAway.startsWith("3-4-2") == true) {
        resultWidget = AnalyzeBattleArray342Widget(dataList,
            isHomeTeam: (controller.state.curMainTab == 0));
      } else if (lineAway.startsWith("3-5-1") == true) {
        resultWidget = AnalyzeBattleArray351Widget(dataList,
            isHomeTeam: (controller.state.curMainTab == 0));
      } else if (lineAway.startsWith("4-3-1") == true) {
        resultWidget = AnalyzeBattleArray431Widget(dataList,
            isHomeTeam: (controller.state.curMainTab == 0));
      } else {
        resultWidget = AnalyzeBattleArrayOtherWidget(dataList,
            isHomeTeam: (controller.state.curMainTab == 0));
      }
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        width: controller.state.bgImgWidth,
        height: controller.state.bgImgHeight,
        child: Stack(
          children: [
            Container(
              width: controller.state.bgImgWidth,
              height: controller.state.bgImgHeight,
              child:WidgetUtils.base64ImageWidget(baseUrl: homeTeambg),
            ),
            resultWidget,
            if(dataList.isEmpty)
              buildEmptyWidget(),
          ],
        ),
      );
    }
  }

  Widget buildEmptyWidget() {
    return Container(
      color: Colors.black26,
      margin: EdgeInsets.only(top: 0.2.sh),
      width: 1.sw,
      height: 40.w,
      alignment: Alignment.center,
      child: Text(LocaleKeys.app_h5_detail_not_data_starter.tr,
        style: TextStyle(color: Colors.white),),
    );
  }
}
