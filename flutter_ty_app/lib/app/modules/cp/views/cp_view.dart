import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:flutter_ty_app/app/modules/cp/widget/cp_collected_ticket_grid_view.dart';
import 'package:flutter_ty_app/app/modules/cp/widget/cp_other_ticket_view.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';

import '../../../widgets/loading.dart';
import '../controllers/cp_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-27800d93-e3ca-4e92-b267-9f07d07c3e73-cp 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票列表页】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票列表页 视图界面 CpController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票列表页 视图界面 CpController
    - CpController
    ```
    ///彩票列表页
    CpView
    ```
    】】】
 *
 */

class CpView extends StatelessWidget {
  const CpView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpController>(
      init: CpController(),
      builder: (controller) {
        return Container(
          decoration: context.isDarkMode
              ? null
              : BoxDecoration(color: CpState.cpViewBgColor),
          child: GetBuilder<CpController>(
            id: 'game_cate_grid_list',
            builder: (_) {
              if (controller.isLoading) {
                return const RepaintBoundary(child: Loading());
              }
              if (controller.isLoadFailed) {
                return NoData(
                  top: CpState.cpViewNoDataTopMargin,
                  content: LocaleKeys.common_no_network.tr,
                ).center;
              }
              if (controller.showCateList.isEmpty &&
                  controller.showTicketList.isEmpty) {
                return NoData(
                  top: CpState.cpViewNoDataTopMargin,
                  content:
                      LocaleKeys.zr_cp_Lottery_Bet_Slips_no_games_available.tr,
                ).center;
              }
              if (controller.selTabIndex == 0) {
                return CpCollectedTicketGridView(
                  tickets: controller.showTicketList,
                  onTicketTap: controller.onTapGame,
                  onCancelTicketCollect: controller.onCollectTicket,
                );
              }
              return CpOtherTicketView(
                totalTicketCount: controller.gameCount,
                cateList: controller.showCateList,
                onTicketTap: controller.onTapGame,
                onToggleTicketCollect: controller.onCollectTicket,
              ).marginOnly(top: CpState.cpViewOtherTicketTopMargin);
            },
          ).keepAlive(),
        );
      },
    );
  }
}
