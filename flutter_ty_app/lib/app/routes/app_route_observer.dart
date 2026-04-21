import 'package:flutter/material.dart';




class AppRouteObserver<R extends Route<dynamic>> extends RouteObserver<R>  {
  Route<dynamic>? topRoute;
  @override
  void didPush(Route route, Route? previousRoute) {
    topRoute = route;
    // _record(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    topRoute = previousRoute;
    /// pop 后，当前展示的是 previousRoute
    // _record(previousRoute);
    super.didPop(route, previousRoute);
  }

  ///页面停留时长记录
  void _record(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (name == null || name.isEmpty) return;
  }


  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      topRoute = newRoute;
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route == topRoute) topRoute = previousRoute;

    super.didRemove(route, previousRoute);
  }

//
// @override
// void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//   if (newRoute != null) {
//     final index = Routes.history.indexWhere((element) {
//       return element == oldRoute?.settings.name;
//     });
//     final name = newRoute.settings.name ?? '';
//     if (name.isNotEmpty) {
//       if (index > -1) {
//         Routes.history[index] = name;
//       } else {
//         Routes.history.add(name);
//       }
//     }
//   }
//   AppLogger.debug('didReplace');
//   AppLogger.debug('Routes.history: ${Routes.history}');
//   super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
// }
//
// @override
// void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
//   final name = route.settings.name ?? '';
//   if (name.isNotEmpty) Routes.history.remove(name);
//   AppLogger.debug('didRemove');
//   AppLogger.debug('Routes.history: ${Routes.history}');
//   super.didRemove(route, previousRoute);
// }
}
