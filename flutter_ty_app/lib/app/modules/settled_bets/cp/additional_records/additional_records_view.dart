import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../main.dart';
import '../../../../widgets/date_picker/show_time_bottom.dart';
import '../item/additional_recordsi_tem.dart';
import '../widgets/cp_bets_loading_view.dart';
import '../widgets/cp_no_data_hints_view.dart';
import '../widgets/time_filtering_view.dart';
import '../widgets/total_amount_bets _view.dart';
import 'additional_records_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 追号记录视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示追号记录的界面，包括时间筛选和记录列表。
    - `settled`：记录状态（0: 未结算, 1: 已结算）。
    - `required this.settled`：初始化时传入的结算状态。
    - 构建 UI 界面，包含时间筛选组件和记录列表。
    - _body()
    - 根据加载状态和数据是否为空，返回不同的组件：
    - 加载时显示 `CpBetsLoadingView`。
    - 数据为空时显示 `CpNoDataHintsView`。
    - 有数据时显示记录列表。
    - getListView()
    - 构建记录列表视图，包含分隔线和统计信息视图。
    - 处理列表项的构建和样式。
    】】】
 *
 */
class AdditionalRecordsView extends StatefulWidget {
  const AdditionalRecordsView({super.key, required this.settled});

  /// 0:未结算
  ///1:已结算
  final int settled;

  @override
  State<AdditionalRecordsView> createState() => _AdditionalRecordsViewState();
}

class _AdditionalRecordsViewState extends State<AdditionalRecordsView> {
  final logic = Get.find<AdditionalRecordsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdditionalRecordsLogic>(builder: (logic) {
      return Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
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
                type: logic.type.value,
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
            _body(),
          ],
        ),
      );
    });
  }

  Widget _body() {
    return SizedBox(
      height: logic.loading || logic.list.isEmpty
          ? 300.h
          : isIPad
              ? 580.h
              : 460.h,
      //列表组件
      child: logic.loading
          ? const CpBetsLoadingView()
          : logic.list.isEmpty
              ? CpNoDataHintsView(
                  type: widget.settled,
                )
              : getListView(),
    );
  }

  Widget getListView() {
    return ListView.separated(
      itemCount: logic.list.length + 1,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return index != 0
            ? Divider(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha: 0.07999999821186066)
                    : null,
                height: 1.0,
              ).marginOnly(
                left: 12.w,
                right: 12.w,
              )
            : Container();
      },
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        ///to
        if (index == 0) {
          return TotalAmountBetsView(
            statistics: logic.statistics,
          );
        }

        /// 这里传  index-1
        return AdditionalRecordsItem(
          index: index - 1,
          isTopRounded: index == 1,
          isBottomRounded: logic.list.length == index,
          data: logic.list[index - 1],
          settled: widget.settled,
        ).marginOnly(
          bottom: logic.list.length == index ? 10.h : 0.h,
        );
      },
    ).marginOnly(
      bottom: 2.h,
    );
  }
}
