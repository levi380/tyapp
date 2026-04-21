import 'dart:io';

import 'package:filbet/api/api.dart';
import 'package:filbet/common/currency.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/base_service.dart';
import 'package:filbet/services/global/global_state.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/http/http_response.dart' as myResponse;
import 'package:filbet/src/home/platform_name_model.dart';
import 'package:filbet/utils/common_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'package:filbet/generated/assets.dart';
import 'dart:convert';
import 'package:filbet/utils/base_util.dart';

enum CategoryType {
  video(1, "视讯"),
  fishing(2, "捕鱼"),
  slot(3, "老虎机"),
  sport(4, "体育"),
  qp(5, "棋牌"),
  entertainment(6, "娱乐"),
  lottery(7, "彩票"),
  dj(8, "电竞");

  final int id;
  final String title;

  const CategoryType(this.id, this.title);

  /// 根据 id 获取枚举
  static CategoryType? fromId(int id) {
    try {
      return CategoryType.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null; // 找不到返回 null
    }
  }
}

Map<int, bool> initCategoryStatus({bool defaultValue = true}) {
  return {
    for (var type in CategoryType.values) type.id: defaultValue,
  };
}

class GlobalService extends BaseService {
  final GlobalState state = GlobalState();

  static GlobalService get to => Get.find();

  Future<GlobalService> init() async {
    debugPrint('GlobalService init');

    try {
      // 初始化语言
      state.language = SpStorage.getAppLocalLanguage() == null
          ? Language.zh_cn
          : Language.fromAbbr(SpStorage.getAppLocalLanguage());

      // 并行请求，避免互相阻塞
      await Future.wait([
        getHomeNewGames()
            .catchError((e) => debugPrint("getHomeGames error: $e")),
        getHomeGames().catchError((e) => debugPrint("getHomeGames error: $e")),
        memberIndex().catchError((e) => debugPrint("memberIndex error: $e")),
        currencystatus()
            .catchError((e) => debugPrint("currencystatus error: $e")),
        customerService(),
      ]);
    } catch (e, s) {
      debugPrint("GlobalService init fatal error: $e\n$s");
    }
    return this;
  }

  /// 币种状态
  Future<void> currencystatus() async {
    try {
      await fetchHandler<List<Currency>>(
        _currencystatus(),
        onSuccess: (response) {
          if (response.isNotEmpty) {
            state.currencyConfig
              ..clear()
              ..addAll(response);
          }
        },
        onError: (e) => debugPrint("currencystatus error: $e"),
      );
    } catch (e) {
      debugPrint("currencystatus fatal error: $e");
    }
  }

  Future<List<Currency>> _currencystatus() async {
    try {
      return [Currency.rmb];
//       final response = await HttpClient.get(Api.currencystatus);
//
//       if (response.status == false) {
//         return [Currency.rmb];
//       }
//
//       List<Currency> list = [];
//
//       if (response.data["d"] == null)
//         return [Currency.usd];
//       else {
//         // for (var item in response.data["d"]) {
//         //   if (item["status"] == 1)
//
//         //      item["sort"] = ;
//
//         //     list.add(Currency.fromCodeInt(item["currency"]));
//         // }
//
//         final rawList = response.data["d"] as List;
//
// // 只取 status == 1 的，并按 sort 降序排列
//         final filtered = rawList.where((item) => item["status"] == 1).toList()
//           ..sort((a, b) => (b["sort"] as int).compareTo(a["sort"] as int));
//
//         list = filtered
//             .map((item) => Currency.fromCodeInt(item["currency"]))
//             .toList();
//       }
//
//       if (list.isEmpty) list.add(Currency.usd);
//
//       return list;
    } catch (e) {
      debugPrint("_currencystatus error: $e");
      return [Currency.rmb];
    }
  }

  Future<void> click(String platform_id, int game_type) async {
    var response = await HttpClient.get(Api.platformClick, queryParameters: {
      "platform_id": platform_id ?? "",
      "game_type": game_type.toString(),
    });
    if (response.status == false) {
      throw response.error!;
    }
  }

  /// 首页刷新
  Future<void> homeRefresh() async {
    try {
      await Future.wait([
        memberIndex()
            .catchError((e) => debugPrint("homeRefresh memberIndex error: $e")),
        getHomeNewGames().catchError(
            (e) => debugPrint("homeRefresh getHomeGames error: $e")),
        getHomeGames().catchError(
            (e) => debugPrint("homeRefresh getHomeGames error: $e")),
        currencystatus().catchError(
            (e) => debugPrint("homeRefresh currencystatus error: $e")),
      ]);
      Get.engine.performReassemble();
    } catch (e) {
      debugPrint("homeRefresh fatal error: $e");
    }
  }

  Future<List<CategoryModel>> platformList() async {
    try {
      final response = await HttpClient.post(Api.platformList);

      if (response.status == false) return [];

      List<dynamic> rawList = response.data["d"] ?? [];
      return rawList
          .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      debugPrint("platformList error: $e");
      return [];
    }
  }

