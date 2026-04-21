import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/going_sport_widget.dart';

import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import '../../../../services/models/res/match_entity.dart';
import '../widget/match_select/vr_match_select_widget.dart';
import '../vr_sport_detail_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情动画头部】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 导航动画头部，与列表共用
    - 监听赛事结束，封盘行为
    # `GoingSportWidget`

    -`VR体育详情头部，与列表共用`

    - 监听视频播放结束，结束后通知Oddsbutton显示赛果

    ```
    onVideoPlayFinished: (){
    controller.onVideoPlayFinished();
    AppLogger.debug("发送赛事结束 =");
    /// 发送比赛结束指令给oddsbutton，显示赛果
    2.seconds.delay((){
    Bus.getInstance().emit(
    EventType.VRDetailEnd,
    );
    });
    },
    ```

    - 剩余时间小于10秒时，发送封盘指令给oddsbutton，此时不能再投注

    ```
    onCount: (time){
    AppLogger.debug("剩余时间 = $time");
    if(time<=10){
    AppLogger.debug("发送封盘 = $time");
    Bus.getInstance().emit(
    EventType.VRDetailClose,
    );
    }
    },
    ```

    】】】
 *
 */
class detailsAppBar extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    // 下拉箭头图标
    String arrowIcon = VrSportDetailState.arrowDownNight;
    return GetBuilder<VrTyHomeController>(
        builder: (VrTyHomeController vrHomeController) {
      final vrMatch = VrSportDetailLogic.to.state.vrMatch!;
      final match = VrSportDetailLogic.to.state.match!;
      const nextVrMatch = null;
      return Stack(
        children: [
          ///体育头部，与列表共用
          GoingSportWidget(
            key: ValueKey('going_match_${vrMatch.batchNo}'),
            type: vrHomeController.topMenu?.type ?? 1,
            vrMatch: vrMatch,
            nextVrMatch: nextVrMatch,
            getVirtualReplay: vrHomeController.getVirtualReplay,
            onNextMatchCountdownEnd: vrHomeController.onNextMatchCountdownEnd,
            onVideoPlayFinished: () {
              vrHomeController.onVideoPlayFinished();
              AppLogger.debug("发送赛事结束 =");

              /// 发送比赛结束指令给oddsbutton，显示赛果
              2.seconds.delay(() {
                Bus.getInstance().emit(
                  EventType.VRDetailEnd,
                );
              });
            },
            isShowItem: false,
            isVrDetail: true,
            aspectRatio: 390 / 264,
            onCount: (time) {
              // AppLogger.debug("剩余时间 = $time");
              if (time <= 10) {
                // AppLogger.debug("发送封盘 = $time");

                ///剩余时间小于10秒时，发送封盘指令给oddsbutton，此时不能再投注
                Bus.getInstance().emit(
                  EventType.VRDetailClose,
                );
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        Get.back();
                      },
                      child: Container(
                        width: 50.w,
                        height: 44.h,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          controller.state.isOpenOtherMatch.value =
                              !controller.state.isOpenOtherMatch.value;
                          MatchEntity? match = controller.state.match;
                          if (match == null) {
                            return;
                          }
                          Get.generalDialog(
                            navigatorKey: Get.key,
                            barrierDismissible: true,
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            barrierLabel: MaterialLocalizations.of(Get.context!)
                                .dialogLabel,
                            // barrierColor: Colors.black.withValues(alpha: 0.5),
                            barrierColor: Colors.transparent,
                            transitionBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeIn,
                                ).drive(Tween<Offset>(
                                  begin: const Offset(0, 1.0),
                                  end: Offset.zero,
                                )),
                                child: child,
                              );
                            },
                            pageBuilder: (context, _, __) {
                              // 获取第几轮的联赛
                              return VrMatchSelectWidget(
                                match: match,
                                matches: controller.state.vrMatch?.matchs ?? [],
                                onTap: () {
                                  controller.state.isOpenOtherMatch.value =
                                      false;
                                  Get.back();
                                },
                                onSelect: (match) =>
                                    controller.onMatchSelect(match),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              match.tn,
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.white),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            // 三角形图标
                            AnimatedRotation(
                              turns: controller.state.isOpenOtherMatch.value
                                  ? 0.5
                                  : 0.0, // 0.5圈 = 180度
                              duration: Duration(milliseconds: 300),
                              child: ImageView(
                                arrowIcon,
                                boxFit: BoxFit.fill,
                                width: 12.w,
                                height: 12.w,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      width: 50.w,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
