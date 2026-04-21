
import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

import '../../services/models/res/match_entity.dart';
import '../match_detail/models/header_type_enum.dart';
import '../match_detail/models/request_status.dart';

class PipVideoState {
  String currentType = "video";
  RequestStatus requestStatus = RequestStatus.loading;
  MatchEntity? match;
  WebviewController? webviewWindowsController;
  WebViewController? webViewController;
  bool isFullScreen = false;

  /// 视频说明打开标识
  bool isOpenVideoInfo = false;

  /// 头部状态 通用、视频、动画
  HeaderType headerType = HeaderType.normal;

  /// 视频直播声音
  bool liveMuted = false;

  // 动画宽高比例
  double animateRatio = 16 / 9;

  bool videoTopShow = true;

  Timer? timer;
  StreamSubscription? sub;

  PipVideoState() {

  }
}
