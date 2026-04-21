import 'dart:math';


import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/bet_count_model.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:oktoast/oktoast.dart';

import '../../../generated/locales.g.dart';

export 'shop_cart_util_headcap.dart';

class ShopCartUtil{
  static Map betCountMap = {
    2:[BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",1)],
    3:[BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",3),BetCountModel('3004',LocaleKeys.bet_bet_3004,"3串4",4)],
    4:[BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",6),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",4),BetCountModel('40011',LocaleKeys.bet_bet_40011,"4串11",11)],
    5:[BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",10),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",10),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",5),BetCountModel('50026',LocaleKeys.bet_bet_50026,"5串26",26)],
    6:[BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",15),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",20),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",15),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",6),BetCountModel('60057',LocaleKeys.bet_bet_60057,"6串57",57)],
    7:[BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",21),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",35),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",35),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",21),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",7),BetCountModel('700120',LocaleKeys.bet_bet_700120,"7串120",120)],
    8:[BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",28),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",56),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",70),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",56),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",28),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",8),BetCountModel('800247',LocaleKeys.bet_bet_800247,"8串247",247)],
    9:[BetCountModel('9001',LocaleKeys.bet_bet_9001,"9串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",36),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",84),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",126),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",126),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",84),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",36),BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",9),BetCountModel('900502',LocaleKeys.bet_bet_900502,"9串502",502)],
    10:[BetCountModel('10001',LocaleKeys.bet_bet_10001,"10串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",45),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",120),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",210),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",252),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",210),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",120),BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",45),BetCountModel('9001',LocaleKeys.bet_bet_9001,"9串1",10),BetCountModel('10001013',LocaleKeys.bet_bet_10001013,"10串1013",1013)],
  };

  static Map betTipsMap = {
    '2001':BetTipsModel('2001',LocaleKeys.app_h5_bet_toltips_2001_title,LocaleKeys.app_h5_bet_toltips_2001_content),
    '3001':BetTipsModel('3001',LocaleKeys.app_h5_bet_toltips_3001_title,LocaleKeys.app_h5_bet_toltips_3001_content),
    '4001':BetTipsModel('4001',LocaleKeys.app_h5_bet_toltips_4001_title,LocaleKeys.app_h5_bet_toltips_4001_content),
    '5001':BetTipsModel('5001',LocaleKeys.app_h5_bet_toltips_5001_title,LocaleKeys.app_h5_bet_toltips_5001_content),
    '6001':BetTipsModel('6001',LocaleKeys.app_h5_bet_toltips_6001_title,LocaleKeys.app_h5_bet_toltips_6001_content),
    '7001':BetTipsModel('7001',LocaleKeys.app_h5_bet_toltips_7001_title,LocaleKeys.app_h5_bet_toltips_7001_content),
    '8001':BetTipsModel('8001',LocaleKeys.app_h5_bet_toltips_8001_title,LocaleKeys.app_h5_bet_toltips_8001_content),
    '9001':BetTipsModel('9001',LocaleKeys.app_h5_bet_toltips_9001_title,LocaleKeys.app_h5_bet_toltips_9001_content),
    '10001':BetTipsModel('10001',LocaleKeys.app_h5_bet_toltips_10001_title,LocaleKeys.app_h5_bet_toltips_10001_content),
    '3004':BetTipsModel('3004',LocaleKeys.app_h5_bet_toltips_3004_title,LocaleKeys.app_h5_bet_toltips_3004_content),
    '40011':BetTipsModel('3004',LocaleKeys.app_h5_bet_toltips_40011_title,LocaleKeys.app_h5_bet_toltips_40011_content),
    '50026':BetTipsModel('50026',LocaleKeys.app_h5_bet_toltips_50026_title,LocaleKeys.app_h5_bet_toltips_50026_content),
    '60057':BetTipsModel('60057',LocaleKeys.app_h5_bet_toltips_60057_title,LocaleKeys.app_h5_bet_toltips_60057_content),
    '700120':BetTipsModel('700120',LocaleKeys.app_h5_bet_toltips_700120_title,LocaleKeys.app_h5_bet_toltips_700120_content),
    '800247':BetTipsModel('800247',LocaleKeys.app_h5_bet_toltips_800247_title,LocaleKeys.app_h5_bet_toltips_800247_content),
    '900502':BetTipsModel('900502',LocaleKeys.app_h5_bet_toltips_900502_title,LocaleKeys.app_h5_bet_toltips_900502_content),
    '10001013':BetTipsModel('10001013',LocaleKeys.app_h5_bet_toltips_10001013_title,LocaleKeys.app_h5_bet_toltips_10001013_content),
  };

  static String getCodeMessage(String code,{String? message}){
    String text = '';
    switch(code){
      case '200':
        text = message??LocaleKeys.bet_message_loading.tr;
        break;
      case '0402001':
      case '0402002':
      case '0402003':
      case '0402005':
      case '0402006':
      case '0402007':
      case '0402008':
      //盘口已失效
        text = LocaleKeys.bet_message_m_0402001.tr;
        break;
      case '0402011':
      case '0402012':
      case '0402016':
      case '0402022':
      case '0402024':
      case '0402025':
      case '0402026':
      case '0402043':
      case '0402044':
      case '0402045':
      case '0402046':
      case '0402047':
      case '04020448':
      case '04020449':
      case '0400451':
      case '0400452':
      case '0400461':
      case 'DJ006':
        text = LocaleKeys.bet_message_m_0402001.tr;
        break;
      case '0402009':
      case '0402010':
      case '0402023':
      case '0402027':
      case '0402028':
      // 投注项盘口、赔率或有效性产生变化!
        text = LocaleKeys.bet_message_m_0402009.tr;
        break;
      case '0402014':
      // 网络异常，请在注单中查看投注结果
        text = LocaleKeys.bet_message_m_0402014.tr;
        break;

      case '0402015':
      case '0402017':
      case '0402020':
      case '0402021':
      case '0402039':
      case '0402040':
      case '0402041':
      case '0400456':
      case '0400457':
      case '0400458':
      case '0400462':
      case '0400463':
      case '0400500':
      case 'XXXXXX':
      case 'DJ999':
      // 投注未成功~再试一次吧
        text = LocaleKeys.bet_message_m_0402015.tr;
        break;
      case '0402018':
      case '0402019':
      case '0402038':
      case '0400450':
      // 投注未成功，请稍后再试
        text = LocaleKeys.bet_message_m_0402018.tr;
        break;
      case '132113':
      // 投注失败，请重新选择投注项
        text = LocaleKeys.bet_message_m_132113.tr;
        break;
      case '0402035':
      case '0400454':
      case '0400455':
      // 余额不足，请您先充值
        text = LocaleKeys.bet_message_m_0402035.tr;
        break;
      case '0402042':
      // 网络异常，请联系客服
        text = LocaleKeys.bet_message_m_0402042.tr;
        break;
      case '0400453':
      //  "m_0400453": "账户异常，请联系客服",
        text = LocaleKeys.bet_message_m_0400453.tr;
        break;
      case '0400459':
      //  "m_0400459": "盘口确认中，请稍等",
        text = LocaleKeys.bet_message_m_0400459.tr;
        break;
      case '0400460':
      //  "m_0400460": "拒绝投注",
        text = LocaleKeys.bet_message_m_0400460.tr;
        break;
      case '0400464':
      case '0400475':
      // "m_0400464": "额度已变更，再试一次吧~",
        text = LocaleKeys.bet_message_m_0400464.tr;
        break;
      case '0400468':
      //  "m_0400468": "比分已变更，再试一次吧",
        text = LocaleKeys.bet_message_m_0400468.tr;
        break;
      case '0400469':
      // "m_0400469": "投注项盘口、赔率或有效性产生变化!",
        text = LocaleKeys.bet_message_m_0400469.tr;
        break;
      case 'M400004':
      //未定义
      //text = LocaleKeys.bet_message_m_M400004.tr;
        text = code;
        break;
      case 'M400005':
        text = LocaleKeys.bet_message_m_M400005.tr;
        break;
      case 'M400007':
        text = LocaleKeys.bet_message_m_M400007.tr;
        break;
      case 'M400009':
        text = LocaleKeys.bet_message_m_M400009.tr;
        break;
      case 'M400010':
      case 'DJ002':
        text = LocaleKeys.bet_message_m_M400010.tr;
        break;
      case 'M400011':
        text = LocaleKeys.bet_message_m_M400011.tr;
        break;
      case 'M400012':
        text = LocaleKeys.bet_message_m_M400012.tr;
        break;
      case '0401038':
        text = LocaleKeys.bet_message_m_0401038.tr;
        break;
      case 'DJ001':
        text = LocaleKeys.bet_message_m_DJ001.tr;
        break;
      case 'DJ003':
        text = LocaleKeys.bet_message_m_DJ003.tr;
        break;
      case 'DJ004':
        text = LocaleKeys.bet_message_m_DJ004.tr;
        break;
      case 'DJ005':
        text = LocaleKeys.bet_message_m_DJ005.tr;
        break;
      case '400004':
        text = LocaleKeys.bet_message_m_400004.tr;
        break;
      case '0402601':
        text = LocaleKeys.bet_message_m_0402601.tr;
        break;
      default:
        text = message??'';
        break;
    }
    return text;
  }

  static List<BetCountModel> getBetCountJoint(int count){
    List<BetCountModel>? ret = betCountMap[count];
    return ret??[];
  }

  static void showBetError(String code,{String? message,String? prefixMsg}){
    String errMsg = getCodeMessage(code,message: message);
    ToastUtils.showGrayBackground((prefixMsg??'')+errMsg);
  }

  static String getRejectOrderReason(String riskEvent){
    switch(riskEvent){
      case 'bet_order_place_num_changeDS':
      case 'bet_order_place_num_changePA':
      case 'bet_order_place_num_change':
        {
          return LocaleKeys.bet_message_bet_order_place_num_change;
        }
      case 'order_odds_change_hold_self':
      case 'order_odds_change_low':
        {
          return LocaleKeys.bet_message_order_odds_change;
        }
      case 'order_odds_change' :
        {
          return LocaleKeys.bet_message_order_odds_change_large;
        }
      case 'merchant_handle_fail':
        {
          return LocaleKeys.bet_message_merchant_handle_fail;
        }
      case 'bus_refuse_120s':
      case 'bus_refuse_600s':
      case 'bus_refuse_20s':
      case 'bus_refuse_16s':
      case 'bus_refuse_305s':
        {
          return LocaleKeys.bet_message_bus_refuse;
        }
      case 'over_payout':
        {
          return LocaleKeys.bet_message_over_payout.tr;
        }
    // case 'market_status_suspended':
    // case 'market_status_suspended-DS':
    // case 'market_status_suspended-PA':
    // case 'match_handicap_status_suspended':
    // case 'match_handicap_status_suspended-PA':
    // case 'match_handicap_status_suspended-DS':
    // case 'match_handicap_status_deactivated-PA':
    // case 'match_handicap_status_deactivated-DS':
    // case 'match_handicap_status_deactivated':
    // case 'market_status_locked-PA':
    // case 'market_status_locked-DS':
    // case 'match_status_exception':
    // case 'match_status_exception-PA':
    // case 'match_status_exception-DS':
    // case 'match_status_closed':
    // case 'match_status_closed-PA':
    // case 'match_status_closed-DS':
    // case 'match_over_status_exception':
    // case 'match_over_status_exception-PA':
    // case 'match_over_status_exception-DS':
    // case 'match_over_status_no_bet':
    // case 'match_over_status_no_bet-PA':
    // case 'match_over_status_no_bet-DS':
    // case 'match_over_status_over':
    // case 'match_over_status_over-PA':
    // case 'match_over_status_over-DS':
    // case 'match_handicap_status_exception':
    // case 'match_handicap_status_exception-PA':
    // case 'match_handicap_status_exception-DS':
    // case 'market_status_exception':
    // case 'market_status_exception-DS':
    // case 'market_status_exception-PA':
    // case 'market_status_no_active':
    // case 'market_status_no_active-DS':
    // case 'market_status_no_active-PA':
    // case 'market_status_deactivated':
    // case 'market_status_deactivated-DS':
    // case 'market_status_deactivated-PA':
    // case 'market_status_settled':
    // case 'market_status_cancelled':
    // case 'market_status_cancelled-DS':
    // case 'market_status_cancelled-PA':
    // case 'market_status_handed_over':
    // case 'market_status_handed_over-DS':
    // case 'market_status_handed_over-PA':
    // case 'bus_refuse_exception':
    // case 'match_status_ended':
    // case 'market_expired':
    // case 'bet_order_place_num_invalid':
    // case 'var_reviewing':
    // case 'var_reason':
    // case 'possible_var':
    // case 'market_status_locked': {
    //   return 'bet_message.order_reject'
    // }
      default :
        {
          return LocaleKeys.bet_message_order_reject;
        }
    }
  }

  // 如果可以再次投注，文案只有以下三种情况
  static bool showBetAgain(String riskEvent) {
    // 盘口和赔率都变化
    if (riskEvent == LocaleKeys.bet_message_serial_can_rebet
        // 盘口变化
        || riskEvent == LocaleKeys.bet_message_bet_order_place_num_change
        // 赔率变化
        || riskEvent == LocaleKeys.bet_message_order_odds_change) {
      return true;
    } else {
      return false;
    }
  }

  static void showTips(String? title,String content,String? confirm){
    showToastWidget(
      Stack(
          children: [
            //灰色背景
            GestureDetector(
              onTap: () {
                dismissAllToast(showAnim:true);
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withValues(alpha:0.2),
              ),
            ),
            Center(child:Container(
                decoration: BoxDecoration(
                  color: Get.theme.shopcartTipsBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: 0.7.sw,
                padding: const EdgeInsets.all(20),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(title!=null)
                      Text(
                        title,
                        style: TextStyle(
                          color: Get.theme.shopcartTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    const SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(content,
                          style: TextStyle(
                            color: Get.theme.shopcartLabelColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),


                      ],
                    ),
                    const SizedBox(height: 20,),
                    if(confirm!=null)
                      InkWell(
                        onTap: (){
                          dismissAllToast(showAnim:true);
                        },
                        child: Text(confirm,
                          style: const TextStyle(
                            color: Color(0xFF179CFF),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                )
            ),
            ),
          ]
      ),
      duration: const Duration(hours: 1),
      handleTouch:true,
    );
  }

  /*
  比分x1-x2
  可以依据x1为锚点 则比分为0-0,0-1,0-2,0-3,0-4,1-0,1-2,2-0,2-1,2-3,3-1,3-2
  例：当用户选择投注项的顺序是4-4,1-1,3-3
  呈现在投注资讯展示和注单的顺序是1-1,3-3,4-4
   */
  static void sortComboCourage(List<String> playOptionNameList){
    playOptionNameList.sort((String a,String b){
      final arrayA = a.split('-');
      final arrayB = b.split('-');
      final firstSort = arrayA[0].compareTo(arrayB[0]);
      if(firstSort != 0){
        return firstSort;
      }else{
        if(arrayA.length>1 && arrayB.length>1){
          return arrayA[1].compareTo(arrayB[1]);
        }else{
          return arrayA.length.compareTo(arrayB.length);
        }
      }
    });
  }

  static double floorLimitAmount(double minAmount,double floorAmount ){
    double retAmount = floorAmount;
    int count = 0;
    while(minAmount>=1){
      minAmount /= 10;
      retAmount = (retAmount/10).floorToDouble();
      count ++;
    }
    retAmount = retAmount * pow(10,count);
    return retAmount;
  }

  static double ceilLimitAmount(double minAmount,double ceilAmount ){
    double retAmount = ceilAmount;
    int count = 0;
    while(minAmount>=1){
      minAmount /= 10;
      retAmount = (retAmount/10);
      count ++;
    }
    retAmount = retAmount.ceilToDouble() * pow(10,count);
    return retAmount;
  }

  /*
  以下玩法，预约需要区分marketValue
  3，// 全场让球胜平负
  4,// 全场让球
  19,1/上半场让球
  33,//15分钟进球-让球（a｝- ）
  39,//让分
  46,//第1节让分
  52,//第2节让分
  58,//第3节让分
  64,//第4节让分
  69,//上半场让球胜平负
  71,1/ 下半场让球胜平负
  113,//角球让球盘
  121,//上半场角球让球
  128,// 加时赛上半场
  130,//加时赛-上半场让球
  143,// 下半场让球
  232,//15分钟角球让球
  306,//罚牌让分
  308,//上半场罚牌让分
  334// 点球大战-让球
   */
  static bool isDiffrentMarket(ShopCartItem shopCartItem){
    return [3, 4, 19, 33,39, 46, 52, 58, 64, 69, 71, 113, 121, 128, 130, 143, 232,306, 308,334]
        .contains(shopCartItem.playId.toInt());
  }
}