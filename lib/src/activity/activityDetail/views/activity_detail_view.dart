import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/common_action_button.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/activity_detail_controller.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/network_image.dart';

class ActivityDetailView extends GetView<ActivityDetailController> {
  const ActivityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScffold(
        backgroundColor: appnewColors.bg1,
        showBgTexture: false,
        appBar: CustomAppbar.normalTitle(
          bgColor: appnewColors.bg1,
          maxLines: 2,
          title: controller.detailModel.value.name ?? '',
        ),
        body: Column(
          children: [
            Expanded(child: _buildHtmlWidget()),
            bottomView(context),
          ],
        ),
      );
    });
  }

  ///html
  ///

  Widget _buildHtmlWidget() {
    final String summary = controller.detailModel.value.h5Summary ?? '';
    final String imageUrl =
        controller.detailModel.value.imageModel?.h5Main ?? '';
    return SingleChildScrollView(
      child: Container(
        //  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              SKNetworkImage(
                width: Get.width,
                imageUrl: imageUrl,
                placeholderType: 1,
                fit: BoxFit.fitWidth,
                expand: false,
              ),
            if (summary.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.r),
                child: Html(
                  shrinkWrap: true,
                  data: summary,
                  onLinkTap: (
                    String? url,
                    Map<String, String> attributes,
                    element,
                  ) {
                    controller.openExternalLinks(url);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget bottomView(BuildContext context) {
    if (controller.detailModel.value.ty == 2) {
      //2 纯展示页
      return bottomNormalView(context);
    } else {
      return SizedBox();
    }
  }

  Widget bottomNormalView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 12.r,
        top: 12.r,
        left: 14.r,
        right: 14.r,
      ),
      child: Row(
        spacing: 10.r,
        children: [
          //测试要求，申请入口没有时，记录也要隐藏
          if (controller.detailModel.value.activityConfigModel?.applyRecord ==
              1)
            bottomButtonView('申请记录', false, () {
              controller.clickApplyRecord();
            }),
          if (controller.detailModel.value.activityConfigModel?.applyEnter == 1)
            Obx(() {
              return bottomButtonView(
                controller.enable.value ? 'apply_now'.tr : 'joined'.tr,
                true,
                enable: controller.enable.value,
                () {
                  controller.clickApplyJoin();
                },
              );
            }),
        ],
      ),
    );
  }

  Expanded bottomButtonView(
      String content, bool isFilled, GestureTapCallback? onTap,
      {bool enable = true}) {
    return Expanded(
      child: InkWell(
        onTap: enable ? onTap : null,
        child: Container(
          height: 40.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border:
                isFilled ? null : Border.all(color: appnewColors.bg, width: 1),
            color: isFilled
                ? enable == true
                    ? appnewColors.bg
                    : Color(0xFF9DBFFA)
                : null,
          ),
          child: Text(
            content,
            style: TextStyle(
              color: isFilled ? appnewColors.textWhite : appnewColors.textBlue,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
