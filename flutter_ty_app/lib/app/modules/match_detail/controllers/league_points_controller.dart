import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_tools_methods.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import '../../login/login_head_import.dart';
import '../models/request_status.dart';
import 'services/league_points_service.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛积分积分主控制器主要操作方法
    - 积分列表
    - 积分页面切换
    】】】
 *
 */
class LeaguePointsController extends GetxController {
  LeaguePointsController({required this.tag});
  LeaguePointsState state = LeaguePointsState();
  final String tag;

  /// 控制器初始化方法
  /// 初始化头部数据
  @override
  void onInit() {
    super.onInit();

    init();
  }

  /// 控制器关闭方法
  /// 释放滚动控制器
  @override
  onClose() {
    super.onClose();
    state.scrollController.dispose();
  }

  /**
   * 初始化头部数据
   * 请求VS信息（支持两种版本的数据结构）
   */
  init() {
    requestVSInfo();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
      【【【 AUTO_PARAGRAPH_TITLE 赛事分析控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      -1 主队
      2  从队
   *
   */
  int getTeamNameType(String team) {
    int result = 0;
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);

    final match = controller.detailState.match;
    if (match != null) {
      String homeName = getTeamName(type: 1, match: match);
      if (homeName == team) {
        return 1;
      }
      String awayName = getTeamName(type: 2, match: match);
      if (awayName == team) {
        return 2;
      }
    }
    return result;
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
      【【【 AUTO_DOCUMENT_TITLE 赛事分析】】】
      【【【 AUTO_PARAGRAPH_TITLE 赛事分析控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 请求接口数据
      此处存在两个版本  一个是旧版本vsInfoVersion3   一个是新版本vsInfoVersion2
   *
   */
  /// 请求VS信息
  /// [flag] 标志，默认为空字符串
  /// 支持两种版本的数据结构：version2（杯赛结构）和version3
  requestVSInfo({String flag = ""}) async {
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);
   // print("=============>tag  ${tag}");
    final match = controller.detailState.match;
    if (match?.tc == 2) {
      flag = "0";
    } else {
      flag = "0";
    }
    state.requestStatus = RequestStatus.success;
    try {
      // 先请求version2接口（杯赛结构）
      var res =
          await AnalyzeDetailApi.instance().vsInfoVersion2(tag, "2", flag);
      state.version=LeaguePointVersion.version2;

      if (res.success && res.data?.isNotEmpty == true) {
        // 判断数据结构：如果teamRankings为空，说明是version3结构
        if (res.data![0].teamRankings.isEmpty) {
          state.version=LeaguePointVersion.version3;
         }
        // 第一种数据结构：杯赛结构（version2），teamRankings不为空
        if(state.version==LeaguePointVersion.version2) {
          LeaguePointsService.processVSInfoVersion2Data(state, res.data ?? []);
          if (state.currentCupBasketBallEventDataEvents.isNotEmpty) {
            setCurrentCupBasketBallEventPageIndex(
                state.currentCupBasketBallEventDataEvents[
                state.currentCupBasketBallEventPageIndex]);
            LeaguePointsService.collectionData(state, pageIndex:state.currentCupBasketBallEventPageIndex);
            state.requestStatus = RequestStatus.success;
          }
        }else if(state.version==LeaguePointVersion.version3) {
          // 第二种数据结构：联赛结构（version3），需要重新请求version3接口
          final resVerison3 =  await AnalyzeDetailApi.instance().vsInfoVersion3(tag, "2", flag);
          state.version3MatchAnalyzeVsInfoDataList=  resVerison3.data ?? [];
          LeaguePointsService.collectionData(state);
          state.requestStatus = RequestStatus.success;
        }
        update();
      }
    } catch (e) {
      RequestStatus.fail;
      AppLogger.debug("MatchCupPointController fetchVSInfo" + e.toString());
    } finally {
      update();
    }
  }

  /// 获取队伍名称颜色索引
  /// [team] 队伍名称
  /// 返回1表示主队，2表示客队，0表示未找到
  int getTeamNameColorIndex(String team) {
    int result = 0;
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);

    final match = controller.detailState.match;
    if (match != null) {
      String homeName = getTeamName(type: 1, match: match);
      if (homeName == team) {
        return 1;
      }
      String awayName = getTeamName(type: 2, match: match);
      if (awayName == team) {
        return 2;
      }
    }
    return result;
  }

  /// 设置展开/收起状态
  setExpand() {
    state.expand = !state.expand;
    update();
  }

  /// 设置当前杯赛篮球事件页面索引
  /// [e] 分析VS信息新信息实体
  void setCurrentCupBasketBallEventPageIndex(AnalyzeVsInfoNewInfoEntity e) {
    int result = -1;
    for (int i = 0; i < state.currentCupBasketBallEventDataEvents.length; i++) {
      AnalyzeVsInfoNewInfoEntity item =
          state.currentCupBasketBallEventDataEvents[i];
      if (e.rankingName == item.rankingName) {
        result = i;
        break;
      }
    }

    if (result < 0) {
      return;
    }
    state.currentCupBasketBallEventPageIndex = result;
    LeaguePointsService.collectionData(state, pageIndex:state.currentCupBasketBallEventPageIndex);
    update();
  }

}
