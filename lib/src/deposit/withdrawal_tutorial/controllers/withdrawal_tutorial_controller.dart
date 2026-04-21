import 'package:filbet/src/deposit/withdrawal_tutorial/controllers/WithdrawalTutorialItem.dart';
import 'package:get/get.dart';

class WithdrawalTutorialController extends GetxController {
  // 展开状态列表，记录每个问题的展开状态
  final RxList<bool> expandedStates = [false, false, false, false, false, false, false, false, false, false, false, false].obs;

  // 转账教程问题列表
  final List<WithdrawalTutorialItem> tutorialItems = [
    WithdrawalTutorialItem(
      question: '如何取款',
      answer: '第一次取款请先绑定银行卡，绑定银行卡步骤 登录账号 -- 我的页面 -- 账户管理 -- 添加银行卡 \n登录账号 -- 首页/我的钱包 -- 点击取款 -- 添加银行卡。\n绑定完成后在取款金额输入框输入金额，点击立即取款。',
    ),
    WithdrawalTutorialItem(
      question: '可以使用别人的银行卡进行取款吗?',
      answer: '为了确保客户的账户资金安全，取款需要使用账号本人的银行卡才可以进行取款哦，且取款银行卡姓名必须与注册姓名一致。',
    ),
    WithdrawalTutorialItem(
      question: '申请取款需要注意些什么？',
      answer: '绑定的银行卡姓名需与账户的注册姓名一致。\n绑定的银行卡信息需要正确。若您未申请任何红利优惠，投注满一倍流水即可申请取款。\n若申请首存红利，则需要满足优惠活动写明的有效投注额要求。\n全天24小时都可进行取款申请。',
    ),
    WithdrawalTutorialItem(
      question: '游戏账户里有钱为什么无法取款？',
      answer: '您需要先将资金从游戏平台钱包转至中心钱包后，才能进行取款操作。',
    ),
    WithdrawalTutorialItem(
      question: '可以绑定多张银行卡吗？',
      answer: '''用户可以绑定10张银行卡进行取款操作，在我的页面选择“账户管理”，按步骤添加银行卡即可。''',
    ),
    WithdrawalTutorialItem(
      question: '取款为什么还需要审核?',
      answer: '''取款审核是相关部门在给您办理出款之前的一个简单的核实步骤，是为了确保客户资金安全，所以需要核实相关信息。''',
    ),
    WithdrawalTutorialItem(
      question: '取款要求（例：流水)',
      answer: '''用户只要达到存款全额投注，可以随时申请取款。比如，您存100元，在该笔存款后，您累计下注达到100元的取款流水，即可办理取款！温馨提示：若会员有领取其他优惠，必须达到相对应的有效流水才能办理取款！''',
    ),
    WithdrawalTutorialItem(
      question: '取款到账时间',
      answer: '''用户取款一般10分钟内到账，如果30分钟还未到账可以联系在线客服为您核查！''',
    ),
    WithdrawalTutorialItem(
      question: '取款支持的银行',
      answer:
          '''目前为您提供15家取款银行：中国银行、工商银行、建设银行、交通银行、农业银行、招商银行、民生银行、平安银行、华夏银行、广东发展银行、邮政储蓄银行、中信银行、兴业银行、上海浦发银行、光大银行。系统不定时会有所调整，具体还请您以添加银行卡时提供的银行为准。''',
    ),
    WithdrawalTutorialItem(
      question: '我流水还差多少？',
      answer: '''首先确认自己是否有申请优惠活动，找到对应优惠活动查看所需流水，再点击APP右下角【我的】一【投注记录】查看流水，无申请优惠活动情况下1倍流水即可出款。\n若无法确认自己所需流水倍数，可直接联系7*24小时在线客服。''',
    ),
    WithdrawalTutorialItem(
      question: '取款输入金额无法提交申请?',
      answer: '''若提示"您有订单尚未核实成功”请联系客服进行咨询。若有其他取款问题请与7*24小时客服团队联系。''',
    ),
    WithdrawalTutorialItem(
      question: '我取款未到账？',
      answer: '''正常情况下10分钟以内即可到账，延迟原因一般是网络波动、风控审核等，耐心等待片刻即可，若30分钟以后未到账:联系7*24小时在线客服同时提供以下信息。\n（1）会员账号\n（2）出款时间\n（3）出款金额''',
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
