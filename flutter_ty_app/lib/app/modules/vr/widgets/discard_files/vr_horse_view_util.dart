import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view.dart';

/// VR赛马视图工具类
/// 提供显示不同类型底部弹窗的方法
class VrHorseViewUtil {
  /// 单例实例
  static VrHorseViewUtil of = VrHorseViewUtil._();

  VrHorseViewUtil._();

  /// 显示单投弹窗
  void showSingle() {
    Get.bottomSheet(
      VrHorseView.single(),
      isScrollControlled: true,
    );
  }

  /// 显示串投弹窗
  void showMulti() {
    Get.bottomSheet(
      VrHorseView.multi(),
      isScrollControlled: true,
    );
  }

  /// 显示投注订单状态弹窗
  void showOrderStatus() {
    Get.bottomSheet(
      VrHorseView.orderStatus(),
      isScrollControlled: true,
    );
  }
}

