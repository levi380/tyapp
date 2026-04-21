import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/bet_item_collection.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/request_status.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';

import '../detail_api_service.dart';
import 'odds_action_logic.dart';


/// 盘口数据处理逻辑
extension OddsDataProcessLogic on MatchDetailController {
  
  /// 处理 API 返回的盘口数据
  void dataHandle(ApiRes<List<dynamic>> res, bool noLoading) {
    detailState.oddsInfoRequestStatus = RequestStatus.success;
    
    if (!res.success) return; // 失败直接返回，或者处理错误逻辑

    if (ObjectUtil.isEmptyList(res.data)) {
      detailState.oddsInfoIsNoData = true;
      detailState.oddsInfoList.clear();
      // 切换赛事 (Assumed to be defined in MatchDetailController or other extensions)
      eventSwitch();
      return;
    }

    detailState.oddsInfoIsNoData = false;
    detailState.oddsInfoRequestCount = 0;

    // 处理 VR 体育热门数据
    final hotIndex = res.data?.indexWhere((e) => e.containsKey("hotName")) ?? -1;
    if (hotIndex != -1 && res.data != null) {
      List<dynamic> plays = res.data![hotIndex]["plays"];
      res.data!.removeAt(hotIndex);
      res.data!.insertAll(hotIndex, plays);
    }

    // JSON 转对象
    List<MatchHps> temp = EntityFactory.generateOBJ<List<MatchHps>>(res.data) ?? [];
    
    // 获取数据仓库中的 MatchEntity 用于比对
    MatchEntity? match = DataStoreController.to.getMatchById(detailState.mId);

    // 更新状态
    detailState.oddsInfoList = temp;

    // 合并冠军投注项
    for (var championMatch in detailState.championMatchs) {
      detailState.oddsInfoList.addAll(championMatch.hps);
    }

    // 遍历处理每个盘口数据
    for (int i = 0; i < detailState.oddsInfoList.length; i++) {
        final hps = detailState.oddsInfoList[i];
        
        // 记录索引，用于取消置顶时恢复位置
        hps.index = i;
        
        // 检查是否已经在置顶列表中，恢复 hton 状态
        final topIndex = detailState.playTopList.indexWhere((item) => item.topKey == hps.topKey);
        if (topIndex > -1) {
          hps.hton = detailState.playTopList[topIndex].hton;
        }

        // 恢复展开/收起状态 (默认展开)
        final showKey = "${hps.hpid}_${hps.topKey}_${hps.hid}";
        hps.hshow = detailState.hShowMap[showKey] ?? SHOW_YES;

        // 获取仓库中的对应数据
        MatchHps? dataStoreHps = match?.allHps.firstWhereOrNull(
          (element) => element.hpid == hps.hpid && element.chpid == hps.chpid
        );

        // 处理投注项集合
        hps.collection = [];
        hps.otherCollection = [];
        
        for (MatchHpsHl hl in hps.hl) {
          for (MatchHpsHlOl ol in hl.ol) {
            // VR 体育锁盘处理
            if (Get.currentRoute == Routes.vrSportDetail && detailState.vrLockStatus) {
              ol.os = 2;
            }

            ol.isDetail = true;
            
            // 数据仓库版本比对
            // 如果接口数据版本(ctsp) >= 仓库版本，则更新仓库并显示
            // 否则检查仓库是否有数据，有则显示
            if (hps.ctsp.toInt() >= (dataStoreHps?.ctsp.toInt() ?? 0)) {
               DataStoreController.to.updateOl(ol);
               _buildCollection(ol, hl, hps);
            } else {
               final dataStoreOl = DataStoreController.to.getOlById(ol.oid);
               if (dataStoreOl != null && dataStoreHps != null) {
                  _buildCollection(ol, hl, hps);
               }
            }
          }
        }
    }

    // 更新 chpids 映射
    detailState.chpids.clear();
    for (var item in detailState.oddsInfoList) {
      if (detailState.isResult) {
        detailState.chpids[item.topKey] = item.topKey;
      } else {
        detailState.chpids[item.chpid] = item.chpid;
      }
    }
  }

  /// 构建投注项集合 (原 getCollection)
  void _buildCollection(MatchHpsHlOl ol, MatchHpsHl hl, MatchHps hps) {
    var item = BetItemCollection(ol: ol, hl: hl);
    hps.collection.add(item);
    hps.allCollection.add(item);
  }

  /// 初始化赛果详情状态
  void initResultDetailOddsInfo(MatchEntity match) {
    detailState.mId = match.mid;
    detailState.csid = match.csid;
    detailState.match = match;
    // 默认全展开
    detailState.getFewer.value = 1;

    detailState.isDJDetail = MatchUtil.isEsport(match);
    detailState.isResult = true;
  }
}
