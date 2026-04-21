import 'package:flutter_ty_app/app/modules/pip_video/widgets/video_switch_buttons.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../routes/route_manager.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/match_util.dart';
import '../../../widgets/hit_test_blocker.dart';
import '../../login/login_head_import.dart';
import '../../match_detail/models/header_type_enum.dart';
import '../pip_video_controller.dart';

/// 画中画视频底部控制栏组件
/// 包含视频切换、信息查看、全屏跳转等功能按钮
class PipBottom extends StatelessWidget {
  const PipBottom({super.key, required this.controller});

  final PipVideoController controller; // 画中画视频控制器

  @override
  Widget build(BuildContext context) {
    // 获取当前比赛信息
    MatchEntity? match = controller.state.match;
    if (match == null) {
      return SizedBox.shrink(); // 如果没有比赛数据，返回空组件
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // 在正常模式下显示视频切换按钮
          if (controller.state.match != null &&
              [HeaderType.normal].contains(controller.state.headerType))
            VideoSwitchButtons(controller: controller),

          // 使用HitTestBlocker防止触摸穿透
          HitTestBlocker(
            child: AnimatedOpacity(
              /// 顶部按钮区域的显示/隐藏动画控制
              opacity: controller.state.videoTopShow ? 1.0 : 0, // 根据状态控制透明度
              duration: const Duration(milliseconds: 300), // 动画持续时间
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                height: 40.h,
                // 底部渐变色背景
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00), // 渐变开始位置
                    end: const Alignment(0, 1), // 渐变结束位置
                    colors: [
                      Colors.black.withValues(alpha: 0), // 透明黑色
                      Colors.black.withValues(alpha: 0.8) // 80%不透明黑色
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // 动画和直播模式下的视频类型切换区域
                    if ([HeaderType.animate, HeaderType.live]
                        .contains(controller.state.headerType))
                      Row(
                        children: [
                          // 视频直播按钮（当有多个视频源或主要视频源时显示）
                          if (match.mms > 1 || match.pmms == 1)
                            Center(
                              child: GestureDetector(
                                behavior: HitTestBehavior.deferToChild,
                                // 触摸行为：传递给子组件
                                onTap: () {
                                  // 点击时显示顶部按钮并加载视频
                                  if (!controller.state.videoTopShow) {
                                    controller.loadVideo();
                                  }
                                  controller.state.videoTopShow = true;
                                },
                                child: Row(
                                  children: [
                                    // 视频图标（根据当前类型显示激活/未激活状态）
                                    ImageView(
                                      controller.state.currentType == "video"
                                          ? 'assets/images/detail/live-active.svg'
                                          : 'assets/images/detail/live-app.svg',
                                      width: 24.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    // 视频文字标签
                                    Text(
                                      LocaleKeys.match_info_video.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: controller.state.currentType ==
                                                "video"
                                            ? const Color(0xFF179CFF) // 激活状态颜色
                                            : Colors.white.withValues(
                                                alpha: 0.9), // 未激活状态颜色
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ).marginOnly(right: 8.w), // 右侧外边距
                            ),

                          /// 动画按钮（当有动画源且用户未禁用动画时显示）
                          if (match.mvs > -1 &&
                              TYUserController.to.userInfo.value?.ommv != 0)
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // 点击时显示顶部按钮并加载动画
                                    if (!controller.state.videoTopShow) {
                                      controller.loadAnimation();
                                    }
                                    controller.state.videoTopShow = true;
                                  },
                                  child: Row(
                                    children: [
                                      // 动画图标（根据当前类型显示激活/未激活状态）
                                      ImageView(
                                        controller.state.currentType ==
                                                "animation"
                                            ? 'assets/images/detail/animate-active.svg'
                                            : 'assets/images/detail/animate.svg',
                                        width: 24.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      // 动画文字标签
                                      Text(
                                        LocaleKeys.match_info_animation.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: controller.state.currentType ==
                                                  "animation"
                                              ? const Color(
                                                  0xFF179CFF) // 激活状态颜色
                                              : Colors.white
                                                  .withValues(alpha: 0.9),
                                          // 未激活状态颜色
                                          fontSize: 12.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                    // 右侧功能按钮区域
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // 右对齐
                        children: [
                          // 信息按钮
                          InkWell(
                            onTap: () {
                              // 点击时显示视频信息
                              if (!controller.state.videoTopShow ||
                                  controller.state.headerType ==
                                      HeaderType.normal) {
                                // 使用Toast显示视频规则信息（代替原有的弹窗）
                                ToastUtils.message(
                                    title: LocaleKeys.info_rules_auto.tr,
                                    content: "1." +
                                        LocaleKeys.app_info_rules_rule1.tr
                                            .replaceAll("\n", " ") +
                                        LocaleKeys.app_info_rules_rule2.tr
                                            .replaceAll("\n", " ") +
                                        "\n\n2." +
                                        LocaleKeys.app_info_rules_rule3.tr
                                            .replaceAll("\n", " "),
                                    fullscreen: false);
                                // 原有弹窗代码（已注释）
                                // Get.dialog(
                                //   VideoInfoDialog(),
                                //   barrierColor: Colors.black.withValues(alpha: 0.5),
                                // );
                              }
                              controller.state.videoTopShow = true; // 保持顶部按钮显示
                            },
                            child: ImageView(
                              // 信息图标（根据状态显示激活/未激活状态）
                              controller.state.isOpenVideoInfo
                                  ? 'assets/images/detail/info-active.svg'
                                  : 'assets/images/detail/info.svg',
                              width: 24.w,
                            ),
                          ).marginOnly(right: 8.w), // 右侧外边距

                          // 在正常模式下添加间距
                          if ([HeaderType.normal]
                              .contains(controller.state.headerType))
                            Spacer(),
                          if ([HeaderType.live]
                              .contains(controller.state.headerType))
                            InkWell(
                              onTap: () {
                                // controller.changeVideoTopShow(true);
                                controller.switchVideoVolume();
                              },
                              child: ImageView(
                                controller.state.liveMuted
                                    ? 'assets/images/detail/sound_close.svg'
                                    : 'assets/images/detail/sound.svg',
                                width: 24.w,
                              ),
                            ).marginOnly(right: 8.w),
                          // 全屏/详情跳转按钮
                          InkWell(
                            onTap: () {
                              // 点击时跳转到比赛详情页
                              if (!controller.state.videoTopShow ||
                                  controller.state.headerType ==
                                      HeaderType.normal) {
                                // 跳转到比赛详情页
                                RouteManager.goMatchDetail(
                                  mid: match.mid, // 比赛ID
                                  csid: match.csid, // 运动类别ID
                                  isESports:
                                      MatchUtil.isEsport(match), // 是否为电竞比赛
                                );
                              }
                              controller.state.videoTopShow = true; // 保持顶部按钮显示
                            },
                            child: ImageView(
                              'assets/images/common/fullscreen-switch.svg',
                              // 全屏切换图标
                              width: 22.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
