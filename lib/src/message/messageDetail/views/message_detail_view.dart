import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/message_detail_controller.dart';

class MessageDetailView extends GetView<MessageDetailController> {
  const MessageDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "";
    switch (controller.type) {
      case 0:
        title = "通知详情".tr;
        break;
      case 1:
        title = "活动详情".tr;
        break;
      case 2:
        title = "公告详情".tr;
        break;
      case 3:
        title = "充提详情".tr;
        break;
      default:
        title = "msg_detail".tr;
        break;
    }
    return CustomScffold(
      backgroundColor: appnewColors.bg5,
      appBarColor: appnewColors.bg1,
      showBgTexture: false,
      appBar: CustomAppbar.back(
        title: title,
        backgroundColor: appnewColors.bg1,
        actions: [
          GestureDetector(
            onTap: () {
              controller.showDeleteBottom(context, onDelete: () {
                controller.showDeleteConfirmDialog(context);
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(Icons.more_horiz_outlined,
                    color: appnewColors.text1, size: 20.w)),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 3.w),
                child: Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      margin: EdgeInsets.only(right: 7.r),
                      child: SKNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.detailModel.iconUrl ?? '',
                        placeholderType: 2,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.detailModel.title ?? '',
                            style: TextStyle(
                                color: appnewColors.text22,
                                fontSize: 14.sp,
                                fontFamily: "PingFang SC",
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            formatTimestampToTime02(
                                (controller.detailModel.createdAt ?? 0) * 1000),
                            style: TextStyle(
                                color: appnewColors.text2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1.h,
                color: appnewColors.colorLine4,
              ),
              InkWell(
                onTap: () {
                  controller.clickDetail(controller.detailModel);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 4.w),
                      //todo 根据type(消息类类型)展示具体样式
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 10.r),
                            child: Text(
                              controller.detailModel.content ?? '',
                              style: TextStyle(
                                  color: appnewColors.text2,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          if (controller.detailModel.imageUrlApp?.isNotEmpty ==
                              true)
                            SKNetworkImage(
                              imageUrl:
                                  controller.detailModel.imageUrlApp ?? '',
                              expand: false,
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
