// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/home/home_view_controller.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:get/get.dart';
import 'package:filbet/routes/app_pages.dart';

class EventConfig {
  void jumpToHomePage() {}

  void jumpToUserCenterPage() {}

  void jumpToActivityPage() {}

  void jumpToRechargePage() {
    //
  }

  void jumpToVipPage() {}

  void registerEvent() {
    // if (Get.currentRoute == Routes.splash) return;

    // if (Get.previousRoute == Routes.splash) {
    //   Get.back();
    //   return;
    // }
    // if (Get.currentRoute != Routes.main) {
    //   ///干掉所有page，直到 mainPage 为止
    //   ///首页弹窗代表现在已经在mainPage
    //   Get.until(
    //     (route) =>
    //         Get.currentRoute == Routes.main ||
    //         Get.currentRoute == Routes.dialogHomeAlien ||
    //         Get.currentRoute == Routes.dialogHomeNotification ||
    //         Get.currentRoute == Routes.dialogHomeUpdate,
    //   );
    // }

    // if (arg == 'showPromotionDialog') {
    //   showHomePromotionDialog(false);
    // }

    // jumpToHomePage();

    EventBus.on(EventType.goToLogin, (arg) {
      print('前往登录');
      Get.toNamed(Routes.LOGIN_AND_REGISTER, arguments: {"type": 0});
    });

    EventBus.on(EventType.goToRegister, (arg) {
      Get.toNamed(Routes.LOGIN_AND_REGISTER, arguments: {"type": 1});
    });

    //刷新个人中心
    EventBus.on(EventType.onRefUserCenter, (arg) {});

    EventBus.on(EventType.onLogout, (arg) {});

    EventBus.on(EventType.onLogin, (arg) {
      HomeViewController.to.noticelogList();
    });

    EventBus.on(EventType.onSiteMaintain, (arg) {
      // todo: to maintain page
    });

    EventBus.on(EventType.onAuthRequire, (arg) {});

    ///存款
    EventBus.on(EventType.onGoRecharge, (arg) {
      if (UserService.to.state.isVisitor) {
        EventBus.emit(EventType.goToLogin);
        return;
      }
      Get.toNamed(Routes.DEPOSIT);
    });

    ///取款
    EventBus.on(EventType.onGoWithdraw, (arg) {
      if (UserService.to.state.isVisitor) {
        EventBus.emit(EventType.goToLogin);
        return;
      }
      Get.toNamed(Routes.WITHDRAW);
    });

    ///vip
    EventBus.on(EventType.onGoVip, (arg) {
      if (UserService.to.state.isVisitor) {
        EventBus.emit(EventType.goToLogin);
        return;
      }
      Get.toNamed(Routes.VIP_PRIVILEDGE);
    });

    ///vip
    EventBus.on(EventType.onGoTransfer, (arg) {
      if (UserService.to.state.isVisitor) {
        EventBus.emit(EventType.goToLogin);
        return;
      }
      Get.toNamed(Routes.TRANSFER);
    });
  }
}
