import 'package:filbet/http/api/api_request.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/message/message_center_list/message_center_list_controller.dart';
import 'package:filbet/src/message/message_private_list/message_private_list_controller.dart';
import 'package:get/get.dart';

class MessageCenterController extends GetXBaseController
    with GetTickerProviderStateMixin {
  static MessageCenterController get to => Get.find();
  final appBarIndex = 0.obs;
  final isEdit = false.obs;
  final messageUnreadNum = 0.obs;
  final privateUnreadNum = 0.obs;

  /// 消息列表初始 tab（由路由 arguments type 传入：0 通知 1 活动 2 公告 3 充提）
  int initialMessageTabIndex = 0;

  /// 私信未读数监听是否已建立（避免重复注册 ever）
  bool _privateUnreadListenerSetup = false;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    final typeStr = args?['type']?.toString() ?? '0';
    initialMessageTabIndex = (int.tryParse(typeStr) ?? 0).clamp(0, 3);
  }

  @override
  void onReady() {
    super.onReady();
    _setupUnreadCountListeners();
    // 进入页面即拉取私信未读数，无需切换 tab
    _fetchPrivateUnreadNum();
    // 切换到私信 tab 时再尝试建立私信未读数监听（用于后续 menu 变化时同步）
    ever(appBarIndex, (index) {
      if (index == 1) {
        _checkAndListenPrivateController();
      }
    });
  }

  /// 直接请求私信未读数接口，不依赖 MessagePrivateListController（不切换 tab 即可显示）
  Future<void> _fetchPrivateUnreadNum() async {
    try {
      final r1 = await ApiRequest.queryPrivateMessages(0, 1);
      num total = (r1?.unreadCount ?? 0);
      privateUnreadNum.value = total.toInt();
      UserService.to.state.totalUnread.value =
          messageUnreadNum.value + privateUnreadNum.value;
    } catch (_) {
      privateUnreadNum.value = 0;
      UserService.to.state.totalUnread.value =
          messageUnreadNum.value + privateUnreadNum.value;
    }
  }

  /// 设置未读数监听器
  void _setupUnreadCountListeners() {
    // 监听 MessageCenterListController 的 menu 变化
    if (Get.isRegistered<MessageCenterListController>()) {
      final centerListController = Get.find<MessageCenterListController>();
      ever(centerListController.menu, (_) {
        _updateMessageUnreadNum();
      });
      // 初始计算一次
      _updateMessageUnreadNum();
    } else {
      // 如果还未注册，延迟检查
      Future.delayed(Duration(milliseconds: 100), () {
        if (Get.isRegistered<MessageCenterListController>()) {
          final centerListController = Get.find<MessageCenterListController>();
          ever(centerListController.menu, (_) {
            _updateMessageUnreadNum();
          });
          _updateMessageUnreadNum();
        }
      });
    }

    // 监听 MessagePrivateListController 的 menu 变化
    // 由于 MessagePrivateListController 可能还未创建，使用延迟检查
    _checkAndListenPrivateController();
  }

  /// 检查并监听 MessagePrivateListController
  void _checkAndListenPrivateController() {
    if (_privateUnreadListenerSetup) {
      // 已建立过监听，仅刷新一次未读数（例如从其他 tab 切回私信）
      if (Get.isRegistered<MessagePrivateListController>()) {
        _updatePrivateUnreadNum();
      }
      return;
    }
    if (Get.isRegistered<MessagePrivateListController>()) {
      final privateListController = Get.find<MessagePrivateListController>();
      ever(privateListController.menu, (_) {
        _updatePrivateUnreadNum();
      });
      _privateUnreadListenerSetup = true;
      _updatePrivateUnreadNum();
    } else {
      // 如果还未注册，延迟检查（最多检查10次，每次间隔100ms）
      int checkCount = 0;
      void checkLoop() {
        if (checkCount >= 10) return;
        Future.delayed(Duration(milliseconds: 100), () {
          checkCount++;
          if (Get.isRegistered<MessagePrivateListController>()) {
            final privateListController =
                Get.find<MessagePrivateListController>();
            ever(privateListController.menu, (_) {
              _updatePrivateUnreadNum();
            });
            _privateUnreadListenerSetup = true;
            _updatePrivateUnreadNum();
          } else {
            checkLoop();
          }
        });
      }

      checkLoop();
    }
  }

  /// 更新 messageUnreadNum（MessageCenterListController 中所有页面的未读数总和）
  void _updateMessageUnreadNum() {
    if (!Get.isRegistered<MessageCenterListController>()) {
      messageUnreadNum.value = 0;
      return;
    }

    final centerListController = Get.find<MessageCenterListController>();
    num total = 0;

    // 遍历所有 menu 项，累加未读数
    for (var item in centerListController.menu) {
      if (item.number != null && item.number!.isNotEmpty) {
        final count = num.tryParse(item.number!) ?? 0;
        total += count;
      }
    }

    messageUnreadNum.value = total.toInt();
    UserService.to.state.totalUnread.value =
        messageUnreadNum.value + privateUnreadNum.value;
  }

  /// 更新 privateUnreadNum（MessagePrivateListController 中所有页面的未读数总和）
  void _updatePrivateUnreadNum() {
    if (!Get.isRegistered<MessagePrivateListController>()) {
      privateUnreadNum.value = 0;
      return;
    }

    final privateListController = Get.find<MessagePrivateListController>();
    num total = 0;

    // 遍历所有 menu 项，累加未读数
    for (var item in privateListController.menu) {
      if (item.number != null && item.number!.isNotEmpty) {
        final count = num.tryParse(item.number!) ?? 0;
        total += count;
      }
    }

    privateUnreadNum.value = total.toInt();
    UserService.to.state.totalUnread.value =
        messageUnreadNum.value + privateUnreadNum.value;
  }

  void editMessages(bool edit) {
    isEdit.value = edit;
    if (appBarIndex.value == 0) {
      Get.find<MessageCenterListController>().editMessages(edit);
    } else {
      Get.find<MessagePrivateListController>().editMessages(edit);
    }
  }

  void readAllMessages() {
    if (appBarIndex.value == 0) {
      Get.find<MessageCenterListController>().readAllMessages();
    } else {
      Get.find<MessagePrivateListController>().readAllMessages();
    }
  }

  void deleteAllMessages() {
    if (appBarIndex.value == 0) {
      Get.find<MessageCenterListController>().deleteAllMessages();
    } else {
      Get.find<MessagePrivateListController>().deleteAllMessages();
    }
  }

  void selectCurrentPage() {
    if (appBarIndex.value == 0) {
      Get.find<MessageCenterListController>().selectCurrentPage();
    }
  }
}
