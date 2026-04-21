import 'package:filbet/common/currency.dart';
import 'package:filbet/http/entity/resp_flow_detail.dart';
import 'package:filbet/src/withdraw/flow_detail/flow_detail_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/empty_view.dart';
import 'package:filbet/widgets/skEasyRefresh.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FlowDetailView extends GetView<FlowDetailController> {
  const FlowDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appnewColors.bg4,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.transparent,
        title: 'flow_detail'.tr,
      ),
      body: Obx(() {
        if (controller.flowModels.isEmpty) {
          return EmptyView(
            iconWidth: 160.w,
            iconHeight: 160.w,
            top: 96.h,
            state: EmptyState.noDeposit,
          );
        }
        return EasyRefreshConfig.build(
          controller: controller.easyRefreshController,
          childBuilder: (_, physics) {
            return ListView.builder(
              physics: physics,
              padding: EdgeInsets.all(16.r),
              itemCount: controller.flowModels.length,
              itemBuilder: (context, index) {
                var model = controller.flowModels[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.r),
                  child: itemView(model),
                );
              },
            );
          },
          onRefresh: () async {
            controller.resetAndLoadData();
          },
          onLoad: () async {
            controller.loadMoreData();
          },
        );
      }),
    );
  }

  Widget itemView(FlowModel model) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "${model.raminTurnover ?? 0}",
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.r),
              Text(
                Currency.fromCodeInt((model.currency ?? 101).toInt()).abbr,
                style: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          ...[
            SizedBox(height: 8.r),
            Text(
              model.platNames?.isNotEmpty == true
                  ? model.platNames ?? ''
                  : 'no_limit'.tr,
              style: TextStyle(
                color: appnewColors.text2,
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
