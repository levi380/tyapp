import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/cp_login_entity.dart';
import '../models/res/get_user_info_cp_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'cp_api.g.dart';

@RestApi()
abstract class CpApi {
  factory CpApi(Dio dio, {String baseUrl}) = _CpApi;

  factory CpApi.instance() =>
      CpApi(AppDio.getInstance().dio, baseUrl: (StringKV.env.get() ?? "") == '测试' ? 'http://api.dbsportxxxifbdxm2.com' : StringKV.baseUrl.get() ?? '');

  /// 彩票设置菜单，用户信息
  /// 
  /// [loginName] 登录名
  @POST("/yewu28/cp/userInfo/getUserInfoCpPB")
  Future<GetUserInfoCpEntity> getUserInfoCp(
    @Field('loginName') String loginName,
  );

  /// 双面盘玩法金额保存
  /// 
  /// [nextConfigId] 下一个配置ID
  @POST("/yewu28/cp/userInfo/saveUserInfoCp")
  Future<GetUserInfoCpEntity> saveUserInfoCpNextConfigId(
    @Field('nextConfigId') int nextConfigId,
  );

  /// 特色游戏投注金额保存
  /// 
  /// [nextConfigId] 下一个配置ID
  @POST("/yewu28/cp/userInfo/saveUserInfoCp")
  Future<GetUserInfoCpEntity> saveUserInfoCpNextFeatureConfigId(
    @Field('nextConfigId') int nextConfigId,
  );

  /// 关闭保存所有
  /// 
  /// [coldHot] 是否开启冷热提示
  /// [countDownBeep] 是否开启倒计时提示
  /// [doubleBetConfirm] 是否开启双倍投注确认
  /// [missRemind] 是否开启遗漏提醒
  /// [winModal] 是否开启中奖弹窗
  /// [colorTheme] 颜色主题
  @POST("/yewu28/cp/userInfo/saveUserInfoCp")
  Future<GetUserInfoCpEntity> saveUserInfoCp(
    @Field('coldHot') bool coldHot,
    @Field('countDownBeep') bool countDownBeep,
    @Field('doubleBetConfirm') bool doubleBetConfirm,
    @Field('missRemind') bool missRemind,
    @Field('winModal') bool winModal,
    @Field('colorTheme') int colorTheme,
  );

  /// 彩票投注-创建
  /// 
  /// 无参数
  @Extra({kRetryable: true})
  @GET('/yewu28/cp/api/user/createV2')
  Future<ApiRes> cpCreateV2();

  /// 彩票投注-热门列表
  /// 
  /// 无参数
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/cp/hotsPB')
  Future<ApiRes<List<CpTicketCateList>>> getCpHotsGameList();

  /// 彩票投注-即开彩
  /// 
  /// 无参数
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/cp/jksPB')
  Future<ApiRes<List<CpTicketCateList>>> getCpJksGameList();

  /// 彩票投注-其他
  /// 
  /// 无参数
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/cp/listPB')
  Future<ApiRes<List<CpTicketCateEntity>>> getCpOtherGameList();

  /// 彩票投注-收藏
  /// 
  /// 无参数
  @GET('/yewu11/v1/cp/collect/collectListPB')
  Future<ApiRes<List<CpTicketCateList>>> getCpCollectGameList();

  /// 彩票 ticket 收藏
  /// 
  /// [ticketId] 票据ID
  /// [collect] 是否收藏
  @POST("/yewu11/v1/cp/collect/collect")
  Future<ApiRes> collectCpTicket(
    @Field('ticketId') String ticketId,
    @Field('collect') bool collect,
  );

  /// 获取用户信息
  /// 
  /// [body] 请求参数
  @POST("/yewu28/cp/api/user/login")
  Future<CpLoginEntity> cpUserLogin(
    @Body() body,
  );
}