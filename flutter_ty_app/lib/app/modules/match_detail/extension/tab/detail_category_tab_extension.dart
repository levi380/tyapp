import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/category_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

/// 详情玩法集（Category/Odds）Tab逻辑扩展
extension DetailCategoryTabExtension on MatchDetailController {
  /// 计算当前玩法集 Tab ID
  /// 用于次要玩法进来时，定位到对应的玩法集和高亮
  void calCurCategoryTabId() {
    if (detailState.curCategoryTabId == "0" &&
        detailState.cid.isNotEmpty &&
        detailState.categoryList.length > 1) {
      bool find = false;
      for (CategoryListData data in detailState.categoryList) {
        if (data.id == detailState.cid) {
          detailState.curCategoryTabId = data.id;
          find = true;
        }
      }
      if (find) {
        detailState.playId = "";
        detailState.cid = "";
      }
    }
  }

  /// 绑定冠军赛事到 Tab
  void bindChampionMatchTab() {
    // 绑定冠军引导盘
    detailState.championMatchs.forEach((MatchEntity match) {
      // hps 没有mid  这里进行绑定
      match.hps.forEach((e) {
        e.mid = match.mid;
        e.isChampion = true;
        e.topKey = e.hpid;
        // 非置顶时 置底部 todo 不严谨
        e.hpon = 99999;

        // 设置置顶信息
        int index = detailState.playTopList
            .indexWhere((item) => item.topKey == e.topKey);
        if (index > -1) {
          e.hton = detailState.playTopList[index].hton;
        }

        // 展开收起状态
        if (detailState.hShowMap["${e.hpid}_${e.topKey}_${e.hid}"] != null) {
          e.hshow = detailState.hShowMap["${e.hpid}_${e.topKey}_${e.hid}"]!;
        } else {
          /// 默认展开
          e.hshow = SHOW_YES;
        }
      });
      bool isHas = detailState.categoryList.any((e) {
        return e.id == match.tid;
      });
      if (!isHas) {
        List<int> plays = match.hps.map((e) {
          List<int> allPlays = detailState.categoryList.safeFirst?.plays ?? [];
          int hpid = e.hpid.toInt();
          // 将plays 加入所有投注列表
          detailState.categoryList.safeFirst?.plays
              .addIf(!allPlays.any((item) => item == hpid), hpid);
          return hpid;
        }).toList();
        detailState.categoryList.add(
          CategoryListData.fromJson({
            "id": match.tid,
            // "marketName": MatchUtil.getOutrightDisplayMatchTn(match.onTn),
            //"marketName": match.onTn,
            "marketName": LocaleKeys.ouzhou_match_outrights.tr,
            "orderNo": match.tid.toInt(),
            "plays": plays, // 所有玩法的hpid
            "isChampion": true
          }),
        );
      }
    });
  }

  /// 检查当前 Category Tab 是否有效
  /// 当前玩法集与玩法标签不一致时刷一次标签接口
  void checkCurCategoryTab(String tabIndex) {
    if (detailState.curCategoryTabId != "0") {
      detailState.throttleCategoryListSubject.add(null);
    }
  }

  /// 切换玩法集 Tab
  void changeCategoryTab(String tabId) {
    // 点中自己
    if (detailState.curCategoryTabId == tabId) return;
    detailState.curCategoryTabId = tabId;
    refreshOddsInfoData();

    // 切换玩法集 玩法列表回到顶部
    bool hasClients = detailState.matchScrollerViewGlobalKey.currentState
            ?.innerController.hasClients ??
        false;
    if (hasClients && detailState.appbarPinned.value) {
      detailState.matchScrollerViewGlobalKey.currentState?.innerController
          .jumpTo(0);
      detailState.showTopBtn.value = false;
    }
  }
}
