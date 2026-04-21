
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/match_video/sport_type_checker.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/match_video/video_animation_checker.dart';

import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../config/analytic/analytics_utils.dart';
import '../../../../db/app_cache.dart';
import '../../../../services/api/match_detail_api.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../services/models/res/video_animation_url_entity.dart';
import '../../../../services/network/app_dio.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';
import '../../../../utils/video_util.dart';
import '../../../quick_bet/quick_bet_controller.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'device_orientation_manager.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-8988d336-2dca-45e0-8d63-71c6ba2fa4d1 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频动画】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情视频动画相关逻辑处理相关】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 视频（电竞只有视频）： 判断登录-》本地liveUrl拼接-》liveUrl没有-》请求videoReferUrl-》对链接进行预请求
    - 动画： 请求动画接口-》对动画接口进行过滤-》对链接进行预请求
    】】】
 *
 */
extension MatchVideoExtension on MatchDetailController {
  /// 检查是否可以加载视频/动画
  bool _canLoadMedia(MatchEntity matchEntity) {
    return matchEntity.mms >= 2 || matchEntity.mvs > -1;
  }

  /// 加载视频
  /// 【【【 AUTO_PARAGRAPH_TITLE 视频加载逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 检查是否可以加载媒体
  /// 2. 发送埋点事件
  /// 3. 检查登录状态
  /// 4. 根据比赛类型加载视频（电竞或普通比赛）
  /// 5. 设置视频固定状态
  /// 】】】
  Future<void> loadVideo(MatchEntity matchEntity) async {
    // 检查是否可以加载视频
    if (!_canLoadMedia(matchEntity)) {
      return;
    }

    // 埋点
    Analytics.track(AnalyticsEvent.btn_live_tab,
        pagePath: '', clickTarget: AnalyticsEvent.btn_live_tab.name);

    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.live;

    try {
      // 检查登录状态
      final isLoggedIn = await _checkLoginStatus();
      if (!isLoggedIn) {
        detailState.liveLoading.value = false;
        return;
      }

      // 根据比赛类型加载视频
      if (SportTypeChecker.isEsport(detailState.match?.csid)) {
        // 电竞只有视频
        await _loadEsportVideo(matchEntity);
      } else {
        // 普通比赛视频
        await _loadRegularVideo(matchEntity);
      }
    } catch (e) {
      AppLogger.debug("loadVideo error: $e");
      detailState.liveLoading.value = false;
    } finally {
      setVideoFixed();
      update();
    }
  }

  /// 检查登录状态
  Future<bool> _checkLoginStatus() async {
    try {
      final response = await AppDio.getInstance()
          .dio
          .post('${StringKV.baseUrl.get()!}/yewu11/v1/w/isLogin');
      final data = response.data;

      if (data['code'] == "0401038") {
        return false;
      }

      return data['code'] == "0000000" && data['data']['isLogin'];
    } catch (e) {
      return false;
    }
  }

  /// 加载电竞视频
  Future<void> _loadEsportVideo(MatchEntity matchEntity) async {
    String? mediaSrc = detailState.match?.vurl ?? detailState.match?.varl;

    if (mediaSrc != null && mediaSrc.isNotEmpty) {
      await checkMediaUrl(mediaSrc);
    } else {
      detailState.liveLoading.value = false;
    }
  }

  /// 加载普通比赛视频
  Future<void> _loadRegularVideo(MatchEntity matchEntity) async {
    String? referUrl = StringKV.liveUrl.get();
    String mediaSrc = '';

    if (referUrl != null && referUrl.isNotEmpty) {
      // 使用本地referUrl拼接视频URL
      mediaSrc = VideoUtil.getVideoUrlH5(referUrl, detailState.mId,
          liveType: 1,
          muted: detailState.liveMuted.value,
          matchEntity: matchEntity);
      await checkMediaUrl(mediaSrc);
    } else {
      // 本地referUrl没有，从服务器获取
      mediaSrc = await _getReferUrlFromServer(matchEntity);
      if (mediaSrc.isNotEmpty) {
        await checkMediaUrl(mediaSrc);
      }
    }
  }

  /// 从服务器获取referUrl
  Future<String> _getReferUrlFromServer(MatchEntity matchEntity) async {
    String sendGcuuid = createGcuuid();
    Map<String, dynamic> param = {'gcuuid': sendGcuuid, 'device': 'H5'};

    try {
      final response = await AppDio.getInstance().dio.post(
            '${StringKV.baseUrl.get()!}/yewu11/v1/w/videoReferUrl?device=H5',
            data: param,
          );

      final referUrl = response.data['data']['referUrl'];
      return VideoUtil.getVideoUrlH5(
        referUrl,
        detailState.mId,
        liveType: 1,
        muted: detailState.liveMuted.value,
        matchEntity: matchEntity,
      );
    } catch (e) {
      return '';
    }
  }

