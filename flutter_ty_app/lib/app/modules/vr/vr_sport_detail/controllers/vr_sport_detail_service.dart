import 'package:flutter_ty_app/app/services/api/vr_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';

/// 统一管理 VR 详情页的所有接口调用
/// 控制器仅负责业务逻辑与状态更新，接口调用集中在此处
class VrSportDetailService {
  /// 获取常规赛排行榜数据
  Future<ApiRes<List<CommonScoreModelData>>> getVirtualSportTeamRankingFetch({
    required String tid,
  }) {
    return VrDetailApi.instance().getVirtualSportTeamRanking(tid);
  }

  /// 获取世界杯类型小组赛排行榜
  Future<ApiRes<List<GroupSoureModelDataGroupData>>>
      getVirtualSportXZTeamRankingFetch({
    required String tid,
  }) {
    return VrDetailApi.instance().getVirtualSportXZTeamRanking(tid);
  }

  /// 获取淘汰赛比分数据
  Future<ApiRes<Map<String, dynamic>>> getMatchSorceFetch({
    required String tid,
    required String batchNo,
    required String lod,
    required String mmp,
    required String beginTime,
  }) {
    return VrDetailApi.instance()
        .getMatchSorce(tid, batchNo, lod, mmp, beginTime);
  }

  /// 获取虚拟体育历史战绩
  Future<ApiRes<List<VrHistoryDogEntity>>> getVirtualMatchDetailCountFetch({
    required String mid,
  }) {
    return VrDetailApi.instance().getVirtualMatchDetailCount(mid);
  }
}
