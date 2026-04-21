import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/src/home/resp_message_model.dart';
import 'package:filbet/widgets/common_tab_bar.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:easy_refresh/easy_refresh.dart';

class MessageCenterListController extends GetXBaseController
    with GetTickerProviderStateMixin {
  MessageCenterListController({this.initialTabIndex = 0});

  /// 初始选中的 tab（0 通知 1 活动 2 公告 3 充提），由外部传入
  final int initialTabIndex;

  final menu = [
    TabBarItem(title: '通知'),
    TabBarItem(title: '活动'),
    TabBarItem(title: '公告'),
    TabBarItem(title: '充提'),
  ].obs;
  final tabIndex = 0.obs;
  late TabController tabController;

  final noticeModels = <NoticeModel>[].obs;
  final activityModels = <NoticeModel>[].obs;
  final announceModels = <NoticeModel>[].obs;
  final depositWithdrawModels = <NoticeModel>[].obs;

  final isEdit = false.obs;

  // 分页相关 - 为每个 tab 创建独立的 EasyRefreshController
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  // 存储每个 tab 的页码和总数（分页从 1 开始）
  int noticePage = 1;
  int activityPage = 1;
  int announcePage = 1;
  int depositWithdrawPage = 1;

  num noticeTotal = 0;
  num activityTotal = 0;
  num announceTotal = 0;
  num depositWithdrawTotal = 0;

  @override
  void onInit() {
    final index = initialTabIndex.clamp(0, menu.length - 1);
    tabController =
        TabController(length: menu.length, vsync: this, initialIndex: index)
          ..addListener(() {
            tabIndex.value = tabController.index;
            if (!tabController.indexIsChanging) {
              refreshDataByTab(tabController.index);
            }
          });
    tabIndex.value = index;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    queryData();
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  void queryData() {
    queryNotices();
    queryMessages();
  }

  /// 删除成功后：先全屏转圈 5 秒，再刷新当前 tab 数据
  Future<void> _refreshAfterSuccess(String content, int tabIdx) async {
    SmartDialog.showLoading(
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: loadinngView(content: content),
        );
      },
    );
    try {
      await Future.delayed(const Duration(seconds: 3));
      await refreshDataByTab(tabIdx);
    } finally {
      try {
        SmartDialog.dismiss(status: SmartStatus.loading);
      } catch (_) {}
    }
  }

  /// 刷新指定 tab 的数据（不先清空列表，等接口返回后一次性替换，避免闪烁）
  Future<void> refreshDataByTab(int tabIndex) async {
    switch (tabIndex) {
      case 0: // 通知
        noticePage = 1;
        await _querySingleMessageType(1, false);
        break;
      case 1: // 活动
        activityPage = 1;
        await _querySingleMessageType(2, false);
        break;
      case 2: // 公告
        announcePage = 1;
        await queryNotices(isLoadMore: false);
        break;
      case 3: // 充提
        depositWithdrawPage = 1;
        await _querySingleMessageType(3, false);
        break;
    }

    // 更新未读数
    await _updateUnreadCounts();

    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  /// 加载指定 tab 的更多数据
  Future<void> loadMoreDataByTab(int tabIndex) async {
    int currentPage;
    num currentTotal = 0;
    RxList<NoticeModel> currentModels;

    // 根据 tab 获取对应的 page 和 models
    switch (tabIndex) {
      case 0: // 通知
        currentPage = noticePage;
        currentTotal = noticeTotal;
        currentModels = noticeModels;
        break;
      case 1: // 活动
        currentPage = activityPage;
        currentTotal = activityTotal;
        currentModels = activityModels;
        break;
      case 2: // 公告
        currentPage = announcePage;
        currentTotal = announceTotal;
        currentModels = announceModels;
        break;
      case 3: // 充提
        currentPage = depositWithdrawPage;
        currentTotal = depositWithdrawTotal;
        currentModels = depositWithdrawModels;
        break;
      default:
        easyRefreshController.finishLoad(IndicatorResult.noMore);
        return;
    }

    // 检查是否还有更多数据
    if (currentModels.length >= currentTotal) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }

    // 加载更多
    if (tabIndex == 2) {
      // 公告
      await queryNotices(isLoadMore: true);
    } else {
      // 消息
      final messageType = tabIndex == 0
          ? 1
          : tabIndex == 1
              ? 2
              : 3;
      await _querySingleMessageType(messageType, true);
    }

    // 检查是否还有更多数据
    final hasMore = currentModels.length < currentTotal;
    easyRefreshController.finishLoad(
      hasMore ? IndicatorResult.success : IndicatorResult.noMore,
    );
  }

  /// 更新所有 tab 的未读数
  Future<void> _updateUnreadCounts() async {
    num unreadCount1 = getUnreadCount(await ApiRequest.queryMessages(1, 1));
    num unreadCount2 = getUnreadCount(await ApiRequest.queryMessages(2, 1));
    num unreadCount3 = getUnreadCount(await ApiRequest.queryMessages(3, 1));
    num unreadCountNotice = getUnreadCount(await ApiRequest.queryNotice(0, 1));

    if (unreadCount1 > 0) {
      menu[0].number = '$unreadCount1';
    } else {
      menu[0].number = null;
    }
    if (unreadCount2 > 0) {
      menu[1].number = '$unreadCount2';
    } else {
      menu[1].number = null;
    }
    if (unreadCountNotice > 0) {
      menu[2].number = '$unreadCountNotice';
    } else {
      menu[2].number = null;
    }
    if (unreadCount3 > 0) {
      menu[3].number = '$unreadCount3';
    } else {
      menu[3].number = null;
    }

    menu.refresh();
  }

  void editMessages(bool edit) {
    isEdit.value = edit;
    if (!isEdit.value) {
      final models = <NoticeModel>[].obs;
      models.value = tabIndex.value == 0
          ? noticeModels
          : tabIndex.value == 1
              ? activityModels
              : tabIndex.value == 2
                  ? announceModels
                  : depositWithdrawModels;
      if (models.isNotEmpty) {
        for (var item in models) {
          item.checked.value = false;
        }
      }
      models.refresh();
    }
  }

  void readAllMessages() async {
    List<NoticeModel> models = tabIndex.value == 0
        ? noticeModels
        : tabIndex.value == 1
            ? activityModels
            : tabIndex.value == 2
                ? announceModels
                : depositWithdrawModels;
    if (models.isNotEmpty) {
      var readIds = models
          .where((item) => item.readState == 0)
          .map((element) => element.id ?? '')
          .toList();
      if (readIds.isNotEmpty) {
        var resp = tabIndex.value == 2
            ? await ApiRequest.readNotices(readIds, null)
            : await ApiRequest.readMessages(readIds, null);
        if (resp == true) {
          await _refreshAfterSuccess('处理中...', tabIndex.value);
        }
      }
    }
  }

  void deleteSelectedMessage() async {
    List<NoticeModel> models = tabIndex.value == 0
        ? noticeModels
        : tabIndex.value == 1
            ? activityModels
            : tabIndex.value == 2
                ? announceModels
                : depositWithdrawModels;
    if (models.isNotEmpty) {
      var readIds = models
          .where((item) => item.checked.value == true)
          .map((element) => element.id ?? '')
          .toList();
      if (readIds.isNotEmpty) {
        var resp = tabIndex.value == 2
            ? await ApiRequest.deleteNotices(readIds, null)
            : await ApiRequest.deleteMessages(readIds, null);
        if (resp == true) {
          await _refreshAfterSuccess('删除中...', tabIndex.value);
        }
      }
    }
  }

  void deleteAllMessages() async {
    List<NoticeModel> models = tabIndex.value == 0
        ? noticeModels
        : tabIndex.value == 1
            ? activityModels
            : tabIndex.value == 2
                ? announceModels
                : depositWithdrawModels;
    if (models.isNotEmpty) {
      var readIds = models.map((element) => element.id ?? '').toList();
      if (readIds.isNotEmpty) {
        var resp = tabIndex.value == 2
            ? await ApiRequest.deleteNotices(readIds, null)
            : await ApiRequest.deleteMessages(readIds, null);
        if (resp == true) {
          await _refreshAfterSuccess('删除中...', tabIndex.value);
        }
      }
    }
  }

  void selectCurrentPage() {
    final models = <NoticeModel>[].obs;
    models.value = tabIndex.value == 0
        ? noticeModels
        : tabIndex.value == 1
            ? activityModels
            : tabIndex.value == 2
                ? announceModels
                : depositWithdrawModels;
    if (models.isNotEmpty) {
      for (var item in models) {
        item.checked.value = true;
      }
    }
    models.refresh();
  }

  void readSelectedMessage() async {
    List<NoticeModel> models = tabIndex.value == 0
        ? noticeModels
        : tabIndex.value == 1
            ? activityModels
            : tabIndex.value == 2
                ? announceModels
                : depositWithdrawModels;
    if (models.isNotEmpty) {
      var readIds = models
          .where((item) => item.readState == 0 && item.checked.value == true)
          .map((element) => element.id ?? '')
          .toList();
      if (readIds.isNotEmpty) {
        var resp = tabIndex.value == 2
            ? await ApiRequest.readNotices(readIds, null)
            : await ApiRequest.readMessages(readIds, null);
        if (resp == true) {
          await _refreshAfterSuccess('处理中...', tabIndex.value);
        }
      }
    }
  }

  void readMessage(NoticeModel model) async {
    var resp = tabIndex.value == 2
        ? await ApiRequest.readNotices([model.id ?? ''], null)
        : await ApiRequest.readMessages([model.id ?? ''], null);
  }

  Future<void> queryNotices({bool isLoadMore = false}) async {
    final page = isLoadMore ? announcePage : 1;
    var resp = await ApiRequest.queryNotice(0, page);
    num unreadCount = getUnreadCount(resp);
    if (unreadCount > 0) {
      menu[2].number = '$unreadCount';
    }
    if (resp != null) {
      announceTotal = resp.t ?? 0;
      final newData = resp.d ?? [];

      if (isLoadMore) {
        announceModels.addAll(newData);
        announcePage = page + 1;
      } else {
        announceModels.value = newData;
        announcePage = newData.isNotEmpty ? 2 : 1;
      }
    }
    menu.refresh();
  }

  Future<void> queryMessages(
      {bool isLoadMore = false, int? messageType}) async {
    // 如果指定了 messageType，只查询该类型；否则查询所有类型
    if (messageType != null) {
      // 只查询指定类型
      await _querySingleMessageType(messageType, isLoadMore);
    } else {
      // 查询所有类型
      await _querySingleMessageType(1, false); // 通知
      await _querySingleMessageType(2, false); // 活动
      await _querySingleMessageType(3, false); // 充提
    }

    // 更新未读数
    num unreadCount1 = getUnreadCount(await ApiRequest.queryMessages(1, 1));
    num unreadCount2 = getUnreadCount(await ApiRequest.queryMessages(2, 1));
    num unreadCount3 = getUnreadCount(await ApiRequest.queryMessages(3, 1));

    if (unreadCount1 > 0) {
      menu[0].number = '$unreadCount1';
    }
    if (unreadCount2 > 0) {
      menu[1].number = '$unreadCount2';
    }
    if (unreadCount3 > 0) {
      menu[3].number = '$unreadCount3';
    }

    menu.refresh();
  }

  Future<void> _querySingleMessageType(int messageType, bool isLoadMore) async {
    int page;
    RxList<NoticeModel> models;
    num total;

    switch (messageType) {
      case 1:
        page = noticePage;
        models = noticeModels;
        total = noticeTotal;
        break;
      case 2:
        page = activityPage;
        models = activityModels;
        total = activityTotal;
        break;
      case 3:
        page = depositWithdrawPage;
        models = depositWithdrawModels;
        total = depositWithdrawTotal;
        break;
      default:
        return;
    }

    final requestPage = isLoadMore ? page : 1;
    var resp = await ApiRequest.queryMessages(messageType, requestPage);
    if (resp != null) {
      final newTotal = resp.t ?? 0;
      final newData = resp.d ?? [];

      switch (messageType) {
        case 1:
          noticeTotal = newTotal;
          break;
        case 2:
          activityTotal = newTotal;
          break;
        case 3:
          depositWithdrawTotal = newTotal;
          break;
      }

      if (isLoadMore) {
        models.addAll(newData);
        final nextPage = requestPage + 1;
        switch (messageType) {
          case 1:
            noticePage = nextPage;
            break;
          case 2:
            activityPage = nextPage;
            break;
          case 3:
            depositWithdrawPage = nextPage;
            break;
        }
      } else {
        models.value = newData;
        switch (messageType) {
          case 1:
            noticePage = newData.isNotEmpty ? 2 : 1;
            break;
          case 2:
            activityPage = newData.isNotEmpty ? 2 : 1;
            break;
          case 3:
            depositWithdrawPage = newData.isNotEmpty ? 2 : 1;
            break;
        }
      }
    }
  }

  num getUnreadCount(RespMessageModel? model) {
    num unreadCount = 0;
    if (model != null) {
      unreadCount = model.unreadCount ?? 0;
    }
    return unreadCount;
  }

  /// 减少指定 tab 的未读数量
  void decreaseUnreadCount(int tabIndex) {
    if (tabIndex < 0 || tabIndex >= menu.length) return;

    final currentNumber = menu[tabIndex].number;
    if (currentNumber != null && currentNumber.isNotEmpty) {
      final currentCount = num.tryParse(currentNumber) ?? 0;
      if (currentCount > 0) {
        final newCount = currentCount - 1;
        if (newCount > 0) {
          menu[tabIndex].number = '$newCount';
        } else {
          menu[tabIndex].number = null;
        }
        menu.refresh();
      }
    }
  }
}