  /// 加载动画
  /// 【【【 AUTO_PARAGRAPH_TITLE 动画加载逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 检查是否可以加载媒体
  /// 2. 请求动画URL接口
  /// 3. 构建动画URL（区分3.0动画和2.0动画）
  /// 4. 检查动画URL是否可用
  /// 5. 设置视频固定状态
  /// 】】】
  Future<void> loadAnimation(MatchEntity matchEntity) async {
    // 检查是否可以加载动画
    if (!_canLoadMedia(matchEntity)) {
      return;
    }

    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.animate;

    try {
      // 请求动画URL
      final response = await MatchDetailApi.instance()
          .getVideoAnimationUrl("Animation", detailState.mId);

      if (response.success && ObjectUtil.isNotEmpty(response.data)) {
        VideoAnimationUrlEntity videoAnimationUrlEntity = response.data!;

        // 构建动画URL
        final animationUrl =
            _buildAnimationUrl(videoAnimationUrlEntity, matchEntity);

        if (animationUrl.isNotEmpty) {
          // 设置动画头部高度
          detailState.animateHeaderHeight.value = 1.sw /
                  (videoAnimationUrlEntity.animationDs == "Z01"
                      ? obtyAnimateZ01Ratio
                      : obtyAnimateRatio) +
              detailState.physicalPaddingTop;

          // 检查动画URL
          await checkMediaUrl(animationUrl, isAnimation: true);
        } else {
          detailState.liveLoading.value = false;
        }
      } else {
        detailState.liveLoading.value = false;
      }
    } catch (e) {
      AppLogger.debug("loadAnimation error: $e");
      detailState.liveLoading.value = false;
    } finally {
      setVideoFixed();
      update();
    }
  }

  /// 构建动画URL
  String _buildAnimationUrl(
    VideoAnimationUrlEntity videoAnimationUrlEntity,
    MatchEntity matchEntity,
  ) {
    String animationUrl = "";

    // 足篮棒网使用3.0动画，其他使用2.0
    if (SportTypeChecker.isAnimation3Supported(detailState.match?.csid)) {
      String style = "night";
      List<VideoAnimationUrlAnimation3Url> animation3Urls =
          videoAnimationUrlEntity.animation3Url;

      // 查找对应风格的动画URL
      for (final item in animation3Urls) {
        if (item.styleName.contains(style)) {
          animationUrl = item.path;
          break;
        }
      }
    }

    // 如果没有找到3.0动画URL，使用2.0动画URL
    if (animationUrl.isEmpty) {
      animationUrl = videoAnimationUrlEntity.animationUrl;
    }

    // 构建URL参数
    String str = "leagueName=${matchEntity.tn}";
    animationUrl =
        "$animationUrl&ty_theme=${TyHomeController.to.homeState.isLight ? "day" : "night"}&$str";

    // 处理电子赛事
    int mbmty = matchEntity.mbmty;
    if (mbmty == 2 || mbmty == 4) {
      /// F01 动画需要拼接 e_match=1 否则播放不了
      /// 电子赛事时增加e_match参数，标志是电子足球/篮球
      animationUrl += '&e_match=1';
    }

    return animationUrl;
  }

  /// 统一检查媒体URL的方法
  /// 【【【 AUTO_PARAGRAPH_TITLE 媒体URL检查逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 检查URL是否可用
  /// 2. 如果可用，加载URL并显示视频顶部信息
  /// 3. 如果不可用，重置媒体URL
  /// 4. 更新加载状态和头部类型
  /// 】】】
  Future<void> checkMediaUrl(String url, {bool isAnimation = false}) async {
    detailState.liveLoading.value = true;

    try {
      // 检查URL是否可用
      final isAvailable = await VideoAnimationChecker.checkUrlAvailability(url);

      if (isAvailable) {
        // 加载URL
        detailState.webViewController.loadRequest(Uri.parse(url));

        // 保存URL
        if (isAnimation) {
          detailState.animationUrl = url;
        } else {
          detailState.videoUrl = url;
        }

        // 显示视频顶部信息
        showVideoTop();

        // 设置横屏方向
        if (!isSDK) {
          await DeviceOrientationManager.setLandscapeOrientation();
        }

        AppLogger.debug('URL loaded successfully: $url');
      } else {
        // 重置媒体URL
        _resetMediaUrl(isAnimation);
        AppLogger.debug('Request failed for URL: $url');
      }
    } catch (e) {
      // 重置媒体URL
      _resetMediaUrl(isAnimation);
      AppLogger.debug('Exception caught: $e');
    } finally {
      // 更新状态
      detailState.liveLoading.value = false;
      detailState.headerType.value =
          isAnimation ? HeaderType.animate : HeaderType.live;
    }
  }

  /// 重置媒体URL
  void _resetMediaUrl(bool isAnimation) {
    if (isAnimation) {
      detailState.animationUrl = "";
    } else {
      detailState.videoUrl = "";
    }
  }

