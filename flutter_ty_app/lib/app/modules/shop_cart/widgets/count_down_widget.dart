import 'dart:async';
import 'dart:math';


import '/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 倒计时Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 倒计时部件
      传入倒计时开始秒数、是否循环计数
    】】】
 *
 */
class CountDownWidget extends StatefulWidget {
  const CountDownWidget(this.countDown,{this.loop = true,Key? key}) : super(key: key);
  final int countDown;
  final bool loop;

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDownWidget> {
  Timer?  _countDownTimer;
  int _countdown = 5;
  @override
  void initState() {
    super.initState();

    _countdown = max(0,widget.countDown - 1);
    _countDownTimer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(widget.countDown!=0) {
          if(widget.loop) {
            _countdown = (_countdown - 1) % widget.countDown;
          }else{
            _countdown = max(0,_countdown - 1);
          }
        }else{
          _countdown = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _countDownTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: themeData.shopcartItemNumberBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          _countdown.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: themeData.shopcartLabelColor,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,

          ),
        ),
      ),
    );
  }
}
