import 'dart:io';
import 'dart:ui';
import 'package:filbet/services/web_socket_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/generated/app_translations.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/controllers/activity_controller.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/home/app_version_model.dart';
import 'package:filbet/src/home/home_view_controller.dart';
import 'package:filbet/src/login/auth_service.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/src/upgrade/view.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/utils/device_util.dart';
import 'package:filbet/utils/fp.dart';
import 'package:filbet/utils/language_util.dart';
import 'package:filbet/widgets/select_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/http/exception_user_message.dart';
import 'package:filbet/http/http_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/widgets/loadinng_view.dart';

class SettingController extends GetXBaseController {
  UserService get userService => Get.find<UserService>();

  AuthService get authService => Get.find<AuthService>();

  static SettingController get to => Get.find();
  List<BottomSelectModel> languageList = [
    BottomSelectModel(
      title: "简体中文",
      imgUrl: Assets.languageChinese,
      keyValue: "zh_CN",
    ),
    // BottomSelectModel(
    //   title: "English",
    //   imgUrl: Assets.languageEnglish,
    //   keyValue: "en_US",
    // ),
    // BottomSelectModel(
    //   title: "Tiếng Việt",
    //   imgUrl: Assets.languageVietnamese,
    //   keyValue: "vi_VN",
    // ),
    BottomSelectModel(
      title: "繁体中文",
      imgUrl: Assets.languageChinese,
      keyValue: "zh_TW",
    ),
  ];
  RxString version = "".obs;
  RxDouble size = 0.0.obs;
  RxBool isUpdate = false.obs;

  ///选中的语言模型 后续需要根据当前环境设置默认的语言
  late Rx<BottomSelectModel> selectLanguageModel;

  @override
  void onInit() {
    super.onInit();
    config();
    getCacheSize();

    _getAppVersion();

    ///获取 看持久化是否有保存code 没有的话默认当前的locale->还是没有就是设备的locale
    String currentLangCode = SpStorage.getAppLocalLanguage();
    if (currentLangCode.isEmpty) {
      currentLangCode = "zh_CN";
    }
    for (var element in languageList) {
      if (element.keyValue == currentLangCode) {
        selectLanguageModel = element.obs;
        break;
      }
    }
  }

