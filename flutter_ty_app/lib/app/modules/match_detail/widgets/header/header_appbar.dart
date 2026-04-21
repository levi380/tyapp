import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../global/data_store_controller.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'appbar/normal_appbar.dart';
import 'appbar/pinned_appbar.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 详情头部】】】
    【【【 AUTO_PARAGRAPH_TITLE 头部appbar】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情页头部置顶、滚动时的悬浮条
    - 联赛下拉赛事选择
    - 返回按钮
    】】】
 *
 */
class HeaderAppbar extends StatefulWidget {
  const HeaderAppbar({super.key, this.tag});

  final String? tag;

  @override
  State<HeaderAppbar> createState() => _HeaderAppbarState();
}

class _HeaderAppbarState extends State<HeaderAppbar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      builder: (controller) {
        if (controller.detailState.match == null) return Container();
        MatchEntity match = controller.detailState.match!;
        return GetBuilder<DataStoreController>(
          id: DataStoreController.to.getMatchId(match.mid),
          builder: (dataStoreController) {
            MatchEntity matchEntity =
                dataStoreController.getMatchById(match.mid) ?? match;
            return Container(
              height: obtyAppbarHeight,
              width: 1.sw,
              padding: EdgeInsets.only(
                  left: 6.w, top: 4.h, bottom: 4.h, right: 14.w),

              /// 根据是否置顶渲染不同的widget
              /// 视频区域固定是 只显示NormalAppbar
              child: Obx(() => !controller.detailState.appbarPinned.value ||
                      (controller.detailState.videoFixed.value &&
                          controller.detailState.headerType.value !=
                              HeaderType.normal)
                  ? NormalAppbar(
                      match: matchEntity,
                      controller: controller,
                      tag: widget.tag,
                    )
                  : PinnedAppbar(
                      match: matchEntity,
                      controller: controller,
                      tag: widget.tag,
                    )),
            );
          },
        );
      },
    );
  }
}
