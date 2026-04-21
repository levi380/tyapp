
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注通知Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注结果顶部通知
    包括一个底部的进度条，自动减少
    到时间执行onFinish
    】】】
 *
 */
class BetToastWidget extends StatefulWidget {
  final int orderStatusCode;
  final String betString;
  final bool isPrebook;
  final VoidCallback? onFinish;
  final int duration;

  const BetToastWidget({Key? key,
    required this.orderStatusCode,
    required this.betString,
    required this.isPrebook,
    this.duration = 5,
    this.onFinish}) : super(key: key);

  @override
  State<BetToastWidget> createState() => _BetToastWidgetState();
}

class _BetToastWidgetState extends State<BetToastWidget> {

  @override
  void initState() {
    super.initState();
    // 倒计时结束后触发回调
    Future.delayed(Duration(seconds: widget.duration), () {
      if (mounted && widget.onFinish != null) {
        widget.onFinish!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color slideColor ;
    String title;
    String titleImage;
    if(widget.orderStatusCode == OrderStatusCode.success.code){
      slideColor = const Color(0XFF00B42A);
      if(widget.isPrebook){
        title = LocaleKeys.app_reservedBetPlacedSuccessfully.tr;
        titleImage = "assets/images/shopcart/toast_book_success.png";
      }else {
        title = LocaleKeys.bet_message_confirmed.tr;//注单成功
        titleImage = "assets/images/shopcart/toast_bet_success.png";
      }
    }else{
      slideColor = const Color(0XFFF53F3F);
      if(widget.isPrebook) {
        title = LocaleKeys.app_reservationExpired.tr;
        titleImage = "assets/images/shopcart/toast_book_failure.png";
      }else {
        title = LocaleKeys.app_h5_bet_bet_error.tr;
        titleImage = "assets/images/shopcart/toast_bet_failure.png";
      }
    }
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        // 外层柔和阴影 + 细边框
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: themeData.shopcartToastBorderColor,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: PhysicalModel(
        color: themeData.shopcartBackgroundColor,
        elevation: 6,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias, // 关键：开启裁剪
         child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child:Column(
                children: [
                  Row(
                    children: [
                      ImageView(titleImage,
                        width: 34.w,
                      ),
                      const SizedBox(width: 8),
                      Text(title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: themeData.shopcartTextColor,
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                      children:[
                        Expanded(
                          child:Text(
                            widget.betString,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: themeData.shopcartLabelColor,
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: Duration(seconds: widget.duration),
              builder: (context, value, child) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 4,
                    backgroundColor: themeData.shopcartBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(slideColor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

