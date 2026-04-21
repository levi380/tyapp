import 'dart:math';

import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_tools_methods.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';


import '../../../../../../vr/vr_sport_detail/import_head.dart';
import 'match_statistic_list_expand_button.dart';
import 'match_statistic_list_head.dart';
import 'match_statistic_list_item.dart';
/// 正面交手列表组件
/// 用于显示正面交手历史记录列表，包括列表头部和列表项
class MatchStatisticListWidget {
  /// 构建正面交手-比赛体
  /// 显示历史交手记录列表，支持展开/收起功能
  /// [controller] 比赛统计控制器，包含历史记录数据
  /// [tag] 控制器标签，用于获取MatchDetailController和MatchEntity
  /// 返回包含历史记录列表的容器
  static Widget build({
    required MatchStatisticController controller,
    required String tag,
  }) {
    if (controller.state.pageList.isEmpty) {
      return Container();
    }
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(tag),
      builder: (dataController) {
        MatchEntity? matchEntity = dataController.getMatchById(tag);
        MatchDetailController detailController =
            Get.find<MatchDetailController>(tag: controller.tag);
        String url = detailController.detailState.match?.mhlu[0];
        String url1 = detailController.detailState.match?.malu[0];
        return Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const MatchStatisticListHead(),
              controller.state.pageList.isEmpty
                  ? const SizedBox()
                  : Container(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.state.expand1
                            ? controller.state.pageList.length
                            : min(controller.state.pageList.length, 5),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index >= controller.state.pageList.length) {
                            return const SizedBox();
                          }
                          return MatchStatisticListItem(
                            record: controller.state.pageList[index],
                            leftUrl: url,
                            rightUrl: url1,
                            leftTeamName: getTeamName(match: matchEntity, type: 1),
                            rightTeamName: getTeamName(match: matchEntity, type: 2),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AnalyzeDivider();
                        },
                      ),
                    ),
              if (controller.state.pageList.length > 5)
                MatchStatisticListExpandButton(
                  isExpanded: controller.state.expand1,
                  onToggle: controller.switchExpand,
                ),
            ],
          ),
        );
      },
    );
  }

}

