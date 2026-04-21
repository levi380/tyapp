import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../network/app_dio.dart';
part 'dj_data_api.g.dart';
@RestApi()
abstract class DjDataApi {
  factory DjDataApi(Dio dio, {String baseUrl}) = _DjDataApi;

  factory DjDataApi.instance() => DjDataApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取日期数据
  /// 
  /// 通过指定的 `csid` 获取日期菜单列表。
  /// 
  /// [csid] - 客户端会话ID
  @POST('/yewu11/v1/w/esports/getDateMenuList')
  Future<ApiRes<List<DjDateEntityEntity>>> getDateMenuList(
      @Field("csid") String csid,);

  /// 获取电竞比赛列表
  /// 
  /// 通过指定的参数获取电竞比赛列表。
  /// 
  /// [category] - 比赛类别
  /// [csid] - 客户端会话ID
  /// [cuid] - 用户客户端ID
  /// [euid] - 用户设备ID
  /// [hpsFlag] - 高性能服务器标志
  /// [md] - 设备型号
  /// [sort] - 排序方式
  /// [type] - 比赛类型
  @POST('/yewu11/v1/m/esportsMatches')
  Future<ApiRes<List<MatchEntity>>> esportsMatches(
      @Field("category") String category,
      @Field("csid") String csid,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );

  /// 获取收藏的比赛列表
  /// 
  /// 通过指定的参数获取收藏的比赛列表。
  /// 
  /// [collect] - 收藏状态
  /// [csid] - 客户端会话ID
  /// [cuid] - 用户客户端ID
  /// [euid] - 用户设备ID
  /// [hpsFlag] - 高性能服务器标志
  /// [md] - 设备型号
  /// [sort] - 排序方式
  /// [type] - 比赛类型
  @POST('/yewu11/v1/m/escnh5')
  Future<ApiRes<List<MatchEntity>>> collection(
      @Field("collect") int collect,
      @Field("csid") String csid,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );

  /// 获取PB比赛列表
  /// 
  /// 通过指定的参数获取PB比赛列表。
  /// 
  /// [category] - 比赛类别
  /// [cuid] - 用户客户端ID
  /// [euid] - 用户设备ID
  /// [hpsFlag] - 高性能服务器标志
  /// [md] - 设备型号
  /// [sort] - 排序方式
  /// [type] - 比赛类型
  @Extra({kRetryable: true, KRetryCode: '0401038'})
  @POST('/yewu11/v1/m/matchesPB')
  Future<ApiRes<List<MatchEntity>>> matchesPB(
      @Field("category") String category,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );

  /// 更新收藏列表菜单赛事数
  /// 
  /// 更新指定用户的收藏列表菜单赛事数。
  /// 
  /// [cuid] - 用户客户端ID
  /// [euid] - 用户设备ID
  /// [device] - 设备类型
  /// [sort] - 排序方式
  /// [type] - 赛事类型
  /// [csid] - 客户端会话ID
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/escnCount')
  Future<ApiRes<int>> updateCollectMatches(
      @Field('cuid') String cuid,
      @Field('euid') String euid,
      @Field('device') String device,
      @Field('sort') int sort,
      @Field('type') int type,
      @Field('csid') String csid
  );

  // // 获取联赛数据
  // // 
  // // 通过指定的参数获取联赛数据。
  // // 
  // // [type] - 联赛类型
  // // [euid] - 用户设备ID
  // // [inputText] - 输入文本
  // // [cuid] - 用户客户端ID
  // // [device] - 设备类型
  // // [showem] - 显示标志
  // // [md] - 设备型号
  // // [t] - 时间戳
  // @GET("/v1/m/getFilterMatchListNew")
  // Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
  //     @Query('type') int type,
  //     @Query('euid') int euid,
  //     @Query('inputText') String inputText,
  //     @Query('cuid') int cuid,
  //     @Query('device') String device,
  //     @Query('showem') String showem,
  //     @Query('md') int md,
  //     @Query('t') int t,
  //     );
}