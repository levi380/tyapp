import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/menu_api.dart';
import '../../login/login_head_import.dart';
import '../../quick_bet/quick_bet_controller.dart';
import '../../shop_cart/shop_cart_controller.dart';
import 'one_click_betting_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f8e965b2-b88c-4808-9861-fc1a918660f9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注】】】
    【【【 AUTO_PARAGRAPH_TITLE 一键投注 控制器 OneClickBettingController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注 控制器 OneClickBettingController
    - OneClickBettingController
    ```
    /// 是否开启和关闭
    bool switchOn = false;

    /// 当前值
    int fastBetAmount = 0;

    /// 最小投注额
    int min = 0;

    /// 最大投注额
    int max = 100000000;

    /// 初始化开关
    Future<void> initData()

    ```
    】】】
 *
 */
class OneClickBettingController extends GetxController {
  static OneClickBettingController get to => Get.find();
  final OneClickBettinglogic logic = OneClickBettinglogic();

  bool betAmount = false;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late List<int> singleList = [];



  @override
  void onInit() {
    /// 先从全局取开关值
    logic.switchOn = TYUserController.to.isOneClickBet.value;
    initData();
    initState();
    super.onInit();
  }

  /// 初始化状态
  initState() {
    logic.min = TYUserController.to.userInfo.value?.cvo?.single?.min ?? 0;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  /// 初始化开关
  Future<void> initData() async {
    final res = await MenuApi.instance().getUserCustomizeInfo();
    if (res.code == '0000000') {
      logic.switchOn = res.data.switchOn;
      logic.fastBetAmount = int.tryParse(res.data.fastBetAmount.toString()) ?? 0;
      // 获取 一键投注和投注额
      singleList = res.data.singleList;
      TYUserController.to.getUserCustomizeInfoBetAmount(infoRes: res);
      update();
    } else {
      ToastUtils.show(res.msg);
    }
  }

  ///一键投注关闭
  onCloseVisibility() {
    betAmount = !betAmount;
    update();
  }

  ///文本插入
  onInsertText(String myText) {
    String inputText = textEditingController.text + myText;
    if (inputText.toInt() >= logic.max) {
      textEditingController.text = logic.max.toString();
    } else {
      textEditingController.text = inputText;
    }
    focusNode.requestFocus();
    update();
  }

  ///最大值
  onMaxInputText() {
    textEditingController.text = logic.max.toString();
    focusNode.requestFocus();
    update();
  }

  ///替换文字
  replaceText(String myText) {
    textEditingController.text = myText;
    update();
  }

  ///删除键
  onBackspace() {
    if (textEditingController.text.isEmpty) {
      return;
    }
    String lastChar = textEditingController.text
        .substring(0, textEditingController.text.length - 1);
    textEditingController.text = lastChar;
    focusNode.requestFocus();
    update();
  }

  ///确定金额
  onOK() async {
    if ((int.tryParse(textEditingController.text) ?? 0) <= logic.min) {
      textEditingController.text = logic.min.toString();
    }
    betAmount = false;
    final res = await MenuApi.instance()
        //.saveUserCustomizeInfos(textEditingController.text, false, true);
        .saveUserCustomizeInfo(
            TYUserController.to.seriesList,
            TYUserController.to.singleList,
            false,
            true,
            textEditingController.text);

    if (res.code == '0000000') {
      ToastUtils.customizedBetAmountSuccessful(
          '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text).toStringAsFixed(2))}');
      update();
      await initData();
    } else {
      ToastUtils.show(res.msg);
    }
  }

  ///金额格式化
  String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
        (match) => '${match.group(1)},',
      );
    }
  }

  ///一键投注点击
  onOneClickBetting() async {
    if(ShopCartController.to.isParlayMode()){
      ToastUtils.show(LocaleKeys.bet_one_click_bet_only_single.tr);
      return;
    }


    if ((int.tryParse(textEditingController.text) ?? 0) <= logic.min) {
      textEditingController.text = logic.min.toString();
    }
    /*
    final res = await MenuApi.instance().saveUserCustomizeInfos(
        textEditingController.text.isEmpty
            ? fastBetAmount.toString()
            : textEditingController.text,
        false,
        !switchOn,
        );
     */
    final res = await MenuApi.instance().saveUserCustomizeInfo(
      TYUserController.to.seriesList,
      TYUserController.to.singleList,
      false,
      !logic.switchOn,
      textEditingController.text.isEmpty
          ? logic.fastBetAmount.toString()
          : textEditingController.text,
    );
    if (res.code == '0000000') {
      // 开启或者关闭都清空订单
      QuickBetController.to.orderRespList.clear();
      if (logic.switchOn == false) {
        ToastUtils.customizedBetAmountSuccessful(
            '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text.isEmpty ? logic.fastBetAmount.toString() : textEditingController.text).toStringAsFixed(2))}');
      }

      update();
      await initData();
    } else {
      ToastUtils.show(res.msg);
    }
  }
}
