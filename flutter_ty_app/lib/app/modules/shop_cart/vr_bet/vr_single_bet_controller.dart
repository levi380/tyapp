import '../esport_bet/esport_single_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE Vr单关投注控制类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - Vr单关投注控制类
    继承自电竞单关投注控制类
    】】】
 *
 */
class VrSingleBetController extends EsportSingleBetController{
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE Vr单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 切换到串关模式，并且把当前ShopCartItem加入
      】】】
   *
   */
  @override
  Future<void> goParlay() async {
    ShopCartItem item = itemList.first;
    closeBet();
    ShopCartController.to.isVrParlay.value = true;
    ShopCartController.to.currentBetController?.addShopCartItem(item);
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
      【【【 AUTO_PARAGRAPH_TITLE Vr单关投注控制类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 倒计时
        Vr倒计时从比赛时间中获取
      】】】
   *
   */
  @override
  int countDownSeconds(ShopCartItem shopCartItem){
    final beginSeconds = ((int.tryParse(shopCartItem.matchTime) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    int diffSeconds = (beginSeconds - nowSeconds).round();
    return diffSeconds + 1;
  }
}