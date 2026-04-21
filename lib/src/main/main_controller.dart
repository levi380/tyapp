//FullLifeCycleController
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/views/activity_view.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:filbet/src/home/home_view.dart';
import 'package:filbet/src/mine/views/mine_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/activity/controllers/activity_controller.dart';

class MainController extends GetXBaseController {
  static MainController get to => Get.find();

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int v) => _currentIndex.value = v;

  ///记录一下优惠活动tab,方便全局路由页面判断
  ///0:优惠 1:任务
  int youhuiTaskTab = 0;

  late PageController pageController;

  List<String> get icons {
    List<String> list = [
      Assets.homeHome,
      Assets.homeActivity,
      Assets.homeKf,
      Assets.homeMine,
    ];
    return list;
  }

  List<String> get titles {
    List<String> list = [
      "home".tr,
      "activity".tr,
      "customer_service".tr,
      "mine".tr,
    ];
    return list;
  }

  List<String> get sicons {
    List<String> list = [
      Assets.homeHomes,
      Assets.homeActivitys,
      Assets.homeKfs,
      Assets.homeMines,
    ];
    return list;
  }

  List<Widget> get pages {
    List<Widget> list = [
      HomeView(),
      ActivityView(),
      SizedBox(),
      MineView(),
    ];
    return list;
  }

  @override
  void onInit() {
    _applyInitialTabFromArgs();
    _init();
    super.onInit();
  }

  void _applyInitialTabFromArgs() {
    final args = Get.arguments;
    if (args is Map) {
      final raw = args["tabIndex"];
      final parsed = raw is int ? raw : int.tryParse('$raw');
      if (parsed != null) {
        currentIndex = parsed.clamp(0, 3);
      }
    }
  }

  void _init() {
    pageController = PageController(initialPage: currentIndex);

    // 首次进入如果直接落在 Activity tab，补一次数据初始化（避免 jumpToPage 才触发）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentIndex == 1 && Get.isRegistered<ActivityController>()) {
        if (ActivityController.to.typeList.isEmpty) {
          ActivityController.to.getPromoTypeData();
        }
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void jumpToPage(int index) {
    if (currentIndex != index) {
      ///后台没配置底部home
      if (index == 3) {
        if (UserService.to.state.isVisitor) {
          EventBus.emit(EventType.goToLogin);
          return;
        }
        MineController.to.memberreport();
        MineController.to.fetchMemberVipInfo();

        UserService.to.getUserInfos();
        MineController.to.financewallet();
      }
      if (index == 2) {
        //  ServiceController.to.fetchDataloading(loading: false);
        AppNavigator.gotoseveiceForMain();
      }

      if (index == 1) {
        if (ActivityController.to.typeList.isEmpty) {
          ActivityController.to.getPromoTypeData();
        }
      }
      if (index != 2) {
        pageController.jumpToPage(index);
        currentIndex = index;
      }

      return;
    }

    // /// 改成每次进入充值页面都刷新一次
    // if (bottomBarOnline[index].tag == appBottomRecharge &&
    //     Get.isRegistered<RechargeController>()) {
    //   Get.delete<RechargeController>();
    // }
  }

  @override
  void onResume() {
    print('main 进入前台');
    // if (UserService.to.state.isRegularUser) {
    //   UserService.to.checkToken();
    // }
  }
}
