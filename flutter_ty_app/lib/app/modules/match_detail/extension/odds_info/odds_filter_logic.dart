import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/category_list_entity.dart';
import '../../constants/detail_constant.dart';
import 'hps_sort.dart';
import 'odds_action_logic.dart';

/// 盘口过滤与排序逻辑
extension OddsFilterLogic on MatchDetailController {
  /// 获取当前Tab下的玩法集，并进行过滤
  List<MatchHps> getOddsInfoFilter(List<MatchHps> allData) {
    // 赛果详情返回全部
    if (Get.currentRoute == Routes.matchResultsDetails) {
      // 原逻辑注释掉了 returning allData check, 但下面有个兜底 return listSort...
      // 这里按原逻辑走，如果有特殊需求可放开
    }

    final mcid = detailState.curCategoryTabId;
    final findItem =
        detailState.categoryList.firstWhereOrNull((item) => item.id == mcid);

    List<MatchHps> res = [];

    // 如果找到了对应的 Tab 筛选规则
    if (findItem != null) {
      final plays = findItem.plays;
      final round = findItem.round ?? -1;

      res = allData.where((item) {
        // 晋级里面不加冠军玩法
        if (mcid != "0" && findItem.isChampion != item.isChampion) {
          return false;
        }

        // 电竞特殊处理：需要判断第一局、第二局...
        if (detailState.isDJDetail && round > 0) {
          String chpid = item.chpid;
          if (detailState.isResult) {
            chpid = item.topKey;
          }
          // 匹配 hpid 且 (chpid匹配 或 只是hpid)
          return plays.contains(int.parse(item.hpid)) &&
              (detailState.chpids['${item.hpid}-$round'] == chpid ||
                  chpid == item.hpid);
        }

        // 常规匹配：只看 hpid 是否在 plays 列表中
        return plays.contains(int.parse(item.hpid));
      }).toList();
    } else {
      // 没找到 Tab，重置为全部 (0)
      if (mcid != "0") {
        checkCurCategoryTab(mcid); // 检查 Tab 是否存在并移除的逻辑
        detailState.curCategoryTabId = "0";
      }
      res = [...allData];
    }
    // 增值赔率
    if (detailState.curCategoryTabId == ADDED_ODDS_CATEGORY_ID) {
      res = createAddMergeOlHps(res);
    }
    // 兜底：如果过滤后为空，也显示全部
    if (res.isEmpty) {
      checkCurCategoryTab(detailState.curCategoryTabId);
      detailState.curCategoryTabId = "0";
      res = [...allData];
    }

    // 排序：置顶在前，普通在后
    return [...listSortNew(res), ...listSortNormal(res)];
  }

  /// 执行过滤并更新 UI 状态 (收起/展开策略)
  void filterOddsInfo() {
    detailState.filterOddsInfoList.clear();
    detailState.filterOddsInfoList
        .addAll(getOddsInfoFilter(detailState.oddsInfoList));
    detailState.hasHotName = false;

    // 每一帧后检查是否需要自动修正展开状态（主要针对 VR 体育少于 11 个玩法进默认展开）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool hasHshow = false;

      for (var hps in detailState.filterOddsInfoList) {
        if (hps is! MatchHps) continue;

        // VR 体育且玩法少时，如果没有手动操作过收起状态，默认展开
        if (detailState.filterOddsInfoList.length < 11 &&
            Get.currentRoute == Routes.vrSportDetail &&
            !detailState.hShowMap
                .containsKey("${hps.hpid}_${hps.topKey}_${hps.hid}")) {
          hps.hshow = SHOW_YES;
        }

        if (hps.hshow == SHOW_YES) {
          hasHshow = true;
        }
      }

      // 根据是否有展开项，更新全局状态
      detailState.getFewer.value = hasHshow ? 3 : 2;
    });
  }

  /// 更新置顶信息 (如置顶列表变更后)
  void updateHtonOddsInfo() {
    for (var hps in detailState.oddsInfoList) {
      final index = detailState.playTopList
          .indexWhere((item) => item.topKey == hps.topKey);
      if (index > -1) {
        hps.hton = detailState.playTopList[index].hton;
      }
    }
    filterOddsInfo();
    update([matchOddsInfoGetBuildId]);
  }

  // 合并增值赔率
  List<MatchHps> createAddMergeOlHps(List<MatchHps> res) {
    MatchHps newHps = MatchHps();
    CategoryListData? addCategory = detailState.categoryList
        .firstWhereOrNull((e) => e.id == ADDED_ODDS_CATEGORY_ID);
    newHps.hpn = addCategory?.marketName ??
        LocaleKeys.discount_odd_odds_value_increase.tr;
    // 由于是合并的玩法，玩法id和盘口id都用ADDED_ODDS_CATEGORY_ID
    newHps.hpid = ADDED_ODDS_CATEGORY_ID;
    newHps.topKey = ADDED_ODDS_CATEGORY_ID;
    newHps.hid = ADDED_ODDS_CATEGORY_ID;
    // 展开收起状态 保存在controller
    if (detailState.hShowMap["${newHps.hpid}_${newHps.topKey}_${newHps.hid}"] !=
        null) {
      newHps.hshow = detailState
          .hShowMap["${newHps.hpid}_${newHps.topKey}_${newHps.hid}"]!;
    } else {
      /// 默认展开
      newHps.hshow = SHOW_YES;
    }
    newHps.hls = [MatchHpsHl()];
    newHps.mid = detailState.match?.mid ?? "";
    for (final item in res) {
      for (final hl in item.hl) {
        for (MatchHpsHlOl ol in hl.ol) {
          if (ol.dov != 0) {
            newHps.hls.first.ol.add(ol
              ..pHl = hl
              ..ppHps = item
              ..isInAddedTab = true);
          }
        }
      }
    }

    return [newHps];
  }
}
