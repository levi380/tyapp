
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/safe_update_extensions.dart';
import 'package:flutter_ty_app/app/modules/cp/extensions/cp_ticket_sort_constants_extension.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';

import 'package:flutter_ty_app/app/services/api/cp_api.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';


import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-27800d93-e3ca-4e92-b267-9f07d07c3e73-cp 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票列表页】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票列表页 控制器 CpController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票列表页 控制器 CpController
    - CpController
    ```
    ///跳转详情
    Future<void> onTapGame(CpTicketCateList ticket)
    ```
    】】】
 *
 */
class CpController extends GetxController {
  CpState state = CpState();

  bool _didCreate = false;

  Timer? timer;

  List<CpTicketCateEntity> get showCateList {
    switch (selTabIndex) {
      case 1:
        return _allCpTicketCates;
      case 2:
        return _classicCpTickets;
      case 3:
        return _featureCpTickets;
      default:
        return [];
    }
  }

  List<CpTicketCateList> get showTicketList {
    switch (selTabIndex) {
      case 0:
        return _collectCpTickets;
      case 1:
        if (_allCpTicketCates.length > selCateIndex) {
          return _allCpTicketCates[selCateIndex].list;
        }
      case 2:
        if (_classicCpTickets.length > selCateIndex) {
          return _classicCpTickets[selCateIndex].list;
        }
      case 3:
        if (_featureCpTickets.length > selCateIndex) {
          return _featureCpTickets[selCateIndex].list;
        }
    }
    return [];
  }

  num get gameCount {
    return _allCpTicketCates
        .map((e) => e.list.length)
        .reduce((e1, e2) => e1 + e2);
  }

  final List<CpTicketCateList> _collectCpTickets = [];

  // 所有的彩票分类：包含热门、即开以及后端返回的分类
  final List<CpTicketCateEntity> _allCpTicketCates = [];
  List<CpTicketCateEntity> get _classicCpTickets =>
      _allCpTicketCates.where((e) => e.seriesKind == 1).toList();
  List<CpTicketCateEntity> get _featureCpTickets =>
      _allCpTicketCates.where((e) => e.seriesKind == 2).toList();

  late PageController pageController;

  final tabTitles = [
    LocaleKeys.zr_cp_settings_Menu_cp_collect.tr,
    LocaleKeys.zr_cp_top_navigation_bar_all.tr,
    LocaleKeys.zr_cp_settings_Menu_cp_classic.tr,
    LocaleKeys.zr_cp_settings_Menu_cp_feature.tr,
  ];

  // 默认选中全部
  int selTabIndex = 1;

  bool isLoading = true;
  bool isLoadFailed = false;

  int selCateIndex = 0;

  onSelTabChangedNewChange(int index) {
    // if (index == selTabIndex) return;
    selTabIndex = index;
    // pageController.animateToPage(
    //   selTabIndex,
    //   duration: 200.milliseconds,
    //   curve: Curves.bounceIn,
    // );
    // 重置分类索引
    selCateIndex = 0;
    safeUpdate();
    if (selTabIndex == 0) {
      _getCollectList();
    } else {
      _getAllTicketList();
    }
  }

  onCateChanged(int index) {
    if (selCateIndex == index) return;
    selCateIndex = index;

    safeUpdate(['game_cate_grid_list']);
  }

  onPageChanged(int index) {
    if (index == selTabIndex) return;
    selTabIndex = index;
    safeUpdate();
  }

  Future<void> onCollectTicket(CpTicketCateList ticket) async {
    final res = await CpApi.instance().collectCpTicket(
      ticket.ticketId,
      !ticket.isCollect,
    );
    if (res.success) {
      if (selTabIndex == 0) {
        _getCollectList();
      } else {
        ticket.isCollect = !ticket.isCollect;
        safeUpdate(['game_cate_grid_list']);
      }
    }
  }

