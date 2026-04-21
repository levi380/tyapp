import 'package:dio/dio.dart';

import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/MatchEsportEntity.dart';
import 'package:flutter_ty_app/app/services/models/res/collection_info.dart';
import 'package:flutter_ty_app/app/services/models/res/discount_odd_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/fireworks_activity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/get_odd_count_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_all_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/added_odds_matches_entity.dart';
import '../models/res/api_res.dart';
import '../models/res/champion_match_result_entity.dart';
import '../models/res/event_info_entity.dart';
import '../models/res/match_base_info_entity.dart';
import '../models/res/pin_info_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'match_api.g.dart';

@RestApi()
abstract class MatchApi {
  factory MatchApi(Dio dio, {String baseUrl}) = _MatchApi;

  factory MatchApi.instance() =>
      MatchApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取冠军赛事结果
  /// 
  /// 通过指定的参数获取冠军赛事结果。
  /// 
  /// [euid] - 赛事ID
  /// [type] - 类型
  /// [orderBy] - 排序方式
  /// [category] - 类别
  /// [startTime] - 开始时间
  /// [endTime] - 结束时间
  @POST("/championMatchResult")
  Future<ChampionMatchResultEntity> championMatchResults(
    @Query("euid") String euid,
    @Query("type") int type,
    @Query("orderBy") int orderBy,
    @Query("category") int category,
    @Query("startTime") String startTime,
    @Query("endTime") String endTime,
  );

  /// 获取定时烟花活动信息
  /// 
  /// 通过指定的 `requestid` 获取定时烟花活动信息。
  /// 
  /// [requestid] - 请求ID
  @Extra({kRetryable: true})
  @POST('/yewu12/fireworksActivity/getFireworksActivity')
  Future<ApiRes<List<FireworksActivityEntity>>> getFireworksActivity(
    @Field('requestid') String requestid,
  );

  /// 获取用户播放定时烟花记录
  /// 
  /// 通过指定的 `requestid` 和 `id` 获取用户播放定时烟花记录。
  /// 
  /// [requestid] - 请求ID
  /// [id] - 记录ID
  @Extra({kRetryable: true})
  @POST('/yewu12/fireworksActivity/getUserPlayInfo')
  Future getUserPlayInfo(
    @Field('requestid') String requestid,
    @Field('id') String id,
  );

  /// 保存用户播放定时烟花记录
  /// 
  /// 通过指定的 `id` 和 `isPlayed` 保存用户播放定时烟花记录。
  /// 
  /// [id] - 记录ID
  /// [isPlayed] - 是否已播放（0: 否, 1: 是）
  /// [requestid] - 请求ID
  @Extra({kRetryable: true})
  @POST('/yewu12/fireworksActivity/saveUserPlayInfo')
  Future saveUserPlayInfo(
    @Field('id') String id,
    @Field('isPlayed') String isPlayed,
    @Field('requestid') String requestid,
  );

  /// 获取列表项弹出提示数据
  /// 
  /// 获取列表项弹出提示数据。
  @GET("/yewu11/v1/w/eventInfo")
  Future<EventInfo2Entity> getEventInfo();

  /// 收藏赛事
  /// 
  /// 通过指定的参数收藏赛事。
  /// 
  /// [cuid] - 用户客户端ID
  /// [euid] - 赛事ID
  /// [sort] - 排序方式
  /// [type] - 赛事类型
  /// [device] - 设备类型（默认值为 'v2_h5_st'）
  /// [md] - 设备型号（默认值为 null）
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/m/matchesCollectNewH5V2PB")
  Future<ApiRes<List<MatchEntity>>> matchesCollectNewH5(
      @Field('cuid') String cuid,
      @Field('euid') String euid,
      @Field('sort') int sort,
      @Field('type') int type,
      [@Field('device') String? device = 'v2_h5_st',
      @Field('md') String? md = null]);

  /// 获取用户个性化设置
  /// 
  /// 通过指定的 `paramKey` 和 `uid` 获取用户个性化设置。
  /// 
  /// [paramKey] - 参数键列表
  /// [uid] - 用户ID
  @Extra({kRetryable: true})
  @POST("/yewu12/user/getUserPersonaliseNew")
  Future<ApiRes<Map<String, dynamic>>> getUserPersonaliseNew(
    @Field('paramKey') List paramKey,
    @Field('uid') String uid, // 用户ID
  );

