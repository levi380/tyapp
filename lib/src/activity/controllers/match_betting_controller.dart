import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/activity/model/promo_report_model.dart';
import 'package:filbet/src/activity/views/match_betting_record_dialog.dart';
import 'package:filbet/src/deposit_activity/views/first_deposit_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/apply_record_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class MatchBettingController extends GetxController {
  Rx<FirstDepositModel?> detail = Rx<FirstDepositModel?>(null);

  RxList<Object?> promoDetail = RxList.empty();

  RxList<PromoReportModel> list = RxList.empty();
  RxList<PromoReportModel> originalList = RxList.empty();

  RxList<PromoReportModel> riddleList = RxList.empty();

  RxBool isSubmit = false.obs;

  final pageTagSelIndex = 0.obs;
  Rx<Object?> pageTagSelItem = Rx<Object?>(null);

  ActivityModel? model;
  RxString id = "".obs;
  RxString ty = "".obs;
  final enable = true.obs; //未申请，false已参与
  RxInt tabIndex = 0.obs;

  final applyModels = <ActivityApplyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
      id.value = model?.id ?? "";
      ty.value = "${model?.ty ?? ""}";
    }
    _promoDetail(id.value, ty.value);
    // applyActivityList();
    promoReportList();
  }

  ///获取活动类型列表
  Future<void> _promoDetail(String id, String ty) async {
    Map<String, dynamic> params = {};
    params["id"] = id;
    params["ty"] = ty;
    params["t"] = DateTime.now().millisecondsSinceEpoch;
    var response =
        await HttpClient.get(Api.activityDetail, queryParameters: params);
    if (response.status == false) {
      throw response.error!;
    }

    if (response.data is Map) {
      detail.value = FirstDepositModel.fromJson(response.data);
      final Map<String, dynamic> config =
          jsonDecode(detail.value?.config ?? "");

      List<Object> promoDetailList = [];
      if (config.isNotEmpty) {
        if (config.containsKey("page_riddle_config")) {
          Map pageRiddleConfig1 = config["page_riddle_config"];
          if (pageRiddleConfig1.isNotEmpty) {
            for (var entry in pageRiddleConfig1.entries) {
              var item = PageRiddleConfigBean.fromJson(entry.value);
              if (item.active == 1) {
                //该页面是否显示 1 显示 2 不显示，页面显示中
                promoDetailList.add(item);
              }
            }
          }
        }
        if (config.containsKey("page_contest_config")) {
          Map pageContestConfig1 = config["page_contest_config"];
          if (pageContestConfig1.isNotEmpty) {
            for (var entry in pageContestConfig1.entries) {
              var item = PageContestConfig.fromJson(entry.value);
              if (item.active == 1) {
                //该页面是否显示 1 显示 2 不显示，页面显示中
                promoDetailList.add(item);
              }
            }
          }
        }
      }

      promoDetail.value = promoDetailList;
      pageTagSelItem.value = promoDetailList.first;
    } else {
      detail.value = FirstDepositModel();
    }
  }

  ///获取活动类型列表
  Future<bool> promoApply(String id, String ty, String contestActiveId,
      int contestActiveTy, String contestResult) async {
    var response = await HttpClient.post(Api.applyJoinActivity, data: {
      "id": id,
      "ty": ty,
      "contest_active_id": contestActiveId,
      "contest_active_type": contestActiveTy,
      if (contestResult.isNotEmpty) "contest_result": contestResult,
    });
    if (response.status == false) {
      AppUtils.showToastForResponse(response.message);
      throw response.error!;
    }
    return true;
  }

  void clickApplyRecord() {
    Get.dialog(MatchBettingRecordDialog(models: originalList.value));
  }

  void applyActivityList() async {
    var result = await ApiRequest.applyActivityList();
    if (result != null) {
      List<ActivityApplyModel> list = result.d ?? [];
      applyModels.value = list.where((e) => e.promoId == model?.id).toList();
      enable.value = applyModels.isEmpty;
    }
  }

  Future<void> promoReportList() async {
    var response = await HttpClient.post(Api.activityWinnerRecord,
        data: {'id': id.value ?? "", 'ty': "5"});
    if (response.status == false) {
      AppUtils.showToastForResponse(response.message, ifEmpty: '加载失败');
      throw response.error!;
    }

    riddleList.clear();
    Map riddle = response.data["riddle"];
    riddle.forEach((key, value) {
      List<dynamic> data = value ?? [];
      var tempList =
          data.map((e) => PromoReportModel.fromJson(Map.from(e))).toList();
      riddleList.addAll(tempList);
    });

    Map contest = response.data["contest"];
    contest.forEach((key, value) {
      List<dynamic> data = value ?? [];
      var tempList =
          data.map((e) => PromoReportModel.fromJson(Map.from(e))).toList();
      list.addAll(tempList);
    });

    //保存原始数据
    originalList.clear();
    originalList.addAll(list);
  }
}
