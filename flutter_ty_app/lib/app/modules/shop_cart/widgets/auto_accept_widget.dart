import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/mix_bet/mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:oktoast/oktoast.dart';

import '../../../widgets/image_view.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';

part 'auto_accept_widget.part.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 接受最新赔率Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 接受最新赔率部件
      串关只显示文字，不允许用户选择
      单关分三项盘还是两项盘
      三项盘弹框选择
      两项盘打勾选择
    】】】
 *
 */
class AutoAcceptWidget extends StatelessWidget {
  AutoAcceptWidget({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController;
  final showTips = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        height: 16.sp,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: logic is MixBetController && logic?.itemCount!=1 ?_buildAutoAcceptText(context)
            :(TYUserController.to.userInfo.value?.defaultOddsOptions==BetAcceptOdds.acceptAll.code?_buildAutoAcceptButton(context):_buildAutoAcceptMenu(context))
    );
  }

  Widget _buildAutoAcceptButton(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return InkWell(
          onTap: ()  {
             TYUserController.to.setUserBetPrefer(
                 TYUserController.to.userInfo.value!.userBetPrefer==BetAcceptOdds.acceptAll.code?BetAcceptOdds.acceptBetter.code:BetAcceptOdds.acceptAll.code
             );

          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16.sp,
                height: 16.sp,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 1,
                      child:  GetBuilder<TYUserController>(
                          id: "auto_accept",
                          init: TYUserController.to,
                          builder: (controller) {
                          return  Container(
                                width: 14.sp,
                                height: 14.sp,
                                decoration: BoxDecoration(
                                  color: TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?Color(0xFF179CFF):Colors.transparent,
                                  border:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?Border.all(color: Color(0xFF179CFF), width: 1): Border.all(color: Colors.grey, width: 1),
                                  borderRadius:  BorderRadius.circular(4)
                                ),
                                child:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?ImageView(
                                    'assets/images/shopcart/check.png',
                                    width: 14.sp):Container(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                LocaleKeys.app_automatically.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              ImageView('assets/images/shopcart/icon_exclamation_mark2.png', width: 16.sp,color: Get.theme.shopcartLabelColor,
                onTap: (){
                  _buildAcceptTips(context);
                },
              )
            ],
          ),
        );
  }

  Widget _buildAutoAcceptText(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '*',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: themeData.shopcartLabelColor,
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          LocaleKeys.app_automatically.tr,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: themeData.shopcartLabelColor,
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        ImageView('assets/images/shopcart/icon_exclamation_mark2.png', width: 16.sp,color: Get.theme.shopcartLabelColor,
          onTap: (){
            _buildAcceptTips(context);
          },
        )
      ],
    );
  }

  Widget _buildAutoAcceptMenu(BuildContext context){
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () async {
        _popAcceptMenu(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            //color:themeData.shopcartContentBackgroundColor,
            borderRadius:  BorderRadius.circular(4)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            GetBuilder<TYUserController>(
                id: "auto_accept",
                init: TYUserController.to,
                builder: (controller) {
                  return
                    Text(
                      _getAcceptText(TYUserController.to.userInfo.value?.userBetPrefer??1),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: themeData.shopcartLabelColor,
                        fontSize: 12.sp,
                        height: 1,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    );
                }),
            const SizedBox(width: 4),
            Obx(()=>Transform.rotate(
              angle: showTips.value? -pi:0,
              child:ImageView(
                  'assets/images/shopcart/arrow_small.png',
                  width: 14.sp),
              )
            ),
            const SizedBox(width: 4),
            ImageView('assets/images/shopcart/icon_exclamation_mark2.png', width: 16.sp,color: Get.theme.shopcartLabelColor,
              onTap: (){
                _buildAcceptTips(context);
              },
            )

          ],
        ),
      )
    );
  }

  void _popAcceptMenu(BuildContext context){
    ThemeData themeData = Theme.of(context);
    /*
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: _getAcceptText(TYUserController.to.userInfo.value?.userBetPrefer??1),
        style: TextStyle(
          color: themeData.shopcartLabelColor,
          fontSize: 12.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();
     */
    showTips.value = true;
      showToastWidget(
        Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  showTips.value = false;
                  dismissAllToast(showAnim:true);
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                bottom: 46 + 50.h + 16.h+ 16.sp,
                left: 14.w - 4,
                child:Container(
                  decoration: ShapeDecoration(
                    color: themeData.shopcartBackgroundColor,
                    shape: RoundedRectangleBorder(
                      side:BorderSide(color: Colors.black.withValues(alpha:0.02)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.2),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              TYUserController.to.setUserBetPrefer(BetAcceptOdds.acceptBetter.code);
                              showTips.value = false;
                              dismissAllToast(showAnim:true);
                            },
                            child: Row(
                              children:[
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                      color: TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptBetter.code?Color(0xFF179CFF):Colors.transparent,
                                      border:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptBetter.code?Border.all(color: Color(0xFF179CFF), width: 1): Border.all(color: Colors.grey, width: 1),
                                      borderRadius:  BorderRadius.circular(4)
                                  ),
                                  child:TYUserController.to.userInfo.value?.userBetPrefer==1?ImageView(
                                      'assets/images/shopcart/check.png',
                                      width: 14.sp):Container(),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _getAcceptText(BetAcceptOdds.acceptBetter.code),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: themeData.shopcartLabelColor,
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ]
                            )
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                              onTap: () {
                                TYUserController.to.setUserBetPrefer(BetAcceptOdds.acceptAll.code);
                                showTips.value = false;
                                dismissAllToast(showAnim:true);
                              },
                              child: Row(
                                  children:[
                                    Container(
                                      width: 14.sp,
                                      height: 14.sp,
                                      decoration: BoxDecoration(
                                          color: TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?Color(0xFF179CFF):Colors.transparent,
                                          border:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?Border.all(color: Color(0xFF179CFF), width: 1): Border.all(color: Colors.grey, width: 1),
                                          borderRadius:  BorderRadius.circular(4)
                                      ),
                                      child:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptAll.code?ImageView(
                                          'assets/images/shopcart/check.png',
                                          width: 14.sp):Container(),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _getAcceptText(BetAcceptOdds.acceptAll.code),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: themeData.shopcartLabelColor,
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                              onTap: () {
                                TYUserController.to.setUserBetPrefer(BetAcceptOdds.acceptNone.code);
                                showTips.value = false;
                                dismissAllToast(showAnim:true);
                              },
                              child: Row(
                                  children:[
                                    Container(
                                      width: 14.sp,
                                      height: 14.sp,
                                      decoration: BoxDecoration(
                                          color: TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptNone.code?Color(0xFF179CFF):Colors.transparent,
                                          border:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptNone.code?Border.all(color: Color(0xFF179CFF), width: 1): Border.all(color: Colors.grey, width: 1),
                                          borderRadius:  BorderRadius.circular(4)
                                      ),
                                      child:TYUserController.to.userInfo.value?.userBetPrefer==BetAcceptOdds.acceptNone.code?ImageView(
                                          'assets/images/shopcart/check.png',
                                          width: 14.sp):Container(),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _getAcceptText(BetAcceptOdds.acceptNone.code),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: themeData.shopcartLabelColor,
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]
                              )
                          )


                        ],
                      )
                  ),
              ),
            ]
        ),
        duration: const Duration(days: 1),
        handleTouch:true,
      );
    }

    String _getAcceptText(int userBetPrefer){
      String acceptText = LocaleKeys.app_automatically.tr;
      if(userBetPrefer == BetAcceptOdds.acceptBetter.code){
        acceptText = LocaleKeys.app_h5_bet_accept_higher_odds.tr;
      }else if(userBetPrefer == BetAcceptOdds.acceptAll.code){
        acceptText = LocaleKeys.app_h5_bet_accept_any_odds.tr;
      }else if(userBetPrefer == BetAcceptOdds.acceptNone.code){
        acceptText = LocaleKeys.app_h5_bet_not_accept_odds.tr;
      }
      return acceptText;
    }
}