  /// 设置用户个性化设置
  /// 
  /// 通过指定的 `uid` 和 `userPersonaliseNewList` 设置用户个性化设置。
  /// 
  /// [uid] - 用户ID
  /// [userPersonaliseNewList] - 用户个性化设置列表
  @Extra({kRetryable: true})
  @POST("/yewu12/user/setUserPersonaliseNew")
  Future<ApiRes<String>> setUserPersonaliseNew(
    @Field('uid') String uid, // 用户ID
    @Field('userPersonaliseNewList') List userPersonaliseNewList,
  );

  /// 设置用户时区个性化设置
  /// 此接口不支持PB
  /// 通过指定的 `uid` 和 `userParams` 设置用户时区个性化设置。
  /// 
  /// [uid] - 用户ID
  /// [userParams] - 用户参数
  @POST("/yewu12/user/setUserPersonaliseNew")
  Future<ApiRes<String>> setUserTimeZonePersonaliseNew(
    @Field('uid') String uid,
    // 用户ID
    @Field('userParams') Map userParams,
  );

  /// 获取收藏赛事ID
  /// 
  /// 通过指定的 `matchType` 和 `cuid` 获取收藏赛事ID。
  /// 
  /// [matchType] - 赛事类型（0: 全部, 1: 常规, 2: 冠军, 3: 电竞）
  /// [cuid] - 用户客户端ID
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/collectMatches')
  Future<ApiRes<Map<String, CollectionInfo?>>> collectMatches(
    @Field('matchType') int matchType, // 0全部 1常规 2冠军 3电竞
    @Field('cuid') String cuid,
  );

