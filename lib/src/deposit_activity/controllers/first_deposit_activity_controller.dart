import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/entity/platform_check_out_model.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/http/entity/resp_promo_tag.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_exceptions.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/model/activity_model.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit_activity/views/first_deposit_model.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/widgets/dialog/recycle_result_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/http/http_client.dart';

class FirstDepositActivityController extends GetXBaseController {
  TextEditingController amountController = TextEditingController();

  RxString inputAmount = "".obs;
  final isRefreshing = false.obs; // 刷新状态
  final centerAmount = '--'.obs;
  Rx<FirstDepositModel?> detail = Rx<FirstDepositModel?>(null);
  RxString selType = "".obs;
  RxString imageTop = "".obs;

  RxString selWalletName = "".obs;

  ActivityModel? model;

  RxString id = "".obs;
  RxString ty = "".obs;
  RxString platformId = "101".obs;
  // Rx<PlatformWalletModel?> walletSel = Rx<PlatformWalletModel?>(null);
  Rx<VenueModel?> walletSel = Rx<VenueModel?>(null);
  RxList<VenueModel> platformList = RxList.empty();
  RxList<PlatformWalletModel> walletList = RxList.empty();

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.containsKey('model')) {
      model = Get.arguments['model'];
      id.value = model?.id ?? "";
      ty.value = "${model?.ty ?? ""}";
    }

    _promoDetail(id.value, ty.value);

    financeWallet();
    // _promoTypeList();
    // _promoList(34);
    super.onInit();

    amountController.addListener(_onAmountChange);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    amountController.removeListener(_onAmountChange);
  }

  void _onAmountChange() {
    inputAmount.value = amountController.text.trim();
  }

  void financeWallet() async {
    if (isRefreshing.value) return; // 如果正在刷新，直接返回
    isRefreshing.value = true;
    var resp = await UserService.to.queryTotalBalance();
    centerAmount.value = UserService.to.state.centerBalance.value ?? '0';
    isRefreshing.value = false;
  }

  ///获取活动列表
  Future<List<ActivityModel>> _promoList(int? type) async {
    Map<String, dynamic> params = {};
    if (type != null) {
      params["tag_id"] = 34;
    }

    var response = await HttpClient.get(Api.promoList, queryParameters: params);
    if (response.status == false) {
      throw response.error!;
    }
    List<dynamic> rawList = response.data ?? [];
    List<ActivityModel> list = rawList.map((e) => ActivityModel.fromJson(Map<String, dynamic>.from(e))).toList();
    return list;
  }

  ///获取活动类型列表
  Future<List<ActivityTypeModel>> _promoTypeList() async {
    var response = await HttpClient.get(Api.promoTypeList);
    if (response.status == false) {
      throw response.error!;
    }
    var resp = RespPromoTag.fromJson(Map<String, dynamic>.from(response.data));
    return resp.d ?? [];
  }

  ///获取活动类型列表
  Future<void> _promoDetail(String id, String ty) async {
    Map<String, dynamic> params = {};
    params["id"] = id;
    params["ty"] = ty;
    var response = await HttpClient.get(Api.activityDetail, queryParameters: params);
    if (response.status == false) {
      throw response.error!;
    }

    if (response.data is Map) {
      detail.value = FirstDepositModel.fromJson(response.data);
      final Map<String, dynamic> json = jsonDecode(detail.value?.config ?? "");
      final Map<String, dynamic> sort = json['platform_sort'];

      final sortedEntries = sort.entries.toList()..sort((a, b) => a.value.compareTo(b.value));

      final sortedMap = Map.fromEntries(sortedEntries);

      List<String> list = [];
      for (var entry in sortedMap.entries) {
        list.add(entry.key);
      }

      List<String> stringList = list.map((e) => e.toString()).toList();
      List<VenueModel> platforms = GlobalService.to.state.allGameConfig;
      List<VenueModel> resultWalletList = [];

      for (int i = 0; i < stringList.length; i++) {
        for (int j = 0; j < platforms.length; j++) {
          if (stringList[i] == (platforms[j].id ?? "")) {
            resultWalletList.add(platforms[j]);
          }
        }
      }

      platformList.value = resultWalletList;

      // 图片。web_list->活动列表图, web_share -> 活动分享图， web_main -> 主图
      String iamges = detail.value?.images ?? "";

      if (iamges.isNotEmpty) {
        final Map<String, dynamic> map = jsonDecode(iamges);
        imageTop.value = map["h5_main"] ?? "";
      }
    } else {
      detail.value = FirstDepositModel();
    }
  }

  // 活动申请
  void promoApply() async {
    if (inputAmount.isEmpty) {
      AppUtils.showToast("请输入申请金额");
      return;
    }

    if (walletSel.value == null) {
      AppUtils.showToast("请选择场馆");
      return;
    }

    if (walletSel.value?.maintained == 2) {
      AppUtils.showToast("该场馆维护中，请重新选择！");
      return;
    }

    var response = await HttpClient.post(
      Api.applyJoinActivity,
      data: {
        'id': id.value,
        'ty': ty.value,
        'apply_amount': inputAmount.value,
        'platform_id': walletSel.value?.id ?? "",
      },
    );

    if (response.status == false) {
      final ex = response.error;
      final tip = ex != null
          ? exceptionMessageForUser(ex)
          : '活动申请未成功，请重试';
      AppUtils.showToast(tip);
      throw ex ?? BadRequestException(message: tip);
    }
    if (response.status == true) {
      Get.dialog(SkBaseDialog(
        callback: () {
          Get.back();
        },
        title: "tips".tr,
        showFooterBtn: true,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        leftBtnTitle: "cancel".tr,
        rightBtnTitle: "confirm".tr,
        margin: EdgeInsets.symmetric(horizontal: 50.r),
        child: Container(
          padding: EdgeInsets.all(20.r),
          child: Text(
            "您今日已申请报名成功",
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ));
    }
  }

  Future<void> oneKeyRecycle() async {
    SmartDialog.showLoading();
    if (walletList.isEmpty) {
      SmartDialog.dismiss();
      AppUtils.showToast('没有可回收的余额');
      return;
    }
    // 收集需要回收的钱包（余额大于0的）
    final recycleTasks = <Future<PlatformCheckOutModel?>>[];
    final recycleItems = <PlatformWalletModel>[];

    for (var item in walletList) {
      final amount = num.tryParse(item.balance ?? '0') ?? 0;
      if (amount > 0) {
        recycleTasks.add(transferOutWallet(item.walletId, item.balance));
        recycleItems.add(item);
      }
    }
    if (recycleTasks.isEmpty) {
      SmartDialog.dismiss();
      AppUtils.showToast('没有可回收的余额');
      return;
    }
    final results = await Future.wait(recycleTasks);
    final stateCode101Items = <PlatformWalletModel>[];
    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      if (result != null && result.stateCode == 101) {
        recycleItems[i].remainTurnover = result.remainTurnover;
        stateCode101Items.add(recycleItems[i]);
      }
    }
    SmartDialog.dismiss();
    // 只刷新有转出的钱包余额
    // for (var item in recycleItems) {
    //   platformBalance(item.walletId);
    // }
    // 刷新中心钱包余额
    financeWallet();

    if (stateCode101Items.isNotEmpty) {
      Get.dialog(RecycleResultDialog(
        models: stateCode101Items,
      ));
    } else {
      AppUtils.showToast('一键回收成功');
    }
  }

  //转出场馆
  Future<PlatformCheckOutModel?> transferOutWallet(String? pid, String? amount) async {
    if (pid == null || amount == null) {
      return null;
    }
    var resp = await ApiRequest.transferOutWallet(pid, amount);
    return resp;
  }

  // void platformBalance(String? pid) async {
  //   if (pid == null) {
  //     return;
  //   }
  //   var resp = await ApiRequest.platformBalance(pid);
  //   if (resp != null) {
  //     walletList.where((item) => item.walletId == pid).first.balance = resp;
  //     walletList.refresh();
  //   }
  // }

  String get amountAvailable {
    var grantMode = detail.value?.grantMode ?? 0;
    if (grantMode == 0) {
      return "0.00";
    } else {
      if (grantMode == 1) {
        var requireAmount = double.parse(detail.value?.requireAmount ?? "0.00");
        var giftRatio = double.parse(detail.value?.giftRatio ?? "0.00");
        var grantLimit = double.parse(detail.value?.grantLimit ?? "0.00");
        var inputNumber = double.parse(inputAmount.value.isEmpty ? "0.00" : inputAmount.value);
        var amount = inputNumber * giftRatio / 100;
        if (amount > grantLimit) {
          return "$grantLimit";
        } else {
          return "$amount";
        }
      } else if (grantMode == 2) {
        return detail.value?.giftRatio ?? "0.00";
      } else {
        return "0.00";
      }
    }
  }

  String get getFlowingWater {
    var inputNumber = double.parse(inputAmount.value.isEmpty ? "0.00" : inputAmount.value);
    var multiple = double.parse(detail.value?.multiple ?? "0.00");
    // 首存活动 流水要求金额 = （本金 + 红利）* 流水倍数要求
    var amount = (inputNumber + double.parse(amountAvailable)) * multiple;
    return "$amount";
  }
}
