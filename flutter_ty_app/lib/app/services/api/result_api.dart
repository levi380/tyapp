import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/get_filter_match_list_all_entity.dart';
import '../models/res/get_filter_match_list_entity.dart';
import '../models/res/get_filter_match_list_new_d_entity.dart';
import '../models/res/analyze_live_video_event_entity.dart';
import '../models/res/get_h5_order_list_entity.dart';
import '../models/res/get_notice_list_by_id_entity.dart';
import '../models/res/mchampion_match_result_entity.dart';
import '../models/res/playback_video_url_entity.dart';
import '../models/res/query_league_template_list_entity.dart';
import '../models/res/query_tournament_score_result_entity.dart';
import '../models/res/virtual_menus_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'result_api.g.dart';

@RestApi()
abstract class ResultApi {
  factory ResultApi(Dio dio, {String baseUrl}) = _ResultApi;

  factory ResultApi.instance() => ResultApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取联赛数据按照国家排序
  ///
  /// [type] - 类型
  /// [euid] - 用户ID
  /// [inputText] - 输入文本
  /// [cuid] - 客户端ID
  /// [device] - 设备类型
  /// [showem] - 显示标志
  /// [md] - 模式
  @GET("/yewu11/v1/m/getFilterMatchList")
  Future<GetFilterMatchListEntity> getFilterMatchList(
    @Query('type') int type,
    @Query('euid') String euid,
    @Query('inputText') String inputText,
    @Query('cuid') String? cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') String md,
  );

  /// 获取联赛数据按照国家排序（全部）
  ///
  /// [type] - 类型
  /// [euid] - 用户ID
  /// [inputText] - 输入文本
  /// [cuid] - 客户端ID
  /// [device] - 设备类型
  /// [showem] - 显示标志
  /// [md] - 模式
  @GET("/yewu11/v1/m/getFilterMatchList")
  Future<GetFilterMatchListAllEntity> getFilterMatchListAll(
    @Query('type') int type,
    @Query('euid') String euid,
    @Query('inputText') String inputText,
    @Query('cuid') String? cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') String md,
  );

  /// 获取联赛数据
  ///
  /// [type] - 类型
  /// [euid] - 用户ID
  /// [inputText] - 输入文本
  /// [cuid] - 客户端ID
  /// [device] - 设备类型
  /// [showem] - 显示标志
  /// [md] - 模式
  @GET("/yewu11/v1/m/getFilterMatchListNew")
  Future<GetFilterMatchListNewDEntity> getFilterMatchListNew(
    @Query('type') int type,
    @Query('euid') String euid,
    @Query('inputText') String inputText,
    @Query('cuid') String cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') String md,
  );

  /// 获取赛果数据
  ///
  /// [category] - 类别
  /// [cuid] - 客户端ID
  /// [device] - 设备类型
  /// [euid] - 用户ID
  /// [hpsFlag] - HPS标志
  /// [md] - 模式
  /// [showem] - 显示标志
  /// [sort] - 排序
  /// [tid] - TID
  /// [type] - 类型
  @POST("/yewu11/v1/m/matcheResultPB")
  Future<ApiRes<List<MatchEntity>>> matcheResult(
    @Field('category') int category,
    @Field('cuid') String cuid,
    @Field('device') String device,
    @Field('euid') String euid,
    @Field('hpsFlag') String hpsFlag,
    @Field('md') String md,
    @Field('showem') int showem,
    @Field('sort') int sort,
    @Field('tid') String tid,
    @Field('type') int type,
  );

  /// 获取赛果详情
  ///
  /// [mcid] - MCID
  /// [mid] - MID
  /// [cuid] - 客户端ID
  /// [isESport] - 是否电子竞技
  @Extra({kRetryable: true, KRetryCode: '0401038'})
  @GET("/yewu11/v1/m/matchDetail/getMatchResult")
  Future<ApiRes<List<dynamic>>> getMatchResult(
    @Query('mcid') int mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('isESport') String? isESport,
  );

  /// 获取赛果详情
  ///
  /// [mid] - MID
  /// [type] - 类型
  /// [cuid] - 客户端ID
  /// [isESport] - 是否电子竞技
  @GET("/yewu11/v1/m/matchDetail/getResultMatchDetail")
  Future<ApiRes<MatchEntity>> getResultMatchDetail(
    @Query('mid') String mid,
    @Query('type') int type,
    @Query('cuid') String cuid,
    @Query('isESport') String isESport, {
    @Query('isNew') int? isNew,
  });

