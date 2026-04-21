import 'package:filbet/http/http_exceptions.dart';
import 'package:get/get.dart';

class BaseService extends GetxService {
  // 错误
  final Rx<HttpException?> _exception = Rx(null);
  HttpException? get exception => _exception.value;
  set exception(HttpException? val) => _exception.value = val;

  /// [future] providers 方法
  /// 带错误处理的网络请求处理方法
  Future<T?> fetchHandler<T>(
    Future<T> future, {
    Function(HttpException exception)? onError,
    Function(T response)? onSuccess,
    Function()? onStart,
    Function()? onComplete,
    bool loading = false,
  }) async {
    try {
      if (onStart != null) onStart();
      T response = await future;
      if (onSuccess != null) await onSuccess(response);
      return response;
    } on HttpException catch (error) {
      exception = error;
      if (onError != null) onError(error);
    } catch (_) {
      rethrow;
    } finally {
      if (onComplete != null) onComplete();
    }
    return null;
  }
}