  /// 获取缓存大小（MB）
  Future<double> getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory(); // 缓存目录
    double totalSize = await _getTotalSizeOfFilesInDir(tempDir);
    size.value = totalSize;
    update();
    return totalSize;
  }

  Future<double> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return length / (1024 * 1024); // 转换成 MB
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      for (final child in children) {
        total += await _getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  Future<void> clearCache() async {
    _showLoginDialog();
  }

  Future<void> _clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }

    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    size.value = 0.0;

    AppUtils.showToast("clearSuccess".tr);
    update();
  }

  void _showLoginDialog() {
    Get.dialog(SkBaseDialog(
      callback: () {
        Get.back();
        _clearCache();
      },
      cancelCallback: () {},
      title: "tips".tr,
      showFooterBtn: true,
      showDeleteBtn: false,
      showDeleteBtnType: '1',
      rightBtnTitle: "confirm".tr,
      leftBtnTitle: "cancel".tr,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "confirmClearCache".tr,
          style:
              TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
        ),
      ),
    ));
  }

  config() async {
    version.value = AppEnvConfig.instance.version;
  }

  ///选择语言
  void selectLanguage() {
    Get.bottomSheet(
      SelectBottomSheet(
        stypeType: 1,
        itemList: languageList,
        onValueChanged: (model) {
          selectLanguageModel.value = model;

          if (model.keyValue != null) {
            List<Locale> supportedLocales = AppTranslations.supportedLocales;

            Locale element = resolveLocale(model.keyValue!, supportedLocales);

            Get.updateLocale(element);
            SpStorage.updateAppLocalLanguage(model.keyValue!);

            Future.delayed(const Duration(milliseconds: 250), () {
              //强制触发 build

              GlobalService.to.state.language =
                  Language.fromAbbr(model.keyValue!);
              Get.forceAppUpdate();
              HomeViewController.to.homeRefresh();
              GlobalService.to.memberIndex();
              GlobalService.to.customerService();
              if (Get.isRegistered<ActivityController>()) {
                Get.find<ActivityController>().getPromoTypeData();
              }
            });
          }
        },
        selectedItem: selectLanguageModel.value,
        title: 'choose_lang'.tr,
      ),
      isScrollControlled: true,
    );
  }

  Locale resolveLocale(String languageKey, List<Locale> supportedLocales) {
    // 1) 规范化：vi-VN / vi_VN / VI_vn -> vi_VN
    final norm = languageKey.trim().replaceAll('-', '_');
    final parts = norm.split('_');
    String lang = parts[0].toLowerCase();
    String? country = parts.length > 1 ? parts[1].toUpperCase() : null;

    // 2) 先精确匹配 语言+地区
    for (final loc in supportedLocales) {
      final lc = loc.languageCode.toLowerCase();
      final cc = (loc.countryCode ?? '').toUpperCase();
      if (lc == lang && (country == null || country == cc)) {
        return loc;
      }
    }

    // 3) 退化：仅按语言匹配
    for (final loc in supportedLocales) {
      if (loc.languageCode.toLowerCase() == lang) {
        return loc;
      }
    }

    return Locale("zh", "CN"); // 找不到就返回 null，由调用方决定 fallback
  }

  ///退出登录
  void logOut() async {
    try {
      await authService.logout();
      await userService.logout();
      WebSocketService c = Get.put(WebSocketService());
      c.closeConnect();
      AppNavigator.startMain();
    } catch (e) {
      Get.snackbar('error'.tr, exceptionMessageForUser(e));
    }
  }

  void getAppVersion() async {
    await fetchHandler<AppVersionModel?>(
      _versionListService(),
      onSuccess: (response) async {
        if (response != null) {
          upDateShow(response);
        }
      },
      onError: (exception) {},
      loading: true,
    );
  }

  void _getAppVersion() async {
    await fetchHandler<AppVersionModel?>(
      _versionListService(),
      onSuccess: (response) async {
        if (response != null) {
          if (haveNewVersion(
              response.version ?? '', AppEnvConfig.instance.version)) {
            isUpdate.value = true;
          } else {
            isUpdate.value = false;
          }
        }
      },
      onError: (exception) {},
      loading: false,
    );
  }

  Future<AppVersionModel?> _versionListService() async {
    if (DeviceUtil.getDeviceOS().isNotEmpty) {
      var response = await HttpClient.get(Api.versionList, queryParameters: {
        "client_type": DeviceUtil.getDeviceOS() == "ios" ? "27" : "26"
      });
      if (response.status == false) {
        throw response.error!;
      }
      List<dynamic> rawList = response.data["d"] ?? [];
      List<AppVersionModel> list = rawList
          .map((e) => AppVersionModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return list.firstOrNull;
    }
    return null;
  }

  void upDateShow(AppVersionModel appVersion) async {
    String updateContent = "";
    switch (LanguageUtils.switchLanguage()) {
      case "en_US":
        updateContent = appVersion.updateAnnouncementEn ?? '';
      case "vi_VN":
        updateContent = appVersion.updateAnnouncementVn ?? '';
      default:
        updateContent = appVersion.updateAnnouncementZh ?? '';
    }

    if (haveNewVersion(
        appVersion.version ?? '', AppEnvConfig.instance.version)) {
      SmartDialog.show(
          clickMaskDismiss: false,
          backDismiss: false,
          alignment: Alignment.center,
          tag: "UpdataEntity",
          builder: (_) {
            return UpgradePage(
              entity: UpdataEntity(
                  versionCode: appVersion.version ?? '',
                  isForceUpdate: appVersion.isForceUpdate,
                  downloadUrl: appVersion.packageUrl,
                  updateContent: updateContent),
            );
          });
    } else {
      AppUtils.showToast("已经最新版本".tr);
    }
  }

  bool haveNewVersion(String newVersion, String old) {
    if (newVersion.isEmpty || old.isEmpty) {
      return false;
    }
    int newVersionInt, oldVersion;
    var newList = newVersion.split('.');
    var oldList = old.split('.');
    if (newList.isEmpty || oldList.isEmpty) {
      return false;
    }
    for (int i = 0; i < newList.length; i++) {
      newVersionInt = int.parse(newList[i]);
      oldVersion = int.parse(oldList[i]);
      if (newVersionInt > oldVersion) {
        return true;
      } else if (newVersionInt < oldVersion) {
        return false;
      }
    }

    return false;
  }
}