  Future<List<PlatFormNameModel>> platformListNew() async {
    try {
      final response = await HttpClient.get(
        Api.platformListNew,
      );

      if (response.status == false) return [];
      List<dynamic> newDatas = [];
      for (var element in response.data.keys) {
        newDatas.add({"id": element, "name": response.data[element]});
      }

      return newDatas
          .map((e) => PlatFormNameModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      debugPrint("platformList error: $e");
      return [];
    }
  }

  /// 首页游戏
  Future<void> getHomeGames() async {
    try {
      await fetchHandler<List<CategoryModel>>(
        platformList(),
        onSuccess: (response) {
          state.allCategoryConfig.clear();
          state.allCategoryConfig.addAll(response);

          final allVenues = mergeAllVenues(response);
          state.allGameConfig.clear();
          state.allGameConfig.addAll(allVenues);
        },
        onError: (e) => debugPrint("getHomeGames error: $e"),
      );
    } catch (e) {
      debugPrint("getHomeGames fatal error: $e");
    }
  }

  /// 首页游戏新街口
  Future<void> getHomeNewGames() async {
    try {
      await fetchHandler<List<PlatFormNameModel>>(
        platformListNew(),
        onSuccess: (response) {
          state.allPlatformNameConfig.clear();
          state.allPlatformNameConfig.addAll(response);
          print(
              'platform list length = ${GlobalService.to.state.allPlatformNameConfig.length}');
        },
        onError: (e) => debugPrint("getHomeGames error: $e"),
      );
    } catch (e) {
      debugPrint("getHomeGames fatal error: $e");
    }
  }

  List<VenueModel> mergeAllVenues(List<CategoryModel> categories) {
    final List<VenueModel> all = [];
    for (var category in categories) {
      if (category.venues != null) {
        all.addAll(category.venues!);
      }
    }
    // for (var category in categories) {
    //   if (category.id == 8) {
    //     var item1 = VenueModel(
    //         id: '-1', gameId: '-1', logo: Assets.emptyEmptyGameItem1);
    //     var item2 = VenueModel(
    //         id: '-1', gameId: '-1', logo: Assets.emptyEmptyGameItem2);
    //     var item3 = VenueModel(
    //         id: '-1', gameId: '-1', logo: Assets.emptyEmptyGameItem3);
    //     category.venues = [item1, item2, item3];
    //     all.addAll(category.venues!);
    //   }
    // }
    return all;
  }

  /// 首页配置
  Future<void> memberIndex() async {
    try {
      final response = await HttpClient.get(Api.membermindex);

      if (response.status == false) {
        SpStorage.removeSplashModel();
        return;
      }

      final json = Map<String, dynamic>.from(response.data);
      final appModel = AppConfigModel.fromJson(json);

      // 处理开屏广告
      await _handleSplashAds(appModel.loading).catchError((e) {
        debugPrint("splash error: $e");
      });

      // 轮播图 & 跑马灯
      _handleBanner(appModel.banner);
//      _handleMarquee(appModel.marqueeNotice);
    } catch (e, s) {
      debugPrint("memberIndex fatal error: $e\n$s");
    }
  }

  /// 开屏广告
  Future<void> _handleSplashAds(List<SplashModel>? loadingList) async {
    if (loadingList == null || loadingList.isEmpty) {
      SpStorage.removeSplashModel();
      return;
    }

    final splashModel = loadingList.first;
    final splashImages = splashModel.getImageUrlsForDevice();

    if (splashImages.isEmpty) {
      print("object123456 1");
      SpStorage.removeSplashModel();
      return;
    }

    try {
      final results = await Future.wait(
        splashImages.map((url) => _downloadSplashImage(url)),
      ).timeout(const Duration(seconds: 5));

      final allSuccess = results.every((path) => path.isNotEmpty);
      if (!allSuccess) {
        return;
      }
      state.splashModel.value = splashModel;
      print("object123456 2234567");
      SpStorage.setSplashModel(splashModel);
    } catch (e) {
      debugPrint("_handleSplashAds error: $e");
    }
  }

  Future<String> _downloadSplashImage(String url) async {
    try {
      final filename = extractFilename(url);
      final savePath = await getSplashImageSavePath(filename);
      final file = File(savePath);

      if (await file.exists()) return savePath;

      await HttpClient.downloadImage(staticImageurl(url), savePath);
      return savePath;
    } catch (e) {
      debugPrint("_downloadSplashImage error: $e");
      return '';
    }
  }


  void _handleBanner(List<BannerItem>? bannerList) {
    if (bannerList == null || bannerList.isEmpty) return;
    state.homeBanners
      ..clear()
      ..addAll(bannerList);
  }

  // void _handleMarquee(List<NoticeModel>? marqueeList) {
  //   if (marqueeList == null || marqueeList.isEmpty) return;
  //   state.allNotice
  //     ..clear()
  //     ..addAll(marqueeList);
  // }

  Future<ServiceModel?> customerService() async {
    try {
      var response = await HttpClient.get(Api.customerservice);
      if (response.status == false) {
        return null;
      }

      List row = response.data["ways"] ?? [];
      List third_partys = response.data["third_partys"] ?? [];

      state.serviceList.clear();
      if (row.isEmpty) {
      } else {
        state.serviceList.value = row.map((e) {
          return ServiceModel(
              image: e["icon"],
              name: getText(e),
              content: getmumber(e),
              type: "1",
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
        state.serviceList.addAll(thirdmodel);
      }
      return null;
    } catch (e) {}
    return null;
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

    final data = jsonDecode(e["desc"] ?? "");
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

    final data = jsonDecode(e["number"]);
    if (data is Map) {
      return data[language];
      // 这里才可以当 Map 用
    }

    return "";
  }
}

class PayoutRecord {
  int? currency; // 币种编号（例如 101=RMB, 102=USD...）
  String? payoutAmount; // 派彩金额
  String? username; // 用户名（部分脱敏）

  PayoutRecord({
    this.currency,
    this.payoutAmount,
    this.username,
  });

  /// JSON -> 对象
  factory PayoutRecord.fromJson(Map<String, dynamic> json) {
    return PayoutRecord(
      currency: json['currency'],
      payoutAmount: json['payout_amount'],
      username: json['username'],
    );
  }

  /// 对象 -> JSON
  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'payout_amount': payoutAmount,
      'username': username,
    };
  }
}

extension GlobalServiceExtension on GlobalService {
  String extractFilename(String url) {
    return url.split('/').last;
  }
}
