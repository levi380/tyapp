import 'dart:convert';

import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/deposit_activity/views/activity_promo_detail_model.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/widgets/dialog/apply_record_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailController extends GetxController {
  ActivityModel? model;
  final detailModel = ActivityModel().obs;
  final enable = true.obs; //未申请，false已参与
  final applyModels = <ActivityApplyModel>[].obs;
  final tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
    }
    queryActivityDetail();
    applyActivityList();
  }

  ///打开外部链接
  void openExternalLinks(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void  clickApplyRecord() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
      return;
    }
    Get.dialog(ApplyRecordDialog(models: applyModels.value));
  }

  void clickApplyJoin() {
    if (UserService.to.state.isVisitor) {
      EventBus.emit(EventType.goToLogin);
      return;
    }
    Get.dialog(SkBaseDialog(
      callback: () {
        applyJoin();
      },
      title: "tip".tr,
      showFooterBtn: true,
      showDeleteBtn: false,
      showDeleteBtnType: '1',
      leftBtnTitle: "cancel".tr,
      rightBtnTitle: "confirm".tr,
      child: Container(
        padding: EdgeInsets.all(30.r),
        child: Text(
          "join_activity_tip".tr,
          style: TextStyle(
            fontSize: 16.sp,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }

  void applyJoin() async {
    var result = await ApiRequest.applyJoinActivity(
        model?.id ?? '', '${model?.ty ?? 0}');
    if (result == true) {
      Get.dialog(SkBaseDialog(
        callback: () {
          applyActivityList();
        },
        title: detailModel.value.activityConfigModel?.applySuccessAlertTitle ??
            "tips".tr,
        showFooterBtn: true,
        showDeleteBtn: false,
        showOneBtn: true,
        showDeleteBtnType: '1',
        leftBtnTitle: "cancel".tr,
        rightBtnTitle: "confirm".tr,
        margin: EdgeInsets.symmetric(horizontal: 50.r),
        child: Container(
          padding: EdgeInsets.all(20.r),
          child: Text(
            detailModel.value.activityConfigModel?.applySuccessAlertText ??
                "您今日已申请报名成功",
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )).then((onValue) {
        applyActivityList();
      });
    }
  }

  void applyActivityList() async {
    var result = await ApiRequest.applyActivityList();
    if (result != null) {
      List<ActivityApplyModel> list = result.d ?? [];
      applyModels.value = list.where((e) => e.promoId == model?.id).toList();
      enable.value = applyModels.isEmpty;
    }
  }

  void queryActivityDetail() async {
    detailModel.value = await ApiRequest.queryActivityDetail(
            model?.id ?? '', '${model?.ty ?? 0}') ??
        model ??
        ActivityModel();
  }
}
