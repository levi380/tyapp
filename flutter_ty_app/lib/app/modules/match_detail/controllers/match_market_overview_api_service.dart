import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_match_information_entity.dart';
import '../../../services/api/analyze_detail_api.dart';

/**
 * 盘面API服务
 * 
 * 负责处理所有与盘面相关的API请求，包括：
 * - 赛事分析数据请求
 * - 预期分析数据请求
 */

/**
 * 请求赛事分析数据
 * 
 * 根据父菜单ID、子菜单ID和标准赛事ID获取赛事分析数据
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 * @param parentMenuId 父菜单ID
 * @param sonMenuId 子菜单ID
 * @param updateIndex 更新索引，默认为0
 */
Future<void> requestMatchAnalysiseData(
  MatchMarketOverviewState state,
  String tag,
  String? parentMenuId,
  String? sonMenuId, {
  int updateIndex = 0,
}) async {
  AnalyzeDetailApi.instance()
      .getMatchAnalysiseData(
    parentMenuId,
    sonMenuId,
    tag,
  )
      .then((value) {
    state.analyzeGetMatchAnalysiseDataItemEntity = value.data ?? {};

    // 注意：这里需要调用update方法，但update方法在controller中
    // 所以这个方法可能需要返回数据，让controller来处理update
  });
}

/**
 * 请求预期分析数据
 * 
 * 根据父菜单ID、子菜单ID和标准赛事ID获取预期分析数据
 * 
 * @param state 盘面状态对象
 * @param tag 控制器标签
 * @param parentMenuId 父菜单ID
 * @param sonMenuId 子菜单ID
 * @param standardMatchId 标准赛事ID
 */
Future<void> requestMatchData(
  MatchMarketOverviewState state,
  String? parentMenuId,
  String? sonMenuId,
  String? standardMatchId,
) async {
  // 接口获取的数据
  AnalyzeDetailApi.instance()
      .getMatchAnalysiseData(
    parentMenuId,
    sonMenuId,
    standardMatchId,
  )
      .then((value) {
    state.analyzeGetMatchAnalysiseDataItemEntity = value.data ?? {};
    if (state.analyzeGetMatchAnalysiseDataItemEntity[
            "sThirdMatchInformationDTOList"] ==
        null) {
      // 数据为空，不做处理
    } else {
      state.dataList.clear();
      state.dataList = (state.analyzeGetMatchAnalysiseDataItemEntity[
              "sThirdMatchInformationDTOList"] as List)
          .map((e) => AnalyzeMatchInformationEntity.fromJson(e))
          .toList();
    }
    // 注意：这里需要调用update方法，但update方法在controller中
    // 所以这个方法可能需要返回数据，让controller来处理update
  });
}