  /// 直播视频蒙层信息显示
  /// 【【【 AUTO_PARAGRAPH_TITLE 视频顶部信息显示逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 显示视频顶部信息
  /// 2. 5秒后自动隐藏（除非被锁定）
  /// 】】】
  void showVideoTop() {
    detailState.videoTopShow.value = true;

    // 进入先显示遮盖信息，5秒后隐藏蒙层
    5.seconds.delay(() {
      if (isClosed) {
        return;
      }
      if (!detailState.lockVideoTopShow) {
        detailState.videoTopShow.value = false;
      }
    });
  }

  /// 全屏缩小放大通用方法
  /// 【【【 AUTO_PARAGRAPH_TITLE 全屏切换逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 设置投注控制器全屏状态
  /// 2. 横屏：设置横屏方向
  /// 3. 竖屏：设置竖屏方向，恢复系统UI
  /// 4. 延迟恢复方向设置
  /// 】】】
  Future<void> fullscreen(bool fullscreen) async {
    // 设置投注控制器全屏状态
    QuickBetController.to.setFullScreen(fullscreen);

    if (fullscreen) {
      // 横屏
      await DeviceOrientationManager.setLandscapeOrientation();
    } else {
      // 竖屏
      await DeviceOrientationManager.setPortraitOrientation();

      // 恢复系统UI
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );

      detailState.fullscreen.value = false;
      detailState.appbarPinned.value = false;

      // 设置头部不固定
      setVideoFixed(fixed: false);
    }

    // 延迟恢复方向设置
    if (!isSDK) {
      _delayedRestoreOrientation();
    }
  }

  /// 延迟恢复方向设置
  void _delayedRestoreOrientation() {
    2.seconds.delay(() {
      if (detailState.headerType.value == HeaderType.normal) {
        // 正常模式只允许竖屏
        DeviceOrientationManager.setPortraitOrientation();
      } else if (!isSDK) {
        // 视频/动画模式允许横竖屏
        DeviceOrientationManager.setLandscapeOrientation();
      }
    });
  }

  /// 视频上方组件展示
  void changeVideoTopShow(bool videoTopShow) {
    if (!detailState.topShowPermanent) {
      detailState.videoTopShow.value = videoTopShow;
    }
  }

  /// 动画视频固钉切换
  void saveVideoFixed() {
    changeVideoTopShow(true);
    detailState.videoFixed.value = !detailState.videoFixed.value;

    if (detailState.videoFixed.value) {
      // 固定视频/动画头部
      detailState.pinnedHeaderHeight.value =
          detailState.headerType.value == HeaderType.animate
              ? detailState.animateHeaderHeight.value
              : detailState.obtyHeaderHeight;
    } else {
      // 恢复默认头部高度
      final double statusBarHeight = detailState.physicalPaddingTop;
      detailState.pinnedHeaderHeight.value = statusBarHeight + obtyAppbarHeight;
    }

    update();
  }

  /// 设置头部固钉高度
  /// 【【【 AUTO_PARAGRAPH_TITLE 头部固定逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 设置视频固定状态
  /// 2. 固定：根据头部类型设置不同高度，更新滚动位置，发送事件
  /// 3. 不固定：恢复默认头部高度
  /// 】】】
  void setVideoFixed({bool fixed = true}) {
    detailState.videoFixed.value = fixed;

    if (fixed) {
      // 获取设置之前的固钉高度
      double before = detailState.pinnedHeaderHeight.value;

      // 设置新的固钉高度（动画和视频高度不同）
      detailState.pinnedHeaderHeight.value =
          detailState.headerType.value == HeaderType.animate
              ? detailState.animateHeaderHeight.value
              : detailState.obtyHeaderHeight;

      // 更新滚动位置
      _updateScrollPosition(before);

      // 发送事件通知正在播放动画
      Bus.getInstance().emit(
        EventType.matchDetailIsPlayingAnimation,
        detailState.headerType.value == HeaderType.animate,
      );
    } else {
      // 不固定，恢复默认头部高度
      final double statusBarHeight = detailState.physicalPaddingTop;
      detailState.pinnedHeaderHeight.value = statusBarHeight + obtyAppbarHeight;
    }
  }

  /// 更新滚动位置
  void _updateScrollPosition(double beforeHeight) {
    detailState.scrollController.position.applyContentDimensions(
      detailState.scrollController.position.minScrollExtent,
      detailState.scrollController.position.maxScrollExtent + beforeHeight,
    );
  }

  /// 播放视频
  /// 【【【 AUTO_PARAGRAPH_TITLE 播放视频逻辑】】】
  /// 【【【 AUTO_PARAGRAPH_CONTENT
  /// 1. 设置头部类型
  /// 2. 保存回放URL
  /// 3. 加载视频URL
  /// 4. 显示视频顶部信息
  /// 】】】
  Future<void> playVideo(
    String url, {
    HeaderType headerType = HeaderType.normal,
  }) async {
    detailState.headerType.value = headerType;
    detailState.replayUrl = url;
    detailState.webViewController.loadRequest(Uri.parse(url));
    detailState.videoTopShow.value = true;
  }

  /// 是否展示全屏投注
  bool isShowFullBet() {
    return fullBetMatchList.contains(detailState.match?.csid.toInt());
  }
}
