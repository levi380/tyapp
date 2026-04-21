import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_response.dart';
import 'package:filbet/http/http_transformer.dart';

class DefaultHttpTransformer extends HttpTransformer {
  @override
  HttpResponse parse(Response response) {
    if (response.data is Map) {
      if (response.data["status"] == true || response.data["code"] == 200) {
        return HttpResponse.success(response.data["data"],
            msg: response.data["message"]);
      } else {
        if (response.data["data"] is Map && response.data["data"].isEmpty) {
          return HttpResponse.failure(errorMsg: "请求失败");
        }
        String errorMsg;
        if (response.realUri.toString().contains("/game2/transfer/out")) {
          // 为了解析转出接口的数据
          final fromMsg = response.data["message"]?.toString().trim();
          if (fromMsg != null && fromMsg.isNotEmpty) {
            errorMsg = fromMsg;
          } else {
            final d = response.data["data"];
            errorMsg = d != null ? jsonEncode(d) : "接口失败";
          }
        } else {
          final fromMsg = response.data["message"]?.toString().trim();
          if (fromMsg != null && fromMsg.isNotEmpty) {
            errorMsg = fromMsg;
          } else {
            final d = response.data["data"];
            if (d is String) {
              final t = d.trim();
              errorMsg = t.isNotEmpty ? t : "接口失败";
            } else {
              errorMsg = d != null ? jsonEncode(d) : "接口失败";
            }
          }
        }
        return HttpResponse.failure(errorMsg: errorMsg);
      }
    } else {
      if (response.data is! String) {
        return HttpResponse.failure(errorMsg: "响应格式无法解析");
      }
      final Map<dynamic, dynamic> map;
      try {
        final decoded = jsonDecode(response.data as String);
        if (decoded is! Map) {
          return HttpResponse.failure(errorMsg: "响应数据格式错误");
        }
        map = decoded;
      } catch (_) {
        return HttpResponse.failure(errorMsg: "响应数据解析失败");
      }
      if (map["status"] == true) {
        // String? serverAccessKeyToken =
        //     StorageUtils.getValue('serverAccessKeyToken');
        // if (serverAccessKeyToken != null) {
        //   if (response.data["data"] == null) {
        //     return HttpResponse.success(response.data);
        //   }
        //   String deCode = '';
        //   return HttpResponse.success(jsonDecode(deCode));
        // }
        return HttpResponse.success(map["data"], msg: map["message"]);
      } else {
        return HttpResponse.failure(
          errorMsg: nonEmptyMessageOr(
            map["message"]?.toString(),
            defaultMessage: '请求失败',
          ),
        );
      }
    }
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
