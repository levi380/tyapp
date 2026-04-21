import 'package:filbet/http/http_exceptions.dart';

class HttpResponse<T> {
  late bool status;

  String? message;
  dynamic data;
  HttpException? error;
  // HttpResponse._internal({this.success = false, this.code = 400});

  HttpResponse.success(this.data, {String? msg, int? status}) {
    this.status = true;

    if (data == null) {
      this.data = [];
      this.message = msg;
    } else {
      this.data = data;
      this.message = msg;
    }
  }

  HttpResponse.successFromString(this.data) {
    this.status = true;

    this.data = data;
  }

  HttpResponse.failure({String? errorMsg, int? errorCode}) {
    final msg = (errorMsg != null && errorMsg.trim().isNotEmpty)
        ? errorMsg.trim()
        : '请求失败';
    this.error = BadRequestException(message: msg, code: errorCode);
    this.status = false;
    this.message = msg;
  }

  HttpResponse.failureFormResponse({dynamic data}) {
    this.error = BadResponseException(data);
    this.status = false;
    this.message = this.error!.message;
  }

  HttpResponse.failureFromError([HttpException? error]) {
    this.error = error ?? UnknownException();
    this.status = false;
    this.message = this.error!.message;
  }
}
