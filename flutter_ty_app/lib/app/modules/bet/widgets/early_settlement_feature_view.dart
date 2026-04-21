import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet/widgets/early_settlement_other_view.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_view.dart';
import '../../unsettled_bets/utils/betsUtils.dart';
import '../controllers/bet_record_controller.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)全部提前兑Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示提前结算的相关信息和操作选项，包括按钮和提示信息。
    - `EarlySettlementFeatureView`：接收两个参数：
    - `data`：类型为 `GetH5OrderListDataRecordxData`，用于存储提前结算的详细数据。
    - `index`：整数类型，表示当前视图的索引。
    - **提前兑现说明**：使用 `RuleStatementView` 组件展示说明。
    - **失败提示**：如果 `earlySettlementSuccessfulType` 为 3，展示红色提示文本。
    - **按钮区域**：包含“全部提前兑现”按钮和条件渲染的预约提前兑现按钮。
    - **预约提前兑现和部分提前兑现**：如果 `earlySettlementState` 为 2，展示 `EarlySettlementOtherView` 组件。
    - `_arlySettlementAllView`：创建“全部提前结算”按钮，动态根据状态和语言设置文本和样式。
    - `_earlySettlement`：创建预约提前兑现和部分提前兑现的开关。
    - `getCashout`：计算并返回可提取的金额。
    】】】
 *
 */
