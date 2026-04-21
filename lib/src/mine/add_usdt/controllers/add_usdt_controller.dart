import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/common/encrypto_protocal.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/dialog/withdraw_deposit_hint_dialog.dart';
import 'package:filbet/src/security/security_data_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/payment_type.dart';
import 'package:filbet/utils/wallet_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:filbet/http/http_client.dart';

class AddUsdtController extends GetXBaseController {
  final WalletService _walletService = WalletService();

  final SecurityService securityService = Get.find<SecurityService>();
  final Rx<SecurityDataModel?> securityData = Rx<SecurityDataModel?>(null);

  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController usdtAddressController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  // final TextEditingController payPwdController = TextEditingController();

  final RxList<BlockChain> encryptoProtocalList = BlockChain.values.obs;
  final Rxn<BlockChain> selectedProtocol = Rxn<BlockChain>(null);
  List<String> countryCodeList = <String>[]; //区号
  final selAreaCodeText = '+86'.obs;

  final RxString name = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString usdtAddress = ''.obs;

  // final RxString password = ''.obs;

  RxBool isPhoneError = false.obs;
  RxBool isVerifyError = false.obs;

  // RxBool isPayPwdError = false.obs;

  RxString phoneErrorText = "".obs;
  RxString verifyErrorText = "".obs;

  // RxString payPwdErrorText = "".obs;

  RxInt countdownSeconds = 0.obs;

  // 1 绑定usdt不需要手机号 ;2 或者其他 绑定usdt需要手机号
  RxInt usdtNeedPhone = 1.obs;

  RxString sid = "".obs;
  final GlobalKey phoneContainerKey = GlobalKey();

  @override
  void onInit() {
    convertAreaAndPhone();
    phoneController.text = phoneNumber.value;

    loadSecurityDataAndOutput();
    super.onInit();
    getCountryCodeList();
    // int paymentType = Get.arguments?["paymentType"] as int? ?? 0;
    // final result = encryptoProtocalList.firstWhereOrNull(
    //   (item) => item.code == 1,
    // );
    encryptoProtocalList.value = [BlockChain.usdt_trc20];

    selectedProtocol.value = encryptoProtocalList.first;

    accountNameController.addListener(() {
      name.value = accountNameController.text;
    });
    usdtAddressController.addListener(() {
      usdtAddress.value = usdtAddressController.text;
    });

    phoneController.addListener(_onPhoneChanged);
    verifyController.addListener(_onVerifyChanged);
    // payPwdController.addListener(_onPayPwdChanged);
  }

  void showWithdrawDepositHintDialog() async {
    var isResult = await Get.dialog(
      WithdrawDepositHintDialog(),
      barrierDismissible: false,
    );
  }

  void _onPhoneChanged() {
    if (usdtNeedPhone.value == 1) {
      isPhoneError.value = false;
      phoneErrorText.value = "";
    } else {
      final phoneText = phoneController.text.trim();
      if (phoneText.isEmpty) {
        isPhoneError.value = true;
        phoneErrorText.value = '${'input_hint'.tr}${'phone_num'.tr}';
      } else {
        isPhoneError.value = false;
        phoneErrorText.value = "";
      }
    }
  }

  void _onVerifyChanged() {
    if (usdtNeedPhone.value == 1) {
      isVerifyError.value = false;
      verifyErrorText.value = "";
    } else {
      final verifyText = verifyController.text.trim();
      if (verifyText.isEmpty) {
        isVerifyError.value = true;
        verifyErrorText.value = '${'input_hint'.tr}${'verity_code'.tr}';
      } else {
        isVerifyError.value = false;
        verifyErrorText.value = "";
      }
    }
  }

  // void _onPayPwdChanged() {
  //   final payPwdText = payPwdController.text.trim();
  //   password.value = payPwdText;
  //   if (payPwdText.isEmpty) {
  //     isPayPwdError.value = true;
  //     payPwdErrorText.value = '${'input_hint'.tr}${'pay_pwd'.tr}';
  //   } else {
  //     isPayPwdError.value = false;
  //     payPwdErrorText.value = "";
  //   }
  // }

  void getCountryCodeList() async {
    var resp = await ApiRequest.getCountryCodeList();
    if (resp != null) {
      countryCodeList = resp;
    }
  }

