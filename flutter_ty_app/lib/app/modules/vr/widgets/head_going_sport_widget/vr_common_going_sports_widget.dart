import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../../../utils/change_skin_tone_color_util.dart';
import '../bottom_wait_list_widget/widget/single_expand_toggle_widget.dart';

///当前轮  第几轮 和 当前赛事状态 头部
class VrCommonGoingSportsWidget extends StatelessWidget {
  const VrCommonGoingSportsWidget({
    super.key,
    required this.isExpand,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.batchNo,
    required this.lod,
    this.cusTime = '',
    required this.child,
    this.onToggleExpand,
  });

  final bool isExpand;
  final int index;
  final String title;
  final String subtitle;
  final String time;
  final String batchNo;
  final String lod;
  final String cusTime;
  final Widget child;
  final ValueChanged<bool>? onToggleExpand;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Get.isDarkMode
              ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
              : AppColor.colorWhite,
        ),
        color: Get.isDarkMode
            ? null
            : const Color(0xffF8F9FA),

      ),
      ///vr悬停头部
      child: StickyHeader(
        header: Column(
          children: [
            Container(
              color: Get.isDarkMode
                  ? AppColor.ggGameBackground
                  : const Color(0xffF8F9FA),

              child: SingleExpandToggleWidget(
                key: ValueKey('eapand_${batchNo}_$lod'),
                title: title,
                subtitle: subtitle,
                time: time,
                cusTime: cusTime,
                isExpand: isExpand,
                onToggleExpand: onToggleExpand,
              ),
            ),
            Container(
              height: 1,
              color: !Get.isDarkMode
                  ? Color(0xFFE4E6ED)
                  : Colors.white.withValues(alpha:0.08),
            )
          ],
        ),
        content: isExpand ? child : const SizedBox(),
      ),
      // Column(
      //   children: [
      //     SingleExpandToggleWidget(
      //       key: ValueKey('eapand_${batchNo}_$lod'),
      //       title: title,
      //       subtitle: subtitle,
      //       time: time,
      //       cusTime: cusTime,
      //       isExpand: isExpand,
      //       onToggleExpand: onToggleExpand,
      //     ),
      //     if (isExpand) child,
      //   ],
      // ),
    );
  }
}
