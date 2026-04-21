// import 'package:common_one/common.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/home/text_announcement.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/themes/app_newcolor.dart';

class NoticeClickDialog extends StatefulWidget {
  final List<NoticeModel> scrollMsg;
  final bool showDivider;

  const NoticeClickDialog(
      {super.key, required this.scrollMsg, this.showDivider = false});

  @override
  State<NoticeClickDialog> createState() => _SrollMsgDialogState();
}

class _SrollMsgDialogState extends State<NoticeClickDialog> {
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
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "关闭",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.textMain,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 48.r,
            width: 1,
            color: Color(0xFFEEEEEE),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
                if (UserService.to.state.isVisitor) {
                  EventBus.emit(EventType.goToLogin);
                } else {
                  AppNavigator.gotoMessage(type: '2');
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "查看全部",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.textBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getText(index) {
    return scrollMsg[index].content ?? "";
  }

  gettitrle(index) {
    return scrollMsg[index].title;
  }
}
