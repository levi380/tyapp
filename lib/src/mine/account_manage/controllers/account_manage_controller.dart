import 'dart:async';

import 'package:filbet/api/api.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:filbet/http/http_client.dart';

class AccountManageController extends GetXBaseController
    with GetTickerProviderStateMixin {
  final WalletService _walletService = Get.find<WalletService>();

  TextEditingController newPaymentPasswordController = TextEditingController();
  TextEditingController confirmPaymentPasswordController =
      TextEditingController();

  UserService get userService => Get.find<UserService>();
  final SecurityService securityService = Get.find<SecurityService>();
  final Rx<SecurityDataModel?> securityData = Rx<SecurityDataModel?>(null);

  final int initialIndex = 0;
  late TabController tabController;
  RxList<WalletAccountModel> mAllAccountList = RxList.empty();
  RxList<WalletAccountModel> mFilterList = RxList.empty();

  Rx<String> originalPaymentPassword = ''.obs;
  Rx<String> newPaymentPassword = ''.obs;
  Rx<String> confirmPaymentPassword = ''.obs;

  // 验证状态
  Rx<bool> verityState = false.obs;

  bool get isNewPaymentPasswordValid {
    if (newPaymentPassword.value.isEmpty) {
      return true;
    }
    return _isPaymentPasswordValid(newPaymentPassword.value);
  }

  bool get canSetPaymentPassword {
    return _isPaymentPasswordValid(newPaymentPassword.value) &&
        newPaymentPassword.value == confirmPaymentPassword.value;
  }

  bool _isPaymentPasswordValid(String password) {
    return paymentPasswordStringValidate(password)
        .every((element) => element.item2);
  }

  List<Tuple2<CredentialStringValidateType, bool>>
      paymentPasswordStringValidate(String value) {
    return [
      Tuple2(
        CredentialStringValidateType.length6,
        value.length == 6,
      ),
      Tuple2(
        CredentialStringValidateType.onlyNumber,
        CredentialStringValidateType.onlyNumber.validate(value),
      ),
    ];
  }

  final List tabTypeList = [
    {
      'title': '虚拟币'.tr,
      'type': AccountManageChangeType.usdtAccount,
    },
    {
      'title': '银行卡'.tr,
      'type': AccountManageChangeType.bankAccount,
    },
    {
      'title': '其他账户'.tr,
      'type': AccountManageChangeType.otherAccount,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _setupTabController();
    loadSecurityDataAndOutput();
    loadWalletAccountList();
    // 设置初始tab index
    if (tabController.length > initialIndex && initialIndex >= 0) {
      tabController.index = initialIndex;
    }
    newPaymentPasswordController.addListener(() {
      newPaymentPassword.value = newPaymentPasswordController.text;
    });

    confirmPaymentPasswordController.addListener(() {
      confirmPaymentPassword.value = confirmPaymentPasswordController.text;
    });
  }

  void _setupTabController() {
    tabController = TabController(length: tabTypeList.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        if (mAllAccountList.isEmpty) {
          mFilterList.value = [];
          return;
        }

        if (tabController.index == 0) {
          const allowTypes = {1, 2}; //usdt 账户
          mFilterList.value = mAllAccountList
              .where((item) => allowTypes.contains(item.paymentType ?? -1))
              .toList();
        } else if (tabController.index == 1) {
          // 银行卡账户
          mFilterList.value =
              mAllAccountList.where((item) => 6 == item.paymentType).toList();
        } else {
          const allowTypes = {
            3,
            4,
            5,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20
          }; // 其它账户 （支付宝、微信）
          mFilterList.value = mAllAccountList
              .where((item) => allowTypes.contains(item.paymentType ?? -1))
              .toList();
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    earseTextControllers();
  }

  void earseTextControllers() {
    newPaymentPasswordController.clear();
    confirmPaymentPasswordController.clear();
  }

  Future<void> loadWalletAccountList() async {
    var allAccountList = await _walletService.getAccountList();
    print("object123456 allAccountList=${allAccountList.length}");
    mAllAccountList.clear();
    mFilterList.clear();
    mAllAccountList.addAll(allAccountList);
    if (tabController.index == 0) {
      const allowTypes = {1, 2}; //usdt 账户
      mFilterList.value = mAllAccountList
          .where((item) => allowTypes.contains(item.paymentType ?? -1))
          .toList();
    } else if (tabController.index == 1) {
      // 银行卡账户
      mFilterList.value =
          mAllAccountList.where((item) => 6 == item.paymentType).toList();
    } else {
      const allowTypes = {
        3,
        4,
        5,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20
      }; // 其它账户 （支付宝、微信）
      mFilterList.value = mAllAccountList
          .where((item) => allowTypes.contains(item.paymentType ?? -1))
          .toList();
    }
  }

  void setObscured(WalletAccountModel item, String decAddress) {
    item.decAddress = decAddress;
    item.isObscured = !item.isObscured;
    mFilterList.refresh(); // 关键：通知 UI 更新
  }

  Future<void> deleteUSDTWalletAddress() async {
    AppUtils.showToast('delete_success'.tr);
    await loadWalletAccountList();
  }

  Future<SecurityDataModel> loadSecurityDataAndOutput() async {
    final model = await securityService.loadSecurityData();
    securityData.value = model;
    return model;
  }

  Future<bool> setPaymentPassword(
    String newPassword, {
    String? secCode,
  }) async {
    final isSuccess = await fetchHandler<bool>(
          securityService.setPayPwd(
            newPassword,
          ),
          onError: toastError,
          loading: true,
        ) ??
        false;

    if (isSuccess) {
      AppUtils.showToast('settings_success'.tr);
      await loadSecurityData();
      earseTextControllers();
    }
    //多处用到此接口，需要返回是否成功做下一步处理
    return Future.value(isSuccess);
  }

  Future<void> loadSecurityData() async {
    await fetchHandler<SecurityDataModel>(
      securityService.loadSecurityData(),
      onSuccess: (model) {
        securityData.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<bool> postPhoneVerify(String phoneDigitsy) async {
    try {
      final response = await HttpClient.post(Api.phoneVerify, data: {
        'phone_digits': phoneDigitsy,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(response.message, ifEmpty: '失败');
      }
      return response.status;
    } catch (e) {
      return false;
    }
  }
}

enum AccountManageChangeType {
  usdtAccount,
  bankAccount,
  otherAccount;

  int get value {
    switch (this) {
      case AccountManageChangeType.usdtAccount:
        return 0;
      case AccountManageChangeType.bankAccount:
        return 6;
      case AccountManageChangeType.otherAccount:
        return 2;
    }
  }

  String get name {
    switch (this) {
      case AccountManageChangeType.usdtAccount:
        return '虚拟币'.tr;
      case AccountManageChangeType.bankAccount:
        return '银行卡'.tr;
      case AccountManageChangeType.otherAccount:
        return '其他账户'.tr;
    }
  }

  static AccountManageChangeType? fromValue(int value) {
    switch (value) {
      case 0:
        return AccountManageChangeType.usdtAccount;
      case 1:
        return AccountManageChangeType.bankAccount;
      case 2:
        return AccountManageChangeType.otherAccount;
      default:
        return null;
    }
  }
}
