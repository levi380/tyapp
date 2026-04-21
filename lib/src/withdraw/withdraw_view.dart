import 'package:filbet/common/currency.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/mixin/security_verification_mixin.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/dialog/first_deposit_hint_dialog.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/dialog/withdraw_deposit_hint_dialog.dart';
import 'package:filbet/src/mine/transfer/widgets/title_and_amount.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/withdraw/glowing_icon.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/src/withdraw/withdraw_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/bottom_sheet_content_util.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/security_util.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/custom_switch.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/over_lay_dialog.dart';
import 'package:filbet/widgets/pop_up_input_owd_view.dart';
import 'package:filbet/widgets/rotating_icon.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:filbet/widgets/wallet_info_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';

class WithdrawView extends GetView<WithdrawController>
    with SecurityVerificationMixin {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: 'withdraw'.tr,
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.WITHDRAWAL_TUTORIAL);
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 7.w),
                    child: Text(
                      '教程'.tr,
                      style: TextStyle(
                        color: appnewColors.text1,
                        fontSize: 16.sp,
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
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopCard(),
                SizedBox(height: 16.h),
                platformView(context),
                _buildCurrencySelection(),
                SizedBox(height: 16.h),
                _buildWithdrawTypeSection(context),
                SizedBox(height: 20.h),
                // _buildWithdrawTypes(),
                // SizedBox(height: 16.h),
                _buildWalletSection(),
                SizedBox(height: 16.h),
                if (controller.accountList.isEmpty)
                  serverView()
                else
                  _buildSubmitInfo(context)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSubmitInfo(BuildContext context) {
    return Column(
      children: [
        _buildWithdrawInfo(context),
        // SizedBox(height: 24.h),
        _buildRemainingCount(),
        SizedBox(height: 20.h),
        _buildSubmitButton(),
        SizedBox(height: 40.h),
      ],
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

          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: (Get.width - 15.r * 2 - 10 * 3) / (4 * 50.r),
              ),
              itemBuilder: (context, index) {
                var model = filteredList[index];
                // 使用 key 确保数据更新时重建 widget
                return platformItemView(model,
                    key: ValueKey('${model.walletId}_${model.balance}'));
              },
              itemCount: filteredList.length,
            ),
          );
        }),
      ],
    );
  }

  Widget platformItemView(PlatformWalletModel model, {Key? key}) {
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
          Text(
            model.walletName ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
            ),
          ),
          // 使用 Obx 监听 amount 变化
          Obx(() {
            // 从 walletList 中重新获取最新的 model，确保数据是最新的
            final updatedModel = controller.walletList.firstWhere(
              (item) => item.walletId == model.walletId,
              orElse: () => model,
            );
            return Text(
              '¥${(updatedModel.balance ?? '0').toFixed2()}',
              style: TextStyle(
                color: appnewColors.textMain,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTopCard() {
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
                  UserService.to.queryTotalBalance();
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
                            '福利中心待领取金额, 需手动领取后才会计入中心钱包余额',
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

  //<editor-fold desc="取款钱包">
  Widget _buildCurrencySelection() {
    if (GlobalService.to.state.currencyConfig.length > 1) {
      return Container(
        child: buildCurrencySelection(
          titleStyle: TextStyle(
            color: appnewColors.text1,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
          titlePadding: EdgeInsets.zero,
          padding: EdgeInsets.all(10),
          glowColor: appnewColors.bg4,
          titleSpacing: 8.h,
          'withdraw_wallet'.tr,
          Image.asset(
            controller.currency.value.imagePath,
            height: 25.h,
            width: 25.w,
          ),
          '${controller.currency.value.name} (${controller.currency.value.abbr})',
          contentPadding: EdgeInsets.zero,
          isShowArrow: controller.canPresentCurrencySelection,
          onTap: controller.canPresentCurrencySelection
              ? () {
                  final dialog = buildCurrencySelectionDialog(
                    currencyList: controller.currencyList,
                    selectedCurrency: controller.currency.value,
                    didSelected: (Currency selectedCurrency) {
                      controller.currency.value = selectedCurrency;
                      UserService.to.state.userInfo.currency =
                          int.parse(selectedCurrency!.code);
                      if (selectedCurrency != null) {
                        // SpStorage.setCurrency(
                        //     currency.abbr);
                        // UserService.to.state.currencyType = selectedCurrency;
                      }
                    },
                  );
                  Get.bottomSheet(dialog);
                }
              : null,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  //</editor-fold>

  //<editor-fold desc="取款类型">
  Widget _buildWithdrawTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "取款类型".tr,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: appnewColors.text22),
        ),
        SizedBox(height: 8.h),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.withdrawTypesItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 三列
              mainAxisSpacing: 16, // 行间距
              crossAxisSpacing: 12, // 列间距
              childAspectRatio: 165 / 43, // 宽高比（越大越扁）
            ),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () => () {},
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: controller.isSelectedWithdrawTypes.value
                              ? appnewColors.bg
                              : appnewColors.colorLine,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.withdrawTypesItems[index]["text"],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: appnewColors.textBlue,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "（0～24小时到账）",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: appnewColors.textBlue,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Text(
                            controller.withdrawTypesItems[index]["text"],
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: appnewColors.text25,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (controller.isSelectedWithdrawTypes.value)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          Assets.mineIconSelectWithdrawMethod,
                          width: 19.w,
                          height: 19.w,
                        ),
                      ),
                  ],
                ),
              );
            })
      ],
    );
  }

  //</editor-fold>

  Widget buildDepositAmountSelection() {
    final amounts = controller.amountLimit;
    const itemsPerRow = 4;
    List<List<int>> rows = [];
    for (var i = 0; i < amounts.length; i += itemsPerRow) {
      rows.add(amounts.sublist(i,
          i + itemsPerRow > amounts.length ? amounts.length : i + itemsPerRow));
    }

    return Column(
      children: rows.asMap().entries.map((entry) {
        final rowIndex = entry.key;
        final rowAmounts = entry.value;
        return Padding(
          padding:
              EdgeInsets.only(bottom: rowIndex < rows.length - 1 ? 10.h : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowAmounts.map((amount) {
              final isSelected = controller.selectedAmount.value == amount;
              return GestureDetector(
                onTap: () {
                  controller.selectedAmount.value = amount;
                  controller.withdrawAmountController.text = amount.toString();
                  controller.enteredWithdrawAmount.value = "$amount";
                  // controller.entereddepositAmount.value =
                  //     controller.depositAmountController.text;
                  controller.updata();
                },
                //
                child: Stack(
                  children: [
                    Container(
                      width: 75.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appnewColors.bg4, // ✅ 背景始终是 bg
                        border: Border.all(
                          color: isSelected
                              ? appnewColors.bg
                              : appnewColors.bg4, // ✅ 边框切换
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: Text(
                        toThousands(amount.toString()),
                        style: TextStyle(
                          color: isSelected
                              ? appnewColors.bg
                              : appnewColors.text1, // ✅ 文字颜色逻辑保留
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          Assets.mineIconSelectWithdrawMethod,
                          width: 19.w,
                          height: 19.w,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  //<editor-fold desc="取款剩余次数">
  Widget _buildRemainingCount() {
    var withdrawLimit =
        controller.withdrawLimitModel.value?.withdrawLimit ?? "0";
    var frontName = controller.selectedChannel.value?.frontName ?? "";
    // 当日剩余取款额度
    var withdrawRemain = double.parse(
        controller.withdrawLimitModel.value?.withdrawRemain ?? '0');
    //   if (withdrawRemain <= 0) {
    // _showTipDialog('当日剩余取款额度不足'.tr);
    // return;
    // }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // "今日$frontName可取款:",
                "今日可提:",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appnewColors.text26),
              ),
              Text(withdrawLimit,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: appnewColors.textBlue)),
              Text(
                "次",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appnewColors.text26),
              ),
              Spacer(),
              Text(
                // "今日$frontName可取款:",
                "今日剩余额:",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appnewColors.text26),
              ),
              Text(
                controller.currency.value.symbol ?? "",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: appnewColors.text26),
              ),
              Text("$withdrawRemain",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: appnewColors.textBlue)),
            ],
          ),

          SizedBox(height: 14.h),
          // if (!controller.isAlipayOrBank())
          Text(
            '(' + controller.rateForUSDT + " 实时变化）",
            style: TextStyle(
              color: appnewColors.text22,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  //</editor-fold>

  Widget _buildWithdrawTypeSection(BuildContext context) {
    return Obx(() {
      if (controller.channels.isEmpty) {
        return const SizedBox.shrink();
      }
      return buildFundingChannelsSelectionGridViewSlide(
        'withdraw_method'.tr,
        crossAxisCount: 3,
        controller.channels,
        context,
        selected: controller.selectedChannel.value,
        didSelect: (ChannelModel channel) {
          controller.selectedChannel.value = channel;
          controller.withdrawAmountController.clear();
          controller.selectedAmount.value = null;
          controller.enteredWithdrawAmount.value = "";
          controller.dealWithWalletTypeLogic();
        },
        titlePadding: EdgeInsets.zero,
        titleSpacing: 8.h,
        contentPadding: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
        bgColor: Colors.transparent,
        titleStyle: TextStyle(
          color: appnewColors.text1,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      );
    });
  }

  Widget _buildWalletSection() {
    int? paymentType = controller.selectedChannel.value?.paymentType;
    String frontName = controller.selectedChannel.value?.frontName ?? "";
    return Obx(() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                controller.getPaymentTypeTitle(),
                style: TextStyle(
                  color: appnewColors.text1,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              buildWalletFunctionButton('add'.tr, () async {
                // 去除是否设置支付密码校验（产品要求20260202）
                // if (!controller.hasWithdrawPassword) {
                //   setPaymentPasswordFirst(onSuccess: (isSuccess) {
                //     if (isSuccess) {
                //       controller.loadSecurityData();
                //       if (Get.isDialogOpen ?? false) {
                //         Get.back();
                //       }
                //     } else {
                //       AppUtils.showToast('settings_failed'.tr);
                //     }
                //   });
                //   return;
                // }

                if (paymentType == 6) {
                  if (!AppUtils.addBankCardEnable()) {
                    return;
                  }
                  final isSuccess = await Get.toNamed(Routes.ADD_BANK_CARD);
                  if (isSuccess) {
                    controller.loadWalletAccountList();
                  }
                  return;
                }
                if (paymentType == 7) {
                  var isSuccess = await Get.toNamed(Routes.ADD_ACCOUNT,
                      arguments: {
                        "paymentType": paymentType,
                        "isFromWithdraw": true
                      });
                  if (isSuccess) {
                    controller.loadWalletAccountList();
                  }
                  return;
                }

                if (paymentType == 1) {
                  final isAppend = await Get.toNamed(Routes.ADD_USDT,
                      arguments: {"paymentType": paymentType});
                  if (isAppend == true) {
                    controller.loadWalletAccountList();
                  }
                  return;
                }

                var result = await Get.toNamed(Routes.ADD_ACCOUNT, arguments: {
                  "paymentType": paymentType,
                  "isFromWithdraw": true
                });
                if (result) {
                  controller.loadWalletAccountList();
                }
              }),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              // GlowingIcon(
              //   glowColor: appnewColors.bg,
              //   size: 36.r,
              //   icon: Image.asset(
              //     Assets.imagesWallet,
              //     height: 24.w,
              //     width: 24.w,
              //   ),
              // ),
              // SizedBox(width: 8.w),
              if (controller.accountList.isEmpty)
                buildEmptyWallet()
              else
                buildWallet(controller.selectedAccount.value ??
                    controller.accountList.first),
            ],
          ),
        ],
      );

      // buildContentShadowWrapperWithTitle(
      //   titlePadding: EdgeInsets.zero,
      //   padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      //   title: blockChain == 6
      //       ? 'arrived_bank'.tr
      //       : blockChain == 7
      //           ? 'arrived_alipay'.tr
      //           : 'arrived_wallet'.tr,
      //   titleSpacing: 8.h,
      //   titleStyle: TextStyle(
      //     color: appnewColors.text1,
      //     fontFamily: 'PingFang SC',
      //     fontWeight: FontWeight.w500,
      //     fontSize: 16.sp,
      //   ),
      //   content: Container(
      //     padding: EdgeInsets.zero,
      //     child: Row(
      //       children: [
      //         GlowingIcon(
      //           glowColor: appnewColors.bg,
      //           size: 36.r,
      //           icon: Image.asset(
      //             Assets.imagesWallet,
      //             height: 24.w,
      //             width: 24.w,
      //           ),
      //         ),
      //         SizedBox(width: 8.w),
      //         if (controller.accountList.isEmpty)
      //           buildEmptyWallet()
      //         else
      //           buildWallet(controller.selectedAccount.value ?? controller.accountList.first),
      //       ],
      //     ),
      //   ),
      // );
    });
  }

  Widget buildWalletFunctionButton(String title, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.h,
        width: 48.w,
        decoration: BoxDecoration(
          color: appnewColors.bgGray1,
          borderRadius: BorderRadius.circular(6.r),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: appnewColors.text2,
            fontFamily: 'PingFang SC',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyWallet() {
    int? blockChain = controller.selectedChannel.value?.paymentType;
    String? channelName = controller.selectedChannel.value?.name;
    String desc = "";
    switch (blockChain) {
      case 6:
        desc = "请先绑定一个银行卡账号，用于收款";
        break;
      case 7:
        desc = "请先绑定一个支付宝账号，用于收款";
        break;
      default:
        desc = "请先绑定一个${channelName ?? ''}账号，用于收款";
        break;
    }

    final contentTextStyle = TextStyle(
      color: appnewColors.textFourth,
      fontFamily: 'PingFang SC',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Expanded(
      child: Row(
        children: [
          Text(desc, style: contentTextStyle),
        ],
      ),
    );
  }

  Widget buildWallet(WalletAccountModel account) {
    return Expanded(
      child: InkWell(
        onTap: () {
          final selectedIndex = controller.accountList.indexWhere(
            (account) => account.id == controller.selectedAccount.value?.id,
          );
          final content = _AccountListWidget(
            accountList: controller.accountList,
            blockName: controller.securityData.value.walletList
                    .where((value) => value.paymentType == account.paymentType)
                    .toList()
                    .firstOrNull
                    ?.paymentTypeName ??
                "",
            selectedIndex: selectedIndex,
            onAccountSelected: (int index) {
              // todo 点击更新
              controller.selectedAccount.value = controller.accountList[index];
            },
          );
          Get.bottomSheet(
            SKBottomSheet(
              title: account.blockChainTitleName,
              content: content,
              closeButton: Text(""),
            ),
            isScrollControlled: true,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: appnewColors.bg17,
              width: 1.h,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(children: [
            if (account.paymentType == 6 || account.paymentType == 7)
              bankOrAlipayInfoView(account)
            else
              usdtView(account),
            const Spacer(),
            Image.asset(
              Assets.mineIconArrowRight,
              width: 14.r,
              height: 14.r,
              color: appnewColors.textSecond,
            ),
            // buildWalletFunctionButton('switch'.tr, () {
            //
            // }),
          ]),
        ),
      ),
    );
  }

  Widget bankOrAlipayInfoView(WalletAccountModel account) {
    final contentTextStyle = TextStyle(
      color: appnewColors.text1,
      fontFamily: 'PingFang SC',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
    var addressInfo = account.addressInfo;
    var img = addressInfo?.img ?? "";
    bool isBank = account.paymentType == 6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (img.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: SKNetworkImage(
              width: 24.w,
              height: 24.w,
              borderRadius: 12.r,
              imageUrl: img ?? '',
              placeholderType: 1,
            ),
          ),
        // if (!isBank) Text(addressInfo?.accountName ?? '', style: contentTextStyle),
        if (isBank) Text(addressInfo?.bankName ?? '', style: contentTextStyle),
        Text(maskUSDTWalletAddress(addressInfo?.accountNo ?? ''),
            style: contentTextStyle),
      ],
    );
  }

  Widget usdtView(WalletAccountModel account) {
    final contentTextStyle = TextStyle(
      color: appnewColors.text1,
      fontFamily: 'PingFang SC',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
    final maskUSDTWalletAddress1 = maskUSDTWalletAddress(account.address);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //只显示地址
        // Text(
        //     account.name.length > 10
        //         ? '${account.name.substring(0, 10)}...'
        //         : account.name,
        //     style: contentTextStyle),
        // Text(
        //     controller.securityData.value.walletList
        //             .where((value) => value.paymentType == account.paymentType)
        //             .toList()
        //             .firstOrNull
        //             ?.paymentTypeName ??
        //         "",
        //     style: contentTextStyle),
        Text(maskUSDTWalletAddress1, style: contentTextStyle),
      ],
    );
  }

  Widget _buildWithdrawInfo(BuildContext context) {
    return buildMultiContentShadowWrapperWithTitle(
      titlePadding: EdgeInsets.zero,
      padding: EdgeInsets.only(bottom: 0.h),
      title: 'withdraw_amount'.tr,
      titleStyle: TextStyle(
        color: appnewColors.text1,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      children: [
        buildDepositAmountSelection(),
        IgnoreContentContainerBackgroundWidget(
          child: GetBuilder<WithdrawController>(
            id: 'withdraw_amount_validation',
            builder: (controller) {
              return SizedBox(
                height: 40.h,
                child: WalletAmountInputField(
                  onChanged: (value) =>
                      controller.enteredWithdrawAmount.value = value,
                  maxLength: controller.maxInputLength,
                  controller: controller.withdrawAmountController,
                  focusNode: controller.withdrawAmountFocusNode,
                  isError: !controller.isWithdrawInputAmountValid,
                  hintText: controller.withdrawRangeForOneTimeText,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  borderRadius: BorderRadius.circular(8.r),
                  textStyle: TextStyle(
                    color: controller.isWithdrawInputAmountValid
                        ? appnewColors.text6
                        : appColors.textRedColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PingFang SC',
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.withdrawAmountController.text =
                          '${num.tryParse(controller.centerAmount.value) ?? 0}';
                    },
                    child: Text(
                      '最大金额',
                      style: TextStyle(
                        color: appnewColors.text7,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'PingFang SC',
                      ),
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: appnewColors.text8,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PingFang SC',
                  ),
                ),
              );
            },
          ),
        ),
        // 单笔取款金额
        // buildWithdrawSummary(),
        // 流水要求
        // buildWithdrawReminder(),
        Obx(() {
          // 只有在输入框有内容时才显示
          if (controller.enteredWithdrawAmount.value.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.zero,
              child: buildWithdrawFee(),
            );
          } else {
            return SizedBox.shrink(); // 返回一个空占位，什么都不显示
          }
        }),
      ],
    );
  }

  Widget buildWithdrawSummary() {
    final contentTextStyle = TextStyle(
      color: appnewColors.text2,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    final withdrawAmountForOneTime =
        '${controller.selectedChannel.value?.range ?? 0} ${controller.currency.value.abbr}';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          WalletInfoText(
            title: 'single_withdrawal_amount'.tr,
            info: Text(
              withdrawAmountForOneTime,
              style: contentTextStyle.copyWith(color: appnewColors.tip4),
            ),
          ),
          if (!controller.isAlipayOrBank()) SizedBox(height: 12.h),
          if (!controller.isAlipayOrBank())
            WalletInfoText(
              title: 'cur_rate'.tr,
              info: Text(
                controller.rateForUSDT,
                style: contentTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildWithdrawReminder() {
    final contentTextStyle = TextStyle(
      color: appnewColors.text2,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    final withdrawRemainText =
        '${controller.withdrawLimitModel.value?.withdrawRemainText ?? 0} ${controller.currency.value.abbr}';
    String currencyType =
        controller.withdrawLimitModel.value?.currencyType.abbr ?? '';
    String flowRequiredText =
        controller.withdrawLimitModel.value?.flowRequiredText ?? '';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          if (controller.withdrawLimitModel.value?.turnover != "0" &&
              currencyType.isNotEmpty &&
              flowRequiredText.isNotEmpty) ...{
            WalletInfoText(
              title: 'roll_req_colon'.tr,
              info: RichText(
                text: TextSpan(
                  text: 'detail'.tr,
                  children: [
                    TextSpan(text: ' '),
                    TextSpan(
                      text: flowRequiredText,
                      style: contentTextStyle.copyWith(
                        color: appnewColors.tip1,
                      ),
                    ),
                  ],
                  style: contentTextStyle.copyWith(
                    color: appnewColors.text7,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(Routes.FLOW_DETAIL);
                    },
                ),
              ),
            ),
            SizedBox(height: 12.h),
          },
          WalletInfoText(
            title: 'remaining_number_of_withdrawals_today'.tr,
            info: Text(
              controller.withdrawLimitModel.value?.withdrawLimit.toString() ??
                  '',
              style: contentTextStyle,
            ),
          ),
          SizedBox(height: 12.h),
          WalletInfoText(
            title: 'remaining_withdrawal_limit_for_today'.tr,
            info: Text(
              '${controller.withdrawLimitModel.value?.withdrawRemainText ?? 0}',
              style: contentTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWithdrawFee() {
    final contentTextStyle = TextStyle(
      color: appnewColors.text2,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    final span = TextSpan(
      text: controller.actualWithdrawAmount,
      style: contentTextStyle,
    );

    final tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: null, // 不限制行数
    );

    tp.layout(maxWidth: 200.w);

    final lineCount = tp.computeLineMetrics().length;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WalletInfoText(
            sizedBoxHeight: 4.h,
            isNextLine: lineCount > 1,
            title: 'actual_amt_colon'.tr,
            info: Text(
              controller.actualWithdrawAmount,
              style: contentTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    String currencyType =
        controller.withdrawLimitModel.value?.currencyType.abbr ?? '';
    String flowRequiredText =
        controller.withdrawLimitModel.value?.flowRequiredText ?? '';
    return Padding(
      padding: EdgeInsets.zero,
      child: CommonActionButton(
        content: Text(
          'withdraw_now'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        height: 44.h,
        isActive: controller.isWithdrawEnabled,
        onPressed: () async {
          if (!controller.hasWithdrawPassword) {
            setPaymentPasswordFirst(onSuccess: (isSuccess) {
              if (isSuccess) {
                controller.loadSecurityData();
                if (Get.isDialogOpen ?? false) {
                  Get.back();
                }
              } else {
                AppUtils.showToast('settings_failed'.tr);
              }
            });
            return;
          }

          // 是否首次点击取款
          var firstClickToWithdraw =
              SpStorage.getBool(StorageKey.firstClickToWithdraw);
          if (!firstClickToWithdraw) {
            var isResult = await Get.dialog(
              WithdrawDepositHintDialog(),
              barrierDismissible: false,
            );
            if (isResult) {
              SpStorage.setBool(StorageKey.firstClickToWithdraw, true);
            } else {
              return;
            }
          }

          // 当日取款次数
          var withdrawLimit = int.parse(
              controller.withdrawLimitModel.value?.withdrawLimit ?? '0');
          if (withdrawLimit <= 0) {
            _showTipDialog('当日取款次数不足'.tr);
            return;
          }
          // 当日剩余取款额度
          var withdrawRemain = double.parse(
              controller.withdrawLimitModel.value?.withdrawRemain ?? '0');
          if (withdrawRemain <= 0) {
            _showTipDialog('当日剩余取款额度不足'.tr);
            return;
          }
          var turnover = double.parse(
              controller.withdrawLimitModel.value?.turnover ?? '0');
          if (turnover > 0) {
            _showTipDialog(
                '${'未达到流水要求'.tr}${flowRequiredText.replaceAll(" ", "")}');
            return;
          }

          // 1 必须要显示用银行卡提现一次,0 或者其他就不用了
          var useBank = controller.withdrawLimitModel.value?.useBank ?? 1;
          if (controller.selectedChannel.value?.paymentType != 6 &&
              useBank == 1) {
            Get.dialog(SkBaseDialog(
                title: "首次取款方式限制".tr,
                showDeleteBtn: true,
                showDeleteBtnType: '1',
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(right: 12.w, left: 12.h, top: 15.h),
                      child: Column(
                        children: [
                          Text(
                            '检测到您之前使用过人民币类型的存款方式。',
                            style: TextStyle(
                                color: appnewColors.text22,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),

                          SizedBox(height: 8.h),

                          /// 富文本
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: appnewColors.text22,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(text: '根据平台规定，'),
                                TextSpan(
                                  text: '首次需使用银行卡的取款方式',
                                  style: TextStyle(
                                      color: appnewColors.textBlue,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(text: '。请使用银行卡取款方式进行首次取款'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 15.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFFE6E6EA),
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                '我知道了',
                                style: TextStyle(
                                    color: appnewColors.text22,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: appnewColors.bgBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                Get.back();
                                if (!AppUtils.addBankCardEnable()) {
                                  return;
                                }
                                var result =
                                    await Get.toNamed(Routes.ADD_BANK_CARD);
                              },
                              child: Text(
                                '使用人民币取款',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
            return;
          }

          final dialog = PopUpInputPwdView(
            title: 'pay_pwd'.tr,
            bgColor: Colors.white,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
            content: WalletPasswordTextField(
              hintText: 'input_pay_pwd'.tr,
              controller: controller.withdrawPasswordController,
              focusNode: controller.withdrawPasswordFocusNode,
              isError: false,
              maxLength: 6,
              keyboardType: TextInputType.number,
              fillColor: appnewColors.bg3,
              contentPadding: EdgeInsets.all(10),
              hintStyle: TextStyle(
                color: appnewColors.text8,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            actionButtonBuilder: () => SizedBox(
              height: 48.h,
              child: InkWell(
                onTap: () => {
                  if (controller.isWithPasswordEnabled) controller.withdraw(),
                },
                child: Center(
                  child: Text(
                    'confirm'.tr,
                    style: TextStyle(
                      color: appnewColors.text7,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            cancelActionButton: () => SizedBox(
              height: 48.h,
              child: InkWell(
                onTap: () => Get.back(),
                child: Center(
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          );

          Get.dialog(dialog, barrierDismissible: false).then((_) {
            controller.withdrawPasswordController.clear();
          });
        },
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  void _showTipDialog(String content) {
    Get.dialog(SkBaseDialog(
        title: "tip".tr,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              child: Text(
                content,
                style:
                    TextStyle(fontSize: 14.sp, color: appColors.textMainColor),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: appnewColors.colorLine))),
                  height: 50.h,
                  alignment: Alignment.center,
                  child: Text(
                    "I_got_it".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.text7,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          ],
        )));
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

  @override
  SecurityController get securityController => controller.securityController;

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
}

class _AccountListWidget extends StatefulWidget {
  final List<WalletAccountModel> accountList;
  final int selectedIndex;
  final String? blockName;
  final Function(int index)? onAccountSelected;

  const _AccountListWidget({
    required this.accountList,
    required this.selectedIndex,
    this.blockName,
    this.onAccountSelected,
  });

  @override
  State<_AccountListWidget> createState() => _AccountListWidgetState();
}

class _AccountListWidgetState extends State<_AccountListWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> addressItems = [];
    var selIndex;

    for (int i = 0; i < widget.accountList.length; i++) {
      final account = widget.accountList[i];

      bool isChecked = i == selectedIndex;
      if (isChecked) selIndex = i;

      addressItems.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = i;
            });
            // if (widget.onAccountSelected != null) {
            //   widget.onAccountSelected!(i);
            // }
          },
          child: account.paymentType == 6 || account.paymentType == 7
              ? buildAaccountContent(
                  account.paymentType == 6
                      ? account.addressInfo?.bankName ?? ''
                      : account.addressInfo?.accountName ?? '',
                  "",
                  maskUSDTWalletAddress(account.addressInfo?.accountNo ?? ''),
                  isChecked,
                )
              : buildAaccountContent(
                  account.name.length > 10
                      ? '${account.name.substring(0, 10)}...'
                      : account.name,
                  widget.blockName ?? "",
                  maskUSDTWalletAddress(account.address),
                  isChecked,
                ),
        ),
      );

      // 添加间距，除了最后一个项目
      if (i < widget.accountList.length - 1) {
        addressItems.add(SizedBox(height: 20.h));
      }
    }
    addressItems.add(SizedBox(height: 24.h));

    addressItems.add(
      Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.center,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(44.r)),
                  border: Border.all(
                    color: appnewColors.text7,
                    width: 1.w,
                  ),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  "cancel".tr,
                  style: TextStyle(
                    color: appnewColors.text7,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PingFang SC',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
              child: InkWell(
            onTap: () {
              setState(() {
                selectedIndex = selIndex;
              });
              Get.back();
              if (widget.onAccountSelected != null) {
                widget.onAccountSelected!(selIndex);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 44.h,
              decoration: BoxDecoration(
                color: appnewColors.text7,
                borderRadius: BorderRadius.all(Radius.circular(44.r)),
              ),
              child: Text(
                textAlign: TextAlign.center,
                "confirm".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PingFang SC',
                ),
              ),
            ),
          )),
        ],
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: addressItems,
    );

    return Padding(
      padding: EdgeInsets.all(12.w),
      child: content,
    );
  }

  Widget buildAaccountContent(
    String name,
    String protocal,
    String address,
    bool isChecked,
  ) {
    final content = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text1,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                protocal,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  color: appnewColors.text7,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (protocal.isNotEmpty)
                SizedBox(
                  width: 12.w,
                ),
              Text(
                address,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  color: appnewColors.text1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return buildBottomSheetContentBorderWrapper(
        Row(
          children: [
            GlowingIcon(
              glowColor: appnewColors.bg,
              size: 36.r,
              icon: Image.asset(
                Assets.imagesWallet,
                height: 24.w,
                width: 24.w,
              ),
            ),
            SizedBox(width: 8.w),
            content,
            // const Spacer(),
            isChecked
                ? Image.asset(
                    Assets.headerCheck,
                    width: 20.w,
                    height: 20.h,
                  )
                : Image.asset(
                    Assets.imagesUncheck,
                    width: 20.w,
                    height: 20.h,
                  ),
          ],
        ),
        // isHighLight: isChecked,
        isHighLight: false,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        bgColor: appnewColors.bg4);
  }
}
