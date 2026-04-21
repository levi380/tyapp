import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import 'mockdata/mock_util.dart';
class MockInterceptor extends Interceptor {
  // 创建一个终端列表，这些你需要mock的数据
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // 检查如果请求端点匹配

    AppLogger.debug("路径:  ${options.path.toString()} ${MockUtil.dataMap.containsKey(options.path.toString())}");
    if (MockUtil.dataMap.containsKey(options.path.toString())) {
      // 如果端点匹配然后跳到追加令牌
      return dealResponce(handler,options);

    }else{
      AppLogger.debug("没有找到数据:  ${options.path.toString()}");
      return super.onRequest(options, handler);
    }
    // 在这里加载令牌到 header
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionTimeout) {
    }
    handler.next(err);
  }
  //
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   try {
  //     if (response.data is String) {
  //       response.data = json.decode(response.data);
  //     }
  //     int? code = response.data['code'];
  //     String? status = response.data['status'];
  //     handler.next(response);
  //   } catch (e) {
  //     AppLogger.debug("请求失败");
  //   }
  // }

  void dealResponce( RequestInterceptorHandler handler,RequestOptions options) {
    Response response=Response(requestOptions: options);
    response.data=jsonDecode(MockUtil.dataMap[options.path]??"");
    return  handler.resolve(response);
  }
}
