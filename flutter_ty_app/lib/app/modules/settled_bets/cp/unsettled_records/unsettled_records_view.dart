import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/date_picker/show_time_bottom.dart';
import '../widgets/time_filtering_view.dart';
import '../widgets/unsettled_records_body.dart';
import 'unsettled_records_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注记录视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，是一个用于展示未结算投注记录的视图组件，继承自 `StatefulWidget`。它通过 `GetX` 状态管理来获取和显示未结算记录的相关信息。
    - 属性
    - settled: 结算状态（整数），通过构造函数传入。
    - logic: 获取 `UnsettledRecordsLogic` 控制器的实例。
    - build() UnsettledRecordsLogic` 中的可观察属性，实时更新 UI。
    - TimeFilteringView()用于选择时间过滤类型。
    - 通过回调 `onChanged` 处理时间类型的变化。
    - 根据选择的时间类型调用 `logic.setType` 或 `logic.showTime` 方法。
    - UnsettledRecordsBody:
    - 显示未结算记录的主体内容，传入 `settled` 参数。
    】】】
 *
 */
class UnsettledRecordsView extends StatefulWidget {
  const UnsettledRecordsView({super.key, required this.settled});

  final int settled;

  @override
  State<UnsettledRecordsView> createState() => _UnsettledRecordsViewState();
}

class _UnsettledRecordsViewState extends State<UnsettledRecordsView>
    with TickerProviderStateMixin {
  final logic = Get.find<UnsettledRecordsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnsettledRecordsLogic>(builder: (logic) {
      return Container(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => TimeFilteringView(
                type: logic.timeType.value,
                onChanged: (int value) {
                  showTimeBottom.resetinitTime();
                  if (value != 5) {
                    logic.setType(value);
                  } else {
                    logic.showTime(context, value);
                  }
                },
                startTime: logic.startTime.value,
                endTime: logic.endTime.value,
              ),
            ),
            UnsettledRecordsBody(
              settled: widget.settled,
            )
          ],
        ),
      );
    });
  }
}
