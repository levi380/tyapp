import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';

import 'model/bet_history_record.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 购物车工具类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注用户输入记忆
      以itemId为key记录
    】】】
 *
 */
class ShopCartHistory{
  ShopCartHistory._privateConstructor();
  static final ShopCartHistory _instance = ShopCartHistory._privateConstructor();

  factory ShopCartHistory() {
    // 返回静态私有实例
    return _instance;
  }

  final Map<String,BetHistoryRecord> historyRecordMap = {};

  BetHistoryRecord getHistoryRecord(ShopCartItem shopCartItem){

    BetHistoryRecord? record = historyRecordMap[shopCartItem.itemId];
    if(record == null){
      record = BetHistoryRecord(shopCartItem);
      historyRecordMap[shopCartItem.itemId] = record;
    }

    return record;
  }

  void removeHistoryRecord(ShopCartItem shopCartItem){
    BetHistoryRecord? record = historyRecordMap[shopCartItem.itemId];
    if(record != null){
      historyRecordMap.remove(shopCartItem.itemId);
    }
  }
}
