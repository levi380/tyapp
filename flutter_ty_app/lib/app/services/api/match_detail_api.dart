import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/category_list_entity.dart';
import '../models/res/detail_video_entity.dart';
import '../models/res/live_video_url_entity.dart';
import '../models/res/match_entity.dart';
import '../models/res/outright_display_matchs_entity.dart';
import '../models/res/play_top_entity.dart';
import '../models/res/video_animation_url_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'match_detail_api.g.dart';

@RestApi()
abstract class MatchDetailApi {
  factory MatchDetailApi(Dio dio, {String baseUrl}) = _MatchDetailApi;

  factory MatchDetailApi.instance() => MatchDetailApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取赛事详情
  ///
  /// 通过指定的 `mid` 和 `cuid` 获取赛事详情。
  ///
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [init] - 初始化标志
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/m/matchDetail/getMatchDetailPB')
  Future<ApiRes<Map<String, dynamic>>> getMatchDetail(
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('init') String init,
  );

  /// 获取赛事详情（w接口）
  ///
  /// 通过指定的 `mid` 和 `cuid` 获取赛事详情（w接口）。
  ///
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/w/matchDetail/getMatchDetailPB')
  Future<ApiRes<Map<String, dynamic>>> getMatchDetailW(
    @Query('mid') String mid,
    @Query('cuid') String cuid,
  );

  /// 获取电竞赛事详情
  ///
  /// 通过指定的 `mid` 和 `cuid` 获取电竞赛事详情。
  ///
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [init] - 初始化标志
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/m/matchDetail/getESMatchDetail')
  Future<ApiRes<Map<String, dynamic>>> getESMatchDetail(
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('init') String init,
  );

  /// 获取玩法类型
  ///
  /// 通过指定的 `sportId` 和 `mid` 获取玩法类型。
  ///
  /// [sportId] - 运动项目ID
  /// [mid] - 赛事ID
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/category/getCategoryList")
  Future<ApiRes<List<CategoryListData>>> getCategoryList(
    @Query('sportId') String sportId,
    @Query('mid') String mid,
  );

  /// 获取电竞玩法类型
  ///
  /// 通过指定的 `sportId` 和 `mid` 获取电竞玩法类型。
  ///
  /// [sportId] - 运动项目ID
  /// [mid] - 赛事ID
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/category/getESCategoryList")
  Future<ApiRes<List<CategoryListData>>> getESCategoryList(
    @Query('sportId') String sportId,
    @Query('mid') String mid,
  );

  @Extra({kRetryable: true})
  @GET("/yewu11/v1/w/category/getESCategoryList")
  Future<ApiRes<List<CategoryListData>>> getESWCategoryList(
    @Query('sportId') String sportId,
    @Query('mid') String mid, {
    @Query('type') String? type,
  });

  /// 获取联赛列表
  ///
  /// 通过指定的 `tId` 获取联赛列表。
  ///
  /// [tId] - 联赛ID
  /// [type] - 类型（可选）
  /// [dateTime] - 日期时间（可选）
  /// [isESport] - 是否为电竞赛事（可选）
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getMatchDetailByTournamentIdPB")
  Future<ApiRes<List<MatchEntity>>> getMatchDetailByTournamentId(
    @Query('tId') String tId,
    @Query('type') num? type,
    @Query('dateTime') String? dateTime,
    @Query('isESport') String? isESport,
  );

  /// 获取投注列表
  ///
  /// 通过指定的 `mcid`, `mid`, `cuid` 和 `newUser` 获取投注列表。
  ///
  /// [mcid] - 市场ID
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [newUser] - 是否为新用户
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getMatchOddsInfo1PB")
  Future<ApiRes<List<dynamic>>> getMatchOddsInfo1(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('newUser') int newUser,
  );

  /// 获取电竞投注列表
  ///
  /// 通过指定的 `mcid`, `mid` 和 `cuid` 获取电竞投注列表。
  ///
  /// [mcid] - 市场ID
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [showType] - 显示类型（可选）
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getESMatchOddsInfoPB")
  Future<ApiRes<List<dynamic>>> getESMatchOddsInfo(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid, {
    @Query('showType') int? showType,
  });

