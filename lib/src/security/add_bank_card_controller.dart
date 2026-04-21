import 'dart:convert';

import 'package:filbet/api/api.dart';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/deposit/wallet_service.dart';
import 'package:filbet/src/security/Address_provinces_model.dart';
import 'package:filbet/src/security/Bank_list_model.dart';
import 'package:filbet/src/security/address_areas_model.dart';
import 'package:filbet/src/security/address_cities_model.dart';
import 'package:filbet/src/security/security_service.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/credential_validate_util.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tuple/tuple.dart';

class AddBankCardController extends GetXBaseController {
  final SecurityService _securityService = Get.find<SecurityService>();

  String realName = "";
  String phone = "";

  TextEditingController walletNameController = TextEditingController();
  TextEditingController addBankCardController = TextEditingController();
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputPhoneController = TextEditingController();
  TextEditingController inputSmsCodeController = TextEditingController();
  TextEditingController paymentPasswordController = TextEditingController();

  late final FocusNode walletNameFocusNode = FocusNode();
  late final FocusNode addBankCardFocusNode = FocusNode();
  late final FocusNode inputNameFocusNode = FocusNode();
  late final FocusNode inputPhoneFocusNode = FocusNode();
  late final FocusNode inputSmsCodeFocusNode = FocusNode();
  late final FocusNode paymentPasswordFocusNode = FocusNode();

  Rx<BankListModel?> selBankCard = Rx<BankListModel?>(null);
  Rx<AddressProvincesModel?> selAddressProvinces = Rx<AddressProvincesModel?>(null);
  Rx<AddressCitiesModel?> selAddressCities = Rx<AddressCitiesModel?>(null);
  Rx<AddressAreasModel?> selAddressAreas = Rx<AddressAreasModel?>(null);

  final Rx<String> walletNameText = ''.obs;
  final Rx<String> addBankCardText = ''.obs;
  final Rx<String> inputNameText = ''.obs;
  final Rx<String> inputPhoneText = ''.obs;
  final Rx<String> smsCodeText = ''.obs;
  final Rx<String> selAreaCodeText = ''.obs;
  final Rx<String> paymentPasswordText = ''.obs;

  final RxList<AddressProvincesModel> addressProvinces = <AddressProvincesModel>[].obs;
  final RxList<AddressCitiesModel> addressCities = <AddressCitiesModel>[].obs;
  final RxList<AddressAreasModel> addressAreas = <AddressAreasModel>[].obs;
  final RxList<BankListModel> bankList = <BankListModel>[].obs;
  final RxList<String> countryCodeList = <String>[].obs;

  final WalletService _walletService = WalletService();

  final countdownSeconds = 0.obs;

  bool get checkBankCardInfo {
    return selBankCard.value != null &&
        selAddressProvinces.value != null &&
        // selAddressCities.value != null && todo
        // selAddressAreas.value != null &&
        addBankCardText.value.isNotEmpty &&
        !isAddBankCardInputError;
  }

  bool get isAddBankCardInputError {
    if (addBankCardText.value.isEmpty) {
      return false;
    }
    if (addBankCardText.value.length < 13 || addBankCardText.value.length > 19) {
      return true;
    } else {
      return !RegExp(r'^\d+$').hasMatch(addBankCardText.value);
    }
  }

  bool get isOriginalPaymentPasswordValid {
    if (paymentPasswordText.value.isEmpty) {
      return true;
    }
    return paymentPasswordStringValidate(paymentPasswordText.value).every((element) => element.item2);
  }

  @override
  void onInit() {
    super.onInit();
    walletNameController.addListener(() {
      walletNameText.value = walletNameController.text;
    });
    inputNameController.addListener(() {
      inputNameText.value = inputNameController.text;
    });

    addBankCardController.addListener(() {
      addBankCardText.value = addBankCardController.text;
    });
    inputPhoneController.addListener(() {
      inputPhoneText.value = inputPhoneController.text;
    });
    inputSmsCodeController.addListener(() {
      smsCodeText.value = inputSmsCodeController.text;
    });

    paymentPasswordController.addListener(() {
      paymentPasswordText.value = paymentPasswordController.text;
    });
  }

  @override
  void onReady() {
    super.onReady();
    getBankList();
    getProvinces();
    getCountryCodeList();
  }

  @override
  void dispose() {
    super.dispose();
    clearInput();
  }

  void onDispose() {
    walletNameFocusNode.unfocus();
    addBankCardFocusNode.unfocus();
    inputNameFocusNode.unfocus();
    inputPhoneFocusNode.unfocus();
    inputSmsCodeFocusNode.unfocus();
    paymentPasswordFocusNode.unfocus();
  }

  clearInput() {
    walletNameController.text = "";
    addBankCardController.text = "";
    inputNameController.text = "";
    inputPhoneController.text = "";
    inputSmsCodeController.text = "";
    paymentPasswordController.text = "";
  }

