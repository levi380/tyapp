

import 'package:flutter/material.dart';




import '../shop_cart_controller.dart';




import 'group_single_bet_controller.dart';

class GroupSingleBetComponent extends StatelessWidget {
  GroupSingleBetComponent({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController as GroupSingleBetController;
  final state = ShopCartController.to.state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
