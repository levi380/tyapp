import 'package:dio/dio.dart';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/constants/detail_constant.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/request_status.dart';
import 'package:flutter_ty_app/app/services/api/match_detail_api.dart';
import 'package:flutter_ty_app/app/services/api/result_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import 'odds_data_process_logic.dart';
import 'odds_filter_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-aca87e59-d4c3-49f4-afe7-e3c4b40c0a3e 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 详情投注列表以及赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情投注列表以及赛果列表逻辑处理相关】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口数据3秒轮训机制，盘口请求返回后3秒轮训
    - 相关接口：普通赛事赛果、vr体育赛事赛果、vr虚拟体育盘口、电竞盘口、常规赛事盘口
    - 数据请求成功后更新到数据仓库，并且筛选数据，按照模板展示
    】】】
 *
 */
extension OddsFetchLogic on MatchDetailController {
  
  /// 轮询盘口数据
  void repeatOddsInfo({bool noLoading = false}) async {
    // 如果没有正在进行的置顶操作且已经结束滚动，则刷新数据
    if (!detailState.topOpRequest && detailState.endScroll) {
      await refreshOddsInfoData(refresh: true, noLoading: noLoading);
    }
    
    // 延迟3秒后再次轮询
    3.seconds.delay(() {
      if (isClosed) return;
      
      repeatOddsInfo(noLoading: true);
      // 通知购物车刷新
      Bus.getInstance().emit(EventType.matchTimerFetch, null);
      // 冠军引导盘
      fetchOutrightDisplayMatchs(); // 假设这个方法在 Controller 中或者其他扩展中
    });
  }

  /// 刷新盘口数据
  /// [refresh] 是否强制刷新
  /// [noLoading] 是否不显示 Loading
  /// [showType] ws调时showType = 2
  Future<void> refreshOddsInfoData({
    bool refresh = false,
    bool noLoading = false,
    int? showType,
  }) async {
    // 只要有数据，就不显示无数据页面
    if (detailState.oddsInfoList.isNotEmpty) {
      detailState.oddsInfoIsNoData = false;
    }

    // 只有在强制刷新、列表为空、或者当前赛事ID不一致时才请求
    if (refresh ||
        detailState.oddsInfoList.isEmpty ||
        detailState.mId != detailState.oddsInfoList[0].mid) {
      
      final mid = detailState.mId;
      
      try {
        if (!noLoading) {
          // 非静默刷新显示 loading
          detailState.oddsInfoRequestStatus = RequestStatus.loading;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
          });
        }

        final res = await _fetchOddsApi(mid, showType);
        
        // 处理返回数据 (定义在 OddsDataProcessLogic 中)
        dataHandle(res, noLoading);
      } on DioException {
        if (!noLoading) {
          detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        }
      } catch (e) {
        AppLogger.debug("oddsInfoError: $e");
      } finally {
        // 最终状态检查
        detailState.oddsInfoIsNoData = detailState.oddsInfoList.isEmpty;

        // 如果还在 loading 且无数据，说明其实是失败了（这里简化了原逻辑）
        if (detailState.oddsInfoRequestStatus == RequestStatus.loading &&
            detailState.oddsInfoList.isEmpty) {
          detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        }
      }
    }

    // 过滤并更新 UI (定义在 OddsFilterLogic 中)
    filterOddsInfo();

    // 如果是 WS 推送 (showType == 2)，且正在滚动，则不更新 UI，避免跳动，否则更新
    // 原代码逻辑：if (showType == 2) { if (endScroll) update... } else { update... }
    // 简化如下：
    if (showType != 2 || detailState.endScroll) {
       update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
    }
  }

  /// 内部方法：统一处理 API 请求分发
  Future<ApiRes<List<dynamic>>> _fetchOddsApi(String mid, int? showType) {
    final route = Get.currentRoute;
    final uid = TYUserController.to.getUid();
    
    // 1. 赛果详情
    if (route == Routes.matchResultsDetails) {
       return ResultApi.instance().getMatchResult(
          0,
          mid,
          uid,
          detailState.isDJDetail ? "1" : null,
       );
    }
    
    // 2. VR 体育
    if (route == Routes.vrSportDetail) {
      if (detailState.isVrGameEnd) {
        return MatchDetailApi.instance().getVirtualMatchResult(detailState.curCategoryTabId, mid);
      } else {
        return MatchDetailApi.instance().getVirtualMatchOddsInfo(
          detailState.curCategoryTabId, 
          mid, 
          uid, 
          showType: 2
        );
      }
    }
    
    // 3. 电竞
    if (detailState.isDJDetail) {
      return MatchDetailApi.instance().getESMatchOddsInfo(
        "0", 
        mid,
        uid,
        showType: showType
      );
    }
    
    // 4. 普通赛事详情
    return MatchDetailApi.instance().getMatchOddsInfo1(
      "0",
      mid,
      uid,
      0, // 原代码此处为 0，注释掉了 showType
    );
  }
}
