import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/feedback/feedback_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/picture_selestor.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        title: 'feedback'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.r, left: 16.r, right: 16.r),
            padding: EdgeInsets.symmetric(
              horizontal: 16.r,
              vertical: 22.r,
            ),
            decoration: BoxDecoration(
              color: appnewColors.bg1,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                ...questionTypeView(),
                ...questionDescribeView(),
                questionImgView(),
                submitView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> questionTypeView() {
    return [
      titleView('question_type'.tr),
      InkWell(
        onTap: () {
          controller.showQuestionTypeBottomSheet();
        },
        child: Container(
          height: 48.r,
          padding: EdgeInsets.symmetric(horizontal: 15.r),
          margin: EdgeInsets.only(bottom: 10.r),
          decoration: BoxDecoration(
            color: appnewColors.bg5,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Text(
                  controller.questionType.value.isNotEmpty
                      ? controller.questionType.value
                      : 'question_type_select'.tr,
                  style: TextStyle(
                    color: appnewColors.text2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              Image.asset(
                Assets.mineIconArrowRight,
                width: 14.r,
                height: 14.r,
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> questionDescribeView() {
    return [
      titleView('question_describe'.tr, subTitle: 'question_describe_tip'.tr),
      Container(
        padding: EdgeInsets.all(10.r),
        height: 160.h,
        decoration: BoxDecoration(
          color: appnewColors.bg5,
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Stack(
          children: [
            CupertinoTextField(
              maxLines: null,
              minLines: 1,
              controller: controller.contentController,
              decoration: const BoxDecoration(),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(color: appnewColors.text1, fontSize: 14.sp),
              scrollPhysics: ScrollPhysics(),
              keyboardType: TextInputType.multiline,
              padding: EdgeInsets.zero,
              placeholder: 'question_describe_hint'.tr,
              placeholderStyle:
                  TextStyle(color: appnewColors.text2, fontSize: 14.sp),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Obx(() {
                return Text(
                  '${controller.textLength.value}/200',
                  style: TextStyle(
                    color: appnewColors.textThird,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    ];
  }

  Widget questionImgView() {
    return Container(
      margin: EdgeInsets.only(top: 12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PictureSelector(
                  controller: controller.pictureController,
                  maxCount: 3,
                  columnCount: 5,
                  multiple: true,
                  onChanged: () {
                    controller.updateImageCount();
                  },
                ),
              ),
              SizedBox(width: 10.r),
              Obx(() {
                return Text(
                  '${controller.imageCount.value}/3',
                  style: TextStyle(
                    color: appnewColors.textThird,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 12.r),
          Text(
            'feedback_img_hint'.tr,
            style: TextStyle(
              color: appnewColors.textFourth,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget submitView() {
    return InkWell(
      onTap: () {
        if (controller.enable.value) {
          controller.submit();
        }
      },
      child: Obx(() {
        return Container(
          height: 45.r,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 24.r),
          decoration: BoxDecoration(
            color: controller.enable.value
                ? appnewColors.bg
                : appnewColors.bg.withAlpha(102),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'submit'.tr,
            style: TextStyle(
                color: appnewColors.text4,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
        );
      }),
    );
  }

  Widget titleView(String title, {String? subTitle}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '*',
            style: TextStyle(
              color: appnewColors.textRed,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subTitle != null)
            Container(
              margin: EdgeInsets.only(left: 5.r),
              child: Text(
                subTitle ?? '',
                style: TextStyle(
                  color: appnewColors.textThird,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
