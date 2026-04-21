import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';
import 'dart:convert';
import 'logic.dart';
import 'package:filbet/generated/assets.dart';

class UpgradePage extends StatelessWidget {
  final logic = Get.put(UpgradeLogic());

  UpgradePage({super.key, required this.entity});

  final UpdataEntity entity;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<UpgradeLogic>(builder: (logic) {
        return Container(
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12.r),
          //     // image: DecorationImage(
          //     //   image: AssetImage("assets/images/tab/update_bg.png"),
          //     //   fit: BoxFit.fill,
          //     // ),
          //     color: Colors.white),
          height: 379,
          width: 271.w,
          child: Stack(
            children: [
              Positioned(
                top: 55.h,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 90.h),
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            alignment: Alignment.center,
                            child: Text(
                              "new_version".tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: appnewColors.text1,
                                fontWeight: FontWeight.w500,
                                fontFamily: "PingFang SC",
                              ),
                            ),
                          ),
                          //版本号
                          // Container(
                          //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     " ${entity.versionCode ?? 1.0}",
                          //     style: TextStyle(
                          //       fontSize: 18.sp,
                          //       color: appnewColors.text1,
                          //       fontWeight: FontWeight.w500,
                          //       fontFamily: "PingFang-Bold-2",
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // 更新内容
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 24.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r), // 设置圆角半径
                            ),
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                              child: Text(
                                entity.updateContent ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: appnewColors.text15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "PingFang SC",
                                ),
                              ),
                            )),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),

                      Stack(
                        children: [
                          logic.isdowlod == false
                              ? entity.isForceUpdate == 2
                                  ? SizedBox(
                                      child: Column(
                                        children: [
                                          Divider(color: appnewColors.colorLine, height: 1),
                                          InkWell(
                                            onTap: () {
                                              logic.updateVersion(entity.downloadUrl!);
                                            },
                                            child: Container(
                                              height: 48.h,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "update_now".tr,
                                                style: TextStyle(
                                                  color: appnewColors.text7,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 48.h,
                                      child: Column(
                                        children: [
                                          Divider(color: appnewColors.colorLine, height: 1),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      SmartDialog.dismiss(tag: "UpdataEntity");
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 14.w,
                                                      ),
                                                      child: Text(
                                                        "forget".tr,
                                                        style: TextStyle(
                                                          color: appnewColors.text1,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 46.h,
                                                color: appnewColors.colorLine,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        logic.updateVersion(entity.downloadUrl!);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 14.w,
                                                        ),
                                                        child: Text(
                                                          "update_now".tr,
                                                          style: TextStyle(
                                                            color: appnewColors.text7,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ))
                              : const SizedBox(),
                        ],
                      ),

                      (logic.event != null && logic.event!.status == OtaStatus.DOWNLOADING)
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: 12.w,
                                right: 12.w,
                                bottom: 28.h,
                              ),
                              child: Stack(children: [
                                SizedBox(
                                  height: 20.h,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(50.h)),
                                    child: LinearProgressIndicator(
                                      value: logic.progress,
                                      backgroundColor: const Color(0xFFEEEEEE),
                                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4C96FF)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${(logic.progress * 100.0).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )),
                              ]))
                          : const SizedBox(),

                      // (logic.event != null && logic.event!.status == OtaStatus.DOWNLOADING)
                      //     ? Padding(
                      //         padding: EdgeInsets.only(
                      //           top: 10.r,
                      //           right: 10.r,
                      //           left: 10.r,
                      //         ),
                      //         child: Align(
                      //             alignment: Alignment.center,
                      //             child: Text(
                      //                 "${(logic.progress * 100.0).toStringAsFixed(1)}%",
                      //                 style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.bold))))
                      //     : const SizedBox(),
                    ],
                  ),
                ),
              ),
              Container(
                height: 146.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.homeUpdateBg),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

UpdataEntity updataEntityFromJson(String str) => UpdataEntity.fromJson(json.decode(str));

String updataEntityToJson(UpdataEntity data) => json.encode(data.toJson());

class UpdataEntity {
  String? versionCode;
  int? versionNum;
  String? md5;
  String? downloadUrl;
  String? updateContent;
  int? isForceUpdate;

  UpdataEntity({
    this.versionCode,
    this.versionNum,
    this.md5,
    this.downloadUrl,
    this.isForceUpdate,
    this.updateContent,
  });

  factory UpdataEntity.fromJson(Map<String, dynamic> json) => UpdataEntity(
        versionCode: json["versionCode"],
        versionNum: json["versionNum"],
        md5: json["md5"],
        downloadUrl: json["downloadUrl"],
        isForceUpdate: json["isForceUpdate"],
        updateContent: json["updateContent"],
      );

  Map<String, dynamic> toJson() => {
        "versionCode": versionCode,
        "versionNum": versionNum,
        "md5": md5,
        "downloadUrl": downloadUrl,
        "isForceUpdate": isForceUpdate,
      };
}
