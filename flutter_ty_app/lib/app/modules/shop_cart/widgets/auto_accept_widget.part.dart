part of 'auto_accept_widget.dart';

extension AutoAcceptWidgetEx on AutoAcceptWidget{
  _buildAcceptTips(BuildContext context){
    ThemeData themeData = Theme.of(context);
    if(TYUserController.to.userInfo.value?.defaultOddsOptions==2){
      showToastWidget(
        Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  dismissAllToast(showAnim: true);
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.black.withValues(alpha:0.2),
                ),
              ),
              Center(child: Container(
                  decoration: BoxDecoration(
                    color: themeData.shopcartTipsBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: 0.7.sw,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.app_h5_bet_accept_odds.tr,
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.app_h5_bet_odd_bet1.tr,
                            style: TextStyle(
                              color: themeData.shopcartLabelColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(LocaleKeys.app_h5_bet_odd_bet2.tr,
                            style: TextStyle(
                              color: themeData.shopcartLabelColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          dismissAllToast(showAnim: true);
                        },
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Text(LocaleKeys.ac_rules_understand.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF179CFF),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
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
        handleTouch: true,
      );
    }else {
      showToastWidget(
        Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  dismissAllToast(showAnim: true);
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.black.withValues(alpha:0.2),
                ),
              ),
              Center(child: Container(
                  decoration: BoxDecoration(
                    color: themeData.shopcartTipsBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: 0.7.sw,
                  constraints: BoxConstraints(maxHeight: 0.5.sh,),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.app_h5_bet_odds_preference_explanation.tr,
                        style: TextStyle(
                          color: themeData.shopcartTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Expanded(child:SingleChildScrollView(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.app_h5_bet_odd_bet3.tr,
                              style: TextStyle(
                                color: themeData.shopcartLabelColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(LocaleKeys.app_h5_bet_odd_bet4.tr,
                              style: TextStyle(
                                color: themeData.shopcartLabelColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(LocaleKeys.app_h5_bet_odd_bet5.tr,
                              style: TextStyle(
                                color: themeData.shopcartLabelColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          dismissAllToast(showAnim: true);
                        },
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Text(LocaleKeys.ac_rules_understand.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF179CFF),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
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
        handleTouch: true,
      );

    }
  }
}