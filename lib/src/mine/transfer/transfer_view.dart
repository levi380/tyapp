import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/transfer/transfer_controller.dart';
import 'package:filbet/src/mine/transfer/widgets/title_and_amount.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/custom_switch.dart';
import 'package:filbet/widgets/over_lay_dialog.dart';
import 'package:filbet/widgets/sk_common_text_field.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransferView extends GetView<TransferController> {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.transparent,
        title: 'transfer'.tr,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.TRANSFER_TUTORIAL);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 7.w),
                  child: Text(
                    '教程'.tr,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 7.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: appnewColors.bgBlue,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 11.w,
                    color: Colors.white,
                  ))
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topView(),
                platformView(context),
                autoTransferView(),
                serverView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      height: 162.r,
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appnewColors.bg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return titleAndAmount(
                    '中心钱包', controller.centerAmount.value.toFixed2(),
                    amountIcon: Assets.mineIconRefresh, onIconTap: () {
                  UserService.to.queryWalletList();
                }, isRotating: controller.isRefreshing.value);
              }),
              recycleView(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15.r),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return titleAndAmount(
                      '锁定金额',
                      controller.lockAmount.value.toFixed2(),
                    );
                  }),
                ),
                Expanded(
                  child: Obx(() {
                    return titleAndAmount(
                        '福利中心', controller.welfareAmount.value.toFixed2(),
                        key: controller.welfareCenterKey,
                        titleIcon: Assets.mineIconQuestion, onTitleIconTap: () {
                      final RenderBox? renderBox = controller
                          .welfareCenterKey.currentContext
                          ?.findRenderObject() as RenderBox?;
                      if (renderBox != null && renderBox.hasSize) {
                        final Offset position =
                            renderBox.localToGlobal(Offset.zero);
                        Get.dialog(
                          OverLayWidget(
                            position.dy -
                                MediaQuery.of(Get.context!).padding.top +
                                16.r,
                            position.dx - 70.r,
                            '福利中心待领取金\n额, 需手动领取后才\n会计入中心钱包余额',
                            Assets.mineBgOverlay1,
                            height: 80.h,
                            width: 132.w,
                          ),
                          barrierColor: Colors.transparent,
                        );
                      } else {
                        Get.dialog(
                          OverLayWidget(
                            160.r,
                            170.r,
                            '福利中心待领取金\n额, 需手动领取后才\n会计入中心钱包余额',
                            Assets.mineBgOverlay1,
                          ),
                          barrierColor: Colors.transparent,
                        );
                      }
                    });
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget platformView(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7.r),
          child: Row(
            children: [
              Obx(() {
                return CustomSwitch(
                  value: controller.hidePlatform.value,
                  onChanged: (v) {
                    controller.hideOrShowPlatform(v);
                  },
                );
              }),
              SizedBox(width: 4.r),
              Text(
                '隐藏无余额场馆',
                style: TextStyle(
                  color: appnewColors.text2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Obx(() {
          // 根据是否隐藏无余额场馆来过滤列表
          final filteredList = controller.hidePlatform.value
              ? controller.walletList
                  .where((item) => (num.tryParse(item.balance ?? '0') ?? 0) > 0)
                  .toList()
              : controller.walletList;

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4.r,
              crossAxisSpacing: 4.r,
              childAspectRatio: (Get.width - 15.r * 2 - 4.r * 3) / (4 * 50.r),
            ),
            itemBuilder: (context, index) {
              var model = filteredList[index];
              // 使用 key 确保数据更新时重建 widget
              return platformItemView(model,
                  key: ValueKey('${model.walletId}_${model.balance}'));
            },
            itemCount: filteredList.length,
          );
        }),
      ],
    );
  }

  Widget autoTransferView() {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15.r, bottom: 10.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '自动转账',
                  style: TextStyle(
                    color: appnewColors.textMain,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(() {
                  return CustomSwitch(
                    value: controller.autoTransfer.value,
                    onChanged: (v) {
                      if (!v) {
                        Get.dialog(
                          SkBaseDialog(
                            bgColor: Colors.white,
                            callback: () {},
                            cancelCallback: () {},
                            showFooterBtn: false,
                            showDeleteBtn: false,
                            showDeleteBtnType: '1',
                            child: Column(
                              children: [
                                SizedBox(height: 10.h),
                                Text(
                                  '温馨提示',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: appnewColors.text1,
                                  ),
                                ),
                                SizedBox(height: 35.h),
                                Text(
                                  '是否要关闭自动免转功能？',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: appnewColors.text1,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 35.h),
                                Container(
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
                                            Get.back(result: true);
                                            controller.changeAutoTransfer(v);
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
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        controller.changeAutoTransfer(v);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
          if (!controller.autoTransfer.value &&
              controller.outWallet.value != null &&
              controller.inWallet.value != null)
            ...autoTransferHideView(),
        ],
      );
    });
  }

  List<Widget> autoTransferHideView() {
    return [
      SizedBox(
        height: 88.r,
        child: Stack(
          children: [
            Column(
              spacing: 2.r,
              children: [
                Obx(() {
                  return transferItem(
                      0, controller.outWallet.value?.walletName ?? '', () {
                    controller.showTransferWallet(true);
                  });
                }),
                Obx(() {
                  return transferItem(
                      1, controller.inWallet.value?.walletName ?? '', () {
                    controller.showTransferWallet(false);
                  });
                }),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  controller.changeWallet();
                },
                child: Image.asset(
                  Assets.mineTransfer,
                  width: 34.r,
                  height: 34.r,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 7.r),
        alignment: Alignment.centerLeft,
        child: Text(
          '场馆钱包之间不能直接互转',
          style: TextStyle(
            color: appnewColors.textFourth,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.r),
        alignment: Alignment.centerLeft,
        child: Text(
          '转账金额',
          style: TextStyle(
            color: appnewColors.textMain,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      amountInputView(),
      Obx(() {
        final msg = controller.amountErrorMsg.value;
        if (msg.isEmpty) return SizedBox.shrink();
        return Container(
          padding: EdgeInsets.only(top: 5.r),
          alignment: Alignment.centerLeft,
          child: Text(
            msg,
            style: TextStyle(
              color: appnewColors.textRed,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
      submitView(),
    ];
  }

  Widget platformItemView(PlatformWalletModel model, {Key? key}) {
    print("object123456 ${model.walletName} ${model.balance}");
    return Container(
      key: key,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: appnewColors.border1, width: 1),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 8.r),
                  child: Text(
                    model.walletName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: appnewColors.textSecond,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              if (model.maintained != 2 && model.locked != 1)
                InkWell(
                  onTap: () {
                    controller.transferInPlatform(model);
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 6.r, left: 2.r),
                    child: Image.asset(
                      Assets.mineTransferIn,
                      width: 12.r,
                      height: 12.r,
                    ),
                  ),
                ),
            ],
          ),
          // 使用 Obx 监听 amount 变化
          Obx(() {
            // 从 walletList 中重新获取最新的 model，确保数据是最新的
            final updatedModel = controller.walletList.firstWhere(
              (item) => item.walletId == model.walletId,
              orElse: () => model,
            );
            return Container(
              padding: EdgeInsets.only(left: 8.r),
              alignment: Alignment.centerLeft,
              child: Text(
                model.maintained == 2
                    ? '维护中'
                    : model.locked == 1
                        ? '锁定中'
                        : '¥${(updatedModel.balance ?? '0').toFixed2()}',
                style: TextStyle(
                  color: model.maintained == 2 || model.locked == 1
                      ? appnewColors.textThird
                      : appnewColors.textMain,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget amountInputView() {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      child: SkCommonTextField(
        fillColor: appnewColors.bg5,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.r),
        controller: controller.amountController,
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
                text: 'RMB',
                style: TextStyle(color: appnewColors.textSecond),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.r),
                  width: 2,
                  height: 14.r,
                  color: appnewColors.textFourth,
                ),
              ),
              TextSpan(
                  text: '全部',
                  style: TextStyle(color: appnewColors.textBlue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.clickAll();
                    }),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitView() {
    return InkWell(
      onTap: () {
        if (controller.submitEnable.value) {
          controller.submitTransfer();
        }
      },
      child: Obx(() {
        return Container(
          height: 44.r,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 15.r),
          decoration: BoxDecoration(
            color: controller.submitEnable.value
                ? appnewColors.bg
                : appnewColors.bg.withAlpha(128),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '立即转账',
            style: TextStyle(
                color: appnewColors.text4,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
        );
      }),
    );
  }

  Widget serverView() {
    return InkWell(
      onTap: () {
        controller.onlineServer();
      },
      child: Container(
        height: 44.r,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15.r, bottom: 24.r),
        decoration: BoxDecoration(
          color: appnewColors.bgGray1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.mineIconServer,
              width: 20.r,
              height: 20.r,
            ),
            SizedBox(width: 6.r),
            Text(
              '在线客服',
              style: TextStyle(
                color: appnewColors.textSecond,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recycleView() {
    return InkWell(
      onTap: () {
        controller.oneKeyRecycle();
      },
      child: Container(
        height: 30.r,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        decoration: BoxDecoration(
          color: Color(0xFF79AFFF),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          'one_recycle'.tr,
          style: TextStyle(
            color: appnewColors.text4,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget transferItem(int type, String content, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43.r,
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        decoration: BoxDecoration(
          color: appnewColors.bg5,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 2.r),
              decoration: BoxDecoration(
                color: type == 0 ? appnewColors.bgBlue : appnewColors.bgGreen,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                type == 0 ? '转出' : '转入',
                style: TextStyle(
                  color: appnewColors.text4,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10.r),
            Text(
              content,
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Image.asset(
              Assets.mineIconArrowRight,
              width: 14.r,
              height: 14.r,
            ),
          ],
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
