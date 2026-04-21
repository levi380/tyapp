
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/widget/electronic_football_header.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/widget/electronic_football_item.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'head_on_confrontation_expand_button.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';

import '../../../../../../global/data_store_controller.dart';

import '../../../../controllers/match_statistic_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import '../../../../states/match_statistic_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电子足球-正面交手
    】】】
 *
 */
class HeadOnConfrontationView extends StatefulWidget {
  final String tag;

  HeadOnConfrontationView({super.key, required this.tag});

  @override
  State<StatefulWidget> createState() {
    return HeadOnConfrontationViewState();
  }
}

class HeadOnConfrontationViewState extends State<HeadOnConfrontationView> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchStatisticController>(
      tag: widget.tag,
      builder: (controller) {
        if (controller.state.isTopDataEmpty &&
            controller.state.pageList.isEmpty) {
          return NoData(
            top: 0,
            content: LocaleKeys.common_no_data.tr,
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(

                padding: EdgeInsets.zero,

                // color: Get.isDarkMode
                //     ? ChangeSkinToneColorUtil.instance()
                //         .getDarkBackgroundColor()
                //     : Get.theme.detailBackgroundColor,
                child: buildElectronicFootball(controller),
              )
            ],
          ),
        );
      },
    );
  }

  /**
   * 电子主球赛事的页面
   */
  buildElectronicFootball(MatchStatisticController controller) {
    return Column(
      children: [
        // 以往数据
        if (controller.state.electronicFootballPBBeanList.isNotEmpty)
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              top: MatchStatisticMatchHistoryState.headOnConfrontationPastDataTopMargin.w,
            ),
            child: Text(
              " ${LocaleKeys.analysis_football_matches_past_data.tr}",
              style: TextStyle(
                fontSize: MatchStatisticMatchHistoryState.headOnConfrontationPastDataFontSize.sp,
                color: Get.theme.oddsButtonValueFontColor,
              ),
            ),
          ),
        SizedBox(
          height: MatchStatisticMatchHistoryState.headOnConfrontationPastDataBottomSpacing.w,
        ),
        const ElectronicFootballHeader(),
        buildMatchBodyElectronicFootball(controller),
        SizedBox(
          height: MatchStatisticMatchHistoryState.headOnConfrontationBottomSpacing.w,
        )
      ],
    );
  }

  /**
   * 电子足球列表
   */
  buildMatchBodyElectronicFootball(MatchStatisticController controller) {
    if (controller.state.electronicFootballPBBeanList.isEmpty) {
      return Container();
    }

    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(widget.tag),
      builder: (dataController) {
        MatchDetailController detailController =
            Get.find<MatchDetailController>(tag: controller.tag);
        return Column(
          children: [
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (controller.state.expand1)
                  ? controller.state.electronicFootballPBBeanList.length
                  : (controller.state.electronicFootballPBBeanList.length > MatchStatisticMatchHistoryState.headOnConfrontationMaxDisplayCount
                      ? MatchStatisticMatchHistoryState.headOnConfrontationMaxDisplayCount
                      : controller.state.electronicFootballPBBeanList.length),
              separatorBuilder: (context, index) {
                return AnalyzeDivider();
              },
              itemBuilder: (context, index) {
                String? url = (detailController.detailState.match?.mhlu as List?)
                    ?.safeFirst;
                String? url1 =
                    (detailController.detailState.match?.malu as List?)
                        ?.safeFirst;

                return ElectronicFootballItem(
                  index: index,
                  item: controller.state.electronicFootballPBBeanList[index],
                  leftTeam1: getTeamName(
                      type: 1, match: detailController.detailState.match),
                  leftUrl: url,
                  leftNumber: "$index",
                  rightTeam1: getTeamName(
                      type: 2, match: detailController.detailState.match),
                  rightUrl: url1,
                  rightNumber: "$index",
                );
              },
            ),
            if (controller.state.electronicFootballPBBeanList.isNotEmpty &&
                controller.state.electronicFootballPBBeanList.length > MatchStatisticMatchHistoryState.headOnConfrontationMaxDisplayCount)
              HeadOnConfrontationExpandButton(
                isExpanded: controller.state.expand1,
                onToggle: controller.switchExpand,
              )
          ],
        );
      },
    );
  }
}
