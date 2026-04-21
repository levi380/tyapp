import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'match_market_overview_models.dart';
import '../../../../generated/locales.g.dart';
import 'match_detail_controller.dart';
import 'match_market_overview_utils.dart';
import '../../../services/models/res/match_entity.dart';

/**
 * 盘面选择器服务
 * 
 * 负责处理选择器相关的业务逻辑，包括：
 * - 设置选择器选项
 * - 更新选择器显示状态
 * - 获取所有选项
 */

/**
 * 设置一级选择器选项
 * 
 * 根据索引设置一级选择器，并重置二级和三级选择器
 * 
 * @param state 盘面状态对象
 * @param index 选择器索引
 */
void setSelectPlayInfo(MatchMarketOverviewState state, int index) {
  state.selectOptionIndex1 = index;
  if ((state.selectOptionIndex1 < state.selectBeans.length)) {
    state.select_Option1 =
        state.selectBeans[state.selectOptionIndex1].name ?? "";
    state.select_Option2 = "";
    state.select_Option2SelectBean = null;
    state.select_Option3 = "";
  }
  state.selectOptionIndex2 = -1;
  state.selectOptionIndex3 = -1;
  state.playId = state.selectBeans[index].value ?? 0;
  updateIndexShow(state);
}

/**
 * 更新选择器显示状态
 * 
 * 根据当前选择器的状态，更新各级选择器的显示/隐藏状态
 * 
 * @param state 盘面状态对象
 */
void updateIndexShow(MatchMarketOverviewState state) {
  if (state.selectBeans.isNotEmpty) {
    state.showSelect_Option1 = true;
    if ((state.selectOptionIndex1 < state.selectBeans.length)) {
      SelectBean selectBean = state.selectBeans[state.selectOptionIndex1];
      if (selectBean.datas?.isNotEmpty == true) {
        state.showSelect_Option2 = true;
        if (state.selectOptionIndex2 < (selectBean.datas?.length ?? 0)) {
          ChildSelectBean? childSelectBean = selectBean.datas?[
              state.selectOptionIndex2 == -1 ? 0 : state.selectOptionIndex2];
          if (childSelectBean?.datas?.isNotEmpty == true) {
            state.showSelect_Option3 = true;
          } else {
            state.showSelect_Option3 = false;
          }
        }
      } else {
        state.showSelect_Option2 = false;
      }
    }
  }
}

/**
 * 设置二级选择器选项
 * 
 * 根据索引设置二级选择器，并重置三级选择器
 * 
 * @param state 盘面状态对象
 * @param index 选择器索引
 */
void setSelectChildPlayInfo(MatchMarketOverviewState state, int index) {
  state.selectOptionIndex2 = index;

  if (state.selectOptionIndex2 <
      (state.selectBeans[state.selectOptionIndex1].datas?.length ?? 0)) {
    if (!state.showSelect_Option3) {
      state.oddsType = state.selectBeans[state.selectOptionIndex1]
              .datas?[state.selectOptionIndex2].value ??
          "";
    } else {
      state.oddsType = "1";
    }
    if (state.selectOptionIndex2 >= 0) {
      state.select_Option2 = state.selectBeans[state.selectOptionIndex1]
              .datas?[state.selectOptionIndex2].name ??
          "";
      state.select_Option2SelectBean = state
          .selectBeans[state.selectOptionIndex1]
          .datas?[state.selectOptionIndex2];
    }
    state.select_Option3 = "";
    state.selectOptionIndex3 = -1;
  }

  updateIndexShow(state);
  if (!state.showSelect_Option3) {
    state.oddsType = "1";
    state.marketValue = "";
  }
}

/**
 * 设置三级选择器选项
 * 
 * 根据索引设置三级选择器
 * 
 * @param state 盘面状态对象
 * @param index 选择器索引
 */
