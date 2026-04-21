import 'package:flutter_ty_app/app/services/api/dj_data_api.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/MatchEsportEntity.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

/// 电竞服务层
/// 负责封装电竞模块的所有接口调用
class DJService extends GetxService {
  static DJService get to => Get.find<DJService>();

  /// 获取日期菜单列表
  Future<ApiRes<List<DjDateEntityEntity>>> getDateMenuListFetch(String csid) {
    return DjDataApi.instance().getDateMenuList(csid);
  }

  /// 获取电竞比赛列表
  Future<ApiRes<List<MatchEntity>>> getEsportsMatchesFetch({
    required String category,
    required String csid,
    required String cuid,
    required String euid,
    required String md,
    required String type,
    String sort = '2',
    String hpsFlag = '0',
  }) {
    return DjDataApi.instance().esportsMatches(
      category,
      csid,
      cuid,
      euid,
      hpsFlag,
      md,
      sort,
      type,
    );
  }

  /// 获取联赛模式下的比赛列表
  Future<ApiRes<MatchEsportEntity>> getLeagueMatchesFetch(MatchListReq req) {
    return MatchApi.instance().matchesNew(req: req);
  }

  /// 收藏或取消收藏赛事
  Future<ApiRes<dynamic>> addOrCancelMatchFetch(
      String cuid, String mid, int status) {
    return MatchApi.instance().addOrCancelMatch(cuid, mid, status);
  }

  /// 获取收藏列表
  Future<ApiRes<List<MatchEntity>>> getCollectionListFetch({
    required String csid,
    required String cuid,
    required String euid,
    required String md,
  }) {
    return DjDataApi.instance().collection(
      1,
      csid,
      cuid,
      euid,
      '0',
      md,
      '1',
      '3000',
    );
  }

  /// 获取新增赛事 (增量更新)
  Future<ApiRes<List<MatchEntity>>> getAddedMatchesFetch({
    required String category,
    required String cuid,
    required String euid,
    required String md,
    required String type,
    required String sort,
    required String hpsFlag,
  }) {
    return DjDataApi.instance().matchesPB(
      category,
      cuid,
      euid,
      hpsFlag,
      md,
      sort,
      type,
    );
  }
}
