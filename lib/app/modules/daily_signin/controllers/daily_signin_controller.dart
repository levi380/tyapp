import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/app/modules/daily_signin/model/daily_sign_detail.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class DailySigninController extends GetXBaseController {
  final count = 0.obs;
  Rx<DailySignDetail> detailModel = DailySignDetail().obs;
  String name = "";
  String id = "";

  @override
  void onInit() {
    super.onInit();
     name = Get.arguments["name"];
     id = Get.arguments["id"];
    if (id.isNotEmpty) {
      getActionDetail();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  test() {}

  getActionDetail() async {
    Map<String, dynamic> params = {};
    params["name"] =name;
    params["id"] =id;
    params["uid"] = UserService.to.state.uid;
    params["lang"] = "zh";
    var response =
        await HttpClient.get(Api.promosignDetail, queryParameters: params);

    if (response.status == false) {
      throw response.error!;
    }
    detailModel.value = DailySignDetail.fromJson(response.data);
  }

  promosignClaim(Days day) async {
    // Map<String, dynamic> params = {};
    // params["name"] = activityModel.value.name;
    // params["id"] = activityModel.value.id;
    // params["currency"] = 102;
    // params["username"] = UserService.to.state.userName;
    // params["uid"] = UserService.to.state.uid;
    // params["summary"] = "";
    var response = await HttpClient.post(Api.promosignClaim, data: {
      "currency": 102,
      "id": num.parse(id ?? "0"),
      "name": name,
      "uid": UserService.to.state.uid,
      "username": UserService.to.state.userName,
      // "summary": "",
    });

    if (response.status == false) {
      throw response.error!;
    }

    getActionDetail();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
