import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/md_entity.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/api_res.dart';

part 'common_api.g.dart';

/// 提供通用API接口的抽象类
///
/// 该类包含了所有通用的API请求方法。
@RestApi()
abstract class CommonApi {
  /// 创建 `CommonApi` 实例的工厂构造函数
  ///
  /// [dio]: Dio 实例
  /// [baseUrl]: 基础URL，默认为空字符串
  factory CommonApi(Dio dio, {String baseUrl}) = _CommonApi;

  /// 获取 `CommonApi` 的单例实例
  ///
  /// 使用 `AppDio` 的单例实例和从 `StringKV` 获取的基础URL。
  factory CommonApi.instance() => CommonApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// 获取电竞图片资源域名
  ///
  /// 该方法用于获取电竞图片资源的域名。
  ///
  /// 返回: [ApiRes] 对象，包含请求结果。
  @GET('/yewu11/v1/games/imgDomain')
  Future<ApiRes> getDjImageDomain();

  ///公共埋点上报接口
  /// 事件ID  eventId;         /// 事件ID
  /// 上报时间戳 eventTime;          /// 上报时间戳
  /// 页面路径 pagePath;        /// 页面路径
  /// 用户ID userId;          /// 用户ID
  /// 商户编码 merchantCode;    /// 商户编码
  /// H5 / APP / PC platform;        /// H5 / APP / PC
  /// 当前语言 language;        /// 当前语言
  /// 点击对象ID clickTarget;     /// 点击对象ID
  /// 停留时间（秒） stayTime;          /// 停留时间（秒）
  @POST("/yewu11/v1/w/eventCollection")
  Future<MdEntity> analyticsApi(
      @Field('event_id') String eventId,
      @Field('event_time') int eventTime,
      @Field('page_path') String pagePath,
      @Field('user_id') String userId,
      @Field('merchant_code') String merchantCode,
      @Field('platform') String platform,
      @Field('language') String language,
      @Field('click_target') String clickTarget,
      @Field('stay_time') int stayTime,
      );
}