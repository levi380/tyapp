import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../global/data_store_operate/data_store_handle/data_store_handle.dart';
import '../../../../../services/network/request_interceptor.dart';
import '../../../controllers/match_detail_controller.dart';
import '../../../extension/match_video/match_video_extension.dart';
import '../../../extension/webview_extension.dart';
import '../../../models/header_type_enum.dart';
import 'change_line.dart';
import 'cover/bet_dialog_container.dart';
import 'cover/video_cover_bottom.dart';
import 'cover/video_cover_right_buttons.dart';
import 'cover/video_cover_top.dart';

/**
 * 【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 背景+全屏】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 视频动画全屏组件】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 视频动画全屏时顶部展示信息及交互 这里不使用.w .h
 * - 顶部 分数展示 返回
 * - 右 投注 赛事分析
 * - 下 全屏操作按钮
 * 】】】
 */
class VideoCover extends StatefulWidget {
  const VideoCover({
    super.key,
    required this.match,
    required this.controller,
    required this.tag,
  });

  final MatchEntity match;
  final MatchDetailController controller;
  final String tag;

  @override
  State<VideoCover> createState() => _VideoCoverState();
}

class _VideoCoverState extends State<VideoCover> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(widget.match.mid),
      builder: (dataStoreController) {
        final match = dataStoreController.getMatchById(widget.match.mid) ?? widget.match;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // 上 分数展示 返回
            Positioned(
              top: 0,
              left: 0,
              child: VideoCoverTop(
                match: match,
                onBack: () => widget.controller.back(),
                currentPlayType: widget.controller.detailState.playTypeList[
                widget.controller.detailState.selectLine.value
                ],
                onLineChange: _showLineChangeDialog,
              ),
            ),
            // 右 投注 赛事分析
            Positioned(
              right: 0,
              child: VideoCoverRightButtons(
                showBettingButton: true,
                showAnimationButton: _shouldShowAnimationButton(match),
                showVideoButton: _shouldShowVideoButton(match),
                onBettingTap: () => _showBettingDialog(match),
                onAnimationTap: () => widget.controller.loadAnimation(match),
                onVideoTap: () => widget.controller.loadVideo(match),
              ),
            ),
            // 下 按钮
            Positioned(
              bottom: 0,
              left: 0,
              child: Obx(() {
                return VideoCoverBottom(
                  showVolumeButton: _shouldShowVolumeButton,
                  isMuted: widget.controller.detailState.liveMuted.value,
                  onInfoTap: _showInfoDialog,
                  onVolumeTap: () {
                    widget.controller.changeVideoTopShow(true);
                    widget.controller.switchVideoVolume();
                  },
                  onExitFullScreen: () {
                    widget.controller.changeVideoTopShow(true);
                    widget.controller.fullscreen(false);
                  },
                );
              }),
            ),
            // 赛事直播说明
            if (_showInfo) Positioned(bottom: 0, child: _buildLiveInfo()),
          ],
        );
      },
    );
  }

  /// 赛事直播说明
  Widget _buildLiveInfo() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(36, 30, 36, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 1),
                  Color.fromRGBO(0, 0, 0, 0.87),
                  Color.fromRGBO(0, 0, 0, 0.6),
                  Color.fromRGBO(0, 0, 0, 0),
                ],
              ),
            ),
            child: Text(
              _buildInfoText(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: ["ru"].contains(getLang()) ? 13 : 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 条件判断方法
  bool get _shouldShowVolumeButton =>
      widget.controller.detailState.headerType.value == HeaderType.live;

  bool _shouldShowAnimationButton(MatchEntity match) =>
      widget.controller.detailState.headerType.value == HeaderType.live &&
          match.mvs > -1 &&
          (TYUserController.to.userInfo.value?.ommv ?? 0) != 0;

  bool _shouldShowVideoButton(MatchEntity match) =>
      widget.controller.detailState.headerType.value == HeaderType.animate &&
          (match.mms > 1 || match.pmms == 1);

  bool get _isHasStatusBar {
    final isLandscapeLeft = MediaQuery.of(context).orientation ==
        Orientation.landscape &&
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return !isLandscapeLeft;
  }

  /// 工具方法
  void _showInfoDialog() {
    setState(() => _showInfo = true);
    widget.controller.changeVideoTopShow(true);
    widget.controller.detailState.topShowPermanent = true;
  }

  void _showLineChangeDialog() {
    sliderLeft(
      ChangeLine(tag: widget.tag, width: 270),
      width: 270,
    );
  }

  void _showBettingDialog(MatchEntity match) {
    widget.controller.changeVideoTopShow(true);
    sliderLeft(
      BetDialogContainer(
        match: match,
        tag: widget.tag,
        hasStatusBar: _isHasStatusBar,
      ),
      width: 375 + (_isHasStatusBar ? MediaQuery.of(context).padding.top : 0),
    );
  }

  String _buildInfoText() {
    final rule1 = LocaleKeys.app_info_rules_rule1.tr.replaceAll("\n", " ");
    final rule2 = LocaleKeys.app_info_rules_rule2.tr.replaceAll("\n", " ");
    final rule3 = LocaleKeys.app_info_rules_rule3.tr.replaceAll("\n", " ");
    return "1.$rule1$rule2\n2.$rule3";
  }
}

/// 左滑弹窗（保持原有）
void sliderLeft(Widget child, {double width = 375}) {
  Get.generalDialog(
    navigatorKey: Get.key,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    barrierLabel: MaterialLocalizations.of(Get.context!).dialogLabel,
    barrierColor: Colors.black.withValues(alpha: 0),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ).drive(Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset(1 - width / 1.sw, 0),
        )),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          Get.back();
        }
        return GestureDetector(
          onTap: () {},
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.8),
              width: width,
              height: 1.sh,
              child: child,
            ),
          ),
        );
      });
    },
  );
}