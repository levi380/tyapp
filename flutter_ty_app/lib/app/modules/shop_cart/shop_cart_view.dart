import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_landscape_view.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_single_bet_controller.dart';
import 'package:get/get.dart';
import 'combo_courage_bet/combo_courage_bet_controller.dart';
import 'combo_courage_bet/combo_courage_bet_view.dart';
import 'esport_bet/esport_mix_bet_controller.dart';
import 'esport_bet/esport_single_bet_controller.dart';
import 'group_bet/group_single_bet_controller.dart';
import 'group_bet/group_single_bet_view.dart';
import 'mix_bet/mix_bet_controller.dart';
import 'mix_bet/mix_bet_view.dart';
import 'shop_cart_controller.dart';
import 'single_bet/single_bet_controller.dart';
import 'single_bet/single_bet_view.dart';
import 'vr_bet/vr_mix_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注入口Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注入口
    根据当前的投注控制器，展示对应的投注widget
    】】】
 *
 */
class ShopCartComponent extends StatelessWidget {
  ShopCartComponent({Key? key}) : super(key: key);

  final logic = ShopCartController.to;
  final state = ShopCartController.to.state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var currentBetController = logic.currentBetController;
      if(currentBetController is GroupSingleBetController) {
        //合买
        return GroupSingleBetComponent();
      }else if(currentBetController is ComboCourageBetController)
      {
        //自选波胆
        return ComboCourageBetComponent();
      }else if (currentBetController is VrSingleBetController) {
        //VR单关
        return SingleBetComponent<VrSingleBetController>();
      } else if (currentBetController is EsportSingleBetController) {
        //电竞单关
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleBetLandscapeComponent<EsportSingleBetController>();
        } else {
          return SingleBetComponent<EsportSingleBetController>();
        }
      } else if (currentBetController is SingleBetController) {
        //单关
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return SingleBetLandscapeComponent<SingleBetController>();
        } else {
          return SingleBetComponent<SingleBetController>();
        }
      } else if (currentBetController is VrMixBetController) {
        //VR串关
        return MixBetComponent<VrMixBetController>();
      } else if (currentBetController is EsportMixBetController) {
        //电竞串关
        return MixBetComponent<EsportMixBetController>();
      } else if (currentBetController is MixBetController) {
        //串关
        return MixBetComponent<MixBetController>();
      } else {
        return Container();
      }
    });
  }
}
