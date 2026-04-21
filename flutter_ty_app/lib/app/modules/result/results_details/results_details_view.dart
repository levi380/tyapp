import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_settled_bets/results_results_bets_view.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_settled_bets/results_settled_bets_logic.dart';

import 'package:flutter_ty_app/app/modules/result/widgets/details_head_with_flag_widget.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../utils/match_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/empty/no_data.dart';
import '../../main_tab/main_tab_controller.dart';
import '../../match_detail/widgets/container/odds_info_container.dart';
import '../../match_detail/widgets/tab/bet_mode_tab_widget.dart';
import '../widgets/details_menu_widget.dart';
import '../widgets/details_title_new_widget.dart';
import '../widgets/match_replay_widget.dart';
import '../result_detail_featured_list_view.dart';
import 'results_details_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9176c2a2-fe19-41b2-9ee1-2cf24db8b7c1-xq 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 视图页面  ResultsDetailsPage】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  赛果详情 视图页面  ResultsDetailsPage
    - ResultsDetailsPage
    ```
    ///赛果详情头部
    Widget _head()
    ///赛果详情头部视频播放组件
    Widget _playVideo()
    /// 赛果详情菜单
    Widget _menu()
    /// 赛果详情列表内容
    Widget _body()
    ```
    】】】
 *
 */
class ResultsDetailsPage extends StatefulWidget {
  const ResultsDetailsPage({Key? key}) : super(key: key);

  @override
  State<ResultsDetailsPage> createState() => _ResultsDetailsPageState();
}

class _ResultsDetailsPageState extends State<ResultsDetailsPage> {
  final controller = Get.find<ResultsDetailsController>();
  final logic = Get.find<ResultsDetailsController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultsDetailsController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode
                ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                : Color(0xFFF2F2F6),
            child: Stack(
              children: [
                Column(
                  children: [
                    if (controller.detailData != null)
                      logic.playVideo == true ? _playVideo() :logic.headMenu == true ?
                      GestureDetector(
                        onTap: ()=>controller.onHeadMenu(),
                        child: _head(),
                      ): _head(),
                    if (controller.detailData != null&& logic.headMenu == false) _menu(),
                    Expanded(
                      child: logic.headMenu ?
                      DetailsTitleNewWidget(
                        isDark: context.isDarkMode,
                        headMenu: logic.headMenu,
                        onHeadMenu: () => controller.onHeadMenu(),
                        detailData: controller.detailData,
                        headMatchList: controller.headMatchList,
                        onHeadMatch: (matchItem) =>
                            controller.onHeadMatch(matchItem),
                        mid: logic.mid,
                        titleIndex: controller.titleIndex,
                      ):
                      Obx(() {
                        return _body();
                      }),
                    ),
                  ],
                ),

                ///定时烟花播放
                Obx(() => MainTabController.to.isFireworksPaly.value &&
                        FireworksController.to.isFireworksActivityValid(
                            MainTabController.to.activityEntity,
                            FireworksController.to.serverNow)
                    ? FireworksAnimation(
                        id: MainTabController.to.fireworksId.value,
                        beginTime: MainTabController.to.beginTime.value,
                        endTime: MainTabController.to.endTime.value,
                        type: MainTabController.to.fireworksType.value,
                        number: MainTabController.to.fireworksNumber,
                        championName: MainTabController.to.championName.value,
                        championIcon: MainTabController.to.championIcon.value,
                      )
                    : Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  ///赛果详情头部
  Widget _head() {
    return DetailsHeadWithFlagWidget(
      isDark: context.isDarkMode,
      headMenu:logic.headMenu  ,
      typePicture: controller.typePicture,
      onHeadMenu: () => controller.onHeadMenu(),
      detailData: controller.detailData,
      onRefresh: () => controller.onRefresh(),
      animationController: controller.animationController,
      headerMap: controller.headerMap,
    );
  }

  ///赛果详情头部视频播放组件
  Widget _playVideo() {
    InAppWebViewSettings settings = InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);
    return Stack(
      children: [
        SizedBox(
          height: isIPad ? 364.h : 264.h,
          child: InAppWebView(
            initialSettings: settings,
            initialUrlRequest: URLRequest(url: WebUri(logic.playVideoUrl)),
            onWebViewCreated: (webViewController) {
              controller.webViewController = webViewController;
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {
                print(consoleMessage);
              }
            },
          ),
        ),
        SafeArea(
          child: Row(
            children: [
              InkWell(
                onTap: () => controller.onClosVideo(),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: ImageView(
                    'assets/images/icon/icon_arrowleft_nor.png',
                    width: 20.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                ),
                child: ImageView(
                  'assets/images/icon/replay_logo.svg',
                  width: 60.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 赛果详情菜单
  Widget _menu() {
    return DetailsMenuWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      onEventHeadIndex: (index) => controller.onEventHeadIndex(index),
      eventHeadIndex: controller.eventHeadIndex,
      event: logic.event,
      bet: logic.bet,
      playback: logic.playback,
      mid: logic.mid,
    );
  }

  /// 赛果详情列表内容
  Widget _body() {
    if (logic.loading.value) {
      return const Loading();
    }
    if (controller.eventHeadIndex == 0) {
      return controller.detailData != null
          ? Column(
              children: [
                // 玩法集 只有电竞显示
                if (MatchUtil.isEsport(controller.match))
                  BetModeTab(
                    tag: logic.mid,
                    refresh: true,
                  ).marginOnly(top: 8.h),
                Expanded(
                  child: OddsInfoContainer(
                    refresh: true,
                    tag: logic.mid,
                  ),
                ),
              ],
            )
          : NoData(
              content: LocaleKeys.analysis_football_matches_no_data.tr,
              top: 0.h,
            );
    } else if (controller.eventHeadIndex == 1) {
      ///自己写的布局
      return controller.matcheHandpickData.isNotEmpty
          ? ResultDetailFeaturedListView(
          isDark: context.isDarkMode,
          matchHandpickData: controller.matcheHandpickData,
          onGoToDetails: (item) => controller.onGoToDetails(item))
          : NoData(
          content: LocaleKeys.analysis_football_matches_no_data.tr,
          top: 0.h);
      ///精选赛事
      // return controller.matcheHandpickData.isNotEmpty
      //     ? FeaturedEventsWidget(
      //         isDark: context.isDarkMode,
      //         matcheHandpickData: controller.matcheHandpickData,
      //         onGoToDetails: (item) => controller.onGoToDetails(item))
      //     : NoData(
      //         content: LocaleKeys.analysis_football_matches_no_data.tr,
      //         top: 0.h);
    } else if (controller.eventHeadIndex == 2) {
      Get.lazyPut(
            () => ResultsSettledBetsLogic(),
      );
      return ResultsSettledBetsPage(data: controller.miApuestaData,);

      // ///我的注单
      // return MiApuestaWidget(
      //   isDark: context.isDarkMode,
      //   miApuestaData: controller.miApuestaData,
      //   onBetIsExpand: (betIsExpand, index) =>
      //       controller.onBetIsExpand(betIsExpand, index),
      // );
    } else if (controller.eventHeadIndex == 3) {
      return MatchReplayWidget(
        isDark: context.isDarkMode,
        videoHead: logic.shootout == true
            ? logic.videoHead1
            : logic.videoHead,
        videoIndex: controller.videoIndex,
        onSelectVideo: (index) => controller.onSelectVideo(index),
        detailData: controller.detailData,
        headerMap: controller.headerMap,
        eventList: controller.eventList,
        onPlayVideo: (eventItem) => controller.onPlayVideo(eventItem),
      );
    }
    return Container();
  }
}
