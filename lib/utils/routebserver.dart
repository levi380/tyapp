import 'package:flutter/material.dart';

//路由监听
class Routebserver extends NavigatorObserver {
  //页面进入
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('页面进入: ${route.settings.name}');
  }

  //页面返回
}
