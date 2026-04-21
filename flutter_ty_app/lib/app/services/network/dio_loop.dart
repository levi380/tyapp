import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'dart:convert' as convert;

// typedef FunThen = void Function(dynamic);
// typedef FunCatch = void Function(dynamic);
// typedef FunFinally = void Function();

///例子测试
// Future<void> fetchTest() async {
//   Map<String, dynamic> data = {
//     // parameters
//     'mids':
//     '3286402,3286615,3286620,3286629,3286631,3286636,3286642,3286643,3286645,3286646',
//     'cuid': '511778663232900410',
//     'sort': 1,
//     'device': 'v2_h5_st'
//   };
//   int maxLoop = 3;
//   int timers = 1000;
//   var result = await AppDio.getInstance().dioApiLoop(
//       '/yewu11/v1/m/getMatchBaseInfoByMids',
//       data: data,
//       maxLoop: maxLoop,
//       timers: timers,
//       errorCodes: [200,0400500]
//   );
//   if(result != null){
//     print(result.toString());
//   }
// }
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9d7f30ff-98d9-47f5-b72a-4dba0578d664-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  dio loop请求类 】】】
    【【【 AUTO_PARAGRAPH_TITLE dio loop请求类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - dio loop请求代码块
    ```
    try {
    Options opt = Options(extra: options, method: methodValues[method]);
    Response res;
    res = await dio.request(
    apiPath,
    data: data,
    queryParameters: params,
    cancelToken: cancelToken,
    options: opt,
    );
    final code =
    res.statusCode ?? res.data['code'] ?? res.data['data']['code'];
    List errorCodeList = errorCodes ?? [];
    if (errorCodeList.contains(code)) {
    if (loopCount >= maxLoop) {
    keyMap.remove(options['dioKey']);
    // funFinally?.call();
    } else {
    Timer newTimer = Timer(Duration(milliseconds: timers), () async {
    Options opt = Options(extra: options, method: methodValues[method]);
    res = await dioApiLoop(apiPath,
    data: data,
    params: params,
    maxLoop: maxLoop,
    timers: timers,
    errorCodes: errorCodes,
    cancelToken: cancelToken,
    loopCount: loopCount,
    dioKey: dioKey,
    options: opt);
    return res.data;
    });
    looptimers[options['dioKey']] = newTimer;
    return null;
    }
    } else {
    if (keyMap.containsKey(options['dioKey'])) {
    keyMap.remove(options['dioKey']);
    // funFinally?.call();
    }
    }

    return res.data;
    } on DioError catch (e) {
    if (looptimers.keys.contains(options['dioKey'])) {
    Timer? timer = looptimers[options['dioKey']];
    timer?.cancel();
    }
    if (loopCount >= maxLoop) {
    keyMap.remove(options['dioKey']);
    // funFinally?.call();
    } else {
    Timer newTimer = Timer(Duration(milliseconds: timers), () async {
    Options opt = Options(extra: options, method: methodValues[method]);
    Response res;
    res = await dioApiLoop(apiPath,
    data: data,
    params: params,
    maxLoop: maxLoop,
    timers: timers,
    cancelToken: cancelToken,
    loopCount: loopCount,
    errorCodes: errorCodes,
    dioKey: dioKey,
    options: opt);
    return res.data;
    });
    looptimers[options['dioKey']] = newTimer;
    return null;
    }
    rethrow;
    }
    ```
    】】】
 *
 */
extension DioApiLoop on AppDio {
  static final Map<String, dynamic> keyMap = {};

