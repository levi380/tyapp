import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';

import '../quick_bet/quick_bet_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Widget 】】】
    【【【 AUTO_PARAGRAPH_TITLE 投注Material】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 投注Widget调用入口
    因为投注Widget在GetMaterialApp之外，投注Widget需要包裹一层Material，以免布局错乱
    】】】
 *
 */
class ShopCartMaterial extends StatefulWidget {
  final Widget? child;

  const ShopCartMaterial({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _ShopCartMaterialState createState() => _ShopCartMaterialState();
}

class _ShopCartMaterialState extends State<ShopCartMaterial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ShopCartController>();
    Get.delete<QuickBetController>();
    super.dispose();
  }
}
