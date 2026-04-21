import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';
import 'package:get/get.dart';

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
    - 时时彩样式 Widget
    】】】
 *
 */
class ShiShiWidget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  ShiShiWidget(
    this.orderListItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    return (data.isEmpty)
        ? const SizedBox()
        : SizedBox(
            height: 40.w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data
                  .map(
                    (e) => Container(
                      width: 20.w,
                      height: 20.h,
                      margin: EdgeInsets.only(left: 1.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF31B7FF), width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha: 0.04)
                            : Colors.white,
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
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
