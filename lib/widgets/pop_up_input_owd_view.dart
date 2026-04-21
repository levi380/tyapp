import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PopUpInputPwdView extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget Function() actionButtonBuilder;
  final Widget Function() cancelActionButton;
  final VoidCallback? onClose;
  final bool? showClose;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;

  const PopUpInputPwdView({
    super.key,
    required this.title,
    required this.content,
    required this.actionButtonBuilder,
    required this.cancelActionButton,
    this.showClose = false,
    this.onClose,
    this.bgColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: bgColor ?? appColors.bgColor2,
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
                        padding: padding ?? EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                        child: Column(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: appColors.textMainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            content,
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                      Divider(color: appnewColors.colorLine),
                      Row(
                        children: [
                          Expanded(child: cancelActionButton()),
                          Container(
                            width: 1.w,
                            height: 48.h,
                            color: appnewColors.colorLine,
                          ),
                          Expanded(child: actionButtonBuilder()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // close Padding
              if (showClose == true)
                Positioned(
                  right: 10.w,
                  top: 10.h,
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
                      width: 30.w,
                      height: 30.w,
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