  /// 获取VR投注列表
  ///
  /// 通过指定的 `mcid`, `mid` 和 `cuid` 获取VR投注列表。
  ///
  /// [mcid] - 市场ID
  /// [mid] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [showType] - 显示类型（可选）
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getVirtualMatchOddsInfo")
  Future<ApiRes<List<dynamic>>> getVirtualMatchOddsInfo(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid, {
    @Query('showType') int? showType,
  });

  /// 获取VR赛果
  ///
  /// 通过指定的 `mcid` 和 `mid` 获取VR赛果。
  ///
  /// [mcid] - 市场ID
  /// [mid] - 赛事ID
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getVirtualMatchResult")
  Future<ApiRes<List<dynamic>>> getVirtualMatchResult(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
  );

  /// 获取详情页赛事结束自动切换赛事接口
  ///
  /// 通过指定的参数获取详情页赛事结束自动切换赛事接口。
  ///
  /// [sm] - 搜索标志
  /// [euid] - 赛事ID
  /// [csid] - 客户端会话ID
  /// [tid] - 联赛ID
  /// [sort] - 排序方式
  /// [keyword] - 关键字
  /// [cuid] - 用户客户端ID
  /// [mid] - 赛事ID
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/w/getDetailVideo")
  Future<ApiRes<DetailVideoEntity>> getDetailVideo(
    @Query('sm') String sm,
    @Query('euid') String euid,
    @Query('csid') String csid,
    @Query('tid') String tid,
    @Query('sort') String sort,
    @Query('keyword') String keyword,
    @Query('cuid') String cuid,
    @Query('mid') String mid,
  );

  /// 获取聊天室视频URL
  ///
  /// 通过指定的 `device` 和 `mid` 获取聊天室视频URL。
  ///
  /// [device] - 设备类型
  /// [mid] - 赛事ID
  @POST("/yewu11/v1/w/liveVideoUrl")
  Future<LiveVideoUrlEntity> liveVideoUrl(
    @Field('device') String device,
    @Field('mid') String mid,
  );

  /// 获取动画链接
  ///
  /// 通过指定的 `type` 和 `mid` 获取动画链接。
  ///
  /// [type] - 类型
  /// [mid] - 赛事ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/w/videoAnimationUrl")
  Future<ApiRes<VideoAnimationUrlEntity>> getVideoAnimationUrl(
    @Field('type') String type,
    @Field('mid') String mid,
  );

  /// 设置置顶
  ///
  /// 通过指定的参数设置置顶。
  ///
  /// [status] - 置顶状态
  /// [playId] - 播放ID
  /// [matchId] - 赛事ID
  /// [cuid] - 用户客户端ID
  /// [topKey] - 置顶键
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/category/playTop")
  Future<void> setPlayTop(
    @Query('status') String status,
    @Query('playId') String playId,
    @Query('matchId') String matchId,
    @Query('cuid') String cuid,
    @Query('topKey') String topKey,
  );

  /// 获取置顶信息
  ///
  /// 获取置顶信息。
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/category/findPlayTop")
  Future<ApiRes<List<PlayTopEntity>>> findPlayTop();

  /// 获取冠军引导盘
  ///
  /// 通过指定的 `tid`, `cuid` 和 `euid` 获取冠军引导盘。
  ///
  /// [tid] - 联赛ID（联赛如果是多个用逗号分开）
  /// [cuid] - 用户ID
  /// [euid] - 菜单ID
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/m/getMobileOutrightDisplayMatchs")
  Future<ApiRes<OutrightDisplayMatchsEntity>> getOutrightDisplayMatchs(
    @Field('tid') String tid, // 联赛ID，联赛如果是多个用逗号分开
    @Field('cuid') String cuid, // 用户id
    @Field('euid') String euid, // 菜单id
    @Field('sportId') String sportId, // 菜单id
  );
}
