// import 'package:common_one/common.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/home/text_announcement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/common/language.dart';

class SrollMsgDialog extends StatefulWidget {
  final List<NoticeModel> scrollMsg;
  final bool showDivider;

  const SrollMsgDialog(
      {super.key, required this.scrollMsg, this.showDivider = false});

  @override
  State<SrollMsgDialog> createState() => _SrollMsgDialogState();
}

class _SrollMsgDialogState extends State<SrollMsgDialog> {
  RxList<NoticeModel> scrollMsg = RxList.empty();

  @override
  void initState() {
    scrollMsg.value = widget.scrollMsg;

    super.initState();
  }

  Widget _top() {
    return Column(
      children: [
        Container(
          width: 311.r,
          constraints: BoxConstraints(minHeight: 48.r),
          padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.r),
          child: Row(
            children: [
              SizedBox(width: 20.r),
              Expanded(
                  child: Text(
                "announcement".tr,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
              GestureDetector(
                onTap: () {
                  resetscrollMsg();
                },
                child: Image.asset(
                  Assets.homeDialogCircularCloseIcon,
                  fit: BoxFit.fill,
                  width: 20.r,
                  height: 20.r,
                ),
              )
            ],
          ),
        ),
        if (widget.showDivider)
          Divider(
            thickness: 2.r,
            height: 0,
            endIndent: 10.r,
            indent: 10.r,
          )
      ],
    );
  }

  void resetscrollMsg() {
    if (scrollMsg.length == 1) {
      Get.back();
    } else {
      scrollMsg.removeAt(0);
    }
  }

  Widget _btn() {
    return Center(
      child: GestureDetector(
          onTap: () {
            resetscrollMsg();
          },
          child: Container(
            height: 48.r,
            width: 311.r - 20.r,
            margin: EdgeInsets.only(bottom: 30.r, top: 30.r),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              // gradient: AoneAppTheme.appTheme.themeLinearGradient,
              gradient: LinearGradient(
                colors: [Color(0xff7AE1FF), Color(0xff00A6D6)], // 定义渐变色
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              "got_it".tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
          width: 311.r,
          height: 380.r,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.homeBg),
                // 本地图片
                // image: NetworkImage('https://example.com/background.jpg'), // 网络图片
                fit: BoxFit.cover,
              ),

              // color: Colors.black,

              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _top(),
              Obx(() {
                return Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                  child: Text(
                    getText(0),
                    style: TextStyle(
                        fontSize: 16.sp,
                        height: 1.5.h,
                        fontWeight: FontWeight.w400),
                  ),
                ));
              }),
              _btn(),
            ],
          ),
        )),
      ),
    );
  }

  getText(index) {
    Language languagemodel = GlobalService.to.state.language;

    String language = "zh_CN";
    if (languagemodel == Language.zh_cn) {
      language = "zh_CN";
    }
    if (languagemodel == Language.zh_tw) {
      language = "zh_TW";
    }
    return scrollMsg[index].content;
  }
}
