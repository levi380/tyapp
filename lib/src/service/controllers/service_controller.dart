import 'package:filbet/generated/assets.dart';
import 'package:get/get.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/services/global/global_service.dart';
import 'dart:convert';

class ServiceModel {
  String image = "";
  String name = "";
  String content = "";
  String url = "";
  String type = "";

  ServiceModel(
      {this.image = "",
      this.name = "",
      this.content = "",
      this.url = "",
      this.type = ""});
}

class ServiceController extends GetXBaseController {
  //TODO: Implement ServiceController

  static ServiceController get to => Get.find();
  final count = 0.obs;

  void increment() => count.value++;

  RxList<ServiceModel> serviceList = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // serviceList.value = [
    //   ServiceModel(image: Assets.homeOnlineKf, name: "在线客服"),
    //   ServiceModel(
    //       image: Assets.homeTelegramKf, name: "Telegram客服", content: "@skkefu")
    // ];
  }

  @override
  void onReady() {
    super.onReady();

    fetchDataloading();
  }

  Future<void> fetchDataloading({bool loading = true}) async {
    await fetchHandler(
      _customerservice(),
      onSuccess: (token) async {},
      onError: (exception) {},
      loading: loading,
    );
  }

  Future<List<ServiceModel>> _customerservice() async {
    var response = await HttpClient.get(
      Api.customerservice,
    );
    if (response.status == false) {
      throw response.error!;
    }

    List row = response.data["ways"] ?? [];
    List third_partys = response.data["third_partys"] ?? [];
    serviceList.clear();
    if (row.isEmpty) {
    } else {
      serviceList.value = row.map((e) {
        if (e["id"] == 1) {
          return ServiceModel(
              image: Assets.homeTelegramKf,
              name: getText(e),
             content: getmumber(e),
              type: e["id"].toString(),
              url: e["jump_url"]);
        }
        return ServiceModel(
            image: Assets.homeOnlineKf,
            name: getText(e),
          
            type: e["id"].toString(),
            url: e["jump_url"]);
      }).toList();
    }
    if (third_partys.isNotEmpty) {
      List<ServiceModel> thirdmodel = third_partys.map((e) {
        return ServiceModel(
            image: Assets.homeOnlineKf,
            name: e["type"],
            content: "",
            type: "2",
            url: e["url"]);
      }).toList();
      serviceList.addAll(thirdmodel);
    }

    return serviceList;
  }

  getText(e) {
    Language languagemodel = GlobalService.to.state.language;

    String language = "zh_CN";
    if (languagemodel == Language.zh_cn) {
      language = "zh_CN";
    }
    if (languagemodel == Language.zh_tw) {
      language = "zh_TW";
    }

    // if (languagemodel == Language.en) {
    //   language = "en_US";
    // }
    // if (languagemodel == Language.viet) {
    //   language = "vi_VN";
    // }

    final data = jsonDecode(e["name"]);
    if (data is Map) {
      return data[language];
      // 这里才可以当 Map 用
    }

    return "";
  }

   getmumber(e) {
    Language languagemodel = GlobalService.to.state.language;

    String language = "zh_CN";
    if (languagemodel == Language.zh_cn) {
      language = "zh_CN";
    }
    if (languagemodel == Language.zh_tw) {
      language = "zh_TW";
    }

    // if (languagemodel == Language.en) {
    //   language = "en_US";
    // }
    // if (languagemodel == Language.viet) {
    //   language = "vi_VN";
    // }

    final data = jsonDecode(e["desc"]);
    if (data is Map) {
      return data[language];
      // 这里才可以当 Map 用
    }

    return "";
  }
}
