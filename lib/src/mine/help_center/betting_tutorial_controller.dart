import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

enum BettingTutorialType {
  outrightWin, // 独赢
  handicap, // 让球
  overUnder, // 大小球
  oddEven, // 单双
  corner, // 角球
  other, // 波胆
}


class BettingTutorialController extends GetXBaseController {
  final Rx<BettingTutorialType> selectedType = BettingTutorialType.outrightWin.obs;
  final RxBool isRealBettingMode = false.obs; // 是否为实战投注模式
  final Rx<int?> selectedBettingOption = Rx<int?>(null); // 选中的投注选项索引 (0: 主胜, 1: 和局, 2: 客胜)
  
  BettingTutorialController({
    BettingTutorialType? initialType,
  }) {
    if (initialType != null) {
      selectedType.value = initialType;
    }
  }

  // 获取当前类型的标题
  String get currentTitle {
    switch (selectedType.value) {
      case BettingTutorialType.outrightWin:
        return '独赢';
      case BettingTutorialType.handicap:
        return '让球';
      case BettingTutorialType.overUnder:
        return '大小球';
      case BettingTutorialType.oddEven:
        return '单双';
      case BettingTutorialType.corner:
        return '角球';
      case BettingTutorialType.other:
        return '波胆';
    }
  }

  // 获取当前类型的规则说明
  String get currentRule {
    switch (selectedType.value) {
      case BettingTutorialType.outrightWin:
        return '竞猜投注和比赛结果一致则全赢,反之全输';
      case BettingTutorialType.handicap:
        return '滚球-让球赛果为投注后的进球比分。举例：投注时比分为1-0，完场比分为2-1，则滚球-让球盘赛果为1-1';
      case BettingTutorialType.overUnder:
        return '投注两队总进球数的大小，总进球数比盘口大即大球，比盘口小即小球，刚好等于盘口退本金';
      case BettingTutorialType.oddEven:
        return '以主客队总进球数是否单双判定胜负';
      case BettingTutorialType.corner:
        return '以主客队角球数判定胜负';
      case BettingTutorialType.other:
        return '即全场比分，投注项与赛果完全一致全赢，反之全输';
    }
  }

  

  // 选择教程类型
  void selectType(BettingTutorialType type) {
    selectedType.value = type;
    // 重置实战模式的选中状态
    selectedBettingOption.value = null;
  }

  // 切换投注模式
  void toggleBettingMode() {
    if (isRealBettingMode.value) {
      // 实战投注模式，返回首页
      Get.offAllNamed(Routes.MAIN);
    } else {
      // 切换到实战投注模式
      isRealBettingMode.value = true;
      // 重置选中状态
      selectedBettingOption.value = null;
    }
  }
  
  // 选择投注选项
  void selectBettingOption(int index) {
    if (isRealBettingMode.value) {
      selectedBettingOption.value = index;
    }
  }
  
  // 获取按钮文案
  String get buttonText {
    return isRealBettingMode.value ? '实战投注' : '模拟投注';
  }
  
