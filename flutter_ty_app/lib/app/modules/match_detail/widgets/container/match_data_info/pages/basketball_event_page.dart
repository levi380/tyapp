import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:get/get.dart';
import 'basketball_event_expand_btn.dart';
import 'basketball_event_head.dart';
import 'basketball_event_list_item.dart';
import 'basketball_event_tab.dart';

/**
 * 篮球事件页面
 *
 * 【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT - 篮球事件页面 】】】
 */
class BasketballEventPage extends StatelessWidget {
  const BasketballEventPage({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDataController>(
      tag: tag,
      builder: (controller) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              BasketballEventTab(controller: controller),
              BasketballEventHead(tag: tag),
              _buildBody(controller),
              if(false)
                _buildSwitch(controller)
            ],
          ),
        );
      },
    );
  }

  /// 事件列表主体：无数据时 NoData，有数据时 ListView + 展开按钮
  Widget _buildBody(MatchDataController controller) {
    if (controller.state.basketballEventList.isEmpty) {
      return NoData(top: 0);
    }
    final list = controller.state.isExpandImport == false
        ? controller.state.basketballEventList.safeSublist(0, 5)
        : controller.state.basketballEventList;

    return Center(
      child: Container(
        height: 300.w,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index == list.length) {
              return BasketballEventExpandBtn(controller: controller);
            }
            final eventItem = list[index];
            final isLast = index == list.length - 1;
            return BasketballEventListItem(
              eventItem: eventItem,
              isLast: isLast,
            );
          },
        ),
      ),
    );
  }


  /// 事件列表主体：无数据时 NoData，有数据时 ListView + 展开按钮
  Widget _buildSwitch(MatchDataController controller) {
    if (controller.state.basketballEventList.isEmpty) {
      return NoData(top: 0);
    }
    final list = controller.state.isExpandImport == false
        ? controller.state.basketballEventList.safeSublist(0, 5)
        : controller.state.basketballEventList;

    return Center(
      child: Container(
        height: 300.w,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index == list.length) {
              return BasketballEventExpandBtn(controller: controller);
            }
            final eventItem = list[index];
            final isLast = index == list.length - 1;
            return BasketballEventListItem(
              eventItem: eventItem,
              isLast: isLast,
            );
          },
        ),
      ),
    );
  }
}
