import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_v_s_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/front_fight_p_b_bean_entity_electronic_football_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/season_stats_p_b_bean_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/analyze_array_person_entity.dart';
import '../models/res/analyze_news_entity.dart';
import '../models/res/historical_performance_p_b_bean_entity.dart';
import '../models/res/historical_performance_p_b_bean_entity_electronic_football_entity.dart';
import '../models/res/match_analyze_vs_info_entity.dart';
import '../models/res/match_playback_video_info_entity.dart';
import '../models/res/odd_report_analyze_data_entity.dart';
import '../models/res/statistics_front_fight_entity.dart';
import '../models/res/statistics_tab_switch_entity.dart';
import '../models/res/statistics_team_vs_other_team_entity.dart';
import '../models/res/statistics_technical_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'analyze_detail_api.g.dart';

@RestApi()
abstract class AnalyzeDetailApi {
  factory AnalyzeDetailApi(Dio dio, {String baseUrl}) = _AnalyzeDetailApi;

  factory AnalyzeDetailApi.instance() =>
      AnalyzeDetailApi(AppDio.getInstance().dio,
          baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取精彩回放视频URL
  ///
  /// [mid]: 匹配ID
  /// [device]: 设备类型
  /// [eventCode]: 事件代码
  @POST("/yewu11/v1/w/playbackVideoUrlPB")
  Future<ApiRes<MatchPlaybackVideoInfoEntity>> playbackVideoUrl(
    @Field('mid') String? mid,
    @Field('device') String? device,
    @Field('eventCode') String? eventCode,
  );

  /// 获取近期战绩信息
  ///
  /// [mid]: 匹配ID
  /// [flag]: 标志
  /// [t]: 时间戳
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<AnalyzeVSInfoEntity>>> vsInfo(
      @Query('mid') String? mid, @Query('flag') String? flag);

  /// 获取新的近期战绩信息
  ///
  /// [mid]: 匹配ID
  /// [type]: 类型
  /// [flag]: 标志
  /// [t]: 时间戳
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>> vsInfoNew(
    @Query('mid') String? mid,
    @Query('type') String? type,
    @Query('flag') String? flag,
  );

  /// 获取合并的近期战绩杯赛信息
  ///
  /// [mid]: 匹配ID
  /// [type]: 类型
  /// [flag]: 标志
  /// [t]: 时间戳
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<AnalyzeVsInfoNewInfoTeamRankings>>> vsInfoCombined(
    @Query('mid') String? mid,
    @Query('type') String? type,
    @Query('flag') String? flag,
    @Query('t') String? t,
  );

  /// 获取团队VS历史记录
  ///
  /// [mid]: 匹配ID
  /// [flag]: 标志
  /// [cps]: 比赛阶段
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/teamVSHistory")
  Future<ApiRes<List<AnalyzeTeamVsHistoryEntity>>> teamVSHistory(
    @Query('mid') String? mid,
    @Query('flag') String? flag,
    @Query('cps') String? cps,
  );

  /// 获取团队与其他团队的交手记录
  ///
  /// [mid]: 匹配ID
  /// [flag]: 标志
  /// [cps]: 比赛阶段
  /// 获取团队与其他团队的交手记录
  ///
  /// [mid]: 匹配ID
  /// [flag]: 标志
  /// [cps]: 比赛阶段
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/teamVsOtherTeam")
  Future<ApiRes<StatisticsTeamVsOtherTeamEntity>> teamVsOtherTeam(
    @Query('mid') String? mid,
    @Query('flag') String? flag,
    @Query('cps') String? cps,
  );

  /// 获取比赛分析数据
  ///
  /// [parentMenuId]: 父菜单ID
  /// [sonMenuId]: 子菜单ID
  /// [standardMatchId]: 标准比赛ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData")
  Future<ApiRes<Map<String, dynamic>>> getMatchAnalysiseData(
    @Field('parentMenuId') String? parentMenuId,
    @Field('sonMenuId') String? sonMenuId,
    @Field('standardMatchId') String? standardMatchId,
  );

  /// 获取淘汰赛信息
  ///
  /// [stId]: 联赛ID
  /// [trg]: 目标
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/knockoutInfo")
  Future<ApiRes<Map<String, dynamic>>> getKnockoutInfo({
    @Query('mid') String? mid,
    @Query('stId') String? stId,
  });

  /// 获取正面交手数据
  ///
  /// [mid]: 联赛ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statistics/frontFightPB")
  Future<ApiRes<StatisticsFrontFightEntity>> getFrontFight({
    @Field('mid') String? mid,
  });

  /// 获取正面交手数据（电子足球）
  ///
  /// [mid]: 联赛ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statisticsC01/frontFight")
  Future<ApiRes<List<FrontFightPBBeanEntityElectronicFootballEntity>>>
      getFrontFightPBForElectronicFootball({
    @Field('mid') String? mid,
  });

  /// 获取历史表现数据
  ///
  /// [mid]: 联赛ID
  /// [flag]: 标志
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statistics/historicalPerformance")
  Future<ApiRes<List<HistoricalPerformancePBBeanEntity>>>
      getHistoricalPerformancePB({
    @Field('mid') String? mid,
    @Field('flag') String? flag,
  });

  /// 获取历史表现数据（电子足球）
  ///
  /// [mid]: 联赛ID
  /// [flag]: 标志
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statisticsC01/historicalPerformance")
  Future<
          ApiRes<
              List<HistoricalPerformancePBBeanEntityElectronicFootballEntity>>>
      getHistoricalPerformancePBElectronicFootball({
    @Field('mid') String? mid,
    @Field('flag') String? flag,
  });

  /// 获取赛季统计数据
  ///
  /// [mid]: 联赛ID
  /// [flag]: 标志
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statistics/seasonStatsPB")
  Future<ApiRes<List<SeasonStatsPBBeanEntity>>> getSeasonStatsPB({
    @Field('mid') String? mid,
    @Field('flag') String? flag,
  });

  /// 获取走势图数据
  ///
  /// [matchId]: 比赛ID
  /// [playId]: 玩法ID
  /// [sportId]: 运动项目ID
  /// [matchType]: 比赛类型
  /// [marketValue]: 市场价值
  /// [playType]: 玩法类型
  /// [period]: 周期
  /// [oddsType]: 赔率类型
  /// [marketId]: 市场ID
  /// [dataSourceCodes]: 数据源代码列表
  /// [isdy]: 是否动态
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/matchAnalysis/oddsReportData")
  Future<ApiRes<OddReportAnalyzeDataEntity>> getMultipleOddsReportList({
    @Field('matchId') String? matchId,
    @Field('playId') String? playId,
    @Field('sportId') String? sportId,
    @Field('matchType') String? matchType,
    @Field('marketValue') String? marketValue,
    @Field('playType') String? playType,
    @Field('period') String? period,
    @Field('oddsType') String? oddsType,
    @Field('marketId') String? marketId,
    @Field('dataSourceCodes') List<String>? dataSourceCodes,
    @Field('isdy') bool? isdy,
  });

  /// 增加文章阅读数
  ///
  /// [id]: 文章ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/art/addArticleCount")
  Future<ApiRes<String>> addArticleCount(
    @Field('id') String? id,
  );

  /// 获取文章内容
  ///
  /// [matchId]: 比赛ID
  /// [type]: 类型
  /// [t]: 时间戳
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/art/getArticle")
  Future<ApiRes<AnalyzeNewsEntity>> getArticle(
    @Query('matchId') String? matchId,
    @Query('type') String? type,
  );

  /// 获取比赛阵容列表
  ///
  /// [matchInfoId]: 比赛信息ID
  /// [homeAway]: 主场或客场
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/matchLineup/getMatchLineupList")
  Future<ApiRes<AnalyzeArrayPersonEntity>> getMatchLineupList(
    @Query('matchInfoId') String? matchInfoId,
    @Query('homeAway') String? homeAway,
  );

  /// 获取收藏的文章
  ///
  /// [id]: 文章ID
  /// [matchId]: 比赛ID
  @GET("/yewu11/v1/art/getFavoriteArticle")
  Future<ApiRes<List<AnalyzeNewsEntity>>> getFavoriteArticle(
    @Query('id') String? id,
    @Query('matchId') String? matchId,
  );

  // 赛事分析足球篮球权限接口
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statistics/tabSwitch")
  Future<ApiRes<StatisticsTabSwitchEntity>> statisticsTabSwitch(
    @Field('mid') String? mid,
  );

  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<MatchAnalyzeVsInfoEntity>>> vsInfoVersion3(
    @Query('mid') String? mid,
    @Query('type') String? type,
    @Query('flag') String? flag,
  );

  /// 获取合并的近期战绩信息
  ///
  /// [mid]: 匹配ID
  /// [type]: 类型
  /// [flag]: 标志
  /// [t]: 时间戳
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>> vsInfoVersion2(
    @Query('mid') String? mid,
    @Query('type') String? type,
    @Query('flag') String? flag,
  );

  ///
  /// [mid]: 联赛ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v2/statistics/technicalPB")
  Future<ApiRes<List<StatisticsTechnicalEntity>>> getTechnicalPBBasketBall({
    @Field('mid') String? mid,
  });
}
