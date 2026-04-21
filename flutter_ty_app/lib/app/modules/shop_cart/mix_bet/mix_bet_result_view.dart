import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../widgets/bet_item_widget.dart';
import '../widgets/bet_series_order_widget.dart';
import '../widgets/gradient_loading_indicator.dart';
import 'mix_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 串关投注结果Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 串关投注结果弹窗
    】】】
 *
 */
class MixBetResultComponent extends StatelessWidget {
  MixBetResultComponent({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController! as MixBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //在绘制完后判断是否可滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.postFrameCallback();
    });
    bool isButtonDiabled = logic.betStatus.value == ShopCartBetStatus.Betting;
    return Container(
        constraints: BoxConstraints(
          maxHeight: 0.8.sh,
        ),
        padding: EdgeInsets.only(bottom: 30),
        decoration: ShapeDecoration(
          color: themeData.shopcartBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Stack(children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildResultHead(context),
                Flexible(
                  child: SingleChildScrollView(
                    controller: logic.scrollController,
                    child: Column(
                      children: [
                        ..._buildBetItems(),
                        ...logic.seriesOrderRespList
                            .map((e) => BetSeriesOrderWidget(e))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                if (logic.showBetAgain()) ...[
                  //接受变化
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                    height: 48,
                    //constraints: BoxConstraints(maxWidth: 375.w),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF179CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        //logic.acceptBetAgain();
                        logic.doBet(betAgain: true);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.bet_agree_change.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //取消投注
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    height: 48,
                    //constraints: BoxConstraints(maxWidth: 375.w),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: ShapeDecoration(
                      color: themeData.shopcartContentBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        logic.clearData();
                        logic.closeBet();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.bet_record_cancel_bet.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0XFF179CFF),
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ] else ...[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    // height: 48.w,
                    //constraints: BoxConstraints(maxWidth: 375.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                    decoration: ShapeDecoration(
                      color: isButtonDiabled || logic.betStatus.value == ShopCartBetStatus.Failure
                          ? themeData.shopcartButtonDisableBackgroundColor
                          : const Color(0xFF179CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (!isButtonDiabled) {
                          logic.clearData();
                          logic.closeBet();
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Obx(() {
                                        String titleText;
                                        switch (logic.betStatus.value) {
                                          case ShopCartBetStatus.Success:
                                            titleText = LocaleKeys
                                                .app_h5_bet_bet_confirm.tr;
                                            break;
                                          case ShopCartBetStatus.PartSuccess:
                                            titleText = LocaleKeys
                                                .app_h5_bet_part_success.tr;
                                            break;
                                          case ShopCartBetStatus.Failure:
                                            titleText =
                                                LocaleKeys.bet_bet_err.tr;
                                            break;
                                          case ShopCartBetStatus.Betting:
                                          default:
                                            titleText =
                                                LocaleKeys.bet_bet_loading.tr;
                                            break;
                                        }
                                        return Text(
                                          titleText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            LocaleKeys.bet_sum.tr,
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.6),
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            TYFormatCurrency.formatCurrency(
                                                logic.orderTotal / 100),
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.6),
                                              fontSize: 16.sp,
                                              fontFamily: 'Akrobat',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
                    // height: 48,
                    //constraints: BoxConstraints(maxWidth: 375.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                    decoration: ShapeDecoration(
                      color: themeData.shopcartContentBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        logic.keepBet();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.app_h5_bet_keep_go_bet.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF179CFF),
                                    fontSize: 16.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ]),
          Positioned(
            bottom: 120 + 5,
            left: (1.sw - 20) / 2,
            child: Obx(
              () => Offstage(
                offstage: !logic.showScrollFlag.value,
                child: ImageView(
                  "assets/images/shopcart/icon_scrolldown1.png",
                  //Assets.home.item.iconLock.path,
                  height: 20,
                  width: 20,
                  onTap: () {
                    logic.scrollController.animateTo(
                        logic.scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.ease);
                  },
                ),
              ),
            ),
          ),
        ]));
  }

  Widget _buildResultHead(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Obx(() {
        String titleImage;
        String titleText;
        switch (logic.betStatus.value) {
          case ShopCartBetStatus.Success:
            titleText = LocaleKeys.app_h5_bet_bet_confirm.tr;
            titleImage = 'assets/images/shopcart/tandem_success2.png';
            break;
          case ShopCartBetStatus.PartSuccess:
            titleText = LocaleKeys.app_h5_bet_part_success.tr;
            titleImage = 'assets/images/shopcart/tandem_success2.png';
            break;
          case ShopCartBetStatus.Failure:
            titleImage = 'assets/images/shopcart/tandem_failed2.png';
            titleText = LocaleKeys.app_h5_bet_bet_error.tr;

            break;
          case ShopCartBetStatus.Betting:
          default:
            // TODO: Handle this case.
            titleImage = 'assets/images/shopcart/tandem_success2.png';
            titleText = LocaleKeys.bet_bet_loading.tr;
            break;
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (logic.betStatus.value == ShopCartBetStatus.Betting)
              SizedBox(
                width: 20.sp,
                height: 20.sp,
                child:GradientLoadingIndicator(
                  strokeWidth: 2.0,
                  color: Colors.blue,
                )
              )
            else
              ImageView(
                titleImage,
                width: 20.sp,
                height: 20.sp,
              ),
            const SizedBox(width: 12),
            Text(
              titleText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: themeData.shopcartTextColor,
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }),
    );
  }

  List<Widget> _buildBetItems() {
    List<Widget> betItems = [];
    for (int i = 0; i < logic.orderRespList.length; i++) {
      BetResultOrderDetailRespList orderResp = logic.orderRespList[i];
      ShopCartItem? item = logic.itemList
          .firstWhereOrNull((e) => e.itemId == orderResp.shopCartItemId);
      if (item == null) {
        //item关闭就被删除，逻辑有问题，暂时这里补上item
        item = ShopCartItem();
        item.cds = '';
        item.olOs = 2.obs;
        item.betType = OddsBetType.guanjun; //为了处理canParlay判断
        item.matchType = orderResp.matchType;
        item.tidName = orderResp.matchName;
        item.oddsHsw = '1'; //欧洲盘
      }
      betItems.add(BetItemWidget(
        item,
        orderDetailResp: orderResp,
      ));
    }

    return betItems;
  }
}
