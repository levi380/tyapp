import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/dialog_kfview.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransferInGameDialog extends StatefulWidget {
  const TransferInGameDialog(
    this.existingTurnover, {
    this.onOneKeyRecycle,
    super.key,
  });

  final num existingTurnover;
  final VoidCallback? onOneKeyRecycle;

  @override
  State<TransferInGameDialog> createState() => _TransferInGameDialogState();
}

class _TransferInGameDialogState extends State<TransferInGameDialog> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    final input = num.tryParse(amountController.text.trim()) ?? 0;
    final centerBalanceStr = UserService.to.state.centerBalance.value;
    final centerBalance = num.tryParse(centerBalanceStr) ?? 0;
    if (input > centerBalance && centerBalance >= 0) {
      amountController.text = toStringAsFixed2(centerBalanceStr);
      amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: amountController.text.length),
      );
    }
    setState(() {});
  }

  num get _requiredTurnover {
    final input = num.tryParse(amountController.text.trim()) ?? 0;
    return widget.existingTurnover + input;
  }

  @override
  void dispose() {
    amountController.removeListener(_onAmountChanged);
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            contentView(),
            amountView(),
            serverView(),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      height: 48.r,
      margin: EdgeInsets.only(top: 10.r),
      alignment: Alignment.center,
      child: Text(
        '转入金额',
        style: TextStyle(
          color: appnewColors.textMain,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget contentView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.r),
        child: RichText(
          text: TextSpan(
            text: '您正在参与活动,场馆锁定中,转入金额后,您还需要完成',
            children: [
              TextSpan(
                text: ' ${_requiredTurnover.toStringAsFixed(2)}元 ',
                style: TextStyle(
                  color: appnewColors.textBlue,
                  fontSize: 14.sp,
                ),
              ),
              TextSpan(
                text: '有效流水才能转出。您确定要转入吗?注意:当前场馆锁定中,转入的金额不享受返水奖励',
              ),
            ],
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget amountView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: '中心钱包：',
                      children: [
                        TextSpan(
                          text: '${UserService.to.state.centerBalance.value}元 ',
                          style: TextStyle(
                            color: appnewColors.textBlue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: appnewColors.textMain,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.onOneKeyRecycle,
                  child: Text(
                    '一键回收',
                    style: TextStyle(
                      color: appnewColors.textBlue,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          amountInputView(),
        ],
      ),
    );
  }

  Widget serverView() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.r, bottom: 20.r, left: 20.r),
      child: RichText(
        text: TextSpan(
          text: '注:若需解锁场馆,请联系',
          children: [
            TextSpan(
                text: '在线客服',
                style: TextStyle(
                  color: appnewColors.textBlue,
                  fontSize: 14.sp,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.dialog(
                      SkBaseDialog(
                        bgColor: Colors.transparent,
                        callback: () {
                          Get.back();
                        },
                        cancelCallback: () {},
                        showFooterBtn: false,
                        showDeleteBtn: true,
                        showDeleteBtnType: '2',
                        child: DialogKfView(),
                      ),
                    );
                  }),
          ],
          style: TextStyle(
            color: appnewColors.textMain,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget bottomView() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appnewColors.colorLine,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '取消',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textMain,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: appnewColors.colorLine,
            width: 1,
            height: 48.r,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                final text = amountController.text.trim();
                final amount = num.tryParse(text);
                if (text.isEmpty || amount == null || amount <= 0) {
                  AppUtils.showToast('请输入有效金额');
                  return;
                }
                Get.back(result: text);
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '确定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appnewColors.textBlue,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountInputView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r, left: 20.r, right: 20.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE0E7FE),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SkCommonTextField(
        fillColor: appnewColors.bg1,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.r),
        controller: amountController,
        hintText: '请输入转账金额',
        maxLength: 12,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // 只允许数字和小数点
          _AmountInputFormatter(), // 自定义格式化，限制小数位数和格式
        ],
        hintStyle: TextStyle(
          color: appnewColors.text21,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        style: TextStyle(
          color: appnewColors.text1,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        suffix: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                  text: '全部',
                  style: TextStyle(color: appnewColors.textBlue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      final centerBalance =
                          UserService.to.state.centerBalance.value;
                      amountController.text = toStringAsFixed2(centerBalance);
                    }),
            ],
          ),
        ),
      ),
    );
  }
}

// 金额输入格式化器
class _AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 不允许多个小数点
    if (newValue.text.split('.').length > 2) {
      return oldValue;
    }

    // 如果以小数点开头，前面补0
    String text = newValue.text;
    if (text.startsWith('.')) {
      text = '0$text';
    }

    // 限制小数位数为2位
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length == 2 && parts[1].length > 2) {
        text = '${parts[0]}.${parts[1].substring(0, 2)}';
      }
    }

    // 不允许多个前导0（除非是0.xx格式）
    if (text.length > 1 && text.startsWith('0') && !text.startsWith('0.')) {
      text = text.substring(1);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
