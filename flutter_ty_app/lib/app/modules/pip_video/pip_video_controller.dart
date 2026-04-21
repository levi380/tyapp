import 'dart:async';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/pip_video/pip_video_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:get/get.dart';

import '../../db/app_cache.dart';
import '../../global/config_static.dart';
import '../../global/data_store_controller.dart';
import '../../global/data_store_operate/data_store_handle/data_store_handle.dart';
import '../../global/ty_user_controller.dart';

import '../../services/models/res/api_res.dart';
import '../../services/models/res/match_entity.dart';
import '../../services/models/res/video_animation_url_entity.dart';
import 'pip_video_service.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/sport.dart';
import '../../utils/utils.dart';
import '../../utils/video_util.dart';
import '../home/controllers/home_controller.dart';
import '../home/controllers/home_controller_ext.dart';
import '../match_detail/constants/detail_constant.dart';
import '../match_detail/models/header_type_enum.dart';
import '../match_detail/models/request_status.dart';
import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../utils/webview_ios_http_auth.dart';
import 'pip_video_state.dart';

class PipVideoController extends GetxController {
  static PipVideoController? get to {
    if (Get.isRegistered<PipVideoController>()) {
      return Get.find<PipVideoController>();
    }
    return null;
  }

  final PipVideoState state = PipVideoState();

  @override
  void onInit() {
    super.onInit();
    initBus();
    state.sub = EventBus().on<EventType>().listen(handleEvent);
    _timerCloseTopShow();
  }

  @override
  void onClose() {
    super.onClose();
    state.sub?.cancel();
    state.timer?.cancel();
    state.timer = null;
    state.webviewWindowsController?.clearCache();
    state.webviewWindowsController?.clearCookies();
    state.webviewWindowsController?.dispose();

    // webview
    try {
      state.webViewController?.loadRequest(Uri.parse('about:blank'));

      state.webViewController?.clearCache();
      state.webViewController?.clearLocalStorage();
    } catch (e) {}

    Bus.getInstance().off(EventType.updata_detail_data);
    Bus.getInstance().off(EventType.RCMD_C11);
  }

