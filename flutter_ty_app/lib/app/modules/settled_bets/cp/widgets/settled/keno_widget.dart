import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注记录列表信息视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票已结算注单Item
    - keno特色菜样式 Widget
    】】】
 *
 */
class KenoWidget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  KenoWidget(
    this.orderListItem, {
    super.key,
  });

  final Map<int, int> colorMagzine = {
    1: 0xFFDFC124,
    2: 0xFF4089F7,
    3: 0xFF4D4D4D,
    4: 0xFFEB7B31,
    5: 0xFF55FBFF,
    6: 0xFF4C1FF4,
    7: 0xFFB8B8B8,
    8: 0xFFE73324,
    9: 0xFF6A1208,
    10: 0xFF62bf38,
  };
  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? SizedBox()
        : Container(
            height: 40.w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data
                  .map((e) => Container(
                        width: 20.w,
                        height: 20.w,
                        margin: EdgeInsets.only(left: 1.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.w)),
                          color: Colors.white,
                        ),
                        child: Text(
                          "$e",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF303442),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
