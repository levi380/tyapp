import 'package:flutter_ty_app/app/services/api/vr_sports_api.dart';
import 'package:flutter_ty_app/app/services/api/result_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/query_league_template_list_entity.dart';

///统一管理 VR 模块的所有接口调用，控制器只负责业务逻辑与状态更新
class VRSportService {
  /// 查询虚拟体育菜单列表
  Future<ApiRes<List<VrSportsMenuEntity>>> getVrSportsMenusFetch({
    String device = 'V1_H5',
  }) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    return VrSportsApi.instance().getVrSportsMenus(device, ts);
  }

  /// 查询虚拟体育赛事列表
  Future<ApiRes<List<VrMatchEntity>>> getVirtualMatchesFetch({
    required String csid,
    required String tid,
    String device = 'KY_APP',
  }) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    return VrSportsApi.instance().getVirtualMatches(csid, tid, device, ts);
  }

  /// 查询虚拟体育赛事回放信息
  Future<ApiRes<VrSportReplayEntity>> getVirtualReplayFetch({
    required String batchNo,
    required String csid,
    required String tid,
  }) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    return VrSportsApi.instance().virtualReplay(batchNo, csid, tid, ts);
  }

  /// 查询赛事比分信息
  Future<ApiRes> getMatchScoreFetch({
    required String mids,
  }) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    return VrSportsApi.instance().getMatchScore(mids, ts);
  }

  /// 查询足球/篮球运营模板列表
  Future<QueryLeagueTemplateListEntity> queryLeagueTemplateListFetch({
    required String uid,
  }) {
    return ResultApi.instance().queryLeagueTemplateLis(uid);
  }
}
