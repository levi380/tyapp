
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';
import 'package:flutter_ty_app/app/services/network/token_whitelist.dart';
import 'package:get/get.dart';
import 'package:mutex/mutex.dart';

import '../../db/app_cache.dart';
import '../../modules/setting_menu/setting_menu_controller.dart';

/// @Author swifter
/// @Date 2023/9/17 15:18

class RequestInterceptor extends Interceptor {
  bool Function(RequestOptions req)? shouldThrottle;

  ///发送回调
  void Function(RequestOptions req, DateTime until)? onThrottled;
  final Mutex _mutex = Mutex();
  DateTime _nextAvailable = DateTime.now();

  RequestInterceptor({this.shouldThrottle, this.onThrottled});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //
    Map<String, dynamic> headers = options.headers;

    int time = DateTime.now().millisecondsSinceEpoch;
    //StringKV.req_checkId.save(time.toString()); 耗时操作
    headers['lang'] = getLang();
    ///处理需要判断的接口名 比对白名单接口
    String apiPath = options.path.replaceFirst('/yewu11', '');
    ///否则需要验证token
    String? token = StringKV.token.get();
    // if(token == null){
    //   Uri uri = Uri.parse(h5ulr);
    //   Map<String, dynamic> params = uri.queryParameters;
    //   if(params.keys.contains('token')){
    //     token = params['token'].toString();
    //   }else{
    //     //AppLogger.debug('获取不到token');
    //   }
    // }


    String oddsType = "";
    if(Get.isRegistered<TYUserController>()){
      // 增加赔率类型
      String curOdd = TYUserController.to.curOdds;
      if(!['EU', 'HK'].contains(curOdd)){
        oddsType =  ',"oddsType":"$curOdd"';
      }
    }

    headers['request-code'] = '{"panda-bss-source":"1"$oddsType}' ;
    headers['Content-Type'] = 'application/json;charset=UTF-8';
    if(options.path.contains('getGameTableInfo')){
      headers['Content-Type'] = 'application/json';
    }else if (options.path.contains('getUserInfoZr')){
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }

    headers.removeWhere((key, value) => value == null);
    // AppLogger.debug(options.baseUrl);
    ///隔离环境 接口域名分组 临时处理b组域名
    //if(options.baseUrl == 'http://api-b.sportxxx1f4xzv5.com'){
    //  options.baseUrl ='http://api-b.dbsportxxx1f4xzv5.com';
    //}
    ///登录白名单  不需要验证token

    if ((token?.isEmpty??true) && (TokenWhiteList.isLoginNoVerification(apiPath))) {
      ///区分赛果和其他首页关联接口的 代理接口  参数一致  代理接口得分开
      // options.path = TokenWhiteList.whiteList.contains(apiPath)
      //     ? TokenWhiteList.replaceUrl
      //     : TokenWhiteList.replaceUrlForResult;
      options.path = TokenWhiteList.replaceUrl;
      //headers['urlPath'] = apiPath;
      if (options.method == 'POST') {
        options.data['urlPath'] = apiPath;
      } else if (options.method == 'GET') {
        options.data = {...options.queryParameters,'urlPath': apiPath};
        options.method = 'POST';
      }
    } else {
      headers['requestId'] = token;
      headers['checkId'] = 'pc-$token-${TYUserController.to.getUid()}-$time';
    }
    options.headers = headers;
    // 所有请求路径加上 ?t=时间戳
    if (!options.path.contains('?t=')) {
      options.path = '${options.path}?t=$time';
    }
    if (options.throttleable == false) {
      //AppLogger.debug('没有延迟请求---->$apiPath}');

      //     !ThrottleUtil.throttleMilliseconds.keys.contains(apiPath)) {
      return super.onRequest(options, handler);
    }

    Duration interval = Duration(milliseconds: options.throttledurtion);

    // if (ThrottleUtil.throttleApiList.contains(apiPath) &&
    //     ThrottleUtil.throttleMilliseconds.keys.contains(apiPath)) {
    //   int throttleTime =
    //       ThrottleUtil.throttleMilliseconds[apiPath]['milliseconds'];
    //   interval = Duration(milliseconds: throttleTime);
    // }
    //
    // if (!ThrottleUtil.throttleMilliseconds.keys.contains(apiPath) ||
    //     !ThrottleUtil.throttleMilliseconds[apiPath].keys
    //         .contains('nextAvailable')) {
    //   ThrottleUtil.throttleMilliseconds[apiPath] = {};
    //   ThrottleUtil.throttleMilliseconds[apiPath]['nextAvailable'] =
    //       DateTime.now();
    // }
    // Map keyMap = ThrottleUtil.throttleMilliseconds[apiPath];
    var now = DateTime.now();
    _mutex.protect(() async {
      if (now.isBefore(_nextAvailable)) {
        /// 这里的代码会被保护 不会并发执行
        // if (now.isBefore(options.nextAvailable)) {
        // var scheduledTime = options.nextAvailable;
        // options.extra[kThrottleNextAvailable] = options.nextAvailable.add(interval);

        // var scheduledTime = keyMap['nextAvailable'];
        // keyMap['nextAvailable'] = keyMap['nextAvailable'].add(interval);
        // return scheduledTime;
        var scheduledTime = _nextAvailable;
        _nextAvailable = _nextAvailable.add(interval);
        return scheduledTime;
      } else {
        // options.extra[kThrottleNextAvailable] = now.add(interval);

        // options.extra[kThrottleNextAvailable] = now.add(interval);
        _nextAvailable = now.add(interval);
        return null;
      }
    }).then((scheduledTime) {
      if (scheduledTime != null) {
        onThrottled?.call(options, scheduledTime);
        Future.delayed(
          scheduledTime.difference(now),
          () {
            return super.onRequest(options, handler);
          },
        );
      } else {
        return super.onRequest(options, handler);
      }
    });
  }

}

///获取当前语言
String getLang() {
  ///默认简体
  String lang = 'zh';
  if (Get.locale?.languageCode == 'zh' && Get.locale?.countryCode == 'TW') {
    ///繁体
    lang = 'tw';
  } else if (Get.locale?.languageCode == 'en') {
    ///英文
    lang = 'en';
  } else if (Get.locale?.languageCode == 'vi') {
    ///越南
    lang = 'vi';
  } else if (Get.locale?.languageCode == 'ko') {
    ///韩国
    lang = 'ko';
  } else if (Get.locale?.languageCode == 'pt') {
    ///葡萄牙
    lang = 'pt';
  }else if (Get.locale?.languageCode == 'id') {
    ///印尼语
    lang = 'ad';
  }else if (Get.locale?.languageCode == 'th') {
    ///泰国
    lang = 'th';
  }else if (Get.locale?.languageCode == 'ms') {
    ///马来西亚
    lang = 'ms';
  }else if (Get.locale?.languageCode == 'es') {
    ///西班牙语
    lang = 'es';
  }else if (Get.locale?.languageCode == 'my') {
    ///缅甸语
    lang = 'mya';
  }else if (Get.locale?.languageCode == 'ar') {
    ///阿拉伯语
    lang = 'ara';
  }else if (Get.locale?.languageCode == 'ru') {
    ///俄语
    lang = 'ru';
  }else if (Get.locale?.languageCode == 'hi') {
    ///印地语
    lang = 'hin';
  }else if (Get.locale?.languageCode == 'zh' && SettingMenuController.to.teamNamePreference == 2) {
    /// 特殊繁译
    lang = 'hk';
  }
  return lang;
}