  Future<void> onTapGame(CpTicketCateList ticket) async {

    Map<String, dynamic> map = {'ticketId': ticket.ticketId};
    var res = await CpApi.instance().cpUserLogin(map);
    String dataUrl = res.data.h5;
    String theme = Get.isDarkMode ? '2' : '1';
    String tag = Get.locale!.toLanguageTag();
    String lang = 'zh_cn';
    if(tag.contains('zh-CN')){
      lang = 'zh_cn';
    }else if(tag.contains('zh-TW')){
      lang = 'zh_tw';
    }else if(tag.contains('en-GB')){
      lang = 'en_us';
    }else if(tag.contains('vi-VN')){
      lang = 'vn_lg';
    }else if(tag.contains('ms-MY')){
      lang = 'ml';
    }else if(tag.contains('th-TH')){
      lang = 'ti_lg';
    }else if(tag.contains('ko-KR')){
      lang = 'ko_kr';
    }else if(tag.contains('pt-PT')){
      lang = 'pt_pt';
    }else if(tag.contains('id-ID')){
      lang = 'id_id';
    }
    /*else if(tag.contains('es-ES')){
      lang = 'es_es';
    }else if(tag.contains('my-MM')){
      lang = 'my_mm';
    }*/
    else {
      lang = 'en_us';
    }
    String langUrl = replaceLanguageTag(dataUrl,lang);
    String ulr = repColorTheme(langUrl,theme);
     ulr = repEmbedded(ulr);
    String replacedString = dataUrl.replaceAll(RegExp(r'^.*#'), '');
    if (kDebugMode) {
      print('langUrl---$langUrl');
    }
    if (kDebugMode) {
      print('colorTheme---$ulr#$replacedString');
    }

    if (res.code == '200') {
      Get.toNamed(
        Routes.webGames,
        arguments: [
          {"title": LocaleKeys.menu_itme_name_cp_menu.tr},
          {"url": '$ulr#$replacedString'},
          {"cp": true},
        ],
      );
    }
  }



  String replaceLanguageTag(String url, String newLanguage) {
    final pattern = RegExp(r'&lang=[^&]*');
    return url.replaceAll(pattern, '&lang=$newLanguage');
  }

  String repColorTheme(String url, String newColorTheme) {
    final pattern = RegExp(r'&colorTheme=[^&]*');
    return url.replaceAll(pattern, '&colorTheme=$newColorTheme');
  }

