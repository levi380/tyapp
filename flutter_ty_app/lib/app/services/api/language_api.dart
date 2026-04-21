import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../db/app_cache.dart';
import '../models/res/set_user_language_entity.dart';
import '../network/app_dio.dart';

part 'language_api.g.dart';

@RestApi()
abstract class LanguageApi {
  factory LanguageApi(Dio dio, {String baseUrl}) = _LanguageApi;

  factory LanguageApi.instance() =>
      LanguageApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  /// 更换用户语言
  /// 
  /// 通过指定的 `token` 和 `languageName` 更换用户的语言设置。
  /// 
  /// [token] - 用户认证令牌
  /// [languageName] - 目标语言名称
  @GET("/yewu12/user/setUserLanguage")
  Future<SetUserLanguageEntity> setUserLanguage(
      @Query('token') String? token,
      @Query('languageName') String? languageName,
      );
}