  Future<T?> dioApiLoop<T>(
    ///接口名
    String apiPath, {
    DioMethod method = DioMethod.post,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    // FunFinally? funFinally,
    ///循环请求最大次数
    int maxLoop = 3,

    ///请求间隔时间
    int timers = 1000,

    ///需要监听的错误码数组
    List? errorCodes,

    ///循环请求标记数 不传就是从0开始计时
    int loopCount = 0,

    ///可以自己传 不传就是根据时间撮
    String? dioKey,
  }) async {
    loopCount++;
    final options = {
      'apiPath': apiPath,
      'params': params,
      // 'fun_finally': funFinally,
      'max_loop': maxLoop,
      'timers': timers,
      'error_codes': errorCodes,
      'loop_count': loopCount,
      'dioKey': dioKey,
    };
    options['loop_count'] = loopCount;
    String key = options['dioKey'].toString();
    if (dioKey != null && !keyMap.containsKey(key)) {
      return null;
    }
    if (dioKey == null) {
      dioKey =
          options['dioKey'] = DateTime.now().millisecondsSinceEpoch.toString();
      String key = options['dioKey'].toString();
      keyMap[key] = options['dioKey'];
    }
    if (looptimers.keys.contains(options['dioKey'])) {
      Timer? timer = looptimers[options['dioKey']];
      timer?.cancel();
    }

    const methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    try {
      Options opt = Options(extra: options, method: methodValues[method]);
      Response res;
      res = await dio.request(
        apiPath,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: opt,
      );
      final code =
          res.statusCode ?? res.data['code'] ?? res.data['data']['code'];
      List errorCodeList = errorCodes ?? [];
      if (errorCodeList.contains(code)) {
        if (loopCount >= maxLoop) {
          keyMap.remove(options['dioKey']);
          // funFinally?.call();
        } else {
          Timer newTimer = Timer(Duration(milliseconds: timers), () async {
            Options opt = Options(extra: options, method: methodValues[method]);
            res = await dioApiLoop(apiPath,
                data: data,
                params: params,
                maxLoop: maxLoop,
                timers: timers,
                errorCodes: errorCodes,
                cancelToken: cancelToken,
                loopCount: loopCount,
                dioKey: dioKey,
                options: opt);
            return res.data;
          });
          looptimers[options['dioKey']] = newTimer;
          return null;
        }
      } else {
        if (keyMap.containsKey(options['dioKey'])) {
          keyMap.remove(options['dioKey']);
          // funFinally?.call();
        }
      }

      return res.data;
    } on DioException {
      if (looptimers.keys.contains(options['dioKey'])) {
        Timer? timer = looptimers[options['dioKey']];
        timer?.cancel();
      }
      if (loopCount >= maxLoop) {
        keyMap.remove(options['dioKey']);
        // funFinally?.call();
      } else {
        Timer newTimer = Timer(Duration(milliseconds: timers), () async {
          Options opt = Options(extra: options, method: methodValues[method]);
          Response res;
          res = await dioApiLoop(apiPath,
              data: data,
              params: params,
              maxLoop: maxLoop,
              timers: timers,
              cancelToken: cancelToken,
              loopCount: loopCount,
              errorCodes: errorCodes,
              dioKey: dioKey,
              options: opt);
          return res.data;
        });
        looptimers[options['dioKey']] = newTimer;
        return null;
      }
      rethrow;
    }
  }
}


class LogUtils {
  static const String tag = 'DEER-LOG';

  /// 是否是调试模式
  static const bool isDebug = kDebugMode;

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static void print_(object) {
    if (!inProduction) {
    }
  }

  static void printAll(object) {
    if (!inProduction) {
    }
  }

  static void init() {
    LogUtil.init(isDebug: !inProduction);
  }

  static void d(String msg, {String tag = tag}) {
    if (!inProduction) {
      LogUtil.v(msg, tag: tag);
    }
  }

  static void e(String msg, {String tag = tag}) {
    if (!inProduction) {
      LogUtil.e(msg, tag: tag);
    }
  }

  static void json(String msg, {String tag = tag}) {
    if (!inProduction) {
      final dynamic data = convert.json.decode(msg);
      if (data is Map) {
        _printMap(data);
      } else if (data is List) {
        _printList(data);
      } else {
        LogUtil.v(msg, tag: tag);
      }
    }
  }

  // https://github.com/Milad-Akarie/pretty_dio_logger
  static void _printMap(Map data, {String tag = tag, int tabs = 1, bool isListItem = false, bool isLast = false}) {
    final bool isRoot = tabs == 1;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) LogUtil.v('$initialIndent{', tag: tag);

    data.keys.toList().asMap().forEach((index, key) {
      final bool isLast = index == data.length - 1;
      var value = data[key];
      if (value is String) value = '\'$value\'';
      if (value is Map) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: $value${!isLast ? ',' : ''}', tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: {', tag: tag);
          _printMap(value, tabs: tabs);
        }
      } else if (value is List) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: ${value.toString()}', tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: [', tag: tag);
          _printList(value, tabs: tabs);
          LogUtil.v('${_indent(tabs)} ]${isLast ? '' : ','}', tag: tag);
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        LogUtil.v('${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', tag: tag);
      }
    });

    LogUtil.v('$initialIndent}${isListItem && !isLast ? ',' : ''}', tag: tag);
  }

  static void _printList(List list, {String tag = tag, int tabs = 1}) {
    list.asMap().forEach((i, e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (e.isEmpty) {
          LogUtil.v('${_indent(tabs)}  $e${!isLast ? ',' : ''}', tag: tag);
        } else {
          _printMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        LogUtil.v('${_indent(tabs + 2)} $e${isLast ? '' : ','}', tag: tag);
      }
    });
  }

  static String _indent([int tabCount = 1]) => '  ' * tabCount;
}
