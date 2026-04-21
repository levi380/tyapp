
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/match_group.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/base_data_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/models/section_group_enum.dart';
import '../services/models/res/origin_data_entity.dart';
import '../services/models/res/team_entity.dart';
import 'config_controller.dart';

extension ConfigControllerMenu on ConfigController {
  Future<void> loadMenuMapping() async {
    try {
      ///新旧菜单ID对应
      final res = await BaseDataApi.instance().loadMenuMapping({});
      if (res.success && res.data != null) {
        sportOldNewIdMap = res.data!;

        StringKV.OldNewId.save(jsonEncode(sportOldNewIdMap));
      }
    } catch (e) {}
  }

  loadMenuCache() {
    //  StringKV.OldNewId.save(jsonEncode(sportOldNewIdMap));
    String? res = StringKV.OldNewId.get();
    if (ObjectUtil.isEmptyString(res)) {
      return;
    }
    try {
      sportOldNewIdMap = jsonDecode(res!) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.debug('loadMenuCache error: $e');
    }
  }

  // 获取球种国际化name映射
  Future loadNameList({bool switchLanguages = false}) async {
    try {
      ApiRes value = await BaseDataApi.instance().loadNameList({});
      if (value.success && value.data != null) {
        nameMap = value.data!;
        StringKV.nameMap.save(jsonEncode(nameMap));
      }
      if (switchLanguages) {
        TyHomeController.to.update();
      }
    } catch (e) {}
  }

  loadNameCache() {
    String? res = StringKV.nameMap.get();
    if (ObjectUtil.isEmptyString(res)) {
      return;
    }
    try {
      nameMap = jsonDecode(res!) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.debug('loadNameCache error: $e');
    }
  }

  ///客户端-获取紧急开关配置
  Future<void> getAccessConfig() async {
    try {
      final res = await BaseDataApi.instance().getAccessConfig();
      if (res.success && res.data != null) {
        // res.data?.zrSwitchConfig.zrSwitch = false;
        // res.data?.zrSwitchConfig.cpSwitch = false;
        accessConfig.value = res.data!;
      }
    } catch (e) {
      print(e);
    }
  }

  ///菜单球种
  Future<void> loadMenuInit() async {
    try {
      ApiRes<List<SportConfigInfo>> ret =
      await BaseDataApi.instance().getMenuInit();
      if (ret.success && ret.data != null) {
        List<SportConfigInfo> menuList = ret.data!;
        for (var item in menuList) {
          // AppLogger.debug("item == " + item.toString());
          menuMap[item.mi] = item;
        }
        menuInit = menuList;

        /// 存到本地
        List<Map<String, dynamic>> res =
        ret.data!.map((e) => e.toJson()).toList();
        StringKV.menuInit.save(jsonEncode(res));
      }
    } catch (e) {
      // AppLogger.debug('e ${e.toString()}');
    }
  }

  loadCacheInit() {
    String? res = StringKV.menuInit.get();
    if (ObjectUtil.isEmptyString(res)) {
      return;
    }
    try {
      List<Map<String, dynamic>> list =
          JsonUtil.getObjectList(res, (v) => v as Map<String, dynamic>) ?? [];
      menuInit = list.map((e) => SportConfigInfo.fromJson(e)).toList();
      for (var item in menuInit) {
        menuMap[item.mi] = item;
      }
    } catch (e) {
      AppLogger.debug('loadCacheInit error: $e');
    }
  }

  ///获取元数据
  Future<void> loadOriginData() async {
    try {
      final res = await BaseDataApi.instance().getOriginalData();
      if (!res.success || res.data == null) return;
      if (res.success) {
        final data = res.data!;

        /// 先判断数据是否可用
        if (!_isOriginDataValid(data)) {
          AppLogger.debug('元数据问题');
          return;
        }
        originData = res.data!;
        /// 缓存本地
        StringKV.originData.save(jsonEncode(originData.toJson()));
      }
    } catch (e) {
      AppLogger.debug('error in fetchOriginData: $e');
    }
  }

  ///先判断元数据的可用性 不要盲插 导致页面异常
  bool _isOriginDataValid(OriginDataEntity data) {
    if (data.tidsObj.isEmpty) return false;
    if (data.matchsList.isEmpty) return false;
    if (data.spList.isEmpty) return false;
    return true;
  }

  loadCacheOrigin() {
    String? res = StringKV.originData.get();
    if (ObjectUtil.isEmptyString(res)) {
      return;
    }
    try {
      Map<String, dynamic> map = jsonDecode(res!);
      originData = OriginDataEntity.fromJson(map);
      // AppLogger.debug('loadCacheOrigin originData = $originData');
    } catch (e) {
      AppLogger.debug('loadCacheOrigin error: $e');
    }
  }

  Future<void> loadTournamentMatch() async {
    try {
      final res = await BaseDataApi.instance().loadTournamentMatch({});
      if (res.success && res.data!=null) {
        tournamentMatchMap = res.data!;

        /// 缓存本地
        StringKV.tournamentMatchMap.save(jsonEncode(tournamentMatchMap));
      }
    } catch (e) {
      AppLogger.debug('error in fetchOriginData: $e');
    }
  }

