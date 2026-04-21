import 'dart:async';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/dialog/notice_click_dialog.dart';
import 'package:filbet/src/dialog/notice_dialog.dart';
import 'package:filbet/src/dialog/scroll_msg_dialog.dart';
import 'package:filbet/widgets/text_marquee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/common/language.dart';
import 'package:marquee/marquee.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/utils/event_bus.dart';

class TextAnnouncement extends StatefulWidget {
  final double? height;
  final Decoration? decoration;

  const TextAnnouncement({
    super.key,
    this.height,
    this.decoration,
  });

  @override
  State<TextAnnouncement> createState() => _TextAnnouncementState();
}

class _TextAnnouncementState extends State<TextAnnouncement> {
  List<NoticeModel> get _scrollMsgs => GlobalService.to.state.marqueeNotice;

  int currentPage = 0;

  final bool _offstage = false;

  @override
  void initState() {
    // _runMsg();
    super.initState();
  }

  void _closeScrollMsg() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
    } else {
      AppNavigator.gotoMessage(type: '2');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _offstage,
      child: Container(
        height: widget.height ?? 20.r,
        decoration: widget.decoration ?? BoxDecoration(),
        child: Row(
          children: [
            Image.asset(
              Assets.homeHomeMessageS,
              height: 18.r,
              width: 18.r,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 2.r),
            Expanded(
              child: Obx(() {
                StringBuffer sb = StringBuffer();
                if (_scrollMsgs.isEmpty) {
                  sb.write("no_announcement".tr);
                }
                for (int i = 0; i < _scrollMsgs.length; i++) {
                  var text = getText(i)
                      .replaceAll('\n', '') // 去掉换行
                      .replaceAll(' ', ''); // 去掉空格
                  sb.write(text);
                  sb.write('    ');
                }
                return InkWell(
                  onTap: () {
                    if (_scrollMsgs.isEmpty) {
                      return;
                    }
                    Get.dialog(
                      NoticeClickDialog(scrollMsg: [_scrollMsgs[0]]),
                      barrierDismissible: false,
                    );
                  },
                  child: Marquee(
                    text: "$sb",

                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xff545A78),
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 100.0.w,
                    // 文字间隔
                    velocity: 10.0,
                    numberOfRounds: null,
                    // 滚动速度
                    pauseAfterRound: Duration(milliseconds: 50),
                    // 每次滚动完后暂停时间
                    startPadding: 5.w,
                    // 开始滚动的位置
                    accelerationDuration: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: false,
                    // 不要渐隐，避免多余高度

                    // 加速度时长
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 100),
                    decelerationCurve: Curves.easeOut,
                  ),
                );
              }),
            ),
            SizedBox(width: 4.r),
            GestureDetector(
              onTap: _closeScrollMsg,
              child: Container(
                height: 20.w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                decoration: BoxDecoration(
                  color: Color(0xFFEAEFF5),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white, width: 1.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66C0CBDF),
                      offset: Offset(0, 4.r),
                      blurRadius: 4.r,
                    )
                  ],
                ),
                child: Text(
                  "查看更多".tr,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xff545A78),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getText(index) {
    Language languagemodel = GlobalService.to.state.language;

    String language = "zh_CN";
    if (languagemodel == Language.zh_cn) {
      language = "zh_CN";
    }
    return _scrollMsgs[index].content ?? "";
  }
}

class ScrollMsg {
  int? id;
  String? content;
  String? contentEn;
  String? contentVi;
  String? contentTh;
  int? showStatus;
  int? startTime;
  int? endTime;

  ScrollMsg(
      {this.id,
      this.content,
      this.contentEn,
      this.contentVi,
      this.contentTh,
      this.showStatus,
      this.startTime,
      this.endTime});

  ScrollMsg.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    content = "";
    contentEn = json["content_en"];
    contentVi = json["content_vi"];
    contentTh = json["content_th"];
    showStatus = json["show_status"];
    startTime = json["start_time"];
    endTime = json["end_time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["content"] = content;
    data["content_en"] = contentEn;
    data["content_vi"] = contentVi;
    data["content_th"] = contentTh;
    data["show_status"] = showStatus;
    data["start_time"] = startTime;
    data["end_time"] = endTime;
    return data;
  }

  /// ✅ 深拷贝方法
  ScrollMsg clone() {
    return ScrollMsg(
      id: id,
      content: content,
      contentEn: contentEn,
      contentVi: contentVi,
      contentTh: contentTh,
      showStatus: showStatus,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