  // 获取投注结果信息（独赢类型）
  Map<String, dynamic>? getOutrightWinBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: 主胜, 1: 和局, 2: 客胜
    switch (option) {
      case 0: // 主胜
        return {
          'option': '主胜',
          'odds': '1.98',
          'result': 'win', // 赢
          'description': '主队赢2球, 获胜 \n故投注 (主胜) 为赢',
        };
      case 1: // 和局
        return {
          'option': '和局',
          'odds': '1.98',
          'result': 'lose', // 输
          'description': '主队赢2球获胜,非和局 \n故投注(和局)为输',
        };
      case 2: // 客胜
        return {
          'option': '客胜',
          'odds': '1.98',
          'result': 'lose', // 输
          'description': '客队输2球,败北\n 故投注(客胜)为输',
        };
      default:
        return null;
    }
  }

  // 获取投注结果信息（单双类型）
  Map<String, dynamic>? getOddEvenBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: 单, 1: 双
    // 假设赛果是2球（双数）
    switch (option) {
      case 0: // 单
        return {
          'option': '单',
          'odds': '1.98',
          'result': 'lose', // 输（因为2是双数）
          'description': '进球数为2,双数\n故投注(单)为输',
        };
      case 1: // 双
        return {
          'option': '双',
          'odds': '1.98',
          'result': 'win', // 赢（因为2是双数）
          'description': '进球数为2,双数\n故投注(双)为赢',
        };
      default:
        return null;
    }
  }

  // 获取投注结果信息（角球类型）
  Map<String, dynamic>? getCornerBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: -1.5, 1: +1.5, 2: -1.5/2, 3: +1.5/2
    // 假设角球赛果：主队7，客队5
    switch (option) {
      case 0: // -1.5 (主队让1.5球)
        return {
          'option': '-1.5',
          'odds': '1.98',
          'result': 'win', // 赢（7-5=2，大于1.5）
          'description': '客队获得受让分后,角球让分赛果为\n7-6.5,主队获胜\n故投注主队(-1.5)为赢',
        };
      case 1: // +1.5 (客队受让1.5球)
        return {
          'option': '+1.5',
          'odds': '1.98',
          'result': 'lose', // 输（7-5=2，客队+1.5后是7-6.5，客队败北）
          'description': '客队获得受让分后,角球让分赛果为\n7-6.5,客队败北\n故投注客队(+1.5)为输',
        };
      case 2: // -1.5/2 (主队让1.5/2球)
        return {
          'option': '-1.5/2',
          'odds': '1.98',
          'result': 'winHalf', // 赢半（7-5=2，一半赛果为主队获胜）
          'description': '客队获得受让分后,角球让分赛果为\n7-6.5或7-7;7-6.5时主队获胜;7-7时为和局;一半的赛果为主队获胜\n故投注主队(-1.5/2)为赢半',
        };
      case 3: // +1.5/2 (客队受让1.5/2球)
        return {
          'option': '+1.5/2',
          'odds': '1.98',
          'result': 'loseHalf', // 输半（7-5=2，一半赛果为客队败北）
          'description': '客队获得受让分后,角球让分赛果为\n7-6.5或7-7;7-6.5时客队败北;7-7时为和局;一半的赛果为客队败北\n故投注客队(+1.5/2)为输半',
        };
      default:
        return null;
    }
  }

  // 获取投注结果信息（让球类型）
  Map<String, dynamic>? getHandicapBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: 0(主), 1: 0(客), 2: -0/0.5, 3: +0/0.5, 4: -1, 5: +1, 6: -1.5/2, 7: +1.5/2
    // 假设赛果是2-0（主队2，客队0）
    switch (option) {
      case 0: // 0(主)
        return {
          'option': '0',
          'odds': '1.98',
          'result': 'win', // 赢（主队获胜）
          'description': '平手盘 (0) 时投注获胜的队伍为赢,\n主队获胜\n故投注主队 (0) 为赢',
        };
      case 1: // 0(客)
        return {
          'option': '0',
          'odds': '1.98',
          'result': 'lose', // 输（客队败北）
          'description': '平手盘 (0) 时投注获胜的队伍为赢,\n客队败北\n故投注客队 (0) 为输',
        };
      case 2: // -0/0.5
        return {
          'option': '-0/0.5',
          'odds': '1.98',
          'result': 'win', // 赢（让分赛果为2-0或2-0.5，均为主队获胜）
          'description': '客队获得受让分后,让分赛果为2-0\n或2-0.5,均为主队获胜\n故投注主队(-0/0.5)为赢',
        };
      case 3: // +0/0.5
        return {
          'option': '+0/0.5',
          'odds': '1.98',
          'result': 'lose', // 输（让分赛果为2-0或2-0.5，均为客队败北）
          'description': '客队获得受让分后,让分赛果为2-0\n或2-0.5,均为客队败北\n故投注客队(+0/0.5)为输',
        };
      case 4: // -1
        return {
          'option': '-1',
          'odds': '1.98',
          'result': 'win', // 赢（让分赛果为2-1，主队获胜）
          'description': '客队获得受让分后,让分赛果为2-1,主队获胜\n故投注主队(-1)为赢',
        };
      case 5: // +1
        return {
          'option': '+1',
          'odds': '1.98',
          'result': 'lose', // 输（让分赛果为2-1，客队败北）
          'description': '客队获得受让分后,让分赛果为2-1,\n客队败北\n故投注客队(+1)为输',
        };
      case 6: // -1.5/2
        return {
          'option': '-1.5/2',
          'odds': '1.98',
          'result': 'winHalf', // 赢半（让分赛果为2-1.5或2-2，一半的赛果为主队获胜）
          'description': '客队获得受让分后,让分赛果为2-1.5 或2-2; 2-1.5时,主队获胜; 2-2时为和局; 一半的赛果为主队获胜\n故投注主队(-1.5/2)为赢半',
        };
      case 7: // +1.5/2
        return {
          'option': '+1.5/2',
          'odds': '1.98',
          'result': 'loseHalf', // 输半（让分赛果为2-1.5或2-2，一半的赛果为客队败北）
          'description': '客队获得受让分后,让分赛果为2-1.5 或2-2; 2-1.5时,客队败北; 2-2时为和局; 一半的赛果为客队败北\n故投注客队(+1.5/2)为输半',
        };
      default:
        return null;
    }
  }

  // 获取投注结果信息（大小球类型）
  Map<String, dynamic>? getOverUnderBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: 大1.5, 1: 小1.5, 2: 大1.5/2, 3: 小1.5/2, 4: 大2, 5: 小2, 6: 大2/2.5, 7: 小2/2.5
    // 假设进球数为2
    switch (option) {
      case 0: // 大1.5
        return {
          'option': '大1.5',
          'odds': '1.98',
          'result': 'win', // 赢（2 > 1.5）
          'description': '进球数为2,大于1.5\n故投注(大1.5)为赢',
        };
      case 1: // 小1.5
        return {
          'option': '小1.5',
          'odds': '1.98',
          'result': 'lose', // 输（2 > 1.5）
          'description': '进球数为2,大于1.5\n故投注(小1.5)为输',
        };
      case 2: // 大1.5/2
        return {
          'option': '大1.5/2',
          'odds': '1.98',
          'result': 'winHalf', // 赢半（2 > 1.5为赢，2 = 2为和，一半为赢）
          'description': '进球数为2,大于投注项1.5为赢,等于投注项2为和;一半的结果为赢\n故投注(大1.5/2)为赢半',
        };
      case 3: // 小1.5/2
        return {
          'option': '小1.5/2',
          'odds': '1.98',
          'result': 'loseHalf', // 输半（2 > 1.5为输，2 = 2为和，一半为输）
          'description': '进球数为2,大于投注项1.5为输,等于投注项2为和;一半的结果为输\n故投注(小1.5/2)为输半',
        };
      case 4: // 大2
        return {
          'option': '大2',
          'odds': '1.98',
          'result': 'tie', // 和（2 = 2，退回本金）
          'description': '进球数为2,等于投注项2为和,和局退款\n故投注(大2)为退回本金',
        };
      case 5: // 小2
        return {
          'option': '小2',
          'odds': '1.98',
          'result': 'tie', // 和（2 = 2，退回本金）
          'description': '进球数为2,等于投注项2为和,和局退款\n故投注(小2)为退回本金',
        };
      case 6: // 大2/2.5
        return {
          'option': '大2/2.5',
          'odds': '1.98',
          'result': 'loseHalf', // 输半（2 = 2为和，2 < 2.5为输，一半为输）
          'description': '进球数为2,等于投注项2为和,小于投注2.5为输;一半的结果为输\n故投注(大2/2.5)为输半',
        };
      case 7: // 小2/2.5
        return {
          'option': '小2/2.5',
          'odds': '1.98',
          'result': 'winHalf', // 赢半（2 = 2为和，2 < 2.5为赢，一半为赢）
          'description': '进球数为2,等于投注项2为和,小于投注2.5为赢;一半的结果为赢\n故投注(小2/2.5)为赢半',
        };
      default:
        return null;
    }
  }

  // 获取投注结果信息（波胆类型）
  Map<String, dynamic>? getOtherBettingResult() {
    if (!isRealBettingMode.value) {
      return null;
    }
    
    final option = selectedBettingOption.value;
    if (option == null) {
      return null;
    }
    
    // 根据选中的选项返回不同的结果
    // 0: 2-0, 1: 其他比分, 2: 0-2
    // 假设赛果是2-0
    switch (option) {
      case 0: // 2-0
        return {
          'option': '2-0',
          'odds': '1.98',
          'result': 'win', // 赢（与赛果完全一致）
          'description': '投注项与赛果完全一致\n故投注(2-0)为赢',
        };
      case 1: // 其他比分
        return {
          'option': '其他比分',
          'odds': '1.98',
          'result': 'lose', // 输（因为有与赛果完全一致的选项）
          'description': '仅当所有比分选项与赛果不一致时,\n投注"其他比分"为赢；当前有与赛果\n完全一致的投注项\n故投注(其他比分)为输',
        };
      case 2: // 0-2
        return {
          'option': '0-2',
          'odds': '1.98',
          'result': 'lose', // 输（与赛果不一致）
          'description': '投注项与赛果不一致\n故投注(0-2)为输',
        };
      default:
        return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}

