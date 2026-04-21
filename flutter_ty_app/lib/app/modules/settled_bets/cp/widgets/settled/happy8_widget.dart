import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

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
    - 快乐8样式 Widget
    】】】
 *
 */
class Happy8Widget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  Happy8Widget(
    this.orderListItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? const SizedBox()
        : SizedBox(
            width: 200.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Wrap(
                children: data
                    .map(
                      (e) => Container(
                        width: 20.w,
                        height: 20.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.isDarkMode
                                  ? Colors.white
                                      .withValues(alpha: 0.8999999761581421)
                                  : const Color(0xFF303442),
                              width: 1.w),
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
                                ? Colors.black
                                : const Color(0xFF303442),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
