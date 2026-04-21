import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_center_entity.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';


import '../models/res/get_notice_front_list_new_entity.dart';

/**
 * @Author bookpeer
 * @Date 2024/2/25 17:34
 */

part 'notice_center_api.g.dart';

@RestApi()
abstract class NoticeCenterApi {
  factory NoticeCenterApi(Dio dio, {String baseUrl}) = _NoticeCenterApi;

  factory NoticeCenterApi.instance() =>
      NoticeCenterApi(AppDio.getInstance().dio,
          baseUrl: StringKV.baseUrl.get() ?? '');

  /// http://sit-api-1.sportxxxifbdxm2.com/yewu11/v2/notice/frontList?t=1715413574698
  @POST('/yewu11/v2/notice/frontList')
  Future<ApiRes<NoticeCenterEntity>> getNoticeData();

  @POST('/yewu11/v2/notice/frontList')
  Future<GetNoticeFrontListNewEntity> getNoticeFrontList(
    @Query('beginTime') String beginTime,
    @Query('endTime') String endTime,
    @Query('noticeType') String noticeType,
  );

  @POST('/yewu11/v2/notice/frontList')
  Future<GetNoticeFrontListNewEntity> getNoticeFrontLists();

  @POST('/yewu11/v2/notice/frontList')
  Future<GetNoticeFrontListNewEntity> getNoticeFrontListNoticeType(
    @Query('noticeType') String noticeType,
  );

  @POST('/yewu11/v2/notice/frontList')
  Future<GetNoticeFrontListNewEntity> getNoticeFrontListBeginTime(
    @Query('beginTime') String beginTime,
    @Query('endTime') String endTime,
  );
}