  void getBankList() async {
    await fetchHandler(
      _securityService.getBankList(),
      onSuccess: (model) {
        bankList.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  void getProvinces() async {
    await fetchHandler(
      _securityService.getAddressProvinces(),
      onSuccess: (model) {
        addressProvinces.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  void getCities(String provinceCode) async {
    await fetchHandler(
      _securityService.getAddressCities(provinceCode),
      onSuccess: (model) {
        addressCities.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  void getAreas(String cityCode) async {
    await fetchHandler(
      _securityService.getAddressAreas(cityCode),
      onSuccess: (model) {
        addressAreas.value = model;
      },
      onError: toastError,
      loading: true,
    );
  }

  Future<void> getSendBindCode() async {
    if (phone.isNotEmpty) {
      Get.bottomSheet(
        SKBottomSheet(
          top: 24.h,
          left: 16.w,
          title: 'safe_verify'.tr,
          content: BottomSafeVerify(
            phoneNum: phone,
            onConfirm: (value) {
              if (Get.isBottomSheetOpen ?? false) {
                Get.back();
              }
              phoneVerify(value);
            },
          ),
        ),
        isScrollControlled: true,
      );
    } else {
      if (inputPhoneController.text.isEmpty) {
        AppUtils.showToast('请输入手机号');
        return;
      }
      sendSms(inputPhoneController.text, "86");
    }
  }

  Future<void> sendSms(phone, code) async {
    await fetchHandler(
      _securityService.getSendBindCode(phone, code),
      onSuccess: (model) {
        if (model) {
          //发送成功
          countdownSeconds.value = countdownTime;
          countdownSeconds.refresh();
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  // member/security/phone/verify
  Future<void> phoneVerify(value) async {
    await fetchHandler(
      _securityService.postPhoneVerify(value),
      onSuccess: (model) {
        if (model) {
          //发送成功
          String replacePhone = phone.replaceAll("****", value);
          print("replacePhone ${replacePhone}");
          sendSms(replacePhone, "86");
        }
      },
      onError: toastError,
      loading: true,
    );
  }

  void getCountryCodeList() async {
    await fetchHandler(
      _securityService.getCountryCodeList(),
      onSuccess: (model) {
        countryCodeList.value = model;
        selAreaCodeText.value = model.last;
      },
      onError: toastError,
      loading: true,
    );
  }

  //添加银行卡
  addBank() async {
    try {
      if (!validateParams()) {
        return;
      }

      var addressParams = {
        "account_name": inputNameText.value,
        "account_no": addBankCardText.value,
        "province": selAddressProvinces.value?.code,
        "city": selAddressCities.value?.code,
        "area": selAddressAreas.value?.code,
        "phone": phone.isNotEmpty ? phone : inputPhoneText.value,
        "img": selBankCard.value?.img ?? "",
        "name": selBankCard.value?.name ?? "",
        "id": selBankCard.value?.id ?? "",
      };
      var params = {
        "name": walletNameController.text,
        "payment_type": 6,
        "address": jsonEncode(addressParams),
        "withdrawal_password": paymentPasswordText.value,
        "sec_code": smsCodeText.value,
      };
      print("发起请求:$params");
      final response = await HttpClient.post(
        Api.accountAdd,
        data: params,
      );
      if (response.status) {
        //添加成功
        AppUtils.showToast('添加成功');
        Get.back();
      } else {
        AppUtils.showToastForResponse(
        response.message, ifEmpty: "添加失败");
      }
    } catch (e) {
      e.printError();
    }
  }

  bool validateParams() {
    if (walletNameText.value.isEmpty) {
      AppUtils.showToast('请输入钱包名称');
      return false;
    }

    // 校验姓名（如果之前没填）
    if (realName.isEmpty && inputNameText.isEmpty) {
      AppUtils.showToast('请输入持卡人姓名');
      return false;
    }

    // 校验手机号（如果之前没填）
    if (phone.isEmpty && inputPhoneText.value.isEmpty) {
      AppUtils.showToast('请输入手机号');
      return false;
    }

    if (smsCodeText.isEmpty) {
      AppUtils.showToast('请输入验证码');
      return false;
    }
    if (addBankCardText.isEmpty) {
      AppUtils.showToast('请输入银行卡号');
      return false;
    }

    if (selBankCard.value == null) {
      AppUtils.showToast('请选择开户银行');
      return false;
    }

    if (selAddressProvinces.value == null) {
      AppUtils.showToast('请选择省');
      return false;
    }

    if (selAddressCities.value == null) {
      AppUtils.showToast('请选择市');
      return false;
    }
    if (paymentPasswordText.value.isEmpty) {
      AppUtils.showToast('input_pay_pwd'.tr);
      return false;
    }

    return true;
  }
}
