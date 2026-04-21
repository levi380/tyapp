import 'package:filbet/http/http_exceptions.dart';
import 'package:filbet/services/theme/themeData.dart';
import 'package:filbet/services/theme/theme_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/fp.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

// 基础GetX状态控制器 主要处理一些公共的状态控制
// 比如 主题， 网络， 全局应用状态
abstract class GetXBaseController extends GetxController
    with WidgetsBindingObserver {
  final List<int> _pendingQueue = [];

  final Rx<AppThemeModel> themeData = ThemeService.to.theme.obs;

  // 页面状态
  final Rx<PageState> _pageState = PageState.idle.obs;

  PageState get pageState => _pageState.value;

  Rx<PageState> get pageStateObs => _pageState;

  set pageState(PageState val) => _pageState.value = val;

  // 错误
  final Rx<HttpException?> _exception = Rx(null);

  HttpException? get exception => _exception.value;

  set exception(val) => _exception.value = val;

  bool get isPageLoading => pageState == PageState.loading;

  void startLoading() => pageState = PageState.loading;

  void stopLoading() => pageState = PageState.idle;

  void criticalError() => pageState = PageState.error;

  void pageEmpty() => pageState = PageState.empty;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        // 应用程序仍然在 Flutter 引擎上运行，但是与宿主 View 组件分离
        break;
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.inactive:
        // 应用进入非活动状态，如来了个电话，电话应用进入前台
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
    }
  }

  void onPause() {}

  void onResume() {}

  /// [future] providers 方法
  /// 带错误处理的网络请求处理方法
  Future<T?> fetchHandler<T>(
    Future<T> future, {
    Function(HttpException exception)? onError,
    Function(T response)? onSuccess,
    Function()? onStart,
    Function()? onComplete,
    bool loading = false,
    bool showToastDialogState = false, //false:吐司    true:带图文的  4月16  日暂时不用
  }) async {
    _pendingQueue.add(future.hashCode);
    if (loading) {
      SmartDialog.showLoading(
        builder: (context) {
          return Align(
            alignment: Alignment.center,
            child: loadinngView(),
          );
        },
      );
      print('进入了loading');
      startLoading();
    }
    try {
      if (onStart != null) onStart();
      T response = await future;
      if (onSuccess != null) await onSuccess(response);
      // if()
      return response;
    } on HttpException catch (error) {
      SmartDialog.dismiss(status: SmartStatus.loading);
      pageState = PageState.error;
      exception = error;
      if (onError != null) onError(error);
    } catch (xxx) {
      print('错误：$xxx');
      rethrow;
    } finally {
      _pendingQueue.remove(future.hashCode);
      if (loading && _pendingQueue.isEmpty) stopLoading();
      SmartDialog.dismiss(status: SmartStatus.loading);
      if (onComplete != null) onComplete();
    }
    return null;
  }

  void Function(HttpException) toastError =
      (e) => AppUtils.showToast(e.message);
}

enum PageState {
  idle,
  loading,
  error,
  empty,
}