  String repEmbedded(String url) {
    final pattern = RegExp(r'&isEmbedded=[^&]*');
    return url.replaceAll(pattern, '&isEmbedded=true');
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: selTabIndex);
    super.onInit();
    _getAllTicketList();
  }

  @override
  void onReady() {
    super.onReady();
    const Duration(milliseconds: 10000).delay(() {
      if (!isClosed) {
        _getAllTicketList();
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}

extension _CpControllerApi on CpController {
  Future<void> _getCollectList() async {
    await _createCp();
    try {
      final res = await CpApi.instance().getCpCollectGameList();
      final colletCpTickets = res.data ?? [];
      for (final ticket in colletCpTickets) {
        ticket.isCollect = true;
      }
      _collectCpTickets.assignAll(colletCpTickets);
      safeUpdate(['game_cate_grid_list']);
    } catch (e) {
      AppLogger.debug('getCpCollectGameList error: $e');
    }
  }

  Future<void> _getAllTicketList() async {
    if (_allCpTicketCates.isEmpty) {
      isLoading = true;
      safeUpdate(['game_cate_grid_list']);
    }

    await _createCp();

    try {
      final res = await Future.wait([
        _getCpHotsGameList(),
        _getCpJksGameList(),
        _getCpOtherGameList(),
      ]);
      _allCpTicketCates.assignAll(res.expand((e) => e));
      // 暂时屏蔽
      _allCpTicketCates.removeWhere((e) => e.name.toLowerCase() == 'p3p5');
    } catch (e) {
      AppLogger.debug('_getAllTicketList error: $e');
      isLoadFailed = true;
    }

    isLoading = false;
    safeUpdate(['game_cate_grid_list']);
  }

  Future<void> _createCp() async {
    try {
      final res = await CpApi.instance().cpCreateV2();
      if (res.data != 'create already!') {
        await _createCp();
      }
      if (!_didCreate) {
        // 感觉改接口有延迟，马上获取cp数据拿不到，所以首次加上延时
        // await 2.seconds.delay();
      }
      _didCreate = true;
      AppLogger.debug('cpCreateV2 res: ${res.data}');
    } catch (e) {
      // AppLogger.debug('cpCreateV2 error: $e');
      if (!_didCreate) {
        // _createCp();
      }
    }
  }

  Future<List<CpTicketCateEntity>> _getCpHotsGameList() async {
    try {
      final res = await CpApi.instance().getCpHotsGameList();
      if (res.success) {
        final hotGameCate = CpTicketCateEntity.fromJson({
          // 'name': '热门游戏',
          'name': LocaleKeys.zr_cp_list_Games_Lottery_top_games.tr,
          'seriesKind': '-1',
          'id': '9999',
        })
          ..list = res.data ?? [];
        return [hotGameCate];
      }
      return [];
    } catch (e) {
      AppLogger.debug('_getCpHotsGameList error: $e');
      return [];
    }
  }

  Future<List<CpTicketCateEntity>> _getCpJksGameList() async {
    try {
      final res = await CpApi.instance().getCpJksGameList();
      if (res.success) {
        // H5 貌似没有排序
        List<CpTicketCateList> newTickets = _sortJKC(res);
        final jkGameCate = CpTicketCateEntity.fromJson({
          // 'name': '即开彩',
          'name': LocaleKeys.zr_cp_list_Games_Lottery_instant_draw.tr,
          'seriesKind': '-1',
          'id': '99',
        })
          ..list = newTickets;

        return [jkGameCate];
      }
      return [];
    } catch (e) {
      AppLogger.debug('_getCpJksGameList error: $e');
      return [];
    }
  }

  List<CpTicketCateList> _sortJKC(
    ApiRes<List<CpTicketCateList>> res, {
    bool sort = false,
  }) {
    final tickets = res.data ?? [];
    if (!sort) return tickets;

    final newTickets = <CpTicketCateList>[];
    for (final id in jkcTicketSortIds) {
      final ticket = tickets.firstWhereOrNull((e) => e.ticketId == id);
      if (ticket != null) {
        newTickets.add(ticket);
        AppLogger.debug('firstWhereOrNull：排序1');
      }
    }
    return newTickets;
  }

  Future<List<CpTicketCateEntity>> _getCpOtherGameList() async {
    try {
      final res = await CpApi.instance().getCpOtherGameList();
      if (res.success) {
        // H5 貌似没有排序
        final dataList = _sortOrtherList(res);
        return dataList;
      }
      return [];
    } catch (e) {
      AppLogger.debug('_getCpOtherGameList error: $e');
      return [];
    }
  }

  _sortOrtherList(
    ApiRes<List<CpTicketCateEntity>> res, {
    bool sort = false,
    bool filter = true,
  }) {
    final dataList = res.data ?? [];

    final newDataList = <CpTicketCateEntity>[];

    List filteModelFor4 = dataList.where(
            (e) => e.id == '4'
    ).toList();
    List  filteModelFor10 = dataList.where(
          (e) => e.id == '10',
    ).toList();
    ///彩种数据合并 预处理
    dataList.forEach((CpTicketCateEntity model){
      List<CpTicketCateList> oldList = model.list;
      /// 将id8中的内容放进id4中
      if(model.id == '8'){
        List<CpTicketCateList> targetList = filteModelFor4.length != 0 ? filteModelFor4.first?.list : [];
        targetList.addAll(oldList);
      }
      ///将id22中的内容放进id3中
      if(model.id == '22'){
        List<CpTicketCateList> targetList = filteModelFor10.length != 0 ?  filteModelFor10.first?.list : [];
        targetList.addAll(oldList);
      }
    });

    for (var orderJson in otherTicketSortIds) {
      final cateId = '${orderJson['id']}';

      if (cateId != 'null' && cateId.isNotEmpty == true) {

        final cate = dataList.firstWhereOrNull((e) {
          return e.id == cateId;
        });

        if (cate != null) {
          final ticketIds = orderJson['ticketId'] as List<int>? ?? [];
          final tickets = cate.list;
          final newTickets = <CpTicketCateList>[];
          final newCate = CpTicketCateEntity.fromJson(cate.toJson());
          if (filter) {
            tickets.takeWhile((e) => ticketIds.contains(e.ticketId));
          }
          if (sort) {
            for (var ticketId in ticketIds) {
              final ticket =
                  tickets.firstWhereOrNull((e) => e.ticketId == '$ticketId');
              if (ticket != null) {
                newTickets.add(ticket);
              }
              AppLogger.debug('firstWhereOrNull：排序');
            }
            newDataList.add(newCate..list = newTickets);
          } else {
            newDataList.add(newCate..list = tickets);
          }
        }
      }
    }
    return newDataList;
  }
}
