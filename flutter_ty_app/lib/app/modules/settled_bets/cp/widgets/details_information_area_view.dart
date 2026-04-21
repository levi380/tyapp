import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/bet_show_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';
import 'details_information_area_head_widget.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票追号记录列表信息视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，用于显示订单的详细信息，包括头部信息和可选的投注内容。
    - `orderListItem`：包含订单信息的对象。
    - `showBetContent`：布尔值，指示是否显示投注内容。
    - `GetOrderCpListEntryList orderListItem`：订单信息对象。
    - `Key? key`：可选的键，用于标识小部件。
    - `this.showBetContent = false`：可选参数，默认值为 `false`。
    - 构建 UI 界面，展示头部信息和（如果需要）投注内容。
    - getPlayName
    - `GetOrderCpListEntryList orderListItem`：订单信息对象。
    - 功能：
    - 根据 `seriesId` 返回对应的玩法名称。
    - Container：
    - 设置宽度、内边距和背景色，使用圆角矩形装饰。
    - Column：
    - 垂直排列子组件，包括头部信息和可选的投注内容。
    - DetailsInformationAreaHeadWidget：
    - 显示订单的头部信息。
    - BetShowContent：
    - 根据 `showBetContent` 的值决定是否显示投注内容。
    】】】
 *
 */
class DetailsInformationAreaView extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  final bool showBetContent;

  DetailsInformationAreaView(this.orderListItem,
      {Key? key, this.showBetContent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 20.h,
      ),
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : const Color(0xFFF2F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DetailsInformationAreaHeadWidget(orderListItem),
          if (showBetContent) BetShowContent(orderListItem)
        ],
      ),
    );
  }

  String getPlayName(GetOrderCpListEntryList orderListItem) {
    String palyName = orderListItem.playName ?? "";
    if (orderListItem.seriesId == 18) {
      palyName = orderListItem.playName ?? "";
    } else if (orderListItem.seriesId == 19) {
      palyName = orderListItem.playName ?? "";
    } else if (orderListItem.seriesId == 12) {
      palyName = orderListItem.playName ?? "";
    }
    return palyName;
  }
}
