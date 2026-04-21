import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/pk10_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/series3_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/sicbo_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/speed3_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/taiguo_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/threed_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/tw539_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/tw581_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/viet13_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/viet15_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/viet16_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/viet19_widget.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/settled/vite_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';
import 'baccarat_widget.dart';
import 'dianjing_widget.dart';
import 'five_of_eleven_widget.dart';
import 'happy8_widget.dart';
import 'keno_widget.dart';
import 'lucky28_widget.dart';
import 'mark_six.dart';
import 'double_color_widget.dart';
import 'shishi_widget.dart';
import 'pk10_serial_widget.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注记录列表信息视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票已结算注单Item
    - 已结算注单 样式多样化选择，根据type判断该显示哪种widget

    】】】
 *
 */
class BetShowContent extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  BetShowContent(this.orderListItem, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget? widget;
    // AppLogger.debug("===============================>${orderListItem.ticketName}  ${orderListItem.seriesId}");

    switch (orderListItem.seriesId?.toInt()) {
      case 1:
        //时时彩样式
        widget = ShiShiWidget(orderListItem);
        break;
      case 2:
        // 11选5样式
        widget = FiveOfElevenWidget(orderListItem);
        break;
      case 3:
        // 六合彩样式
        widget = MarkSix(orderListItem);
        break;
      case 4:
        // 3d彩票样式
        widget = ThreedWidget(orderListItem);
        break;
      case 5:
        // 快乐8样式
        widget = Happy8Widget(orderListItem);
        break;
      case 6:
        // PK10样式
        widget = PK10Widget(orderListItem);
        break;
      case 7:
        //快三样式
        widget = Speed3Widget(orderListItem);
        break;
      case 8:
        // 连续彩票样式
        widget = SeriesWidget(orderListItem);
        break;
      case 9:
        // sicbo 特色菜样式
        widget = SicboWidget(orderListItem);
        break;
      case 10:
        // 百家乐样式
        widget = BaccaratWidget(orderListItem);
        break;
      case 11:
        // 普通pk10样式
        widget = PK10Widget(orderListItem);
        break;
      case 13:
        // 万宁福字
        widget = Viet13Widget(orderListItem);
        break;
      case 27:
        // 特色PK10样式
        widget = PK10SerialWidget(orderListItem);
        break;
      case 12:
        // 双色球样式
        widget = DoubleColorWidget(orderListItem);
        break;
      case 15:
        // 越南菜15样式
        widget = Vite15Widget(orderListItem);
        break;
      case 16:
        // 越南菜15样式
        widget = Vite16Widget(orderListItem);
        break;
      case 14:
        // 越南菜15样式
        widget = ViteWidget(orderListItem);
        break;

      case 18:
        // 幸运28样式
        widget = TaiguoWidget(orderListItem);
        break;
      case 19:
        // 幸运28样式
        widget = Lucky28Widget(orderListItem);
        break;
      case 20:
        // keno特色菜样式
        widget = KenoWidget(orderListItem);
        break;
      case 21:
        // 太旺539样式
        widget = Tw539Widget(orderListItem);
        break;
      case 24:
        // 台湾581样式
        widget = Tw581Widget(orderListItem);
        break;
      case 26:
        // 越南菜19样式
        widget = Vite19Widget(orderListItem);
        break;

      case 17:
        // 电竞 英雄 男女 样式
        widget = DianJingWidget(orderListItem);
        break;
    }
    return widget ?? const SizedBox();
  }
}
