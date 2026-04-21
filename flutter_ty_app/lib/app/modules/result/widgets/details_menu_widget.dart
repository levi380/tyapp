import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/image_view.dart';
import '../../match_detail/controllers/match_detail_controller.dart';
import 'event_head_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情菜单  组件 DetailsMenuWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情菜单  组件 DetailsMenuWidget
    - DetailsMenuWidget
    ```
    /// 赛果详情菜单
    DetailsMenuWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      onEventHeadIndex: (index) => controller.onEventHeadIndex(index),
      eventHeadIndex: controller.eventHeadIndex,
      event: controller.event,
      bet: controller.bet,
      playback: controller.playback,
      mid: controller.mid,
    )
    ```
    】】】
 *
 */

class DetailsMenuWidget extends StatelessWidget {
  const DetailsMenuWidget({
    super.key,
    required this.isDark,
    required this.event,
    required this.bet,
    required this.playback,
    required this.onExpandAll,
    required this.onEventHeadIndex,
    required this.eventHeadIndex,
    required this.mid,
  });

  final bool isDark;
  final bool event;
  final bool bet;
  final bool playback;
  final VoidCallback? onExpandAll;
  final void Function(dynamic) onEventHeadIndex;
  final int eventHeadIndex;
  final String mid;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: isIPad ? 60.h : 40.h,
        color: isDark
            ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(
                colorStyle_1: Color(0xFF2B2D33),
                colorStyle_2: Color(0xFF23292D),
                colorStyle_3: Color(0xFF26242A))
            : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onExpandAll,
              child: Container(
                margin: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Obx(() {
                  return ImageView(
                    Get.find<MatchDetailController>(tag: mid)
                                .detailState
                                .getFewer
                                .value !=
                            2
                        ? 'assets/images/icon/tab_up_btn.svg'
                        : 'assets/images/icon/tab_up_btn_off.svg',
                    width: 12.w,
                    height: 12.h,
                    color: Colors.grey,
                  );
                }),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  EventHeadWidget(
                    onTap: () => onEventHeadIndex(0),
                    title: LocaleKeys.match_info_all_result.tr,
                    isSelected: eventHeadIndex == 0 ? true : false,
                    isDark: context.isDarkMode,
                  ),
                  ///精选赛事
                  if (event)
                    EventHeadWidget(
                      onTap: () => onEventHeadIndex(1),
                      title: LocaleKeys.match_info_select_event.tr,
                      isSelected: eventHeadIndex == 1 ? true : false,
                      isDark: context.isDarkMode,
                    ),
                  ///我的注单
                  if (bet)
                    EventHeadWidget(
                      onTap: () => onEventHeadIndex(2),
                      title: LocaleKeys.match_info_my_bets.tr,
                      isSelected: eventHeadIndex == 2 ? true : false,
                      isDark: context.isDarkMode,
                    ),
                  if (playback)
                    EventHeadWidget(
                      onTap: () => onEventHeadIndex(3),
                      title: LocaleKeys.highlights_title.tr,
                      isSelected: eventHeadIndex == 3 ? true : false,
                      isDark: context.isDarkMode,
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