  Future<void> getSendBindCode(String replacePhone) async {
    if (phoneController.text.isEmpty) {
      AppUtils.showToast('${'input_hint'.tr}${'phone_num'.tr}');
      return;
    }
    sendSms(
        replacePhone.trim().isNotEmpty ? replacePhone : phoneController.text,
        selAreaCodeText);
  }

  Future<void> sendSms(phone, code) async {
    var resp = await ApiRequest.getSendBindCode(phone, code);
    if (resp == true) {
      AppUtils.showToast('code_send'.tr);
      countdownSeconds.value = countdownTime;
    }
  }

  @override
  void dispose() {
    accountNameController.dispose();
    usdtAddressController.dispose();
    // payPwdController.dispose();
    phoneController.dispose();
    verifyController.dispose();
    // payPwdController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    showWithdrawDepositHintDialog();
  }

  @override
  void onClose() {
    phoneController.removeListener(_onPhoneChanged);
    verifyController.removeListener(_onVerifyChanged);
    // payPwdController.removeListener(_onPayPwdChanged);
    super.onClose();
  }

  int getInputLength() {
    switch (selectedProtocol.value?.code) {
      case 1:
        return 34; // TRC20
      case 3:
        return 34; // EB
      case 4:
        return 16; // NO
      case 5:
        return 19; // HD
    }
    return 34;
  }

  bool get isAddressValid {
    switch (selectedProtocol.value!) {
      case BlockChain.usdt_trc20:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.eb_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.no_wallet:
        return isSimplePayAddress(usdtAddress.value);
      // return isSimpleTrc20Address(usdtAddress.value);
      // case BlockChain.usdt_erc20:
      //   return isSimpleErc20Address(usdtAddress.value);
      case BlockChain.hd_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.bank_pay:
        return false;
      case BlockChain.alipay:
        return false;
      case BlockChain.m_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.weChat_pay:
        return false;
      case BlockChain.cb_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.f_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.go_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.p365_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.w_pay:
        return isSimplePayAddress(usdtAddress.value);
      case BlockChain.ok_pay:
        return isSimplePayAddress(usdtAddress.value);
    }
  }

  bool get isAddressInputError {
    if (usdtAddress.value.isEmpty) {
      return false;
    }
    return !isAddressValid;
  }

  bool get inSubmit {
    if (usdtNeedPhone.value == 1) {
      return accountNameController.text.isNotEmpty &&
          usdtAddressController.text.isNotEmpty;
      // &&
      // payPwdController.text.isNotEmpty;
    } else {
      return accountNameController.text.isNotEmpty &&
          usdtAddressController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          verifyController.text.isNotEmpty;
      // &&
      // payPwdController.text.isNotEmpty;
    }
  }

  String getWalletName() {
    switch (selectedProtocol.value?.code) {
      case 1:
        return 'USDT'; // TRC20
      case 3:
        return "EB Pay"; // EB
      case 4:
        return "No Wallet"; // NO
      case 5:
        return "HD Pay"; // HD
    }
    return '';
  }