class EarlySettlementFeatureView extends StatelessWidget {
  EarlySettlementFeatureView({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;
  final int index;
  final logic = Get.find<BetRecordController>().betTylogic;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        ///提前兑现失败提示语
        if (data.earlySettlementSuccessfulType == 3)
          Text(
            LocaleKeys.early_info2.tr,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        SizedBox(
          width: double.infinity,
          ///如果已经提前结算过，高度增高一些
          height: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///全部提前兑现按钮
              _arlySettlementAllView(context),
              if (data.earlySettlementState != 0)

                ///预约提前兑现和部分提前兑现的展示开关
                _earlySettlement(context).paddingOnly(left: 8.w, top: 4.h),
            ],
          ),
        ),
        ///  提前兑现取消(只有在提前结算等待中才展示)
        if(data.turnOnEarlySettlement)
          InkWell(
            onTap: () => {
              logic.setCancelSubmission(index),
            },
            child: Container(
              width: double.infinity,
              height: 34.h,
              alignment: Alignment.bottomCenter,
              child: Text(
                LocaleKeys.common_cancel.tr,
                style: TextStyle(
                  color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ).marginOnly(
            top: 6.h,
            bottom: 6.h,
          ),

        if (data.earlySettlementState == 2)

          ///预约提前兑现和部分提前兑现
          EarlySettlementOtherView(
            data: data,
            betTylogic: logic,
            index: index,
          ),
      ],
    );
  }

  ///全部提前结算按钮
  Widget _arlySettlementAllView(BuildContext context) {
    String prefix = '';
    if (data.earlySettlementSuccessfulType == 1) {
      prefix = LocaleKeys.early_btn4.tr;
    } else if (data.earlySettlementSuccessfulType == 2) {
      prefix = LocaleKeys.early_btn5.tr;
    } else if (data.turnOnEarlySettlement) {
      prefix = LocaleKeys.app_h5_bet_confirm.tr + LocaleKeys.early_btn2_1.tr;
    } else {
      prefix = LocaleKeys.early_btn2_1.tr;
    }

    // var fontSize = 14.sp;
    // var lineBreaks = '';
    // if (Get.locale?.languageCode == 'pt') {
    //   fontSize = 12.sp;
    //   lineBreaks = "\n\t";
    // }

    String substance = prefix;
    String amount =
        '${setAmount(getCashout())} ${TYUserController.to.currCurrency()}';
    String principal = ' ${LocaleKeys.early_btn2_2.tr}';
    if (principal.contains('¥')) {
      principal = principal.replaceAll('¥', '');
    }
    if (principal.contains('￥')) {
      principal = principal.replaceAll('￥', '');
    }
    if (principal.contains('元')) {
      principal = principal.replaceAll('元', '');
    }

    var fontSizeBig = 11;
    var fontSizeSmall = 9;
    var widthDistancing = 0;
    var widthInterval = 4;
    var languageCode = Get.locale?.languageCode ?? "";

    if (languageCode == 'zh') {
      ///当是中文简体，繁体 就一行
      fontSizeBig = 12;
      fontSizeSmall = 10;
      widthDistancing = 0;
      widthInterval = data.earlySettlementState == 0 ? 8 : 2;
      amount = substance + ' ' + amount;
      substance = "";
    } else if (languageCode == 'ko') {
      fontSizeBig = 12;
      fontSizeSmall = 10;
      if (data.earlySettlementState == 0) {
        ///当是韩语，只有全部提提前结算，只展示一行
        widthDistancing = 0;
        widthInterval = 8;
        amount = substance + ' ' + amount;
        substance = "";
      } else {
        widthDistancing = 30;
        widthInterval = 15;
      }
    }
    return Expanded(
      child: InkWell(
        onTap: () => {
          logic.setTurnOnEarlySettlement(
            index,
          ),
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 4.h),
          decoration: BoxDecoration(
            color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.r,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                  getPreSettleBetAmount(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeBig.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      height: 1),
                ).marginOnly(bottom: 2.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthDistancing.w,
                  ),


                  ///当只有中文和韩语的时候文字才展示一行，其他语言分2行展示
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///中文和韩语不展示
                      if (substance.isNotEmpty)
                        Text(
                          substance,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeBig.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 1),
                        ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: amount,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizeBig.sp,
                                fontFamily: 'PingFang SC',
                                //           fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: principal,
                              //   textAlign: TextAli
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizeSmall.sp,
                                fontFamily: 'PingFang SC',
                                //           fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: widthInterval.w,
                  ),

                  ///提交展示的等待的加载图
                  if (data.earlySettlementBeingRequested)
                    ImageView(
                      'assets/images/bets/early_settlement_loding.gif',
                      width: 24.w,
                      height: 24.w,
                    ),
                ],
              ),
            ],
          ),


        ),
      ),
    );
  }

  /// 预约提前兑现和部分提前兑现开关
  Widget _earlySettlement(BuildContext context) {
    return InkWell(
      onTap: () => {
        logic.setEarlySettlementState(
          index,
          data.earlySettlementState,
        ),
      },
      child: Container(
        width: 32.w,
        height: 44.h,
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? data.earlySettlementState == 1
                  ? Colors.transparent
                  : const Color(0xFF127DCC)
              : data.earlySettlementState == 1
                  ? Colors.transparent
                  : const Color(0xFF179CFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        alignment: Alignment.center,
        child: ImageView(
          // data.earlySettlementState == 1
          //     ? "assets/images/bets/early_settlement_stateless_daytime.png"
          //     : "assets/images/bets/early_settlement_stated.png",
          "assets/images/bets/early_settlement_stated.png",
          width: 20.w,
          height: 20.w,
          color: data.earlySettlementState == 2
              ? Colors.white
              : Color(context.isDarkMode ? 0xFF127DCC : 0xFF179CFF),
        ),
      ),
    );
  }

  ///用来判断是全部提前兑现还是部分提前兑现
  String getCashout() {
    String cashout = '';
    ///当是部分提前结算的时候
    if (data.earlySettlementState == 2 && data.earlySettlementType == 1) {
      cashout = BetsUtils.getExpectedProfit(logic.listData[index]);
    } else {
      cashout = data.maxCashout.toString();
    }
      return cashout;
  }

  ///已经提前兑现的金额
  String getPreSettleBetAmount() {
    String preSettleBetAmount = '';
    String managerCode = TYUserController.to.currCurrency();

    ///当是部分提前结算的时候
    if (data.earlySettlementState == 2 && data.earlySettlementType == 1) {
      preSettleBetAmount = LocaleKeys.app_cashout_stake.tr +
          FormatMoney.formatMoney2(BetsUtils.cashoutStake(data)) +
          " " +
          managerCode;
    } else {
      preSettleBetAmount = LocaleKeys.app_cashout_stake.tr +
          setAmount(data.preSettleBetAmount.toString()) +
          " " +
          managerCode;
    }
    return preSettleBetAmount;
  }

}
