import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';

import '../network/retry_interceptor.dart';

/**
 * @Author bookpeer
 * @Date 2024/2/25 17:34
 */

part 'vr_sports_api.g.dart';

@RestApi()
abstract class VrSportsApi {
  factory VrSportsApi(Dio dio, {String baseUrl}) = _VrSportsApi;

  factory VrSportsApi.instance() => VrSportsApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// This method is used to get virtual sports menus.
  /// The API endpoint is https://api.lkjklkyi.com/yewu11/v1/w/virtual/menus.
  /// The parameters are device and time.
  @GET('/yewu11/v1/w/virtual/menus')
  Future<ApiRes<List<VrSportsMenuEntity>>> getVrSportsMenus(
    @Query("device") String device,
    @Query("t") String time,
  );

  /// This method is used to get virtual matches.
  /// The API endpoint is https://api.lkjklkyi.com/yewu11/v1/m/virtualMatches.
  /// The parameters are csid, tid, device and time.
  @POST('/yewu11/v1/m/virtualMatches')
  Future<ApiRes<List<VrMatchEntity>>> getVirtualMatches(
    @Field('csid') String csid,
    @Field('tid') String tid,
    @Field('device') String device,
    @Query("t") String time,
  );

  /// This method is used to get virtual replay.
  /// The API endpoint is https://api.lkjklkyi.com/yewu11/v1/w/virtualReplay.
  /// The parameters are batchNo, csid, tid and time.
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/virtualReplay')
  Future<ApiRes<VrSportReplayEntity>> virtualReplay(
    @Field('batchNo') String batchNo,
    @Field('csid') String csid,
    @Field('tid') String tid,
    @Query("t") String time,
  );

  /// This method is used to get match score.
  /// The API endpoint is https://api.lkjklkyi.com/yewu11/v1/w/virtual/getMatchScore.
  /// The parameters are mids and time.
  @POST('/yewu11/v1/w/virtual/getMatchScore')
  Future<ApiRes> getMatchScore(
    @Field('mids') String mids,
    @Query("t") String time,
  );
}
