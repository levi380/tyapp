import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/origin_data_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/access_config.dart';
import '../models/res/get_filter_match_list_new_entity.dart';
import '../models/res/get_user_annual_report_template_entity.dart';
import '../models/res/md_entity.dart';
import '../models/res/report_info_entity.dart';
import '../models/res/sport_config_info.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'base_data_api.g.dart';

@RestApi()
abstract class BaseDataApi {
  factory BaseDataApi(Dio dio, {String baseUrl}) = _BaseDataApi;

  factory BaseDataApi.instance() => BaseDataApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 新旧菜单ID对应
  @Extra({kRetryable: true})
  @POST('/yewu11/v3/menu/loadMapping')
  Future<ApiRes<Map<String, dynamic>>> loadMenuMapping(
      @Body() Map<String, dynamic> body);

  ///球种
  @Extra({kRetryable: true})
  @GET('/yewu11/v3/menu/init')
  Future<ApiRes<List<SportConfigInfo>>> getMenuInit();

  // 菜单-联赛-赛事
  @POST('/yewu11/v3/menu/loadTournamentMatch')
  Future<ApiRes<Map<String, dynamic>>> loadTournamentMatch(
      @Body() Map<String, dynamic> map);

  // 菜单国际化
  @Extra({kRetryable: true})
  @POST('/yewu11/v3/menu/loadNameList')
  Future<ApiRes<Map<String, dynamic>>> loadNameList(
      @Body() Map<String, dynamic> map);

  // 获取元数据
  @Extra({kRetryable: true})
  @GET('/yewu11/v2/m/getOriginalData')
  Future<ApiRes<OriginDataEntity>> getOriginalData();

  // 获取联赛数据
  @GET("/yewu11/v1/m/getFilterMatchListNew")
  Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
    @Query('type') int type,
    @Query('euid') int euid,
    @Query('inputText') String inputText,
    @Query('cuid') int cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') int md,
    @Query('t') int t,
  );
  ///客户端-获取紧急开关配置
  @GET('/yewu11/v1/art/getAccessConfig')
  @Extra({kRetryable: true})
  Future<ApiRes<AccessConfig>> getAccessConfig();

  ///获取年报数据接口
  @POST("/yewu12/v1/userAnnualReport/getBigDataAnnualReportInfo")
  Future<ReportInfoEntity> getBigDataAnnualReportInfo(
    @Field('yearId') String yearId,
    @Field('userId') String userId,
  );

  ///获取年报数据接口
  @POST("/yewu12/v1/userAnnualReport/getUserAnnualReportTemplate")
  Future<GetUserAnnualReportTemplateEntity> getUserAnnualReportTemplate(
    @Field('yearId') String yearId,
    @Field('userId') String userId,
  );

  ///年报埋点
  @POST("/yewu11/v1/w/eventCollection")
  Future<MdEntity> eventCollection(
      @Field('deviceType') int deviceType,
      @Field('eventId') int eventId,
      @Field('version') String version,
      @Field('versionId') String versionId,
      );
}
