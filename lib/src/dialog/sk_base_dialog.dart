import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SkBaseDialog extends StatefulWidget {
  final String? title;
  final bool? showDeleteBtn;
  final String? showDeleteBtnType;
  final Color? bgColor;
  final Color? closeIconColor;
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final bool? showFooterBtn;
  final bool? showOneBtn;
  final String? leftBtnTitle;
  final String? rightBtnTitle;
  final Function? callback;
  final Function? cancelCallback;
  final Function? closeCallback;
  final bool? showBgImage;

  SkBaseDialog({
    super.key,
    this.title = '',
    this.showDeleteBtn = true,
    this.bgColor,
    this.showDeleteBtnType = '1',
    this.closeIconColor,
    this.child,
    this.onTap,
    this.margin,
    this.showFooterBtn = false,
    this.showOneBtn = false,
    this.leftBtnTitle,
    this.rightBtnTitle,
    this.callback,
    this.cancelCallback,
    this.closeCallback,
    this.showBgImage = false,
  });

  @override
  State<SkBaseDialog> createState() => _SkBaseDialogState();
}

class _SkBaseDialogState extends State<SkBaseDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      widget.margin ?? EdgeInsets.symmetric(horizontal: 20.w),
                  // EdgeInsets.only(left: 20.r, right: 20.r),
                  decoration: BoxDecoration(
                    color: widget.bgColor ?? appnewColors.bg1,
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  child: Column(
                    children: [
                      if (widget.showBgImage == true) _buildHeaderLogo(),
                      Container(
                        margin: widget.showBgImage! == true
                            ? EdgeInsets.only(
                                left: 10.r, right: 10.r, bottom: 25.r)
                            : EdgeInsets.zero,
                        decoration: ShapeDecoration(
                          color: widget.bgColor ?? appnewColors.bg1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            if (widget.title!.isNotEmpty) _buildHeader(),
                            Flexible(
                                child: SingleChildScrollView(
                              child: widget.child ?? const SizedBox.shrink(),
                            )),
                            if (widget.showFooterBtn == true &&
                                widget.showOneBtn == false)
                              Container(
                                margin: EdgeInsets.only(top: 20.r, bottom: 0.r),
                                width: 1.sw,
                                height: 1.r,
                                color: appnewColors.colorLine,
                              ),
                            if (widget.showFooterBtn == true &&
                                widget.showOneBtn == false)
                              buildFooter(),
                            if (widget.showFooterBtn == true &&
                                widget.showOneBtn == true)
                              buildFooterOne(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.showDeleteBtn == true &&
                    widget.showDeleteBtnType == '2') ...[
                  SizedBox(
                    height: 15.r,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Get.back();
                      widget.closeCallback?.call();
                    },
                    child: Image.asset(
                      Assets.homeDialogIconCloes,
                      fit: BoxFit.fill,
                      width: 32.r,
                      height: 32.r,
                    ),
                  )
                ],
              ],
            ),
          ),
        ));
  }

  SizedBox _buildHeader() {
    return SizedBox(
      height: 40.r,
      child: Row(
        children: [
          SizedBox(width: 30.r),
          Expanded(
              child: Text(
            widget.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: appnewColors.text1),
          )),
          widget.showDeleteBtn == true && widget.showDeleteBtnType == '1'
              ? GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.back();
                  },
                  child: Image.asset(Assets.mineIconCloes,
                      // package: 'common_view',

                      fit: BoxFit.fill,
                      width: 20.r,
                      height: 20.r),
                )
              : SizedBox(
                  width: 20.r,
                ),
          SizedBox(width: 10.r),
        ],
      ),
    );
  }

  Container buildFooter() {
    return Container(
      height: 48.w,
      // padding: EdgeInsets.symmetric(horizontal: 16.r),

      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
                widget.cancelCallback?.call();
              },
              child: Container(
                  height: 40.r,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.leftBtnTitle ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.text1,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ),
          Container(
            width: 1.r,
            height: 48.w,
            color: appnewColors.colorLine,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
                widget.callback?.call();
              },
              child: Container(
                  height: 40.r,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.rightBtnTitle ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Outfit',
                      color: appnewColors.bg,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container buildFooterOne() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      margin: EdgeInsets.only(top: 20.r, bottom: 20.r),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  height: 40.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    widget.rightBtnTitle ?? "",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildHeaderLogo() {
    return SizedBox(
      height: 58.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 74.r,
            height: 3.r,
            margin: EdgeInsets.only(right: 7.5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2.r),
                  bottomRight: Radius.circular(2.r)),
            ),
          ),
          Align(
            child: SKNetworkImage(
              imageUrl: '',
              height: 46.h,
              width: (46 * 2.67).w,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 74.r,
            height: 3.r,
            margin: EdgeInsets.only(left: 7.5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.r),
                  bottomLeft: Radius.circular(2.r)),
            ),
          ),
        ],
      ),
    );
  }
}
