
import 'package:flutter_ty_app/app/modules/main_tab/widgets/annualReportPortal_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/bottomNavigationBar_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/floatingActionButton_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/footballAndBasketball_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/rightMenu_widget.dart';

import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';

import '../../../main.dart';
import '../../widgets/fireworks/fireworks_animation.dart';
import '../home/controllers/home_controller.dart';
import '../home/models/match_list_type.dart';
import '../home/views/home_view.dart';
import '../login/login_head_import.dart';
import 'main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE APP底部菜单 视图 MainTabPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP底部菜单 视图 MainTabPage
    - MainTabPage
    ```
    ///列表组件
    body: _body(listType),

    ///浮动按钮
    floatingActionButton: _floatingActionButton(),

    ///底部菜单
    bottomNavigationBar: _bottomNavigationBar(listType),
    ```
    】】】
 *
 */
class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final controller = Get.find<MainTabController>();
  final logic = Get.find<MainTabController>().logic;

  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
          //关闭购物车之后再退出
          canPop: !ShopCartController.to.state.showShopCart.value,
          onPopInvoked: (didPop) {
            if (ShopCartController.to.state.showShopCart.value) {
              ShopCartController.to.currentBetController?.closeBet();
            }
          },
          child: GetBuilder<MainTabController>(
            builder: (controller) {
              MatchListType listType;
              if (Get.isRegistered<TyHomeController>(tag: controller.uuid)) {
                listType = TyHomeController.to.homeState.listType;
              } else {
                //如果TyHomeController还未创建，则显示缺省菜单
                listType = MatchListType.home;
              }
              return Scaffold(
                ///列表组件
                body: _body(listType),

                ///浮动按钮
                floatingActionButton: floatingActionButtonWidget(
                  controller: controller,
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

                ///底部菜单
                bottomNavigationBar: bottomNavigationBarWidget(
                  controller: controller,
                  listTyper: listType,
                ),
              );
            },
          ),
        ));
  }

  ///列表组件
  Widget _body(MatchListType listType) {
    return Stack(
      children: [
        ///首页列表
        const HomeView(),

        ///烟花效果
        Obx(() => controller.isFireworksPaly.value
            ? FireworksAnimation(
                id: controller.fireworksId.value,
                beginTime: controller.beginTime.value,
                endTime: controller.endTime.value,
                type: controller.fireworksType.value,
                number: controller.fireworksNumber,
                championName: controller.championName.value,
                championIcon: controller.championIcon.value,
              )
            : Container()),

        ///右侧悬浮菜单
        if (bottomHideSwitch == true)
          rightMenuWidget(
            controller: controller,
            listTyper: listType,
          ),

        ///年报入口
        if (AnnualReportEntrance == true &&
            (Get.locale?.countryCode == 'TW' ||
                Get.locale?.countryCode == 'CN' ||
                Get.locale?.countryCode == 'GB'))
          annualReportPortalWidget(
            controller: controller,
          ),

        /// 需求4186    足球篮球专题页入口
        if (footballBasketballTemplate == true)
          footballAndBasketballWidget(
            controller: controller,
          ),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<MainTabController>();
    super.dispose();
  }
}
