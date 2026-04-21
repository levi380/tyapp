import 'dart:async';

import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:get/get.dart';

import '../../../global/config_controller.dart';
import '../../match_detail/models/odds_button_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
    【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 购物车条目
      选择投注项时，先把数据组装加入购物车
      和投注有关的数据会组装成ShopCartItem，投注的数据变化都在ShopCartItem上进行。这样减少投注模块与其它模块的耦合
    】】】
 *
 */
class ShopCartItem {
  late String cds;
  late String sportId; // 球种id
  late String matchId; // 赛事id
  late String tournamentId; //联赛id
  late String scoreBenchmark; // 比分
  late String marketId; //盘口ID
  late String marketValue;
  late String playOptionsId; //投注项id
  late String marketTypeFinally; //欧洲版默认是欧洲盘 HK代表香港盘
  late int odds; //十万位赔率
  late int discountOdds;//优惠赔率
  String? odds2; //十万位赔率，美国盘、英国盘、印尼盘、马来盘 赔率
  late RxString oddFinally; //最终赔率
  late String sportName; //球种名称
  late int matchType; //赛事类型
  late String matchName; //赛事名称
  late String playOptionName; // 投注项名称
  late String playOptions; // 投注项
  late int tournamentLevel; //联赛级别
  late String playId; //玩法ID
  late String cplayId;//子玩法ID
  late String playName; //玩法名称
  late String dataSource; //数据源
  late String home; //主队名称
  late String away; //客队名称
  //late String ot;              //投注項类型
  int? placeNum; //盘口坑位
  // 以下为 投注显示或者逻辑计算用到的参数
  late String betAmount; // 投注金额
  late OddsBetType betType; // 投注类型
  late String tidName; // 联赛名称
  late int matchMs; // 赛事阶段
  late String matchMmp; //赛事阶段 限额
  late String matchTime; // 开赛时间
  late String handicap; // 投注项名称
  late RxString handicapHv; // 投注项 球头
  late String markScore; // 显示的基准分
  late int mbmty; //  2 or 4的  都属于电子类型的赛事
  late RxInt olOs; // 投注项状态 1：开 2：封 3：关 4：锁
  late RxInt hlHs; // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
  late RxInt
      midMhs; // 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态）
  late String matchCtr; // 数据仓库 获取比分
  late int deviceType; // 设备号
  late String oddsHsw; // 投注项支持的赔率
  late int ispo; // 电竞赛事 0为不支持串关的赛事
  late int hipo; //电竞赛事 不支持串关的赛事 盘口值
  late int hpsHids; //判断是否允许串关用
  late String scoreHome; // 主队进球数
  late String scoreAway; // 客队进球数
  late String scoreHomeAway;
  late String preMarketValue; //存储预约marketValue
  late String vrNo;

  final oddStateType = OddStateType.none.obs;
  Timer? timerOdds;
  DateTime changeTime = DateTime.now();
  int savedOdds = 0;

  //监控是否关闭
  Worker? everListener;

  //Vue在坑位变化时设置此字段。目前App中没用
  bool marketChange = false;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - isColsed:判断投注项是否关闭
      投注项状态 1：开 2：封 3：关 4：锁
      盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态）
      】】】
   *
   */
  bool get isColsed =>
      [2, 3].contains(olOs.value) ||
      [1, 2].contains(hlHs.value) ||
      [1, 2, 11].contains(midMhs.value);

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - canParlay:是否支持串关
      mbmty 2 or 4 为电子赛事  足球 篮球 C01 O01 不支持串关
      】】】
   *
   */
  bool get canParlay => !(betType == OddsBetType.guanjun ||
      // 不支持串关的  电竞赛事
      (betType == OddsBetType.esport && (ispo == 0 || hipo == 0)) ||
      // 不支持串关的 数据源
      ["O01"].contains(dataSource)
      //|| ([2, 4].contains(mbmty)  && ['1','2'].contains(sportId) )
      || (betType == OddsBetType.common && hpsHids != 1)
  );

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - isLocked:是否锁盘
      】】】
   *
   */
  bool get isLocked =>
      olOs.value == 4 || hlHs.value == 11 || midMhs.value == 11;

  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - itemId:购物车条目ID
        如果是固定坑位的投注项，使用赛事id+玩法id+坑位+投注项类型，因为选中坑位的投注项Id可能会变
        如果非固定坑位，直接使用投注项Id
      】】】
   *
   */
  String get itemId {
    if (placeNum != null) {
      if(sportId == "1" && ConfigController.to.accessConfig.value.marketIsOpen){
        //固定盘口用投注项Id
        return playOptionsId;
      }else {
        //赛事id+玩法id+坑位+投注项类型
        return matchId + playId + placeNum.toString() + playOptions;
      }
    } else {
      //没有坑位用投注项Id
      return playOptionsId;
    }
  }

  //
  /**
   *
   *
      【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
      【【【 AUTO_DOCUMENT_TITLE 投注Model 】】】
      【【【 AUTO_PARAGRAPH_TITLE 购物车条目类】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - changeOdds:赔率变化
        赔率改变时，设置购物车数据的赔率状态，用以显示赔率红升绿降
        同时设置定时器，3秒后将赔率状态复位，恢复赔率颜色的普通显示
      】】】
   *
   */
  void changeOdds(int newOdds,[int newDiscountOdd = 0]){
    /*
    if(newOdds > odds){
      oddStateType.value = OddStateType.oddUp;
      timerOdds?.cancel();
      timerOdds = Timer(Duration(seconds: 3), () {
        oddStateType.value = OddStateType.none;
        timerOdds?.cancel();
      });
    } else if (newOdds < odds) {
      oddStateType.value = OddStateType.oddDown;
      timerOdds?.cancel();
      timerOdds = Timer(Duration(seconds: 3), () {
        oddStateType.value = OddStateType.none;
        timerOdds?.cancel();
      });
    }
    odds = newOdds;
    */

    //避免赔率变化过于频繁，搞垃圾代码
    int oldOdds;
    if(DateTime.now().difference(changeTime)<Duration(milliseconds: 100) ){
      oldOdds = savedOdds;
    }else{
      oldOdds = odds;
      savedOdds = odds;
    }
    if(newDiscountOdd !=discountOdds){
      if(newDiscountOdd > discountOdds){
        oddStateType.value = OddStateType.oddUp;
        timerOdds?.cancel();
        timerOdds = Timer(Duration(seconds: 3), () {
          oddStateType.value = OddStateType.none;
          timerOdds?.cancel();
        });
      }else if(newDiscountOdd < discountOdds){
        oddStateType.value = OddStateType.oddDown;
        timerOdds?.cancel();
        timerOdds = Timer(Duration(seconds: 3), () {
          oddStateType.value = OddStateType.none;
          timerOdds?.cancel();
        });
      }
    }
    else if(newOdds > oldOdds){
      oddStateType.value = OddStateType.oddUp;
      timerOdds?.cancel();
      timerOdds = Timer(Duration(seconds: 3), () {
        oddStateType.value = OddStateType.none;
        timerOdds?.cancel();
      });
    }else if(newOdds < oldOdds){
      oddStateType.value = OddStateType.oddDown;
      timerOdds?.cancel();
      timerOdds = Timer(Duration(seconds: 3), () {
        oddStateType.value = OddStateType.none;
        timerOdds?.cancel();
      });
    }

    changeTime = DateTime.now();
    odds = newOdds;
    discountOdds = newDiscountOdd;
  }
}