  void validateAndSubmit() async {
    if (accountNameController.text.isEmpty) {
      AppUtils.showToast('请输入别名'.tr);
      return;
    }
    if (usdtAddressController.text.isEmpty) {
      AppUtils.showToast('请输入usdt地址'.tr);
      return;
    }
    if (usdtNeedPhone.value == 2) {
      if (phoneController.text.isEmpty) {
        AppUtils.showToast('请输入手机号'.tr);
        return;
      }
      if (verifyController.text.isEmpty) {
        AppUtils.showToast('请输入验证码'.tr);
        return;
      }
    }

    // if (usdtNeedPhone.value == 2 && phoneController.text.isEmpty) {
    //   AppUtils.showToast('请输入手机号'.tr);
    //   return;
    // }
    //
    // if (usdtNeedPhone.value == 2 && verifyController.text.isEmpty) {
    //   AppUtils.showToast('请输入验证码'.tr);
    //   return;
    // }
    // if (payPwdController.text.isEmpty) {
    //   AppUtils.showToast('请输入支付密码'.tr);
    //   return;
    // }

    // 绑定地址必现要添加手机号
    if (usdtNeedPhone.value == 2) {
      var params = getParams();
      params['code'] = verifyController.text.trim();
      var isSuccess = await accountBindStep3(params);
      if (isSuccess) {
        accountBindStep4();
      }
    } else {
      var inputPhone = phoneController.text.isEmpty;
      if (inputPhone) {
        accountBindStep4();
      } else {
        if (verifyController.text.isEmpty) {
          AppUtils.showToast('请输入验证码'.tr);
          return;
        }
        var params = getParams();
        params['code'] = verifyController.text.trim();
        var isSuccess = await accountBindStep3(params);
        if (isSuccess) {
          accountBindStep4();
        }
      }
    }

    // Tuple2<bool, String?> future = usdtNeedPhone.value == 2
    //     ? await _walletService.addAccount(accountNameController.text, selectedProtocol.value!.code, usdtAddress.value,
    //         secCode: verifyController.text, phone: phoneController.text.trim())
    //     : await _walletService.addAccount(accountNameController.text, selectedProtocol.value!.code, usdtAddress.value);
    // if (future.item1) {
    //   UserService.to.getUserInfos();
    //   Get.back(result: true);
    //   AppUtils.showToast('add_success'.tr);
    // } else {
    //   var msg = future.item2;
    //   AppUtils.showToast(msg ?? 'add_failed'.tr);
    // }
  }

  //<editor-fold desc="获取接口传递参数">
  Map getParams() {
    return {
      "sid": usdtNeedPhone.value == 2 ? sid.value : sid.value,
      "name": accountNameController.text.trim(),
      "payment_type": PayType.trc20.code,
      "is_agent": 0,
      "address": usdtAddressController.text.trim(),
    };
  }

  //</editor-fold>

  Future<SecurityDataModel> loadSecurityDataAndOutput() async {
    final model = await securityService.loadSecurityData();
    securityData.value = model;
    usdtNeedPhone.value = model.usdtNeedPhone;
    return model;
  }

  Future<bool> postPhoneVerify(String phone) async {
    try {
      final response = await HttpClient.post(Api.accountBindStep1, data: {
        'phone': phone,
      });
      if (!response.status) {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: '手机号校验失败！');
        return false;
      }
      sid.value = response.data;
      return response.status;
    } catch (e) {
      sid.value = "";
      return false;
    }
  }

  Future<bool> accountBindStep2(String sid) async {
    final response = await HttpClient.post(Api.accountBindStep2, data: {
      'sid': sid,
    });
    if (!response.status) {
      AppUtils.showToast(
        nonEmptyMessageOr(
          response.message,
          defaultMessage: '操作未成功，请重试',
        ),
      );
      return response.status;
    }
    countdownSeconds.value = countdownTime;
    return response.status;
  }

  Future<bool> accountBindStep3(Map params) async {
    try {
      params["phone"] = "${selAreaCodeText.value}-${phoneController.text}";
      final response =
          await HttpClient.post(Api.accountBindStep3, data: params);
      if (!response.status) {
        AppUtils.showToastForResponse(response.message, ifEmpty: "验证失败");
      }
      return response.status;
    } catch (e) {}
    return false;
  }

  //添加Usdt地址
  void accountBindStep4() async {
    try {
      var params = {
        "sid": usdtNeedPhone.value == 2 ? sid.value : sid.value,
        "name": accountNameController.text.trim(),
        "payment_type": PayType.trc20.code,
        "is_agent": 0,
        "address": usdtAddressController.text.trim(),
      };
      print("发起请求:$params");

      final response = await HttpClient.post(
        Api.accountBindStep4,
        data: params,
      );
      if (response.status) {
        //添加成功
        AppUtils.showToast('添加成功');
        UserService.to.getUserInfos();
        Get.back(result: true);
      } else {
        AppUtils.showToastForResponse(response.message, ifEmpty: "添加失败");
      }
    } catch (e) {
      e.printError();
    }
  }

  void convertAreaAndPhone() {
    String phoneWithArea = UserService.to.state.userInfo.phone ?? "";
    var arr = phoneWithArea.split('-');
    if (arr.length > 1) {
      selAreaCodeText.value = arr[0].isNotEmpty ? arr[0] : '+86';
      phoneNumber.value = arr[1];
    } else {
      phoneNumber.value = arr[0];
    }
  }
}
