import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_login_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';
import 'package:retrofit/retrofit.dart';



import '../../db/app_cache.dart';
import '../models/res/get_user_info_zr_entity.dart';
import '../models/res/save_user_info_zr_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'zr_api.g.dart';

@RestApi()
abstract class ZrApi {
  factory ZrApi(Dio dio, {String baseUrl}) = _ZrApi;

  // factory ZrApi.instance() => ZrApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');
  factory ZrApi.instance() => ZrApi(AppDio.getInstance().dio, baseUrl: (StringKV.env.get() ?? "") == '测试' ? 'http://api.dbsportxxxifbdxm2.com' : StringKV.baseUrl.get() ?? '');

  @GET('/yewu27/zr/api/user/createV2')
  Future<ApiRes<String>> createV2();

  @Extra({kRetryable: true})
  @POST('/yewu11/v1/zr/getGameTableInfoPB')
  Future<ApiRes<List<ZrListEntity>>> getGameTableInfo(
    @Field('tableInfoType') int tableInfoType,
  );

  // 真人注册
  @GET("/yewu27/zr/api/user/createV2")
  Future getCreate();

  // 获取真人用户信息
  @POST("/yewu27/zr/userInfo/getUserInfoZr")
  Future<GetUserInfoZrEntity> getUserInfoZr(
    @Field('timestamp') String timestamp,
  );

  // 获取真人用户信息
  @POST("/yewu27/zr/userInfo/saveUserInfoZr")
  Future<SaveUserInfoZrEntity> saveUserInfoZr(
    @Body() body,
  );
  // 获取真人用户信息
  @POST("/yewu27/zr/api/user/zrUserLogin")
  Future<ApiRes<ZrLoginEntity>> zrUserLogin(
    @Body() body,
  );
}
