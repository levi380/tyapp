import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../services/models/res/get_order_cp_list_entry_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注记录列表信息视图头部Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，用于显示订单的详细信息，包括玩法名称、赔率和投注内容。
    - `orderListItem`：包含订单信息的对象。
    - `showxBetContent`：布尔值，指示是否显示额外的投注内容（目前未使用）。
    - 构造方法
    - 参数：
    - `GetOrderCpListEntryList orderListItem`：订单信息对象。
    - build
    - 构建 UI 界面，展示玩法名称、赔率和投注内容。
    - getPlayName
    - `GetOrderCpListEntryList orderListItem`：订单信息对象。
    - 功能：
    - 根据 `seriesId` 返回对应的玩法名称。
    - Text：
    - 显示玩法名称和赔率，文本样式根据当前主题进行调整。
    - SizedBox：
    - 用于在文本之间添加间距。
    】】】
 *
 */
class DetailsInformationAreaHeadWidget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  final bool showxBetContent = false;

  DetailsInformationAreaHeadWidget(
    this.orderListItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = jsonDecode(orderListItem.odd ?? "");
    String odds = ((double.tryParse(map["1"] ?? "0"))).toString();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getPlayName(orderListItem),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "@${odds}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          orderListItem.betContent.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.5)
                : const Color(0xFF7981A3),
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
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
