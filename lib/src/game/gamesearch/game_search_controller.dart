import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import '../gamelist/game_item.dart';
import '../gamelist/gamelist_controller.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/common/language.dart';
import 'package:filbet/services/global/global_service.dart';

class GameSearchController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static GameSearchController get to => Get.find();

  EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);
  String? platform_id;
  String? venue_id;
  int currencyint = 101;
  Map<String, dynamic> params = {};
  int pageNum = 1;
  int pageSize = 20;
  RxString ckeyword = "".obs;
  final RxList<GameInfoModel> records = RxList.empty();
  RxInt total = 0.obs;
  CategoryType? categoryType;

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {}
    if (Get.arguments is Map) {
      platform_id = Get.arguments["platform_id"];
      venue_id = Get.arguments["venue_id"];
      categoryType = Get.arguments["type"];
    }
    ever<List>(GameListController.to.favgames, (_) => _syncFavStatus());
  }

  _syncItemFavStatus(List<GameInfoModel> sgames) {
    for (var game in sgames) {
      game.fav = GameListController.to.favgames.contains(game);
    }

    return sgames;
  }

  void _syncFavStatus() {
    _syncItemFavStatus(records);

    update();
  }

  void searchWithKeyWord(String keyword) {
    ckeyword.value = keyword;
    if (keyword.isEmpty) {
      records.value = [];
      update();

      return;
    } else {
      refreshData();
    }
  }

  @override
  void onReady() async {
    super.onReady();
  }

  /// refresh[刷新数据]
  refreshData() async {
    if (ckeyword.value.isEmpty) {
      // refreshController.refreshCompleted();
      return;
    }
    fetchListData(page: pageNum, isRefresh: true);
  }

  /// [loadMoreData] 加载更多
  loadMoreData() async {
    pageNum++;
    fetchListData(page: pageNum);
  }

  oncollect() async {}

  /// [ckeyword] 去掉空白与非中英文数字字符，再作为接口搜索词
  String _keywordForApi(String raw) {
    final noSpace = raw.replaceAll(RegExp(r'\s'), '');
    return noSpace.replaceAll(RegExp(r'[^a-zA-Z0-9\u4e00-\u9fa5]'), '');
  }

  fetchListData({int? page, bool isRefresh = false}) async {
    final word = _keywordForApi(ckeyword.value);
    try {
      var response = await HttpClient.get(Api.gameList, queryParameters: {
        "page": page,
        "page_size": 10,
        "game_type": 0,
        "is_hot": 0,
        "platform_id": platform_id ?? "",
        "venue_id": venue_id ?? "",
        // "currency": currencyint
        "w": word
      });
      if (response.status == false) {}

      List<dynamic> rawList = response.data["d"] ?? [];

      //   List<dynamic> rawList = res.data["data"] ?? [];
      List<GameInfoModel> transactions = rawList
          .map((e) => GameInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (page! > 1) {
        records.addAll(transactions);
      } else {
        total.value = response.data["t"] ?? 0;
        records.value = transactions;
      }

      update();

      bool hasMore = page! * 10 < total.value;

      if (isRefresh) {
        easyRefreshController.finishRefresh();
        easyRefreshController.resetFooter();
      } else {
        easyRefreshController.finishLoad(
            hasMore ? IndicatorResult.success : IndicatorResult.noMore);
      }
    } catch (e) {
      e.printError();
    }
  }

  inserftav(GameInfoModel item) async {
    GameListController.to.inserftav(item);
  }

  favdelete(GameInfoModel item) async {
    GameListController.to.favdelete(item);
  }

  @override
  void onClose() async {
    super.onClose();
    // currentController?.pause();
  }
}
