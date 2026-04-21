import 'package:filbet/src/mine/help_center/betting_tutorial_controller.dart';
import 'package:get/get.dart';

class BettingTutorialBinding extends Bindings {
  @override
  void dependencies() {
    // 从路由参数中获取初始类型
    final arguments = Get.arguments as Map<String, dynamic>?;
    
    BettingTutorialType? initialType;
    
    if (arguments != null && arguments.containsKey('type')) {
      final typeString = arguments['type'] as String?;
      switch (typeString) {
        case 'outrightWin':
          initialType = BettingTutorialType.outrightWin;
          break;
        case 'handicap':
          initialType = BettingTutorialType.handicap;
          break;
        case 'overUnder':
          initialType = BettingTutorialType.overUnder;
          break;
        case 'oddEven':
          initialType = BettingTutorialType.oddEven;
          break;
        case 'corner':
          initialType = BettingTutorialType.corner;
          break;
        case 'other':
          initialType = BettingTutorialType.other;
          break;
      }
    }
    
    Get.lazyPut<BettingTutorialController>(
      () => BettingTutorialController(initialType: initialType),
    );
  }
}

