import 'package:get/get.dart';

import '../../../services/models/res/bet_amount_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关选项类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关选项类
      包括比如2串1的代码、名字、数量
      限额接口返回的限额数据也存放在该类里面
    】】】
 *
 */
class BetCountModel {
  String id;
  String localeName;
  String name;
  int count;



  Rxn<BetAmountBetAmountInfo> betAmountInfo =  Rxn<BetAmountBetAmountInfo>();

  BetCountModel(this.id,this.localeName,this.name,this.count);
}

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关选项说明类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关选项说明类
      保存串关选项说明数据。点击2串1的？图标后，弹框展示该类中保存的说明数据
    】】】
 *
 */
class BetTipsModel{
  String id;
  String tipsTitle;
  String tipsContent;
  BetTipsModel(this.id,this.tipsTitle,this.tipsContent);
}