  loadCacheTournamentMatch() {
    String? res = StringKV.tournamentMatchMap.get();
    if (ObjectUtil.isEmptyString(res)) {
      return;
    }
    try {
      Map<String, dynamic> map = jsonDecode(res!);
      tournamentMatchMap = map;
      // AppLogger.debug('loadCacheTournamentMatch tournamentMatchMap = $tournamentMatchMap');
    } catch (e) {
      AppLogger.debug('loadCacheTournamentMatch error: $e');
    }
  }
}

///////////////////////////////////////////////////////////////
////////////////          根据sportID和菜单menuid获取列表元数据      //////////////////
///////////////////////////////////////////////////////////////
extension ConfigControllerX on ConfigController {
  ////isTidGroup 是否是排序
  List<CombineInfo> getMatchGroup(String sportId, int menuId, bool isTidGroup) {
    try {
      String targetId = getTargetId(sportId, menuId);
      Map<String, dynamic> map = tournamentMatchMap[targetId] ?? {};
      if (map.isEmpty) {
        targetId = '${targetId}01';
        map = tournamentMatchMap[targetId] ?? {};
      }
      if (ObjectUtil.isEmpty(map)) return [];
      //全部
      List<MatchGroup> matchGroupList = [];
      if (!map.containsKey('nd') && !map.containsKey('ld')) {
        List mapList = map.values.toList().safeFirst ?? [];
        List<Map<String, dynamic>> list = [];
        for (var element in mapList) {
          list.add(element as Map<String, dynamic>);
        }
        matchGroupList = _handleList(list, SectionGroupEnum.ALL, isTidGroup);
        matchGroupList.safeFirst?.isSectionHeader = true;
        matchGroupList.safeFirst?.isSportHeader = true;
      } else {
        //nd 进行中 ld 为开始
        List<Map<String, dynamic>> nd = JsonUtil.getObjectList(
            map['nd'], (v) => v as Map<String, dynamic>) ??
            [];
        List<Map<String, dynamic>> ld = JsonUtil.getObjectList(
            map['ld'], (v) => v as Map<String, dynamic>) ??
            [];
        List<MatchGroup> ndList =
        _handleList(nd, SectionGroupEnum.IN_PROGRESS, isTidGroup);
        ndList.safeFirst?.isSectionHeader = true;
        ndList.safeFirst?.isSportHeader = true;
        List<MatchGroup> ldList =
        _handleList(ld, SectionGroupEnum.NOT_STARTED, isTidGroup);
        ldList.safeFirst?.isSectionHeader = true;
        ldList.safeFirst?.isSportHeader = true;
        matchGroupList.addAll(ndList);
        matchGroupList.addAll(ldList);
      }
      return CombineInfo.generateFromList(matchGroupList);
    } catch (e) {
      AppLogger.debug('getMatchGroup error: $e');
      return [];
    }
  }

  List<MatchGroup> _handleList(List<Map<String, dynamic>> list,
      SectionGroupEnum sectionGroupEnum, bool isTidGroup) {
    try {
      List<MatchGroup> matchGroupList = [];
      int totalNum = 0;
      for (var item in list) {
        String tid = item['tid'];
        TeamEntity? teamEntity = originData.tidsObj
            .firstWhereOrNull((element) => element.tid == tid);
        List<String> mids = item['mids'].cast<String>();
        List<MatchEntity> matchList = originData.matchsList
            .where((element) => mids.contains(element.mid))
            .toList();
        if (matchList.isEmpty) continue;
        String csna = originData.spList
            .firstWhereOrNull((element) =>
        element.csid == (matchList.safeFirst?.csid ?? ''))
            ?.csna ??
            '';
        totalNum += matchList.length;
        if (isTidGroup) {
          MatchGroup matchGroup = MatchGroup(
              tn: teamEntity?.tn ?? '',
              tid: tid,
              matches: matchList,
              isSectionHeader: false,
              sectionGroupEnum: sectionGroupEnum,
              isSportHeader: false,
              sportTitle: csna,
              sportCount: matchList.length,
              csid: matchList.safeFirst?.csid ?? '');
          matchGroupList.add(matchGroup);
        } else {
          matchGroupList.addAll(
            matchList
                .map(
                  (e) => MatchGroup(
                  tn: teamEntity?.tn ?? '',
                  tid: tid,
                  matches: [e],
                  isSectionHeader: false,
                  sectionGroupEnum: sectionGroupEnum,
                  isSportHeader: false,
                  sportTitle: csna,
                  sportCount: matchList.length,
                  csid: e.csid),
            )
                .toList(),
          );
        }
      }
      matchGroupList.safeFirst?.sportCount = totalNum;
      return matchGroupList;
    } catch (e) {
      AppLogger.debug('handleList error: $e');
      return [];
    }
  }

  ///根据sportID和菜单menuid获取联赛配置
  List getLeagure(
      String menuId,
      String sportId,
      ) {
    return tournamentMatchMap[menuId + sportId] ?? [];
  }

  updateDjMenuCount(String sportMi, int count) {
    String menuId = SportConfig.EsportsPage.sportId.toString();
    SportConfigInfo? sportConfigInfo = menuMap[menuId];
    if (!ObjectUtil.isEmptyList(sportConfigInfo?.sl)) {
      for (SportConfigInfo item in sportConfigInfo!.sl!) {
        if (item.mi == sportMi) {
          if (item.ct != count) {
            item.ct = count;
          }
        }
      }
    }
  }
}