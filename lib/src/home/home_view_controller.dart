import 'dart:async';
import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/routes/app_navigator.dart';

import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/dialog/account_security_tips.dart';
import 'package:filbet/src/home/Home_index_ads_model.dart';
import 'package:filbet/src/home/app_version_model.dart';
import 'package:filbet/src/home/home_ads_dialog.dart';
import 'package:filbet/src/mine/vip/models/member_vip_info.dart';
import 'package:filbet/src/mine/vip/vip_service.dart';
import 'package:filbet/utils/app_config.dart';
import 'package:filbet/utils/device_util.dart';
import 'package:filbet/utils/language_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/http/http_client.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/upgrade/view.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'appconfig_model.dart';
import 'package:filbet/src/dialog/notice_dialog.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';

import 'homegame_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeViewController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static HomeViewController get to => Get.find();

  final ScrollController scrollController = ScrollController();
  final ScrollController leftNavController = ScrollController();

  final ScrollController rightScrollController = ScrollController();

  final List<GlobalKey> categoryKeys = [];
  bool _isProgrammaticScroll = false;

  ///滚动顶部按钮
  final RxBool _showGoTopIcon = false.obs;

  bool get showGoTopIcon => _showGoTopIcon.value;

  set showGoTopIcon(bool v) => _showGoTopIcon.value = v;

  ///drawer key
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  EasyRefreshController easyRefreshController =
      EasyRefreshController(controlFinishRefresh: true);

  final RxInt _selIndex = 0.obs;

  int get selIndex => _selIndex.value;

  set selIndex(int v) => _selIndex.value = v;

  /// 左侧点击切换分类时，右侧列表做一次「顶部下拉再回顶」过渡；由 [consumePendingGameListTapScrollBounce] 消费。
  bool _pendingGameListTapScrollBounce = false;

  void selectGameCategoryWithTapScrollBounce(int index) {
    _pendingGameListTapScrollBounce = true;
    selIndex = index;
  }

  bool consumePendingGameListTapScrollBounce() {
    final v = _pendingGameListTapScrollBounce;
    _pendingGameListTapScrollBounce = false;
    return v;
  }

  final vipInfo = Rx<MemberVipInfoModel?>(null);

  @override
  void onInit() {
    rightScrollController.addListener(_scrollingListener);

    super.onInit();
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    rightScrollController.removeListener(_scrollingListener);
    rightScrollController.dispose();
    leftNavController.dispose();
    scrollController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onReady() async {
    getAppVersion();
    noticelogList();
    if (UserService.to.state.isRegularUser) {
      UserService.to.getUserInfos();
    }
    GlobalService.to.getHomeGames();
    fetchMemberVipInfo();
    super.onReady();
  }

  void _getIndexAdsPopup() async {
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';
    final homeAdsDate = SpStorage.homeAdsDate ?? "";
    if (todayString == homeAdsDate) return;

    var response = await HttpClient.get(Api.indexAds);
    if (response.status == false) {
      return;
    }

    List<dynamic> rawList = response.data["d"] ?? [];
    List<HomeIndexAdsModel> list = rawList
        .map((e) => HomeIndexAdsModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    if (list.isNotEmpty) {
      var result = await Get.dialog(
          WillPopScope(
            onWillPop: () async {
              // 返回 false 表示屏蔽返回键
              return false;
            },
            child: HomeAdsDialog(
              dataList: list,
            ),
          ),
          barrierDismissible: false,
          navigatorKey: navigatorKey);
    }
  }

  bool shouldShowPopup() {
    final savedDate = SpStorage.kdate ?? "";

    if (savedDate.isEmpty) return true; // 从未设置过，默认显示

    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';

    return savedDate != todayString; // 不是今天保存的，就可以弹
  }

  Timer? _timer;

  Future<void> noticelogList() async {
    queryNoticeAll();
    if (UserService.to.state.isVisitor) {
      return;
    }
    _timer = Timer(const Duration(seconds: 3), () async {
      showAccountSecurityTipsDialog();
    });
  }

  void shouldShowDialog() async {
    var resp = await ApiRequest.queryNotice(0, 1);
    List<NoticeModel> response = [];
    if (resp != null) {
      response = resp.d ?? [];
    }
    if (response.isNotEmpty) {
      // 跑马灯：类型为普通且start_time/end_time不为0
      // 弹窗：类型为特殊且start_time/end_time 不为0
      var list = response
          .where((item) =>
              item.noticeType == 2 && item.startTime != 0 && item.endTime != 0)
          .toList();
      if (shouldShowPopup()) {
        if (list.isNotEmpty) {
          await Get.dialog(
            noticeDialog(scrollMsg: list),
            barrierDismissible: true, // ✅ 点背景可关闭
          );
        }
        _getIndexAdsPopup();
      } else {
        _getIndexAdsPopup();
      }
    } else {
      _getIndexAdsPopup();
    }
  }

  void queryNoticeAll() async {
    var resp = await ApiRequest.queryNoticeAll(0, 1);
    List<NoticeModel> response = [];
    if (resp != null) {
      response = resp.d ?? [];
    }
    if (response.isNotEmpty) {
      // 跑马灯：类型为普通且start_time/end_time不为0
      final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var marqueeList = response
          .where((item) =>
              item.noticeType == 1 &&
              item.startTime != 0 &&
              item.endTime != 0 &&
              ((item.startTime ?? 0) == 0 || item.startTime! <= nowSec) &&
              ((item.endTime ?? 0) == 0 || nowSec <= item.endTime!))
          .toList();
      GlobalService.to.state.marqueeNotice
        ..clear()
        ..addAll(marqueeList);
    }
  }

  ///登录成功,如果没有签到只弹签到
  void _onLoginSuccess(arg) {
    // if (arg == true) {
    //   ///登录状态变更刷新一下任务红点
    //   _refreshTask();

    //   bool interception = _eventInterception();
    //   if (interception) {
    //     return;
    //   }

    //   ///防止其他内页弹窗
    //   if (Get.currentRoute == Routes.main &&
    //       MainController.to.currentBottomNavBar.tag == appBottomHome) {
    //     // APP未登入账号状态
    //     // -登入账号后【弹窗】会再弹出显示。
    //     // openSignDialog(unSignShow: true);
    //     showDialog();
    //   }
    // }
  }

  ///注册，先弹onShowRegisterDialog，再通知回来
  void _onRegSuccess(arg) {}

  Future<void> openSignDialog({bool unSignShow = false}) async {}

  ///首页刷新
  Future homeRefresh({
    bool onDoubleTap = false,
  }) async {
    try {
      if (onDoubleTap) {
        easyRefreshController.callRefresh();
      }
      await GlobalService.to.homeRefresh();
      easyRefreshController.finishRefresh();
      easyRefreshController.resetHeader();
    } catch (e) {
      easyRefreshController.finishRefresh();
      easyRefreshController.resetHeader();
    }
  }

  void tapGoTop() {
    scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void gotoUserinfo() {
    AppNavigator.gotoUserinfo();
  }

  CategoryModel? getCategoryById(
      List<CategoryModel> list, CategoryType categoryType) {
    try {
      return list.firstWhere((element) => element.id == categoryType.id);
    } catch (e) {
      return null; // 没找到返回 null
    }
  }

  getCategoryModel(CategoryType categoryType) {
    return getCategoryById(
        GlobalService.to.state.allCategoryConfig, categoryType);
  }

  getMaintainedForCategoryType(CategoryType categoryType) {
    var model = getCategoryModel(categoryType);
    if (model.deft == null) {
      return true;
    }
    return model.deft.maintained == 2 ? true : false;
  }

  gotoGameVenueModel(CategoryType categoryType) {
    var model = getCategoryModel(categoryType);
    if (model.deft == null) {
      return;
    }
    if (model.deft.maintained == 2) {
      return;
    }

    AppNavigator.gotoGameList(model.deft, categoryType);

    // if (UserService.to.state.isVisitor) {
    //   AppNavigator.showLoginDialog();
    //   return;
    // }
    // // GlobalService.to.platformOne(
    // //   (response) {
    // //     gotoGameList(response);
    // //   },
    // //   onError: () {
    // //     _showLoginDialog();
    // //   },
    // //   platformId: categoryType.id,
    // // );
    // platformOne(
    //   platformId: categoryType.id,
    //   onSuccess: (response) {
    //     AppNavigator.gotoGameList(response, categoryType);
    //   },
    //   onError: () {
    //     // AppNavigator.showdialog();
    //   },
    // );
  }

  /// 首页游戏
  Future<void> platformOne({
    required int platformId,
    Function(VenueModel response)? onSuccess,
    Function()? onError,
  }) async {
    try {
      await fetchHandler<VenueModel>(
        loading: true,
        _platformOne(platformId: platformId),
        onSuccess: (response) {
          if (onSuccess != null) onSuccess(response);
        },
        onError: (e) {
          if (onError != null) onError();
        },
      );
    } catch (e) {
      debugPrint("getHomeGames fatal error: $e");
    }
  }

  Future<VenueModel> _platformOne({required int platformId}) async {
    try {
      final response = await HttpClient.get(
        Api.platformOne,
        queryParameters: {"game_type": platformId},
      );

      if (response.status == false) {
        if (response.data == "20000") {
          GlobalService.to.state.categoryStatus[platformId] = false;
          GlobalService.to.state.categoryStatus.refresh();
        }
        throw response.error!;
      }

      return VenueModel.fromJson(Map<String, dynamic>.from(response.data));
    } catch (e) {
      debugPrint("platformOne error: $e");
      GlobalService.to.state.categoryStatus[platformId] = false;
      GlobalService.to.state.categoryStatus.refresh();
      throw e;
    }
  }

  void financewallet() async {
    await UserService.to.queryTotalBalance();
  }

  onTapNav(int index) {
    if (selIndex != index) {
      selIndex = index;
    }
    scrollToCategory(index);
  }

  void ensureCategoryKeys(int length) {
    if (categoryKeys.length == length) return;
    categoryKeys
      ..clear()
      ..addAll(List.generate(length, (_) => GlobalKey()));
  }

  void scrollToCategory(int index) {
    if (index < 0 || index >= categoryKeys.length) return;
    final ctx = categoryKeys[index].currentContext;
    if (ctx != null) {
      _isProgrammaticScroll = true;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.0,
      ).whenComplete(() {
        _isProgrammaticScroll = false;
      });
    }
  }

  void _scrollingListener() {
    if (_isProgrammaticScroll) return;
    int closestIndex = -1;
    double minDelta = double.infinity;
    final ScrollPosition? position = rightScrollController.hasClients
        ? rightScrollController.position
        : null;

    for (int i = 0; i < categoryKeys.length; i++) {
      final ctx = categoryKeys[i].currentContext;
      if (ctx == null) continue;
      final render = ctx.findRenderObject();
      if (render is! RenderBox || !render.attached) continue;
      final viewport = RenderAbstractViewport.of(render);
      if (viewport == null) continue;
      final double itemOffset = viewport.getOffsetToReveal(render, 0.0).offset;
      final double delta = (itemOffset - (position?.pixels ?? 0.0)).abs();
      if (delta < minDelta) {
        minDelta = delta;
        closestIndex = i;
      }
    }
    // 只更新高亮，不滚动左侧导航
    if (closestIndex != -1 && selIndex != closestIndex) {
      selIndex = closestIndex;
    }
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
                  // downloadUrl: 'https://appdownload.skbet.com/releases/app-1.0.0.apk',
                  updateContent: updateContent),
            );
          });
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

  ///vip信息接口
  Future fetchMemberVipInfo() async {
    vipInfo.value = await VipService.getMemberVipInfo();
  }

  Future showAccountSecurityTipsDialog() async {
    if (UserService.to.state.isVisitor) {
      return;
    }
    var isEmptyTags = UserService.to.state.userInfo.tags ?? "";
    if (isEmptyTags.isNotEmpty && isEmptyTags.contains("安全提示用户")) {
      bool? isResult = await Get.dialog(
            AccountSecurityTipsDialog(),
            barrierDismissible: false, // 禁止点击空白关闭
          ) ??
          false;

      if (isResult) {
        var response = await HttpClient.post(Api.removeTags, data: {
          'tag_name': "安全提示用户",
        });
        UserService.to.getUserInfos();
        shouldShowDialog();
      } else {
        shouldShowDialog();
      }
    } else {
      shouldShowDialog();
    }
  }
}

class ContactModel {
  final int type;
  final String icon;

  ContactModel({
    required this.type,
    required this.icon,
  });
}
