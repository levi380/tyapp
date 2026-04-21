
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_player_item.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_player_list_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_array_person_entity.dart';
import 'package:flutter_ty_app/app/widgets/empty/text_no_data.dart';
import 'package:flutter_ty_app/main.dart';

import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/battle_array_controller.dart';

import 'package:flutter_ty_app/generated/locales.g.dart';


import '../../../../../../login/login_head_import.dart';
/// 篮球球员列表组件
/// 用于展示首发阵容、替补信息、伤病信息等球员列表
class BasketballBattleArrayPlayerList extends StatelessWidget {
  /// 控制器
  final BattleArrayController controller;

  const BasketballBattleArrayPlayerList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 首发阵容
        if (controller.getBodyUpData()?.isNotEmpty == true)
          _buildStartingLineup(),
        // 替补信息
        if (controller.getBodyDownData()?.isNotEmpty == true)
          _buildBenchLineup(),
        // 伤病信息
        if (controller.getBodyLayOffData()?.isNotEmpty == true)
          _buildInjuryInfo(),
      ],
    );
  }

  /// 构建首发阵容
  Widget _buildStartingLineup() {
    return Column(
      children: [
        _buildSectionHead(
            "${LocaleKeys.analysis_football_matches_starting_lineup.tr} "),
        BasketballBattleArrayPlayerListHead(),
        _buildStartingLineupList(),
      ],
    );
  }

  /// 构建替补信息
  Widget _buildBenchLineup() {
    return Column(
      children: [
        _buildSectionHead(
            "${LocaleKeys.analysis_football_matches_bench_lineup.tr}"),
        AnalyzeDivider(),
        BasketballBattleArrayPlayerListHead(),
        _buildSubstituteList(),
      ],
    );
  }

  /// 构建伤病信息
  Widget _buildInjuryInfo() {
    return Column(
      children: [
        _buildSectionHead("伤病信息"),
        AnalyzeDivider(),
        BasketballBattleArrayPlayerListHead(),
        _buildInjuryList(),
      ],
    );
  }

  /// 构建章节标题
  Widget _buildSectionHead(String title) {
    return Container(
      height: 40.w,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
                color: Get.theme.tabPanelSelectedColor,
                fontSize: isIPad ? 18.sp : 14.sp,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  /// 构建首发阵容列表
  Widget _buildStartingLineupList() {
    if (controller.isBodyUpEmpty()) {
      return TextNoData();
    }

    return Container(
      /// 最小高度单个item的高度
      constraints: BoxConstraints(minHeight: 100.h),
      color: Get.theme.tabPanelBackgroundColor,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8.w).copyWith(bottom: 10.w),
        itemCount: controller.getBodyUpData()?.length ?? 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return BasketballBattleArrayPlayerItem(
            controller: controller,
            entity: controller.getBodyUpData()?[index] ?? Up(),
            showNumber: false,
          );
        },
      ),
    );
  }

  /// 构建替补列表
  Widget _buildSubstituteList() {
    return Column(
      children: [
        AnalyzeDivider(),
        controller.isBodyDownEmpty()
            ? TextNoData()
            : Container(
                /// 最小高度单个item的高度
                constraints: BoxConstraints(minHeight: 100.h),
                color: Get.theme.tabPanelBackgroundColor,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.w)
                      .copyWith(bottom: 10.w),
                  itemCount: controller.getBodyDownData()?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //列表项构造器
                  itemBuilder: (BuildContext context, int index) {
                    return BasketballBattleArrayPlayerItem(
                      controller: controller,
                      entity: controller.getBodyDownData()?[index] ?? Up(),
                    );
                  },
                ),
              )
      ],
    );
  }

  /// 构建伤病列表
  Widget _buildInjuryList() {
    return Column(
      children: [
        AnalyzeDivider(),
        controller.isBodyLayoffEmpty()
            ? TextNoData()
            : Container(
                /// 最小高度单个item的高度
                constraints: BoxConstraints(minHeight: 100.h),
                color: Get.theme.tabPanelBackgroundColor,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.w)
                      .copyWith(bottom: 10.w),
                  itemCount: controller.getBodyLayOffData()?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //列表项构造器
                  itemBuilder: (BuildContext context, int index) {
                    return BasketballBattleArrayPlayerItem(
                      controller: controller,
                      entity: controller.getBodyLayOffData()?[index] ?? Up(),
                    );
                  },
                ),
              )
      ],
    );
  }
}

