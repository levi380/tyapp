import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/login_panda_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/balance_entity.dart';
import '../models/res/user_param_config_entity.dart';
import '../models/res/user_personalise_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';
import '../network/throttle_api.dart';

part 'account_api.g.dart';

@RestApi()
abstract class AccountApi {
  factory AccountApi(Dio dio, {String baseUrl}) = _AccountApi;

  factory AccountApi.instance() => AccountApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// 登录（试玩使用GET请求）
  ///
  /// [username] - 用户名
  /// [merchantCode] - 商户代码
  /// [password] - 密码
  /// [terminal] - 终端类型
  @GET("/user/loginPanda")
  Future loginPanda(
    @Query("userName") String? username,
    @Query("merchantCode") String merchantCode,
    @Query("password") String? password,
    @Query('terminal') String? terminal,
  );

  /// 登录（其余情况使用POST请求）
  ///
  /// [env] - 环境
  /// [merchantCode] - 商户代码
  /// [password] - 密码
  /// [userName] - 用户名
  @POST("/user/login")
  Future<LoginPandaEntity> login(
    @Field('env') String? env,
    @Field('merchantCode') String? merchantCode,
    @Field("password") String? password,
    @Field('username') String? userName,
  );

  /// 获取用户信息
  ///
  /// [token] - 用户令牌
  @GET('/yewu12/user/getUserInfo')
  Future<ApiRes<UserInfo>> getUserInfo(@Query('token') String token);

  /// 获取用户余额
  ///
  /// [uid] - 用户ID
  @Extra({kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET(ThrottleUtil.userAmount)
  Future<ApiRes<BalanceEntity>> getBalance(@Query('uid') String uid);

  /// 记住用户选择（附加盘/语言/日间/夜间等）
  ///
  /// [a] - 参数a
  @POST('/yewu12/user/getUserPersonalise')
  Future<ApiRes<UserPersonaliseEntity>> getUserPersonalise(@Field("a") int? a);

  /*
  /// 设置用户选择（附加盘/语言/日间/夜间等）
  /// 
  /// [toAccept] - 接受的参数
  /// [userVersion] - 用户版本
  /// [handicapType] - 盘口类型
  @POST('/yewu12/user/setUserPersonalise')
  Future<ApiRes> setUserPersonalise(
      @Field("toAccept") String? toAccept,
      @Field("userVersion") String? userVersion,
      @Field("handicapType") String? handicapType,
  );
  */

  /// 记录用户偏好
  ///
  /// [userBetPrefer] - 用户投注偏好
  @POST('/yewu12/v1/betOrder/recordUserPreference')
  Future<ApiRes> recordUserPreference(
    @Field("userBetPrefer") int userBetPrefer,
  );

  /// 获取服务器时间
  @GET('/yewu11/v1/getSystemTime/currentTimeMillis')
  Future<ApiRes> getServerTime();

  /// 设置用户参数配置
  ///
  /// [paramKey] - 参数键
  /// [paramValue] - 参数值
  @POST('/yewu12/user/setUserParamConfig')
  Future<ApiRes> setUserParamConfig(
    @Field("paramKey") String paramKey,
    @Field("paramValue") String paramValue,
  );

  /// 获取用户参数配置
  ///
  /// [paramKey] - 参数键
  @POST('/yewu12/user/getUserParamConfig')
  Future<ApiRes<List<UserParamConfigEntity>>> getUserParamConfig(
    @Field("paramKey") String paramKey,
  );

  /// 添加商户调用标记
  ///
  /// [source] - 源
  @POST('/yewu11/device/source/save')
  Future<ApiRes> save(
    @Field("source") String source,
  );

  /// 心跳接口
  ///
  /// 参数包括 sessionId, os, sid, uid, code, device, sign, t
  @POST("/yewu40/req/request")
  Future<ApiRes<dynamic>> heartbeat(@Body() Map<String, dynamic> data);

  /// 页面停留/用户在线统计上报接口
  ///
  /// 参数包括 browser, os, frontLoadingTime, sessionId
  @POST("/yewu12/userOnlineStatistics/sendStatisticsInfo")
  Future<ApiRes<dynamic>> sendStatisticsInfo(@Body() Map<String, dynamic> data);
}
