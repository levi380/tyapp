import 'dart:core';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';

import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-c142bcb1-1488-43af-a1c1-6ced08bd5d99-sz 】】】
    【【【 AUTO_DOCUMENT_MENU  公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  未登录管理类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未登录管理类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 过滤接口白名单
    ```
    '/v1/art/getAccessConfig',
    '/v1/games/imgDomain',
    '/v1/w/virtual/menus',
    '/v1/w/collectMatches',
    '/v1/w/eventCollection',
    '/v3/menu/init',
    '/v1/m/matches',
    '/v3/menu/initPB',
    '/v1/m/matchesPB',
    '/v1/m/getMatchBaseInfoByMids',
    '/v1/m/getMatchBaseInfoByMidsPB',
    '/v3/menu/loadMapping',
    '/v3/menu/loadNameList',
    '/v3/menu/loadTournamentMatch',
    '/v3/menu/loadMappingPB',
    '/v3/menu/loadNameListPB',
    '/v3/menu/loadTournamentMatchPB',
    '/v2/m/getOriginalData',
    '/v2/m/getOriginalDataPB',
    '/v1/getSystemTime/currentTimeMillis',
    '/v1/m/matcheResultPB',
    '/v1/m/matcheResult',
    '/v1/m/getFilterMatchListNew',
    '/v1/m/championMatchResult',
    ```
    - 代理接口replaceUrl
    ```
    static String replaceUrl = '/yewu11/v1/router/post/path';
    ```
    - 执行登录操作  1.app跳转登录页面  2.sdk进行回调
    ```
    static void operationsForLogin(){
    判断是否是sdk
    isSDK ? Bus.getInstance().emit(EventType.tyToLogin)
    : Get.toNamed(Routes.login);
    }
    ```
    】】】
 *
 */
///登录白名单 不需要添加token
class TokenWhiteList {
  static List whiteList = [
    //'/v1/router/post/path',
    '/v1/art/getAccessConfig',
    '/v1/games/imgDomain',
    '/v1/w/virtual/menus',
    '/v1/w/collectMatches',
    '/v1/w/eventCollection',
    '/v3/menu/init',
    '/v1/m/matches',
    '/v3/menu/initPB',
    '/v1/m/matchesPB',
    '/v1/m/getMatchBaseInfoByMids',
    '/v1/m/getMatchBaseInfoByMidsPB',
    '/v3/menu/loadMapping',
    '/v3/menu/loadNameList',
    '/v3/menu/loadTournamentMatch',
    '/v3/menu/loadMappingPB',
    '/v3/menu/loadNameListPB',
    '/v3/menu/loadTournamentMatchPB',
    '/v2/m/getOriginalData',
    '/v2/m/getOriginalDataPB',
    '/v1/getSystemTime/currentTimeMillis',
    '/v1/m/matcheResultPB',
    '/v1/m/matcheResult',
    '/v1/m/getFilterMatchListNew',
    '/v1/m/championMatchResult',
  ];

  // static List whiteListForreslut = [
  //   '/v1/m/matcheResultPB'
  // ];

  static String replaceUrl = '/yewu11/v1/router/post/path';
  // static String replaceUrlForResult = '/yewu11/v1/router/post/path';
  ///是否需要验证token
  static bool isLoginNoVerification(String apiPath) {
    // String route = Get.currentRoute;
    ///请求接口在白名单里 并且 是在首页
    return whiteList.contains(apiPath);
  }

  ///执行登录操作  1.app跳转登录页面  2.sdk进行回调
  static void operationsForLogin(){
    ///判断是否是sdk
    isSDK ? Bus.getInstance().emit(EventType.tyToLogin)
        : Get.toNamed(Routes.login);
  }

}