void setSelectThirdChildPlayInfo(MatchMarketOverviewState state, int index) {
  state.selectOptionIndex3 = index;

  if (state.selectOptionIndex3 <
      (state.selectBeans[state.selectOptionIndex1]
              .datas?[state.selectOptionIndex2].datas?.length ??
          0)) {
    state.select_Option3 = state
            .selectBeans[state.selectOptionIndex1]
            .datas?[state.selectOptionIndex2]
            .datas?[state.selectOptionIndex3]
            .name ??
        "";
  }
  updateIndexShow(state);
}

/**
 * 获取所有选项
 * 
 * 根据赛事盘口信息，构建所有可用的选择器选项
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 */
void getAllOptions(MatchMarketOverviewState state, String tag) {
  Map<String, String> labelObj =
      // 1
      {
    "1": LocaleKeys.list_title_1_title_0.tr,
    "4": LocaleKeys.list_title_1_title_1.tr,
    "2": LocaleKeys.list_title_1_title_2.tr,
    "17": LocaleKeys.list_title_1_title_3.tr,
    "18": LocaleKeys.list_title_1_title_5.tr,
    "19": LocaleKeys.list_title_1_title_4.tr,
  };

  List<Map<String, String>> tabs = [
    {"name": LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_1.tr, "value": "1"},
    {"name": LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_X.tr, "value": "X"},
    {"name": LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_2.tr, "value": "2"},
  ];
  MatchDetailController controller =
      Get.find<MatchDetailController>(tag: tag);

  List<MatchHps> oddinfo =
      controller.detailState.oddsInfoList.isNotEmpty == true
          ? controller.detailState.oddsInfoList
          : (controller.detailState.match?.hps ?? []);

  List<int> hpidArrs = [1, 17, 2, 18, 4, 19];
  List<Map<String, String>> totalData = [];
  // 二级列表出现的赔率  [2.5, 2.5/3, 3]
  state.selectBeans.clear();
  for (int item in hpidArrs) {
    MatchHps? hpidlist = findMatchHpsById(oddinfo, item);

    if (hpidlist?.hl.isNotEmpty == true) {
      Map<String, String> map = {
        "label": labelObj["$item"] ?? "",
        "value": "$item",
      };
      totalData.add(map);

      // 找到一级列表
      SelectBean selectBean = SelectBean(
          name: map["label"], value: int.tryParse(map["value"] ?? "0"));
      List<MatchHpsHl> tempList =
          hpidlist?.hl.where((e) => e.hv?.isNotEmpty == true).toList() ?? [];
      if (tempList.isNotEmpty) {
        //   找到二级列表
        List<String> childHvList = tempList.map((e) => e.hv ?? "").toList();
        selectBean.datas = childHvList.map((e) {
          //   找到二级列表
          ChildSelectBean childSelectBean =
              ChildSelectBean(name: "$e", value: "$e");
          //   找到三级列表
          List<Map<String, String>> computedTabsLibs = computedTabs(item);

          if (computedTabsLibs.isNotEmpty) {
            childSelectBean.datas = computedTabsLibs
                .map((e) =>
                    ThirdChildSelectBean(name: e["name"], value: e["value"]))
                .toList();
          }
          return childSelectBean;
        }).toList();
      } else {
        tabs.map((e) {
          if (selectBean.datas == null) {
            selectBean.datas = [];
          }
          //   找到二级列表
          ChildSelectBean childSelectBean =
              ChildSelectBean(name: e["name"], value: e["value"]);
          selectBean.datas?.add(childSelectBean);
        }).toList();

        state.showSelect_Option3 = false;
      }
      state.selectBeans.add(selectBean);
    }
  }

  if (state.selectBeans.isNotEmpty) {
    state.select_Option1 = state.selectBeans[0].name ?? "";
    if (state.selectBeans[0].datas?.isNotEmpty == true) {
      state.select_Option2 = state.selectBeans[0].datas?[0].name ?? "";
      state.select_Option2SelectBean = state.selectBeans[0].datas?[0];
    }
  }
}

/**
 * 改变赔率类型
 * 
 * 更新当前选择的赔率类型
 * 
 * @param state 盘面状态对象
 * @param oddsType 赔率类型
 */
void changeOddType(MatchMarketOverviewState state, String oddsType) {
  state.oddsType = oddsType;
}

