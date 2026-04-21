import 'dart:convert';
import 'dart:io';
import 'package:filbet/constants/constants.dart';
import 'package:filbet/http/entity/resp_widthdraw_method.dart';
import 'package:filbet/utils/payment_type.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart' as myDio;
import 'package:filbet/api/api.dart';
import 'package:filbet/common/encrypto_protocal.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/wallet_util.dart';
import 'package:filbet/widgets/picture_selestor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddAccountController extends GetXBaseController {
  RxInt countdownSeconds = 0.obs;
  final aliasController = TextEditingController();
  final nameController = TextEditingController();
  final accountController = TextEditingController();
  final phoneController = TextEditingController();
  final verifyController = TextEditingController();

  final PictureSelectorController pictureController =
      PictureSelectorController();

  final usdtAddressController = TextEditingController();

  final selAreaCodeText = '+86'.obs;
  RxString titleStr = ''.obs;

  RxString qrcodeUpload = ''.obs;

  // 错误状态管理
  RxBool isAliasError = false.obs;
  RxBool isNameError = false.obs;
  RxBool isAccountError = false.obs;
  RxBool isPhoneError = false.obs;
  RxBool isVerifyError = false.obs;

  // RxBool isPayPwdError = false.obs;
  RxBool isAddressError = false.obs;

  RxString aliasErrorText = "".obs;
  RxString nameErrorText = "".obs;
  RxString accountErrorText = "".obs;
  RxString phoneErrorText = "".obs;
  RxString verifyErrorText = "".obs;

  // RxString payPwdErrorText = "".obs;
  RxString addressErrorText = "".obs;
  RxString phoneNumber = "".obs;
  RxString usdtAddress = ''.obs;
  RxString realName = "".obs;
  final imageCount = 0.obs;

  RxString sid = "".obs;

  // final RxList<BlockChain> encryptoProtocalList = BlockChain.values.obs;
  // final Rxn<BlockChain> selectedProtocol = Rxn<BlockChain>(null);

  final methodList = <MethodModel>[].obs;
  final selectedMethod = Rxn<MethodModel>(null);

  final GlobalKey phoneContainerKey = GlobalKey();

  /// 支付宝账号：大陆手机 / 香港手机 / 邮箱
  static final RegExp _alipayAccountRegex = RegExp(
    r'^(?:\+?86)?1[3-9]\d{9}$|^(?:\+?852)?[4-9]\d{7}$|^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// 微信账号：大陆手机号
  static final RegExp _wechatAccountRegex = RegExp(r'^1[3-9]\d{9}$');

  @override
  void onInit() {
    super.onInit();
    convertAreaAndPhone();
    phoneController.text = phoneNumber.value;
    realName.value = UserService.to.state.userInfo.realName ?? "";
    _addListeners();
  }

  @override
  void onReady() {
    queryWithdrawTypeList();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    removeListeners();
  }

  void changeSelectedProtocol(int index) {
    selectedMethod.value = methodList[index];
  }

  void _addListeners() {
    aliasController.addListener(_onAliasChanged);
    nameController.addListener(_onNameChanged);
    accountController.addListener(_onAccountChanged);
    phoneController.addListener(_onPhoneChanged);
    verifyController.addListener(_onVerifyChanged);
    // payPwdController.addListener(_onPayPwdChanged);
    usdtAddressController.addListener(_usdtAddressChanged);
  }

  void removeListeners() {
    aliasController.removeListener(_onAliasChanged);
    nameController.removeListener(_onNameChanged);
    accountController.removeListener(_onAccountChanged);
    phoneController.removeListener(_onPhoneChanged);
    verifyController.removeListener(_onVerifyChanged);
    // payPwdController.removeListener(_onPayPwdChanged);
    usdtAddressController.removeListener(_usdtAddressChanged);
  }

  void _onAliasChanged() {
    final aliasText = aliasController.text.trim();
    if (aliasText.isEmpty) {
      isAliasError.value = true;
      aliasErrorText.value = '${'input_hint'.tr}${'alias'.tr}';
    }
    // else if (aliasText.length < 2) {
    //   isAliasError.value = true;
    //   aliasErrorText.value = '别名至少2位';
    // } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(aliasText)) {
    //   isAliasError.value = true;
    //   aliasErrorText.value = '别名只能包含英文或数字';
    // }
    else {
      isAliasError.value = false;
      aliasErrorText.value = "";
    }
  }

  void _onNameChanged() {
    final nameText = nameController.text.trim();
    if (nameText.isEmpty) {
      isNameError.value = true;
      nameErrorText.value = '${'input_hint'.tr}${'arrive_name'.tr}';
    } else {
      isNameError.value = false;
      nameErrorText.value = "";
    }
  }

  void _onAccountChanged() {
    final accountText = accountController.text.trim();
    if (accountText.isEmpty) {
      isAccountError.value = true;
      accountErrorText.value =
          selectedMethod.value?.paymentType == BlockChain.weChat_pay.code
              ? '${'input_hint'.tr}微信账号'
              : '请输入支付宝账户对应的手机号或邮箱';
      return;
    }
    if (selectedMethod.value?.paymentType == BlockChain.alipay.code) {
      if (!_alipayAccountRegex.hasMatch(accountText)) {
        isAccountError.value = true;
        accountErrorText.value = '请输入支付宝账户对应的手机号或邮箱';
        return;
      }
    } else if (selectedMethod.value?.paymentType ==
        BlockChain.weChat_pay.code) {
      if (!_wechatAccountRegex.hasMatch(accountText)) {
        isAccountError.value = true;
        accountErrorText.value = '请输入正确的微信账号';
        return;
      }
    }
    isAccountError.value = false;
    accountErrorText.value = "";
  }

  void _onPhoneChanged() {
    final phoneText = phoneController.text.trim();
    if (phoneText.isEmpty) {
      isPhoneError.value = true;
      phoneErrorText.value = '${'input_hint'.tr}${'phone_num'.tr}';
    } else {
      isPhoneError.value = false;
      phoneErrorText.value = "";
    }
  }

  void _onVerifyChanged() {
    final verifyText = verifyController.text.trim();
    if (verifyText.isEmpty) {
      isVerifyError.value = true;
      verifyErrorText.value = '${'input_hint'.tr}${'verity_code'.tr}';
    } else {
      isVerifyError.value = false;
      verifyErrorText.value = "";
    }
  }

  // void _onPayPwdChanged() {
  //   final payPwdText = payPwdController.text.trim();
  //   if (payPwdText.isEmpty) {
  //     isPayPwdError.value = true;
  //     payPwdErrorText.value = '${'input_hint'.tr}${'pay_pwd'.tr}';
  //   } else {
  //     isPayPwdError.value = false;
  //     payPwdErrorText.value = "";
  //   }
  // }

  void _usdtAddressChanged() {
    print("_usdtAddressChanged");
    final addressText = usdtAddressController.text.trim();
    if (addressText.isEmpty) {
      isAddressError.value = true;
      addressErrorText.value = '${'input_hint'.tr}${'pay_pwd'.tr}';
    } else {
      isAddressError.value = false;
      addressErrorText.value = "";
    }
    print("object123456 ${isAddressError.value}");
  }

  void validateAndSubmit() async {
    // 重置所有错误状态和错误消息
    isAliasError.value = false;
    isNameError.value = false;
    isNameError.value = false;
    isPhoneError.value = false;
    isVerifyError.value = false;
    // isPayPwdError.value = false;
    isAddressError.value = false;
    aliasErrorText.value = "";
    nameErrorText.value = "";
    accountErrorText.value = "";
    phoneErrorText.value = "";
    verifyErrorText.value = "";
    // payPwdErrorText.value = "";
    addressErrorText.value = "";
    // 验证所有输入框
    bool hasError = false;
    String? errorMessage;
    if (selectedMethod.value?.paymentType == BlockChain.alipay.code) {
      final aliasText = aliasController.text.trim();
      if (aliasText.isEmpty) {
        isAliasError.value = true;
        aliasErrorText.value = '${'input_hint'.tr}${'alias'.tr}';
        hasError = true;
        errorMessage = aliasErrorText.value;
      } else if (nameController.text.trim().isEmpty) {
        isNameError.value = true;
        nameErrorText.value = '${'input_hint'.tr}${'arrive_name'.tr}';
        hasError = true;
        errorMessage = nameErrorText.value;
      } else if (accountController.text.trim().isEmpty) {
        isAccountError.value = true;
        accountErrorText.value = '请输入支付宝账户对应的手机号或邮箱';
        hasError = true;
        errorMessage = accountErrorText.value;
      } else if (!_alipayAccountRegex.hasMatch(accountController.text.trim())) {
        isAccountError.value = true;
        accountErrorText.value = '请输入支付宝账户对应的手机号或邮箱';
        hasError = true;
        errorMessage = accountErrorText.value;
      } else if (phoneController.text.trim().isEmpty) {
        isPhoneError.value = true;
        phoneErrorText.value = '${'input_hint'.tr}${'phone_num'.tr}';
        hasError = true;
        errorMessage = phoneErrorText.value;
      } else if (verifyController.text.trim().isEmpty) {
        isVerifyError.value = true;
        verifyErrorText.value = '${'input_hint'.tr}${'verity_code'.tr}';
        hasError = true;
        errorMessage = verifyErrorText.value;
      }
      if (hasError) {
        if (errorMessage != null) {
          AppUtils.showToast(errorMessage);
        }
        return;
      }
      if (pictureController.files.isEmpty) {
        AppUtils.showToast("请上传二维码！");
        return;
      }
      var result = await addAlipay();
      if (result == true) {
        Get.back(result: true);
      }
    } else if (selectedMethod.value?.paymentType ==
        BlockChain.weChat_pay.code) {
      final aliasText = aliasController.text.trim();
      if (aliasText.isEmpty) {
        isAliasError.value = true;
        aliasErrorText.value = '${'input_hint'.tr}${'alias'.tr}';
        hasError = true;
        errorMessage = aliasErrorText.value;
      } else if (nameController.text.trim().isEmpty) {
        isNameError.value = true;
        nameErrorText.value = '${'input_hint'.tr}${'arrive_name'.tr}';
        hasError = true;
        errorMessage = nameErrorText.value;
      } else if (accountController.text.trim().isEmpty) {
        isAccountError.value = true;
        accountErrorText.value = '${'input_hint'.tr}微信账号';
        hasError = true;
        errorMessage = accountErrorText.value;
      } else if (!_wechatAccountRegex.hasMatch(accountController.text.trim())) {
        isAccountError.value = true;
        accountErrorText.value = '请输入正确的微信账号（11位大陆手机号）';
        hasError = true;
        errorMessage = accountErrorText.value;
      } else if (phoneController.text.trim().isEmpty) {
        isPhoneError.value = true;
        phoneErrorText.value = '${'input_hint'.tr}${'phone_num'.tr}';
        hasError = true;
        errorMessage = phoneErrorText.value;
      } else if (verifyController.text.trim().isEmpty) {
        isVerifyError.value = true;
        verifyErrorText.value = '${'input_hint'.tr}${'verity_code'.tr}';
        hasError = true;
        errorMessage = verifyErrorText.value;
      }
      if (hasError) {
        if (errorMessage != null) {
          AppUtils.showToast(errorMessage);
        }
        return;
      }
      if (pictureController.files.isEmpty) {
        AppUtils.showToast("请上传二维码！");
        return;
      }
      var result = await addAlipay();
      if (result == true) {
        Get.back(result: true);
      }
    } else {
      final aliasText = aliasController.text.trim();
      if (aliasText.isEmpty) {
        isAliasError.value = true;
        aliasErrorText.value = '${'input_hint'.tr}${'alias'.tr}';
        hasError = true;
        errorMessage = aliasErrorText.value;
      } else if (usdtAddressController.text.trim().isEmpty) {
        isAddressError.value = true;
        addressErrorText.value = '${'input_hint'.tr}${'address_label'.tr}';
        hasError = true;
        errorMessage = addressErrorText.value;
      } else if (phoneController.text.trim().isEmpty) {
        isPhoneError.value = true;
        phoneErrorText.value = '${'input_hint'.tr}${'phone_num'.tr}';
        hasError = true;
        errorMessage = phoneErrorText.value;
      } else if (verifyController.text.trim().isEmpty) {
        isVerifyError.value = true;
        verifyErrorText.value = '${'input_hint'.tr}${'verity_code'.tr}';
        hasError = true;
        errorMessage = verifyErrorText.value;
      }
      if (hasError) {
        if (errorMessage != null) {
          AppUtils.showToast(errorMessage);
        }
        return;
      }
      var result = await addAlipay();
      if (result == true) {
        Get.back(result: true);
      }
    }
  }

  Future<void> phoneVerify(String phone, String value) async {
    var resp = await ApiRequest.postPhoneVerify(value);
    if (resp) {
      String replacePhone = phone.replaceAll("****", value);
      sendSms(replacePhone, selAreaCodeText);
    }
  }

  Future<void> sendSms(phone, code) async {
    var resp = await ApiRequest.getSendBindCode(phone, code);
    if (resp == true) {
      AppUtils.showToast('code_send'.tr);
      countdownSeconds.value = countdownTime;
    }
  }

  Future<bool?> addAlipay() async {
    try {
      if (selectedMethod.value?.paymentType == BlockChain.alipay.code) {
        var isSuccessUpload =
            await alipayQrcodeUpload(pictureController.files.first) ?? false;
        if (!isSuccessUpload) {
          AppUtils.showToast("图片上传失败");
          return false;
        }

        Map params = getParams();
        params['code'] = verifyController.text.trim();
        var isSuccess = await accountBindStep3(params);
        if (!isSuccess) {
          return false;
        }

        final response = await HttpClient.post(
          Api.accountBindStep4,
          data: getParams(),
        );
        if (response.status) {
          //添加成功
          UserService.to.getUserInfos();
          AppUtils.showToast('添加成功');
        } else {
          AppUtils.showToastForResponse(response.message, ifEmpty: "添加失败");
        }
        return response.status;
      } else if (selectedMethod.value?.paymentType ==
          BlockChain.weChat_pay.code) {
        var isSuccessUpload =
            await alipayQrcodeUpload(pictureController.files.first) ?? false;
        if (!isSuccessUpload) {
          AppUtils.showToast("图片上传失败");
          return false;
        }

        Map params = getParams();
        params['code'] = verifyController.text.trim();
        var isSuccess = await accountBindStep3(params);
        if (!isSuccess) {
          return false;
        }
        final response = await HttpClient.post(
          Api.accountBindStep4,
          data: params,
        );
        if (response.status) {
          //添加成功
          UserService.to.getUserInfos();
          AppUtils.showToast('添加成功');
        } else {
          AppUtils.showToastForResponse(response.message, ifEmpty: "添加失败");
        }
        return response.status;
      } else {
        var params = {
          "sid": sid.value,
          "name": aliasController.text.trim(),
          "payment_type":
              selectedMethod.value?.paymentType ?? PayType.alipay.code,
          "address": usdtAddressController.text.trim(),
          "is_agent": 0,
        };
        params['code'] = verifyController.text.trim();
        var isSuccess = await accountBindStep3(params);
        if (!isSuccess) {
          return false;
        }

        final response = await HttpClient.post(
          Api.accountBindStep4,
          data: params,
        );
        if (response.status) {
          //添加成功
          UserService.to.getUserInfos();
          AppUtils.showToast('添加成功');
        } else {
          AppUtils.showToastForResponse(response.message, ifEmpty: "添加失败");
        }
        return response.status;
      }
    } catch (e) {
      e.printError();
      return null;
    }
  }

  Map getParams() {
    // 支付宝账号（手机号或邮箱）
    var addressParams = {
      "account_no": accountController.text,
    };

    return {
      "sid": sid.value,
      "name": aliasController.text.trim(),
      "real_name": nameController.text.trim(),
      "payment_type": selectedMethod.value?.paymentType ?? PayType.alipay.code,
      "address": jsonEncode(addressParams),
      "is_agent": 0,
    };
  }

  bool get isAddressValid {
    int paymentType = selectedMethod.value?.paymentType?.toInt() ?? 1;
    if (paymentType == BlockChain.bank_pay.code ||
        paymentType == BlockChain.alipay.code ||
        paymentType == BlockChain.weChat_pay.code) {
      return true;
    } else {
      return isSimplePayAddress(usdtAddress.value);
    }
  }

  String getWalletString() {
    return selectedMethod.value == null
        ? '添加钱包地址'
        : '添加${selectedMethod.value?.name}';
  }

  void updateImageCount() {
    imageCount.value = pictureController.files.length;
  }

  Future<bool?> alipayQrcodeUpload(File file, {bool isShowLoad = true}) async {
    try {
      // ⭐️ 先压缩
      final compressedFile = await compressImage(file);
      final formData = myDio.FormData.fromMap({
        "file": await myDio.MultipartFile.fromFile(
          compressedFile.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await HttpClient.post(
        Api.alipayQrcodeUpload,
        data: formData,
        options: myDio.Options(contentType: 'multipart/form-data'),
      );

      if (!response.status) {
        AppUtils.showToast("图片上传失败");
        return false;
      }

      var objectKey = response.data["object_key"] ?? "";
      var publicUrl = response.data["public_url"] ?? "";
      qrcodeUpload.value = "$publicUrl/$objectKey";

      return true;
    } catch (e) {
      e.printError();
      return null;
    }
  }

  Future<XFile> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // ⭐️ 60~80 最合适
      format: CompressFormat.jpeg,
    );
    return result!;
  }

  Future<bool> accountBindStep1(String phone) async {
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
        AppUtils.showToastForResponse(
            response.message, ifEmpty: "验证码错误");
      }
      return response.status;
    } catch (e) {}
    return false;
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

  void queryWithdrawTypeList() async {
    var result = await ApiRequest.queryWithdrawMethodList();
    methodList.value = result ?? [];
    titleStr.value = getWalletString();
    if (methodList.isNotEmpty) {
      methodList.removeWhere(
          (value) => value.paymentType == 1 || value.paymentType == 6);
      if (methodList.isNotEmpty) {
        initWithdrawMethod();
      }
    }
  }

  void initWithdrawMethod() {
    if (Get.arguments != null &&
        (Get.arguments as Map).containsKey("paymentType")) {
      int paymentType = Get.arguments["paymentType"];
      bool isFromWithdraw = false;
      if ((Get.arguments as Map).containsKey("isFromWithdraw")) {
        isFromWithdraw = (Get.arguments as Map).containsKey("isFromWithdraw");
      }
      selectedMethod.value = methodList
          .where((result) {
            return result.paymentType == paymentType;
          })
          .toList()
          .first;
      if (isFromWithdraw) {
        methodList.removeWhere((element) => element.paymentType != paymentType);
      } else {
        selectedMethod.value = methodList.first;
      }
    } else {
      selectedMethod.value = methodList.first;
    }
  }
}