  /// 获取比赛基本信息
  /// 
  /// 通过指定的参数获取比赛基本信息。
  /// 
  /// [mids] - 赛事ID
  /// [cuid] - 用户ID
  /// [sort] - 排序方式
  /// [euid] - 赛事ID
  /// [device] - 设备类型
  /// [pids] - 项目ID
  /// [isUser] - 是否用户
  /// [playId] - 播放ID
  /// [tabs] - 标签列表
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1000})
  @POST('/yewu11/v1/m/getMatchBaseInfoByMidsPB')
  Future<ApiResN<List<MatchEntity>>> getMatchBaseInfo(
    @Field('mids') String mids,
    // 赛事id
    @Field('cuid') String? cuid, // 用户id
    @Field('sort') int sort,
    @Field('euid') String? euid,
    @Field('device') String device,
    @Field('pids') String? pids,
    @Field('is_user') String? isUser,
    @Field('playId') int? playId,
    @Field('scroll') int? scroll,
    /*     @Field('orpt') String? orpt,
      @Field('selectionHour') String? selectionHour,
      @Field('cos') int? cos,*/
    @Field('tabs') List tabs,
  ); //

  /// 获取比赛基本信息
  ///
  /// 通过指定的参数获取比赛基本信息。
  /// 后端已修改api返回数据，此接口废弃
  ///
  /// [mids] - 赛事ID
  /// [cuid] - 用户ID
  /// [sort] - 排序方式
  /// [euid] - 赛事ID
  /// [device] - 设备类型
  /// [pids] - 项目ID
  /// [isUser] - 是否用户
  /// [playId] - 播放ID
  /// [tabs] - 标签列表
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1000})
  @POST('/yewu11/v1/m/getMatchBaseInfoByMidsPB')
  Future<ApiRes<MatchBaseInfoEntity>> getMatchBaseInfoWithTabs(
      @Field('mids') String mids,
      // 赛事id
      @Field('cuid') String? cuid, // 用户id
      @Field('sort') int sort,
      @Field('euid') String? euid,
      @Field('device') String device,
      @Field('pids') String? pids,
      @Field('is_user') String? isUser,
      @Field('playId') int? playId,
      /*     @Field('orpt') String? orpt,
      @Field('selectionHour') String? selectionHour,
      @Field('cos') int? cos,*/
      {@Field('tabs') required List tabs,}
      ); //

  /// 获取比赛列表信息
  /// 
  /// 通过指定的请求参数获取比赛列表信息。
  /// 
  /// [req] - 请求参数对象
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/matchesPB')
  Future<ApiRes<List<MatchEntity>>> matches(
    @Body() MatchListReq req,
  );

  /// 更新收藏列表菜单赛事数
  /// 
  /// 通过指定的参数更新收藏列表菜单赛事数。
  /// 
  /// [cuid] - 用户客户端ID
  /// [euid] - 赛事ID
  /// [sort] - 排序方式
  /// [type] - 赛事类型
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/matchesCollectNewH5Count')
  Future<ApiRes<int>> updateCollectMatches(
    @Field('cuid') String cuid,
    @Field('euid') String euid,
    @Field('sort') int sort,
    @Field('type') int type,
  );

  /// 添加或取消收藏赛事
  /// 
  /// 通过指定的参数添加或取消收藏赛事。
  /// 
  /// [cuid] - 用户客户端ID
  /// [mid] - 赛事ID
  /// [cf] - 操作类型（0: 取消收藏, 1: 添加收藏）
  /// [dota2] - 电竞收藏包含联赛收藏接口有加参数dota2=1（可选）
  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelMatch')
  Future<ApiRes<int>> addOrCancelMatch(
    @Field('cuid') String cuid,
    @Field('mid') String mid,
    @Field('cf') int cf,
    { @Field('dota2') int? dota2} // 电竞收藏包含联赛收藏接口有加参数dota2=1
  );

  /// 添加或取消收藏联赛
  /// 
  /// 通过指定的参数添加或取消收藏联赛。
  /// 
  /// [cuid] - 用户客户端ID
  /// [tid] - 联赛ID
  /// [cf] - 操作类型（0: 取消收藏, 1: 添加收藏）
  /// [dota2] - 电竞收藏包含联赛收藏接口有加参数dota2=1（可选）
  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelTournament')
  Future<ApiRes<int>> addOrCancelTournament(
    @Field('cuid') String cuid,
    @Field('tid') String tid,
    @Field('cf') int cf,
    { @Field('dota2') int? dota2} // 电竞收藏包含联赛收藏接口有加参数dota2=1
  );

  /// 添加或取消收藏联赛（冠军）
  /// 
  /// 通过指定的参数添加或取消收藏联赛（冠军）。
  /// 
  /// [cuid] - 用户客户端ID
  /// [mid] - 赛事ID（冠军传这个）
  /// [cf] - 操作类型（0: 取消收藏, 1: 添加收藏）
  /// [dota2] - 电竞收藏包含联赛收藏接口有加参数dota2=1（可选）
  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelTournament')
  Future<ApiRes<int>> addOrCancelTournamentGuanjun(
    @Field('cuid') String cuid,
    @Field('mid') String mid, // 冠军传这个
    @Field('cf') int cf,
    { @Field('dota2') int? dota2} // 电竞收藏包含联赛收藏接口有加参数dota2=1
  );

  /// 获取优惠赔率
  /// 
  /// 通过指定的 `cuid` 和 `euid` 获取优惠赔率。
  /// 
  /// [cuid] - 用户客户端ID
  /// [euid] - 赛事ID
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/getAllAddedOddsMatchesPB')
  Future<ApiRes<AddedOddsMatchesEntity>> getAllAddedOddsMatches(
    @Field('cuid') String cuid,
    @Field('euid') String euid,
    @Field('sportId') String sportId,
    @Field('sort') String sort,
  );

  /// 联赛置顶
  /// 
  /// 通过指定的参数设置联赛置顶状态。
  /// 
  /// [cuid] - 用户客户端ID
  /// [status] - 置顶状态（0: 取消置顶, 1: 置顶）
  /// [tId] - 联赛ID
  /// [matchId] - 赛事ID
  /// [menuId] - 一级菜单ID（1: 滚球, 2: 今日, 3: 早盘, 4: 电子竞技, 5: 串关, 6: 热门页面）
  /// [mType] - 赛种类型（二级菜单ID, sportId 200: 滚球和热门的全部）
  /// [mLeve3] - 三级菜单ID
  /// [h5Collect] - H5收藏状态
  /// [matchType] - 赛事类型（可选）
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/leagueTopPB')
  Future<ApiRes> leagueTopPB({
    @Field('cuid') required String cuid,
    @Field('status') required int status,
    @Field('tId') required String? tId,
    @Field('matchId') required String? matchId,
    @Field('menuId') required int menuId,
    @Field('mType') required int mType,
    @Field('mLeve3') required String mLeve3,
    @Field('h5Collect') required int h5Collect,
    @Field('matchType') int? matchType
  });

  /// 赛事置顶
  /// 
  /// 通过指定的参数设置赛事置顶状态。
  /// 
  /// [menuId] - 一级菜单ID（1: 滚球, 2: 今日, 3: 早盘, 4: 电子竞技, 5: 串关, 6: 热门页面）
  /// [mType] - 赛种类型（二级菜单ID, sportId 200: 滚球和热门的全部）
  /// [md] - 设备型号
  /// [mLeve3] - 三级菜单ID
  /// [h5Collect] - H5收藏状态
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/findTopMatchsPB')
  Future<ApiRes<List<MatchEntity>>> findTopMatchsPB({
    @Field('menuId') required int menuId,
    @Field('mType') required int mType,
    @Field('md') required String md,
    @Field('mLeve3') required String mLeve3,
    @Field('h5Collect') required int h5Collect,
  });

  /// 获取已经置顶的联赛ID和赛事ID
  /// 
  /// 通过指定的参数获取已经置顶的联赛ID和赛事ID。
  /// 
  /// [menuId] - 一级菜单ID（1: 滚球, 2: 今日, 3: 早盘, 4: 电子竞技, 5: 串关, 6: 热门页面）
  /// [mType] - 赛种类型（二级菜单ID, sportId 200: 滚球和热门的全部）
  /// [mLeve3] - 三级菜单ID
  /// [h5Collect] - H5收藏状态
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/findTopIds')
  Future<ApiRes<PinInfoEntity>> findTopIdsPB({
    @Field('menuId')
    required int menuId, // 1:滚球  2:今日  3:早盘  4:电子竞技  5:串关  6:热门页面
    @Field('mType') required int mType, // 二级菜单id  sportId 200:滚球和热门的全部
    @Field('mLeve3') required String mLeve3,
    @Field('h5Collect') required int h5Collect,
  });

  /// 获取热门赛事
  /// 
  /// 通过指定的请求参数获取热门赛事。
  /// 
  /// [req] - 请求参数对象
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/matchesNewPB')
  Future<ApiRes<MatchEsportEntity>> matchesNew({
    @Body() required MatchListReq req,
  });

  /// 获取滚球赛事
  /// 
  /// 通过指定的请求参数获取滚球赛事。
  /// 
  
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/structureLiveMatchesPB')
  Future<ApiRes<List<MatchEntity>>> structureLiveMatches({
    @Field('cuid') required String cuid,
    @Field('euid') required int euid,
    @Field('type') required int type,
    @Field('sort') required int sort,
    @Field('orpt') required int orpt,
    @Field('apiType') required int apiType,
    @Field('hotMatches') required int hotMatches,
  });

  //首页获取优惠赔率
  @POST('/yewu11/v1/m/getAddedOddsMatches')
  Future<ApiRes<DiscountOddEntity>> getAddedOddsMatches({
    @Field('cuid') required String cuid,
    @Field('euid') required String euid,
    @Field('sportId') required String sportId,
  });

  //首页获取优惠赔率 受关注人数
  @POST('/yewurecord/order/query/queryBetCount')
  Future<ApiRes<GetOddCountBeanEntity>> getQueryBetCount({
    @Field('paramList') required List paramList,
  });

  /**
   * 获取所有滚球赛事
   * {
      "cuid": "519790403081400014",
      "euid": "40003,40004,40090,40091,40006,40007,40008,40009,40012,40010,40023,40015,40016,40017,40020,40021,40022,40011,40013",
      "type": 1,
      "sort": 1,
      "device": "v2_h5_st",
      "hpsFlag": 1,
      "category": 1
      }
   */
  /// 获取所有滚球赛事
  /// 通过指定的请求参数获取所有滚球赛事。
  /// [cuid] - 用户客户端ID
  /// [euid] - 赛事ID
  /// [type] - 类型
  /// [sort] - 排序方式
  /// [device] - 设备类型
  /// [hpsFlag] - 高性能服务器标志
  /// [category] - 类别
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/getAllInPlayMatchListPB')
  Future<ApiRes<MatchAllEntity>> getAllInPlayMatchList({
    @Field('cuid') required String cuid,
    @Field('euid') required String euid,
    @Field('type') required int type,
    @Field('sort') required int sort,
    @Field('device') String device = 'v2_h5_st',
    @Field('hpsFlag') int hpsFlag = 1,
    @Field('category') int category = 1,
  });

  /// 获取所有搜索热词
  /// sportId球种id
  /// mType 1滚球 2 今日 4电子竞技
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/keyword/selectKeywordListMobile')
  Future<ApiRes<List<Map<String,dynamic>>>> getKeywordList(
    @Query('sportId') String? sportId,
    @Query('mType') int mType,
    @Query('md') String? md,
  );
}
