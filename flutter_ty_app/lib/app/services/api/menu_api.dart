import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../db/app_cache.dart';
import '../models/res/get_user_customize_info_entity.dart';
import '../models/res/menu_entity.dart';
import '../models/res/save_user_customize_info_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'menu_api.g.dart';

@RestApi()
abstract class MenuApi {
  factory MenuApi(Dio dio, {String baseUrl}) = _MenuApi;

  factory MenuApi.instance() =>
      MenuApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  /// 盘口设置 按钮更新
  /// 
  /// [handicapType] 盘口类型
  @Extra({kRetryable: true})
  @POST("/yewu12/user/setUserPersonalise")
  Future<MenuEntity> setUserPersonalise(
    @Field('handicapType') int handicapType,
  );

  @POST("/yewu12/user/setUserPersonalise")
  Future<MenuEntity> setUserPersonalisePopUps(
      @Field('popUps') int popUps,
      @Field('userVersion') int userVersion,
      );

  /// 排序规则 按钮更新
  /// 
  /// [sort] 排序规则
  @POST("/yewu12/user/rememberSelect")
  Future<MenuEntity> rememberSelect(
    @Field('sort') int sort,
  );

  /// 投注模式 按钮更新
  /// 
  /// [userVersion] 用户版本
  @POST("/yewu12/user/setUserPersonalise")
  Future<MenuEntity> setUserPersonaliseT(
    @Field('userVersion') int userVersion,
  );

  /// 自定义快捷投注金额 拉取投注余额
  /// 
  /// 无参数
  @Extra({kRetryable: true})
  @POST("/yewu12/user/getUserCustomizeInfo")
  Future<GetUserCustomizeInfoEntity> getUserCustomizeInfo();

  /// 自定义快捷投注金额 保存投注余额
  /// 
  /// [seriesList] 系列列表
  /// [singleList] 单项列表
  /// [firstTime] 是否第一次
  /// [switchOn] 开关状态
  /// [fastBetAmount] 快捷投注金额
  @POST("/yewu12/user/saveUserCustomizeInfo")
  Future<SaveUserCustomizeInfoEntity> saveUserCustomizeInfo(
    @Field('seriesList') List<int> seriesList,
    @Field('singleList') List<int> singleList,
    @Field('firstTime') bool firstTime,
    @Field('switchOn') bool switchOn,
    @Field('fastBetAmount') String fastBetAmount,
  );
}