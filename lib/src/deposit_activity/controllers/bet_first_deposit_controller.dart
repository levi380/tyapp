import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/deposit_activity/views/activity_promo_detail_model.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/src/deposit_activity/views/activity_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class BettingFirstDepositController extends GetxController {
  final ActivityService _activityService = Get.find<ActivityService>();

  RxInt selIndex = 0.obs;
  RxString h5Summary = "".obs;
  RxString topIamges = "".obs;
  Rx<ActivityPromoDetailModel> detailBean = ActivityPromoDetailModel().obs;

  //首存豪礼，礼品列表
  RxList firstConfigGiftList = [].obs;

  //投注礼品列表
  RxList betConfigGiftList = [].obs;

  //已首存豪礼，礼品列表
  Rx<BettingResults?> firstDepositGift = Rx(null);

  //已投注，礼品列表
  Rx<BettingResults?> bettingGift = Rx(null);

  ActivityModel? model;
  RxString id = "".obs;
  RxString ty = "".obs;

  Rx<String?> betting = "0.00".obs;
  Rx<String?> firstDeposit = "0.00".obs;
  RxString promoId = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
      id.value = model?.id ?? "";
      ty.value = "${model?.ty ?? ""}";
    }

    queryPromoDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> queryPromoDetail() async {
    var detail = await _activityService.queryPromoDetail(id.value, ty.value);
    detailBean.value = detail;
    h5Summary.value = detail.promo?.h5Summary ?? "";
    String images = detail.promo?.images ?? "";
    if (images.isNotEmpty) {
      final Map<String, dynamic> map = jsonDecode(images);
      topIamges.value = map["h5_main"] ?? "";
    }

    ///处理礼品列表
    firstConfigGiftList.value = detail.config?["first_deposit_config"]["gifts"];

    betConfigGiftList.value = detail.config?["betting_config"]["gifts"];

    firstDeposit.value = detail.progress?['first_deposit'];
    betting.value = detail.progress?["betting"];
    promoId.value = detail.progress?["promo_id"];

    if (detail.progress?["first_deposit_gift"] != null) {
      firstDepositGift.value = BettingResults.fromJson(detail.progress?["first_deposit_gift"]);
    }

    if (detail.progress?["betting_gift"] != null) {
      bettingGift.value = BettingResults.fromJson(detail.progress?["betting_gift"]);
    }
  }

  ///首存豪礼活动领奖接口
  Future<bool> promoClaim(int giftIndex) async {
    var response = await HttpClient.post(Api.promoClaim, data: {
      'id': id.value,
      'ty': ty.value,
      'promo_id': promoId.value,
      'gift_type': selIndex.value == 0 ? 2 : 1,
      'gift_index': giftIndex,
    });
    if (response.status == false) {
      AppUtils.showToast(
        nonEmptyMessageOr(
          response.message,
          defaultMessage: '领取未成功，请重试',
        ),
      );
      throw response.error!;
    }
    return true;
  }
}