  Future<void> initializeWebView() async {
    if (Platform.isWindows) {
      state.webviewWindowsController = WebviewController();
      await state.webviewWindowsController?.initialize();
      await state.webviewWindowsController
          ?.setBackgroundColor(const Color(0x00ffffff));
      await state.webviewWindowsController?.setCacheDisabled(false);
    } else {
      // #docregion platform_features
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{}, // ios视频自动播放
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      final WebViewController controller =
          WebViewController.fromPlatformCreationParams(params);
      // #enddocregion platform_features

      final NavigationDelegate nav = NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onHttpAuthRequest: tyWebViewRejectHttpAuth,
      );
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000));
      await tyWebViewSetNavigationDelegateForIos(
        controller: controller,
        navigationDelegate: nav,
      );
      // #docregion platform_features
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }
      // #enddocregion platform_features

      state.webViewController = controller;
    }
  }

  /// 加载视频
  loadVideo() async {
    if (state.match == null) return;

    bool check = state.match!.mms >= 2 || state.match!.mvs > -1;
    if (!check) {
      return;
    }

    try {
      // 判断登录
      bool isLogin = await PipVideoService().checkLogin();
      if (isLogin) {
        // 电竞只有视频
        if ([
          (SportConfig.lol.sportId - 2000).toString(),
          (SportConfig.dota2.sportId - 2000).toString(),
          (SportConfig.cs2.sportId - 2000).toString(),
          (SportConfig.honorOfKings.sportId - 2000).toString(),
          (SportConfig.valorant.sportId - 2000).toString()
        ].contains(state.match?.csid)) {
          String? mediaSrc = state.match?.vurl ?? state.match?.varl;
          await checkUrl(mediaSrc);
        } else {
          String referUrl = StringKV.liveUrl.get() ?? "";
          String mediaSrc = '';
          if (referUrl != '') {
            mediaSrc = VideoUtil.getVideoUrlH5(referUrl, state.match!.mid,
                liveType: 1, muted: false, matchEntity: state.match);
            await checkUrl(mediaSrc);
          } else {
            /// 本地referUrl没有 走这里
            String sendGcuuid = createGcuuid();
            var data = await PipVideoService().getVideoReferUrl(sendGcuuid);
            if (data != null && data['code'] == "0000000") {
              //[GETX] {"code":"0000000","data":{"referUrl":"https://sandboxliveh5.sportxxx13ky.com","aniUrl":"https://d2theorj75dyet.cloudfront.net/sc/index.jsp?"},"msg":"成功","ts":1710687162751}
              mediaSrc = VideoUtil.getVideoUrlH5(
                  data['data']['referUrl'], state.match!.mid,
                  liveType: 1, muted: true, matchEntity: state.match);
              await checkUrl(mediaSrc);
            }
          }
        }
      }
    } catch (e) {
      Get.log("loadVideo:$e");
    }
    update();
  }

  /// 加载动画
  loadAnimation() async {
    if (state.match == null) return;
    bool check = state.match!.mms >= 2 || state.match!.mvs > -1;
    if (!check) {
      return;
    }

    try {
      await PipVideoService()
          .getVideoAnimationUrl(state.match!.mid)
          .then((value) async {
        if (value.success && ObjectUtil.isNotEmpty(value.data)) {
          VideoAnimationUrlEntity videoAnimationUrlEntity = value.data!;
          String animationUrl = "";
          //足篮棒网使用3.0动画  其他使用2.0
          if (["1", "2", "3", "5"].contains(state.match?.csid)) {
            String style = "night";
            List<VideoAnimationUrlAnimation3Url> animation3Urls =
                videoAnimationUrlEntity.animation3Url;
            animation3Urls.forEach((item) {
              if (item.styleName.contains(style)) {
                animationUrl = item.path;
              }
            });
          }
          animationUrl = animationUrl == ""
              ? videoAnimationUrlEntity.animationUrl
              : animationUrl;

          String str = "leagueName=${state.match!.tn}";

          animationUrl =
              "$animationUrl&ty_theme=${Get.isDarkMode ? "night" : "day"}&$str";
          int mbmty = state.match!.mbmty;
          if (mbmty == 2 || mbmty == 4) {
            ///F01 动画 需要拼接 e_match=1 否则播放不了
            /// 电子赛事时增加e_match参数,标志是电子足球/篮球
            animationUrl += '&e_match=1';
          }
          state.animateRatio = videoAnimationUrlEntity.animationDs == "Z01"
              ? obtyAnimateZ01Ratio
              : obtyAnimateRatio;
          load(animationUrl);
          state.currentType = "animation";
          state.headerType = HeaderType.animate;
          state.requestStatus = RequestStatus.success;
          _timerCloseTopShow();
        }
      });
    } catch (e) {
      Get.log("loadAnimate:$e");
    } finally {
      update();
    }
  }

  /// 检测视频
  checkUrl(url) async {
    try {
      bool isOk = await PipVideoService().checkUrl(url);

      // 检查响应状态码
      if (isOk) {
        // webviewWindowsController?.loadRequest(Uri.parse(url));
        // webviewWindowsController?.loadUrl(url);
        load(url);
        state.currentType = "video";
        state.headerType = HeaderType.live;
        _timerCloseTopShow();
        // videoUrl = url;
        // 处理请求结果
        Get.log('Received data: success');
      } else {
        // videoUrl = "";
        Get.log('Request failed');
      }
    } catch (e) {
      // videoUrl = "";

      Get.log('Exception caught: $e');
    } finally {
      state.requestStatus = RequestStatus.success;
      update();
    }
  }

  void load(String url) {
    if (Platform.isWindows) {
      state.webviewWindowsController?.loadUrl(url);
    } else {
      state.webViewController?.loadRequest(Uri.parse(url));
    }
  }

  // 公共方法
  void reload() {
    if (Platform.isWindows) {
      state.webviewWindowsController?.reload();
    } else {
      state.webViewController?.reload();
    }
  }

  void goBack() {
    if (Platform.isWindows) {
      state.webviewWindowsController?.goBack();
    } else {
      state.webViewController?.goBack();
    }
  }

  initMatch(MatchEntity matchEntity) {
    state.match = matchEntity;
    fetchMatchDetailData();
  }

  void play(String type) {
    state.currentType = type;

    if (state.currentType == "video") {
      loadVideo();
    } else {
      loadAnimation();
    }
  }

  void toggleFullScreen() {
    state.isFullScreen = !state.isFullScreen;
    update();
  }

  fetchMatchDetailData() async {
    try {
      if (state.match == null) {
        return;
      }
      String mId = state.match!.mid;
      // 详情数据
      await PipVideoService()
          .getMatchDetail(mId, TYUserController.to.getUid(), "init",
              isEsport: MatchUtil.isEsport(state.match!))
          .then((value) {
        _detailDataHandler(value, mId);
      });
    } catch (e) {
      Get.log("fetchMatchDetailData:$e");
      update();
    }
  }

  _detailDataHandler(ApiRes<Map<String, dynamic>> value, String mId) {
    if (value.success && ObjectUtil.isNotEmpty(value.data)) {
      // 从数据库取原始数据 有原始数据不能直接覆盖
      MatchEntity? originMatch = DataStoreController.to.getMatchById(mId);
      if (originMatch != null) {
        Map<String, dynamic> originMatchMap = originMatch.toJson();
        // 合并赛事
        originMatchMap.addAll(value.data!);
        state.match = MatchEntity.fromJson(originMatchMap);
      } else {
        state.match = MatchEntity.fromJson(value.data!);
      }

      DataStoreController.to.updateMatch(state.match!);

      // 插入数据仓库可视化赛事
      DataStoreController.to.injecthowMatchIdByMatchEntity(mId);
      update();

      /// 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断   ms=110时:显示即将开赛
      List<int> arrMs = [
        SportData.sportMs_0,
        SportData.sportMs_1,
        SportData.sportMs_2,
        SportData.sportMs_7,
        SportData.sportMs_10,
        SportData.sportMs_110
      ];
      if (state.match!.mmp == "999" || !arrMs.contains(state.match!.ms)) {
        Get.log("赛事结束-mmp:" +
            state.match!.mmp +
            "-ms:" +
            state.match!.ms.toString());
        TyHomeController.to.closePipVideo();
      }
    } else {
      // 赛事不存在 关闭画中画
      Get.log("赛事不存在");
      TyHomeController.to.closePipVideo();
    }
  }

  //  主题
  changeTheme() {
    // 动画底色 黑夜白天
    if (state.headerType == HeaderType.animate) {
      loadAnimation();
    }

    update();
  }

  void changeTopShow() {
    if (state.headerType == HeaderType.normal) return;
    state.videoTopShow = !state.videoTopShow;
    update();
    _timerCloseTopShow();
  }

  bool isPausedForNavigation = false;

  // 导航跳转暂停视频
  void pauseVideoForNavigation() {
    Get.log("PipVideo: pausing video for navigation");
    isPausedForNavigation = true;
    if (Platform.isWindows) {
      state.webviewWindowsController?.loadUrl('about:blank');
    } else {
      state.webViewController?.loadRequest(Uri.parse('about:blank'));
    }
  }

  // 导航返回恢复视频
  void resumeVideoFromNavigation() {
    Get.log("PipVideo: resuming video from navigation");
    if (!isPausedForNavigation) return;
    isPausedForNavigation = false;
    if (state.headerType == HeaderType.live) {
      loadVideo();
    } else if (state.headerType == HeaderType.animate) {
      loadAnimation();
    }
  }

  void _timerCloseTopShow() {
    state.timer?.cancel();
    state.timer = null;
    state.timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (isClosed) return;
      if (state.videoTopShow && state.headerType != HeaderType.normal) {
        state.videoTopShow = false;
        update();
      }
    });
  }

  /// 声音切换
  switchVideoVolume() async {
    state.videoTopShow = true;
    await FlutterVolumeController.updateShowSystemUI(true);
    if (state.liveMuted) {
      await FlutterVolumeController.setVolume(0.5);
      // sendMessage({"cmd": 'volume_video', "volume": 1});
      state.liveMuted = false;
    } else {
      await FlutterVolumeController.setMute(true);
      // sendMessage({"cmd": 'volume_video', 'volume': 0});
      state.liveMuted = true;
    }
    update();
  }
}
