import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/bases/get_base_controller.dart';
import 'package:get/get.dart';

class TransferTutorialController extends GetXBaseController {
  // 展开状态列表，记录每个问题的展开状态
  final RxList<bool> expandedStates = [false, false, false, false, false].obs;

  // 转账教程问题列表
  final List<TransferTutorialItem> tutorialItems = [
    TransferTutorialItem(
      question: '如何转账',
      answer: '''登录账号 > 首页/我的，点击转账 > 进入转账页面

手动转账步骤：

1）打开页面：登录账号 -- 我的 -- 转账；
2）选择转出转入钱包；
3）输入金额，或点击“全部”；
4）点击立即转账；
自动转账步骤：
1）打开页面：登录账号 -- 我的 -- 转账页；
2）（向右）打开自动转账开关；''',
      imgUrl: Assets.helpHelpTransfer,
      tips: '进入某场馆时，中心钱包的金额自动带入到对应的游戏场馆中'
    ),
    TransferTutorialItem(
      question: '开启自动转账后怎么取款?',
      answer:
          '''开启自动转账模式后，当您进入取款页面时，会自动回收所有场馆的余额，直接进行取款申请的操作即可，若因网络原因造成场馆的余额没有及时回收到中心钱包，点击钱包金额右方的“一键回收”按钮即可进行二次回收场馆余额。''',
    ),
    TransferTutorialItem(
      question: '转账到场馆金额变少?',
      answer: '''大部分金额变少或金额变负数是系统二次结算导致的结果，若对该部分有异议可联系7*24小时在线客服进行详细咨询。''',
    ),
    TransferTutorialItem(
      question: '转账没有成功,但是钱却没了怎么办?',
      answer: '''转账时请先退出游戏平台再操作。

如转账出现金额丢失及时联系24小时在线客服，并提供以下信息：

（1）会员账号

（2）丢失金额

（3）问题场馆。''',
    ),
    TransferTutorialItem(
      question: '主账户/场馆,转场馆/主账户失败?',
      answer: '''查看场馆是否处于锁定中，若场馆处于锁定中状态则不支持转账处理。

是否存在频繁转账操作，因转账人数较多，单个账户若频繁转账会增加数据交互负担，从而造成数据丢失或数据错误。

请尝试转入整数。

联系24小时在线客服进行咨询。''',
    ),
  ];

  // 切换展开状态
  void toggleExpanded(int index) {
    if (index >= 0 && index < expandedStates.length) {
      final currentValue = expandedStates[index];
      expandedStates[index] = !currentValue;
      // 触发更新
      expandedStates.refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}

// 转账教程数据模型
class TransferTutorialItem {
  final String question;
  final String answer;
  String? imgUrl;
  String? tips;

  TransferTutorialItem({
    required this.question,
    required this.answer,
    this.imgUrl,
    this.tips,
  });
}
