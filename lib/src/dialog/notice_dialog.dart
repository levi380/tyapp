// import 'package:common_one/common.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/home/text_announcement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/themes/app_newcolor.dart';

class noticeDialog extends StatefulWidget {
  final List<NoticeModel> scrollMsg;
  final bool showDivider;

  const noticeDialog(
      {super.key, required this.scrollMsg, this.showDivider = false});

  @override
  State<noticeDialog> createState() => _SrollMsgDialogState();
}

class _SrollMsgDialogState extends State<noticeDialog> {
  RxList<NoticeModel> scrollMsg = RxList.empty();

  RxInt index = 0.obs;
  RxBool dontShowAgain = false.obs;

  @override
  void initState() {
    scrollMsg.value = widget.scrollMsg;

    super.initState();
  }

  void resetscrollMsg() {
    Get.back();
  }

  // 下一页
  void nextlMsg() {
    if (index.value == (scrollMsg.length - 1)) {
      return;
    } else {
      index.value = index.value + 1;
    }
  }

  void previouslMsg() {
    if (index.value == 0) {
      return;
    } else {
      index.value = index.value - 1;
    }

    // Get.back();
  }

  setDontShowToday() async {
    final today = DateTime.now();
    String todayString = '${today.year}-${today.month}-${today.day}';
    if (!dontShowAgain.value) {
      todayString = '';
    }
    SpStorage.setkdate(todayString);
  }

  /// 判断今天是否已勾选“今日不再弹出”

  _againbtn() {
    return Obx(() {
      return InkWell(
        onTap: () {
          dontShowAgain.value = !dontShowAgain.value;
          setDontShowToday();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              dontShowAgain.value
                  ? Assets.imagesCircleChecked
                  : Assets.imagesCircleNormal,
              width: 12.r,
              height: 12.r,
            ),
            SizedBox(width: 4.w),
            Text(
              'noPopupToday'.tr,
              style: TextStyle(
                  color: appnewColors.textBlue, // 蓝色字体
                  fontSize: 12.sp,
                  height: 1,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40.w, right: 40.w),
          decoration: BoxDecoration(
            color: appnewColors.bg1,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 280.w),
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 12.h, bottom: 20.w),
                  child: Obx(
                    () {
                      return SingleChildScrollView(
                        child: Container(
                          child: Text(
                            getText(index.value),
                            style: TextStyle(
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              buildFooter(),
              SizedBox(
                height: 15.h,
              ),
              _againbtn(),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(left: 12.r, right: 12.r),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 20.r, left: 10.r, right: 10.r),
              child: Obx(() {
                return Text(
                  gettitrle(index.value),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: appnewColors.text1,
                  ),
                );
              }),
            ),
          ),
          Positioned(
            right: 0.r,
            top: 12.r,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.back();
              },
              child: Image.asset(
                Assets.mineIconCloes,
                fit: BoxFit.fill,
                width: 16.r,
                height: 16.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter() {
    if (scrollMsg.length == 1) {
      return Container();
    }
    return Obx(() {
      return Container(
        height: 32.r,
        margin: EdgeInsets.symmetric(horizontal: 22.r),
        child: Row(
          spacing: 10.r,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  previouslMsg();
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index.value == 0
                          ? appnewColors.text5
                          : appnewColors.bg,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "previousPage".tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: appnewColors.textWhite,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // widget.callback?.call();
                  nextlMsg();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index.value == (scrollMsg.length - 1)
                        ? appnewColors.text5
                        : appnewColors.bg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "nextPage".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.textWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  getText(index) {
    return scrollMsg[index].content ?? "";
  }

  gettitrle(index) {
    return scrollMsg[index].title;
  }
}
