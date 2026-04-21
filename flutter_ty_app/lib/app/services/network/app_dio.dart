import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/services/network/domain.dart';
import 'package:flutter_ty_app/app/services/network/response_interceptor.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';


import '../../db/app_cache.dart';
import '../models/domain_model.dart';
import 'mock_interceptor.dart';
import 'request_interceptor.dart';

/// @Author swifter
/// @Date 2023/9/17 15:17

class AppDio {
  static AppDio? instance;

  Map looptimers = {};

  late final Dio _dio;

  Dio get dio => _dio;

  static AppDio getInstance() {
    instance ??= AppDio._internal();
    // if (kDebugMode) {
    //   //允许自签名证书
    //   (instance!.dio.httpClientAdapter as IOHttpClientAdapter)
    //       .createHttpClient = () => HttpClient()
    //     ..badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    // }
    return instance!;
  }

  AppDio._internal() {
    _dio = Dio();

    /// 配置dio实例
    BaseOptions options = BaseOptions(
        baseUrl: StringKV.baseUrl.get() ?? '',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 9000),
    );
    _dio.options = options;

    _dio.httpClientAdapter = IOHttpClientAdapter(
      //自己设置缺省超时时间
      createHttpClient: (){
        HttpClient httpClient = HttpClient();
        httpClient.idleTimeout = const Duration(seconds: 60); // 设置 keep-alive 的空闲超时时间为 60 秒
        return httpClient;
      },
    );
    bool mockOpen = const bool.fromEnvironment("MOCK_OPEN", defaultValue: false);
    AppLogger.debug("mockOpen:${mockOpen}");
    if(mockOpen){
      _dio.interceptors.add(MockInterceptor());
    }

    final cancelToken = CancelToken();
    /// 添加拦截器
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(RetryInterceptor(
      dio: dio,
      ///修改重连次数为5次
      retryCount: 5,
      retryTimer: 2000,
      cancelToken: cancelToken,
    ));
    _dio.interceptors.add(ResponseInterceptor());
    // if(kDebugMode){
    //   _dio.interceptors.add(DioNetworkLogger());
    // }

    //测试代码，
    // 列表数据多的话，打log影响出来速度
    bool env = const bool.fromEnvironment("LOG_OPEN", defaultValue: false);

    if(env && kDebugMode){
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: false,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          logPrint: (obj) => AppLogger.debug(
            obj.toString(),
          ),
        ),
      );
    }
  }


  setApiDomainForNoToken(String apiDomain){
    ///隔离环境 接口域名分组 临时处理b组域名
    //apiDomain.replaceAll('api-b.sportxxx1f4xzv5.com', 'api-b.dbsportxxx1f4xzv5.com');
    _dio.options.baseUrl = apiDomain;
    StringKV.baseUrl.save(apiDomain);
  }

  // 设置网络相关数据
  setApiDomain() {
    var apiDomain = DOMAIN_RESULT.first_one;

    if (apiDomain.isEmpty) {
      String? bestApi = StringKV.best_api.get();
      String? gr = StringKV.gr.get();
      var domainApi = AllDomain.instance().get_save_domain_api();
      if (gr == null) {
        gr = DOMAIN_RESULT.gr.isNotEmpty ? DOMAIN_RESULT.gr : "COMMON";
        StringKV.gr.save(gr);
      }
      if (bestApi != null) {
        // 缓存   有  最快域名
        DOMAIN_RESULT.first_one = bestApi;
        apiDomain = bestApi;
      } else {
        // 缓存   无  最快域名
        // 从本地 存储内找一条数据先用 ， 后面即便 是分组不对 ，会走到纠错流程
        var findObj;
        if (domainApi.isNotEmpty) {
          findObj = domainApi.where((x) => x.group == gr);
        }
        if (findObj != null) {
          //如果找到 数据
          apiDomain = findObj["api"];
          DOMAIN_RESULT.first_one = apiDomain;
        } else {
          // 什么都没有的 补偿刷新一次  或者两次
          // if (has_reload < 4) {
          //   SessionStorage .set("set_root_domain_error_force_reload", has_reload + 1);
          //   force_current_api_flow_use_oss_file_api_reload();
          // } else {
          //   // 正常的走到 释放页面 的步骤 ，就是 wifi 图标 必须刷新页面才行的 那种
          // }
        }
      }
    }

    // 设置api 和 ws
    // https://api.jlsdfj012.com/yewu11

    // 全局设置
    // https://api.jlsdfj012.com 现在全局设置的不带yewu后缀 自行在接口前面加上
    // http://api-b.sportxxx1f4xzv5.com/yewu11/v1/m/getMatchBaseInfoByMidsPB?t=1728719511984
    ///隔离环境 接口域名分组 临时处理b组域名
    //apiDomain.replaceAll('api-b.sportxxx1f4xzv5.com', 'api-b.dbsportxxx1f4xzv5.com');
    _dio.options.baseUrl = apiDomain;
    StringKV.baseUrl.save(apiDomain);

    // final wsUrl = DOMAIN_RESULT.first_one.replaceFirst('http', 'ws');
    // StringKV.wssUrl.save(wsUrl);
  }
}
