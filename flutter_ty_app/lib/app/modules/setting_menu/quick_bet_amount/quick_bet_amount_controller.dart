import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/menu_api.dart';
import 'quick_bet_amount_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额 控制器 QuickBetAmountController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额 控制器 QuickBetAmountController
    - QuickBetAmountController
    ```
    ///选择单关投注
    String selectedSingleLevelBetting = '';

    ///串关投注
    String selectedMatchBetting = '';

    ///投注金额
    bool betAmount = false;

    late int bettingColumn;

    bool downloadData = true;

    /// 最小投注额
    int min = 0;

    /// 初始化状态
    initState()
    ```
    】】】
 *
 */
class QuickBetAmountController extends GetxController {
  final QuickBetAmountlogic logic = QuickBetAmountlogic();

  late List<int> seriesList = [];
  late List<int> singleList = [];
  late ActionType currentActionType;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late int bettingColumn;


  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    initState();

    textEditingController.text = '10';
    super.onInit();
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

  /// 初始化状态
  initState() {
    logic.min = TYUserController.to.userInfo.value?.cvo?.single?.min ?? 0;
  }

  Future<void> initData() async {
    seriesList = TYUserController.to.seriesList;
    singleList = TYUserController.to.singleList;
    if (seriesList.isEmpty && singleList.isEmpty) {
      await TYUserController.to.getUserCustomizeInfo();
      seriesList = TYUserController.to.seriesList;
      singleList = TYUserController.to.singleList;
      update();
    }
  }

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

  ///单关 确认
  onSelectSingleLevelBetting(int amount, int i) {
    bettingColumn = i;
    logic.betAmount = true;
    logic.selectedMatchBetting = '';
    logic.selectedSingleLevelBetting = amount.toString();
    focusNode.requestFocus();
    textEditingController.text = amount.toString();

    currentActionType = ActionType.SINGLE;

    update();
  }

  ///串关 确认
  onSelectMatchBetting(int amount, int i) {
    bettingColumn = i;
    logic.betAmount = true;
    logic.selectedSingleLevelBetting = '';
    logic.selectedMatchBetting = amount.toString();
    focusNode.requestFocus();
    textEditingController.text = amount.toString();

    currentActionType = ActionType.SERIES;

    update();
  }

  ///关闭键盘
  onCloseVisibility() {
    logic.betAmount = false;
    logic.selectedMatchBetting = '';
    logic.selectedSingleLevelBetting = '';
    update();
  }

  onFocusNode() {
    focusNode.unfocus();
    update();
  }

  onInsertText(String myText) {
    if (textEditingController.text.isNotEmpty &&
        int.parse(textEditingController.text) >= 9999999) {
      update();
      return;
    }
    textEditingController.text = textEditingController.text + myText;
    focusNode.requestFocus();
    update();
  }

  ///最大金额设置
  onMaxInputText() {
    textEditingController.text = '9999999';
    focusNode.requestFocus();
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

  ///确认修改金额
  onOK() async {
    if (int.parse(textEditingController.text) <= logic.min) {
      textEditingController.text = logic.min.toString();
    }
    var v = textEditingController.text;
    int index = bettingColumn - 1;

    List<int> copySingList = lodash.deepCopyArr<int>(singleList);
    List<int> copySeriesList = lodash.deepCopyArr(seriesList);
    if (currentActionType == ActionType.SINGLE) {
      copySingList[index] = int.parse(v);
    } else {
      copySeriesList[index] = int.parse(v);
    }

    final res = await MenuApi.instance().saveUserCustomizeInfo(
        copySeriesList,
        copySingList,
        false,
        TYUserController.to.isOneClickBet.value,
        TYUserController.to.oneClickBetAmount.toString());
    if (res.code == '0000000') {
      logic.betAmount = false;
      logic.selectedMatchBetting = '';
      logic.selectedSingleLevelBetting = '';
      ToastUtils.customizedBetAmountSuccessful(
          '${'${LocaleKeys.app_h5_filter_quick_bet.tr}$bettingColumn '}${'${LocaleKeys.app_h5_filter_change_to.tr}: '}${toAmountSplit(int.parse(textEditingController.text).toStringAsFixed(2))}');
      // await initData();
      // 减少接口请求
      if (currentActionType == ActionType.SINGLE) {
        singleList = copySingList;
      } else {
        seriesList = copySeriesList;
      }
      update();

      TYUserController.to.seriesList = seriesList;
      TYUserController.to.singleList = singleList;
      // 更新UserController中得数据 不走接口
      TYUserController.to.setUserCustomizeInfo();
    } else {
      ToastUtils.show(res.msg);
      update();
    }
  }
}

///单关串关
enum ActionType {
  SINGLE('single'),
  SERIES('series');

  final String code;

  const ActionType(this.code);
}
