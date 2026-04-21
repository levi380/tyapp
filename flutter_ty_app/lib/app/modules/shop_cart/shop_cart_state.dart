import 'package:get/get.dart';

import '../home/models/main_menu.dart';

class ShopCartState {
  //购物车显示收敛控制开关
  final showShopCart = false.obs;
  //串关右下角悬浮球是否显示
  final isMaintabDialogicOpen = false.obs;
  //早盘、滚球、串关、冠军 index
  MainMenu menu = MainMenu(0, '', 0, 0);
  //电竞冠军
  bool isDjGuanjun = false;
  //保存可预约的投注项
  final List<String> prebookOidList = [];
  String? currentRoute;
  String sportId = "";
  bool isDjMenu = false;
  bool isVrMenu = false;

  ShopCartState() {
    ///Initialize variables
  }
}
