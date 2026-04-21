import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'game_item.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/routes/app_navigator.dart';

import 'package:filbet/src/game/gameinit/VenueSwitchSheet.dart';
import 'package:filbet/src/game/gameinit/guideOverlay.dart';

import 'package:filbet/src/home/homegame_model.dart';

class GameListController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static GameListController get to {
    final args = Get.arguments;
    final id = args?['platform_id'] ?? '';
    print('[GameListController.to] args=' +
        (args?.toString() ?? 'null') +
        ' id=' +
        id.toString() +
        ' type=' +
        id.runtimeType.toString() +
        ' registered=' +
        Get.isRegistered<GameListController>(tag: id).toString());
    return Get.find<GameListController>(tag: id);
  }

  String? platform_id;
  String? venue_id;

  Map<String, dynamic> params = {};
  int pageNum = 1;
  int pageSize = 20;
  RxInt total = 0.obs;
  String? title;

  int currencyint = 101;
  CategoryType? categoryType;
  RxInt hottotal = 0.obs;
  late TabController tabController;
  final RxList typeList = [
    'all_games_num'.tr.replaceAll('{m}', ""),
    'reco_games_num'.tr.replaceAll('{m}', ""),
    'fav_games_num'.tr.replaceAll('{m}', ""),
  ].obs;

  final RxList<GameInfoModel> records = RxList.empty();
  final RxList<GameInfoModel> hotrecords = RxList.empty();
  // bool showGuide =
  RxBool showGameVenue = false.obs;
  RxBool showGuide = false.obs;
  RxList<GameInfoModel> favgames = RxList.empty();

  @override
  void onInit() {
    super.onInit();

    showGuide.value = UserService.to.state.userInfo.guide ?? false;
    if (Platform.isAndroid) {}
    if (Get.arguments is Map) {
      platform_id = Get.arguments["platform_id"];
      venue_id = Get.arguments["venue_id"];
      title = Get.arguments["title"];
      categoryType = Get.arguments["type"];
    }
    print('[GameListController.onInit] platform_id=' +
        (platform_id?.toString() ?? 'null') +
        ' venue_id=' +
        (venue_id?.toString() ?? 'null') +
        ' title=' +
        (title?.toString() ?? 'null') +
        ' type=' +
        (categoryType?.toString() ?? 'null'));
    tabController = TabController(length: typeList.length, vsync: this);
    ever<List>(favgames, (_) => _syncFavStatus());
  }

  _syncItemFavStatus(List<GameInfoModel> sgames) {
    for (var game in sgames) {
      game.fav = favgames.contains(game);
    }

    return sgames;
  }

  void _syncFavStatus() {
    _syncItemFavStatus(records);

    _syncItemFavStatus(hotrecords);

    update();
  }

  @override
  void onReady() async {
    super.onReady();

    fetchListDataloading();
    getfavList();
    fetchhotListData(1);

    // showdGuideDialog();
    // fetchListData(1);
  }

  Future<void> fetchListDataloading() async {
    await fetchHandler(
      fetchListData(1),
      onSuccess: (token) async {},
      onError: (exception) {},
      loading: true,
    );
  }

  fetchListData(int? pageNum, {Function(bool hasMore)? onSuccess}) async {
    try {
      var response = await HttpClient.get(Api.gameList, queryParameters: {
        "page": pageNum,
        "page_size": 10,
        "game_type": 0,
        "is_hot": 0,
        "platform_id": platform_id ?? "",
        "venue_id": venue_id ?? "",
        // "currency": currencyint
      });
      if (response.status == false) {}

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<GameInfoModel> transactions = rawList
          .map((e) => GameInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (pageNum! > 1) {
        records.addAll(transactions);
      } else {
        total.value = response.data["t"] ?? 0;
        records.value = transactions;
        typeList.first = 'all_games_num'.tr.replaceAll('{m}', "$total");
      }

      update();

      bool hasMore = pageNum! * 10 < total.value;

      onSuccess?.call(hasMore);
    } catch (e) {
      e.printError();
    }
  }

  fetchhotListData(int? pageNum, {Function(bool hasMore)? onSuccess}) async {
    try {
      var response = await HttpClient.get(Api.gameList, queryParameters: {
        "page": pageNum,
        "page_size": 10,
        "game_type": 0,
        "is_hot": 1,
        "platform_id": platform_id ?? "",
        "venue_id": venue_id ?? "",
        // "currency": currencyint
      });
      if (response.status == false) {
        update();

        return;
      }

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<GameInfoModel> transactions = rawList
          .map((e) => GameInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (pageNum! > 1) {
        hotrecords.addAll(transactions);
      } else {
        hottotal.value = response.data["t"] ?? 0;
        hotrecords.value = transactions;
        typeList[1] = 'reco_games_num'.tr.replaceAll('{m}', "$hottotal");
      }

      update();

      bool hasMore = pageNum! * 10 < hottotal.value;

      onSuccess?.call(hasMore);
    } catch (e) {
      e.printError();
    }
  }

  fetchData(int? pageNum, {Function(bool hasMore)? onSuccess}) async {
    if (tabController.index == 0) {
      return fetchListData(pageNum, onSuccess: onSuccess);
    }
    if (tabController.index == 1) {
      return fetchhotListData(pageNum, onSuccess: onSuccess);
    }
  }

  inserftav(GameInfoModel item) async {
    try {
      Map<String, dynamic> params = {};

      params["id"] = item.id;

      var res = await HttpClient.get(Api.favinsert, queryParameters: params);

      // homeModel = HomeModel.fromJson(Map<String, dynamic>.from(res.data));
      if (res.status == true) {
        if (favgames.contains(item)) {
          favgames.remove(item);
        } else {
          favgames.add(item);
        }
        int tol = favgames.length;
        typeList[2] = 'fav_games_num'.tr.replaceAll('{m}', "$tol");
        AppUtils.showToast("fav_success".tr);
      }
    } catch (e) {
      e.printError();
      AppUtils.showToast("favorite_failed".tr);
    }
  }

  favdelete(GameInfoModel item) async {
    try {
      Map<String, dynamic> params = {};

      params["id"] = item.id;

      var res = await HttpClient.get(Api.favdelete, queryParameters: params);

      // homeModel = HomeModel.fromJson(Map<String, dynamic>.from(res.data));
      if (res.status == true) {
        if (favgames.contains(item)) {
          favgames.remove(item);
        } else {
          favgames.add(item);
        }
        int tol = favgames.length;
        typeList[2] = 'fav_games_num'.tr.replaceAll('{m}', "$tol");
        AppUtils.showToast("cancel_fav_success".tr);
      }
    } catch (e) {
      AppUtils.showToast("failed_to_remove_from_favorites".tr);
      e.printError();
    }
  }

  @override
  void onClose() async {
    super.onClose();
    // currentController?.pause();
  }

  getfavList() async {
    try {
      Map<String, dynamic> params = {};

      params["page"] = 1;
      params["page_size"] = 1000;

      var response = await HttpClient.get(Api.favList, queryParameters: params);
      // homeModel = HomeModel.fromJson(Map<String, dynamic>.from(res.data));

      if (response.status == false) {
        update();

        return;
      }

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<GameInfoModel> transactions = rawList
          .map((e) => GameInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      favgames.value = transactions;
      int tol = favgames.length;

      typeList[2] = 'fav_games_num'.tr.replaceAll('{m}', "$tol");
    } catch (e) {
      e.printError();
    }
  }

  ///完成
  void onComplete(TopActionType type) {
    showGameVenue.value = false;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (type == TopActionType.home) {
        Get.until((route) => route.isFirst); // 回到首页
      }
      if (type == TopActionType.deposit) {
        AppNavigator.onGoRecharge();
      }
      if (type == TopActionType.reload) {
        // refreshData();
      }
      if (type == TopActionType.support) {
        showGameVenue.value = false;
        AppNavigator.gotoseveice();
      }
    });
  }

  // Function(VenueModel venue, CategoryModel category)? ongotogame,
  ongotogame(VenueModel venue, CategoryModel category) {
    showGameVenue.value = false;

    Future.delayed(const Duration(milliseconds: 300), () {
      categoryType = CategoryType.fromId(category.id ?? 0);

      if (venue.gameId == null || venue.gameId!.isEmpty) {
        print('[GameListController.showsheet] delete tag=' +
            (platform_id?.toString() ?? 'null') +
            ' registered=' +
            Get.isRegistered<GameListController>(tag: platform_id).toString());
        if (Get.isRegistered<GameListController>(tag: platform_id)) {
          Get.delete<GameListController>(tag: platform_id, force: true);
        }

        // Get.replace(
        //   Routes.GAME_LIST,
        //   // transition: Transition.noTransition,
        //   arguments: {
        //     "platform_id": venue.id,
        //     "venue_id": venue.venueId,
        //     "title": venue.name,
        //     "type": categoryType,
        //   },
        // );
        Get.offAndToNamed(
          Get.currentRoute,
          arguments: {
            "platform_id": venue.id,
            "venue_id": venue.venueId,
            "title": venue.name,
            "type": categoryType,
          },
        );
        print('[GameListController.showsheet] offAndToNamed route=' +
            Get.currentRoute +
            ' platform_id=' +
            (venue.id?.toString() ?? 'null') +
            ' venue_id=' +
            (venue.venueId?.toString() ?? 'null') +
            ' title=' +
            (venue.name?.toString() ?? 'null') +
            ' type=' +
            (categoryType?.toString() ?? 'null'));
      } else {
        //  gotoGame(
        //   model.id ?? "", model.gameId ?? "", model.name ?? "", categoryType);
        AppNavigator.gotoGame(venue.id ?? "", venue.gameId ?? "",
            venue.name ?? "", categoryType!);
      }
    });
  }
}
