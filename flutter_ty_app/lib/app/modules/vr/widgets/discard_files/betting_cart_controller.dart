import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


enum BettingType {
  single,
  multi,
}

class BettingCartController extends GetxController {
  static BettingCartController of = Get.find();

  BettingType bettingType = BettingType.single;

  void onBettingTypeChanged(BettingType newBettingType) {
    if (newBettingType == bettingType) return;
    bettingType = newBettingType;
    update(['betting_entrance']);
  }

  void showBettingCartDialog() {
    switch (bettingType) {
      case BettingType.single:
        _showSingle();
      case BettingType.multi:
        _showMulti();
    }
  }

  // 单投
  void _showSingle() {

  }

  // 串投
  void _showMulti() {

  }

  // 投注订单状态
  void showOrderStatus() {

  }
}
