import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PopUpView extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget Function() actionButtonBuilder;
  final VoidCallback? onClose;
  final bool? showClose;

  const PopUpView({
    super.key,
    required this.title,
    required this.content,
    required this.actionButtonBuilder,
    this.showClose = true,
    this.onClose,
  });

  factory PopUpView.withActionButton({
    Key? key,
    required String title,
    required Widget content,
    required Widget actionButton,
    bool showClose = true,
    VoidCallback? onClose,
  }) {
    return PopUpView(
        key: key,
        title: title,
        content: content,
        actionButtonBuilder: () => actionButton,
        onClose: onClose,
        showClose: showClose);
  }

  factory PopUpView.withCancelActionButton({
    Key? key,
    required String title,
    required Widget content,
    bool showClose = true,
    VoidCallback? onCancel,
    VoidCallback? onCofirm,
    required bool canConfirmAction,
  }) {
    return PopUpView(
        key: key,
        title: title,
        content: content,
        actionButtonBuilder: () {
          return Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (Get.isBottomSheetOpen ?? false) {
                    Get.back();
                  }
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                  onCancel?.call();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: appColors.borderCommonColor, width: 1.w))),
                  child: Center(
                    child: Text(
                      'cancel'.tr,
                      style: TextStyle(
                          fontSize: 16.sp, color: appColors.textMainColor),
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (!canConfirmAction) {
                    return;
                  }
                  if (Get.isBottomSheetOpen ?? false) {
                    Get.back();
                  }
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                  onCofirm?.call();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: appColors.borderCommonColor, width: 1.w),
                          left: BorderSide(
                              color: appColors.borderCommonColor, width: 1.w))),
                  child: Center(
                    child: Text(
                      'confirm'.tr,
                      style: TextStyle(
                          fontSize: 16.sp, color: canConfirmAction ? appColors.textMain2Color : appnewColors.text3),
                    ),
                  ),
                ),
              ))
            ],
          );
        },
        onClose: onCancel,
        showClose: showClose);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                        child: Column(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: appnewColors.text1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            content,
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                      actionButtonBuilder(),
                    ],
                  ),
                ),
              ),
              // close Padding
              if (showClose == true)
                Positioned(
                  right: 24.w,
                  top: 24.h,
                  child: GestureDetector(
                    onTap: () {
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                      if (Get.isDialogOpen ?? false) {
                        Get.back();
                      }
                      onClose?.call();
                    },
                    child: Image.asset(
                      Assets.popupClose,
                      fit: BoxFit.fill,
                      width: 16.w,
                      height: 16.w,
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