  /// 获取精选赛果
  ///
  /// [cuid] - 客户端ID
  /// [sportId] - 运动项目ID
  @POST("/yewu11/v1/m/matcheHandpick")
  Future<ApiRes<List<MatchEntity>>> matcheHandpick(
    @Field('cuid') String cuid,
    @Field('sportId') String sportId,
  );

  /// 获取回放视频URL
  ///
  /// [device] - 设备类型
  /// [eventCode] - 事件代码
  /// [mid] - MID
  @POST("/yewu11/v1/w/playbackVideoUrl")
  Future<PlaybackVideoUrlEntity> playbackVideoUrl(
    @Field('device') String device,
    @Field('eventCode') String eventCode,
    @Field('mid') String mid,
  );

  /// 获取实时事件
  ///
  /// [mid] - MID
  /// [flag] - 标志
  @GET("/yewu11/v2/matchAnalysis/liveEvents")
  Future<AnalyzeLiveVideoLiveEventEntityEntity> liveEvents(
    @Query('mid') String mid,
    @Query('flag') String flag,
    @Query('sportId') String sportId,
  );

  /// 获取走势事件
  ///
  /// [device] - 设备类型
  /// [eventCode] - 事件代码
  /// [mid] - MID
  @POST("/yewu11/v2/matchAnalysis/zoushiEvents")
  Future<AnalyzeLiveVideoEventEntity> zoushiEvents(
    @Field('device') String device,
    @Field('eventCode') String eventCode,
    @Field('mid') String mid,
  );

  /// 获取冠军赛果
  ///
  /// [category] - 类别
  /// [cuid] - 客户端ID
  /// [device] - 设备类型
  /// [endTime] - 结束时间
  /// [euid] - 用户ID
  /// [isVirtualSport] - 是否虚拟体育
  /// [md] - 模式
  /// [orderBy] - 排序方式
  /// [sort] - 排序
  /// [sportType] - 运动类型
  /// [startTime] - 开始时间
  /// [type] - 类型
  @Extra({kThrottleAbleKey: true, kThrottleDurtionKey: 1000})
  @POST("/yewu11/v1/m/championMatchResult")
  Future<MchampionMatchResultEntity> championMatchResult(
    @Field('category') int category,
    @Field('cuid') String cuid,
    @Field('device') String device,
    @Field('endTime') String endTime,
    @Field('euid') int euid,
    @Field('isVirtualSport') int isVirtualSport,
    @Field('md') String md,
    @Field('orderBy') int orderBy,
    @Field('sort') int sort,
    @Field('sportType') int sportType,
    @Field('startTime') String startTime,
    @Field('type') int type,
    @Field('tid') String tid,
  );

  /// 获取我的注单
  ///
  /// [matchId] - 比赛ID
  /// [orderBy] - 排序方式
  /// [orderStatus] - 订单状态
  /// [timeType] - 时间类型
  @POST("/yewurecord/order/betRecord/getH5OrderList")
  Future<GetH5OrderListEntity> resultGetH5OrderList(
    @Field('matchId') String matchId,
    @Field('orderBy') int orderBy,
    @Field('orderStatus') String orderStatus,
    @Field('timeType') int timeType,
  );

  /// 获取VR菜单
  @GET("/yewu11/v1/w/virtual/menus")
  Future<VirtualMenusEntity> getVirtualMenus();

  /// 获取VR 列表数据
  @POST("/yewu11/v1/orderScoreResult/queryTournamentScoreResult")
  Future<QueryTournamentScoreResultEntity> getQueryTournamentScoreResult(
    @Body() body,
  );

  /// 篮球足球运营模版
  ///
  /// [uid] - 用户ID
  @POST("/yewu12/user/queryLeagueTemplateList")
  Future<QueryLeagueTemplateListEntity> queryLeagueTemplateLis(
    @Field('uid') String uid,
  );

  /// 赛果列表公告
  ///
  /// [uid] - 用户ID
  @POST("/yewu11/v2/notice/getNoticeListById")
  Future<GetNoticeListByIdEntity> getNoticeListById(
    @Field('matchManageId') String uid,
  );
}
