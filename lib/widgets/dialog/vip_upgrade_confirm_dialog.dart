import 'dart:math';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/http/entity/vip_upgrade_offer.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/mine/welfareCenter/models/platform_model.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipUpgradeConfirmDialog extends StatelessWidget {
  VipUpgradeConfirmDialog({
    super.key,
    required this.platformModel,
    required this.upgradeOffer,
  });

  final VenueModel platformModel;
  final UpgradeOffer upgradeOffer;

  final amountController = TextEditingController();
  num amount = 0; //申请金额
  final step = 0.obs;
  final receiveAmount = 0.0.obs;
  final turnoverAmount = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (step.value == 0) {
        return stepOneView();
      } else {
        return stepTwoView();
      }
    });
  }

  Widget stepOneView() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.only(bottom: 20.r),
              decoration: BoxDecoration(
                color: appnewColors.bg1,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.r),
                    child: Text(
                      '领取确认',
                      style: TextStyle(
                        color: appnewColors.textMain,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            titleAndContentView('选择钱包：', '中心钱包'),
            titleAndContentView('选择场馆：', platformModel.name ?? ''),
            titleAndContentView(
                '中心钱包：', UserService.to.state.centerBalance.value),
            Container(
              margin: EdgeInsets.only(top: 8.r, bottom: 20.r),
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              height: 40.r,
              child: WalletAmountInputField(
                onChanged: (value) {
                  amount = num.tryParse(value) ?? 0;
                },
                controller: amountController,
                contentPadding: EdgeInsets.symmetric(horizontal: 9.w),
                borderRadius: BorderRadius.circular(8.r),
                hintText: '请输入转入场馆申请优惠的金额',
                textStyle: TextStyle(
                  color: appnewColors.text1,
                  fontSize: 12.sp,
                ),
                hintStyle: TextStyle(
                  color: appnewColors.text8,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'PingFang SC',
                ),
                suffixIcon: null,
                isError: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  _AmountInputFormatter(),
                ],
              ),
            ),
            bottomView(confirm: '下一步'),
          ],
        ),
      ),
    );
  }

  Widget stepTwoView() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.only(bottom: 20.r),
              decoration: BoxDecoration(
                color: appnewColors.bg1,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.r),
                    child: Text(
                      '领取确认',
                      style: TextStyle(
                        color: appnewColors.textMain,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.r),
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              alignment: Alignment.centerLeft,
              child: Text(
                '你是否确认申请此活动？',
                style: TextStyle(
                  color: appnewColors.text3,
                  fontSize: 14.sp,
                ),
              ),
            ),
            titleAndContentView('发放钱包：', '中心钱包'),
            titleAndContentView('选择场馆：', platformModel.name ?? ''),
            titleAndContentView('申请金额：', amount.toDouble().toFixed2()),
            titleAndContentView('可得彩金：', receiveAmount.value.toFixed2()),
            titleAndContentView('流水要求：', turnoverAmount.value.toFixed2()),
            SizedBox(height: 8.r),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget bottomView({String? confirm}) {
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
                if (step.value == 0) {
                  clickNext();
                } else {
                  Get.back(result: {
                    'pid': platformModel.id ?? '',
                    'amount': amount.toString()
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  confirm ?? '确定',
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

  Widget titleAndContentView(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.r),
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appnewColors.text3,
              fontSize: 14.sp,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: appnewColors.textBlue,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  void clickNext() {
    //最低金额
    num minAmount = num.tryParse(upgradeOffer.minTransfer ?? '') ?? 0;
    //中心钱包金额
    num centerAmount =
        num.tryParse(UserService.to.state.centerBalance.value ?? '') ?? 0;
    if (amount <= 0) {
      AppUtils.showToast('请输入申请金额');
      return;
    }
    if (amount < minAmount) {
      AppUtils.showToast('申请金额未达到最低转账金额');
      return;
    }
    if (amount > centerAmount) {
      AppUtils.showToast('您的余额不足');
      return;
    }
    //可得彩金
    num ratio = num.tryParse(upgradeOffer.bonusRatio ?? '') ?? 0;
    num maxBonus = num.tryParse(upgradeOffer.maxBonus ?? '') ?? 0;
    double bonus = ratio > 0 ? amount * ratio / 100 : 0;
    receiveAmount.value = min(bonus, maxBonus.toDouble());
    //流水要求
    num turnoverMultiple =
        num.tryParse(upgradeOffer.turnoverMultiple ?? '') ?? 0;
    if (bonus > receiveAmount.value && ratio > 0) {
      // 当 bonus 超过 maxBonus 时，实际奖励被限制为 maxBonus
      final double ratioDouble = ratio.toDouble();
      turnoverAmount.value = maxBonus.toDouble() *
              (1 + 100 / ratioDouble) *
              turnoverMultiple.toDouble() +
          (amount - maxBonus.toDouble() * 100 / ratioDouble);
    } else {
      turnoverAmount.value =
          ((amount + receiveAmount.value) * turnoverMultiple).toDouble();
    }
    step.value = 1;
  }
}

// 金额输入格式化器，限制2位小数
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

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
