import 'package:flutter/material.dart';

import '../../../global/ty_user_controller.dart';
import '../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 账户余额刷新Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 账户余额刷新部件
      点击拉取余额接口。动画至少转动一圈
    】】】
 *
 */
class BalanceRefreshWidget extends StatefulWidget {
  const BalanceRefreshWidget({this.width=20,this.height=20,Key? key}) : super(key: key);
  final double width;
  final double height;

  @override
  _BalanceRefreshState createState() => _BalanceRefreshState();
}

class _BalanceRefreshState extends State<BalanceRefreshWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: ImageView('assets/images/shopcart/refresh1.png',
        width: widget.width,
        height: widget.height,
        onTap: () async{
          if(!_animationController.isAnimating) {
            _animationController.repeat();
            await TYUserController.to.getBalance();

            Future.delayed(Duration(milliseconds: ((1 - _animationController.value)*1000).toInt() ),(){
              _animationController.stop();
            });
          }
        },
      ),
    );
  }
}