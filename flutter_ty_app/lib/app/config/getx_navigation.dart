import 'package:flutter/material.dart' ;
import 'package:get/get.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  GET  插件封装加ID兼容 】】】
    【【【 AUTO_PARAGRAPH_TITLE GET  插件封装加ID兼容 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - GET  插件封装加ID兼容
    - Get_TY
    ```
    Get_TY.bottomSheet();
    Get_TY.back();

    ```
    】】】
 *
 */

class Get_TY {
  static const _id = 888;

  static GlobalObjectKey globalObjectKeyDB = const GlobalObjectKey("globalObjectKeyDB");
  static GlobalKey<NavigatorState>? navigatorStateKeyDB = Get.nestedKey(_id);
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKeyDB = const GlobalObjectKey("scaffoldMessengerStateKeyDB");

  //开关。如果设置为false，则走Get相关调用
  static bool useTYDefaultId = true;

  static Future<T?> bottomSheet<T>(
    Widget widget, {
        Color? backgroundColor,
        String? barrierLabel,
        double? elevation,
        ShapeBorder? shape,
        Clip? clipBehavior,
        BoxConstraints? constraints,
        Color? barrierColor,
        bool isScrollControlled = false,
        double scrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
        bool useRootNavigator = false,
        bool isDismissible = true,
        bool enableDrag = true,
        bool? showDragHandle,
        bool useSafeArea = false,
        RouteSettings? routeSettings,
        AnimationController? transitionAnimationController,
        Offset? anchorPoint,
        AnimationStyle? sheetAnimationStyle,
  }) {
    if(useTYDefaultId) {
      return showModalBottomSheet<T>(
        context: navigatorStateKeyDB!.currentContext!,
        builder: (BuildContext context) {
          return widget;
        },
        backgroundColor: backgroundColor,
        barrierLabel: barrierLabel,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings??RouteSettings(name: 'TYBottomSheet'), // 给底部弹出框指定一个名称,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
        sheetAnimationStyle: sheetAnimationStyle,
      );
    }else{
      return Get.bottomSheet(widget,
          backgroundColor:backgroundColor,
          elevation:elevation,
          shape:shape,
          clipBehavior:clipBehavior,
          barrierColor:barrierColor,
          isScrollControlled:isScrollControlled,
          useRootNavigator :useRootNavigator,
          isDismissible:isDismissible,
          enableDrag:enableDrag,
      );
    }
  }

  static Future<T?> dialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return Get.dialog(
      widget,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      navigatorKey: navigatorKey ?? (useTYDefaultId?navigatorStateKeyDB:null),
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings??RouteSettings(name: 'TYDialog'),
    );
  }

  static Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    Duration? reverseDuration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) {
    return Get.to(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      duration: duration,
      //reverseDuration: reverseDuration,
      id: id ?? (useTYDefaultId?_id:null),
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      arguments: arguments,
      binding: binding,
      preventDuplicates: preventDuplicates,
      popGesture: popGesture,
      gestureWidth: gestureWidth,
    );
  }

  static Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed(
      page,
      arguments: arguments,
      id: id ?? (useTYDefaultId?_id:null),
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  static Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.offNamed<T>(
      page,
      arguments: arguments,
      id: id ?? (useTYDefaultId?_id:null),
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  static void until(RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widgets don't mounted
    return Get.global(id ?? (useTYDefaultId?_id:null)).currentState?.popUntil(predicate);
  }

  static Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widgets don't mounted
    return Get.global(id ?? (useTYDefaultId?_id:null)).currentState?.pushAndRemoveUntil<T>(page, predicate);
  }

  static Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return Get.global(id ?? (useTYDefaultId?_id:null)).currentState?.pushNamedAndRemoveUntil<T>(
          page,
          predicate,
          arguments: arguments,
        );
  }

  static Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return Get.global(id ?? (useTYDefaultId?_id:null)).currentState?.popAndPushNamed(
          page,
          arguments: arguments,
          result: result,
        );
  }

  static void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    Get.back<T>(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id ?? (useTYDefaultId?_id:null),
    );
  }

  static void close(int times, [int? id]) {
    return Get.close(times, id ?? (useTYDefaultId?_id:null));
  }

  static Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: newRouteName, queryParameters: parameters);
      newRouteName = uri.toString();
    }

    return Get.global(id ?? (useTYDefaultId?_id:null)).currentState?.pushNamedAndRemoveUntil<T>(
          newRouteName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
  }
}
