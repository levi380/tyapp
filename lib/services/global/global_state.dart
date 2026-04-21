
import 'package:filbet/common/currency.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/home/homegame_model.dart';

import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/src/home/platform_name_model.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'global_service.dart';

class GlobalState {
  final RxList<BannerItem> homeBanners = RxList.empty();

  final Rxn<SplashModel> splashModel = Rxn<SplashModel>();

  // 首页所有游戏列表
  final RxList<VenueModel> allGameConfig = RxList.empty();
  // 语言

  final RxList<NoticeModel> marqueeNotice = RxList.empty();

  final RxList<CategoryModel> allCategoryConfig = RxList.empty();

  final RxList<PlatFormNameModel> allPlatformNameConfig = RxList.empty();

  final RxMap<int, bool> categoryStatus = initCategoryStatus().obs;
  RxList<ServiceModel> serviceList = <ServiceModel>[].obs;

  final RxString installQuery = ''.obs;
//  final RxString installQueryTest = ''.obs;

  final RxList<Currency> currencyConfig = RxList.empty();
  //

  final Map<int, String> playIconAssets = {
    106: Assets.homeIconPa,
    321: Assets.homeIconPa,
    107: Assets.homeIconDb,
    404: Assets.homeIconDb,
    322: Assets.homeIconDb,
    509: Assets.homeIconDb,
    323: Assets.homeIconUu,
  };

  // 语言
  // 默认语言为中文
  final Rx<Language> _language = Rx(Language.zh_cn);
  set language(Language value) => _language.value = value;
  Language get language => _language.value;
}
