import 'package:filbet/common/currency.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/sp_storage/storage_key.dart';
import 'package:filbet/src/deposit/channel_model.dart';
import 'package:filbet/src/deposit/deposit_controller.dart';
import 'package:filbet/src/dialog/first_deposit_hint_dialog.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:filbet/widgets/content_shadow_wrapper.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/widgets/wallet_component_builder.dart';
import 'package:filbet/widgets/wallet_info_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/services/global/global_service.dart';

import 'package:filbet/services/user/user_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DepositView extends GetView<DepositController> {
  const DepositView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: 'deposit'.tr,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.DEPOSIT_TUTORIAL,
                    arguments: {
                      'channelList': controller.channelList.toList(),
                      'selectedChannel': controller.selectedChannel.value,
                    },
                  );
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.zero,
                //
                child: Obx(() {
                  var phone = UserService.to.state.userInfo.phone ?? "";
                  var name = UserService.to.state.userInfo.realName ?? "";
                  var fastDepositAddress =
                      controller.selectedChannel.value?.fastDepositAddress ??
                          "";
                  var paymentType =
                      controller.selectedChannel.value?.paymentType ?? 1;
                  return Column(
                    children: [
                      if (phone.isEmpty || name.isEmpty)
                        _buildAuthenticationInfo(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Column(
                          children: [
                            _walletSection(),
                            SizedBox(height: 16.h),
                            if (controller.channelList.isNotEmpty)
                              _depositTypeSection(context),
                            SizedBox(height: 16.h),
                            if (fastDepositAddress.isNotEmpty &&
                                paymentType == 1)
                              buildFastDepositAddress()
                            else
                              builderInputAmount(context),
                            serverView(),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
          Obx(() {
            if (controller.selectedChannel.value?.wdlUrl?.isNotEmpty == true) {
              return downloadView(context);
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget builderInputAmount(BuildContext context) {
    return Column(
      children: [
        //存款金额
        _withdrawAmountSection(context),
        CommonActionButton(
          content: Text(
            'deposit_now'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          height: 44.h,
          isActive: controller.isDepositEnabled,
          onPressed: () async {
            var phone = UserService.to.state.userInfo.phone ?? "";
            var name = UserService.to.state.userInfo.realName ?? "";
            bool isWhitelist =
                UserService.to.state.userInfo.depositWhitelist == 1;
            if (!isWhitelist &&
                (phone.isEmpty || name.isEmpty) &&
                controller.selectedChannel.value?.paymentType != 1) {
              showUnverifiedDialog();
            } else {
              controller.deposit();
            }
          },
          borderRadius: BorderRadius.circular(12.r),
        ),
      ],
    );
  }

  // 未绑定手机号弹窗
  void showUnverifiedDialog() {
    Get.dialog(
      SkBaseDialog(
        bgColor: Colors.white,
        callback: () {},
        cancelCallback: () {},
        showFooterBtn: false,
        showDeleteBtn: false,
        showDeleteBtnType: '1',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
          child: Column(
            children: [
              Text(
                '温馨提示',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: appnewColors.text1,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                '请先完成账户信息认证，认证通过即可使用更多人民币存款方式',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: appnewColors.text1,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFFAFAFC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          '暂不认证',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: appnewColors.text1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          final result =
                              Get.toNamed(Routes.REAL_NAME_AUTHENTICATION);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: appnewColors.bgBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          '去认证',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthenticationInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 15.w),
      color: appnewColors.bg5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            Assets.mineIconAuthenticationTip,
            width: 12.w,
            height: 12.w,
          ),
          Text(
            "完成账户信息认证，可使用更多支付方式",
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: appnewColors.text27),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.REAL_NAME_AUTHENTICATION);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
              decoration: BoxDecoration(
                  color: appnewColors.bgBlue,
                  borderRadius: BorderRadius.circular(22.r)),
              child: Text(
                "去认证",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletSection() {
    if (GlobalService.to.state.currencyConfig.length > 1) {
      return buildCurrencySelection(
        'arrived_wallet'.tr,
        titleStyle: TextStyle(
          color: appnewColors.text1,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
        Image.asset(
          controller.currency.value.imagePath,
          height: 25.h,
          width: 25.w,
        ),
        '${controller.currency.value.name} (${controller.currency.value.abbr})',
        isShowArrow: controller.canPresentCurrencySelection,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        padding: EdgeInsets.all(10),
        glowColor: appnewColors.bg4,
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
      );
    }
    return SizedBox();
  }

  Widget _depositTypeSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: buildFundingChannelsSelectionGridViewSlide(
          'pay_method'.tr,
          crossAxisCount: 4,
          childAspectRatio: 80 / 60,
          controller.channelList,
          context,
          selected: controller.selectedChannel.value,
          didSelect: (ChannelModel channel) {
        controller.depositAmountController.clear();

        controller.selectedAmount.value = 0;

        controller.entereddepositAmount.value = "";
        controller.selectedChannel.value = channel;
      },
          titlePadding: EdgeInsets.zero,
          titleSpacing: 8.h,
          contentPadding: EdgeInsets.zero,
          isPermanentUrl: true,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
          bgColor: Colors.transparent,
          titleStyle: TextStyle(
            color: appnewColors.text1,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          positionedLeft: 45.r),
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
        margin: EdgeInsets.only(top: 12.r, bottom: 20.r),
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

  Widget _withdrawAmountSection(BuildContext context) {
    return buildMultiContentShadowWrapperWithoutContainerBackgroundWithTitle(
      title: 'deposit_amount'.tr,
      titlePadding: EdgeInsets.zero,
      titleSpacing: 8.h,
      titleStyle: TextStyle(
        color: appnewColors.text22,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      padding: EdgeInsets.only(bottom: 16.h),
      children: [
        // buildDepositAmountSelection(),
        _buildDepositAmountSelectionGrid(context),
        buildDepositAmountInput(),
        // 提示信息
        // buildDepositReminder(),
        if (!controller.isAlipayOrBank()) _buildExchangeRate(),
        Text(
          '存款提示信息'.tr,
          style: TextStyle(
              color: appnewColors.text25,
              fontSize: 10.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildExchangeRate() {
    var rate = controller.realtimeCurrencyRate.replaceAll(" ", "");
    return Text(
      "($rate ${'real_time_exchange_rate'.tr})",
      style: TextStyle(
        color: appnewColors.text2,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDepositAmountSelectionGrid(BuildContext context) {
    final amounts = controller.amountLimit;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.amountLimit.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 三列
            mainAxisSpacing: 10.r, // 行间距
            crossAxisSpacing: 16.r, // 列间距
            childAspectRatio:
                (Get.width - 20.r * 2 - 16.r * 2) / 4 / 40.r, // 宽高比（越大越扁）
          ),
          itemBuilder: (_, index) {
            var amount = amounts[index];
            final isSelected = controller.selectedAmount.value == amount;
            return Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {
                    controller.selectedAmount.value = amount;
                    controller.depositAmountController.text = amount.toString();
                    controller.entereddepositAmount.value =
                        controller.depositAmountController.text;
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          //color: appnewColors.bg4, // ✅ 背景始终是 bg
                          border: Border.all(
                            color: isSelected
                                ? appnewColors.bg
                                : appnewColors.bg4, // ✅ 边框切换
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Text(
                          toThousands(amount.toString()),
                          style: TextStyle(
                            color: isSelected
                                ? appnewColors.bg
                                : appnewColors.text1, // ✅ 文字颜色逻辑保留
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            Assets.mineIconSelectWithdrawMethod,
                            height: 19.w,
                            width: 19.w,
                          ),
                        ),
                    ],
                  ),
                ));
          }),
    );
  }

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
                  controller.depositAmountController.text = amount.toString();
                  controller.entereddepositAmount.value =
                      controller.depositAmountController.text;
                },
                //
                child: Stack(
                  children: [
                    Container(
                      width: 72.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appnewColors.bg4, // ✅ 背景始终是 bg
                        border: Border.all(
                          color: isSelected
                              ? appnewColors.bg
                              : appnewColors.bg4, // ✅ 边框切换
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14.r),
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
                          height: 19.w,
                          width: 19.w,
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

  Widget buildDepositAmountInput() {
    final hintText = controller.selectedChannel.value == null
        ? ''
        : 'input_min_max'.trParams({
            'min': toThousands(controller.selectedChannel.value!.minAmount),
            'max': toThousands(controller.selectedChannel.value!.maxAmount),
          });
    return IgnoreContentContainerBackgroundWidget(
      child: GetBuilder<DepositController>(
        id: 'withdraw_amount_validation',
        builder: (controller) {
          return SizedBox(
            height: 40.h,
            child: WalletAmountInputField(
              onChanged: (value) =>
                  controller.entereddepositAmount.value = value,
              maxLength: controller.maxInputLength,
              controller: controller.depositAmountController,
              focusNode: controller.depositAmountFocusNode,
              isError: !controller.isDepositInputAmountValid,
              contentPadding: EdgeInsets.symmetric(horizontal: 9.w),
              borderRadius: BorderRadius.circular(8.r),
              hintText: hintText,
              textStyle: TextStyle(
                color: controller.isDepositInputAmountValid
                    ? appnewColors.text1
                    : appnewColors.tip1,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: appnewColors.text8,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'PingFang SC',
              ),
              suffixIcon: Obx(
                () => Text(
                  controller.selectedChannel.value?.tokenType ?? '',
                  style: TextStyle(
                    color: controller.isDepositInputAmountValid
                        ? appnewColors.bg
                        : appnewColors.tip1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFeeReminder() {
    final contentTextStyle = TextStyle(
      color: appnewColors.text2,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
    final actual1 = controller.actualDepositAmount;
    final actual2 = controller.actualDepositAmountInCurrency;

    final actual1Str =
        '${toThousands(controller.truncateTo2(actual1).toStringAsFixed(2))} ${controller.selectedChannel.value?.tokenType ?? ''}';
    final actual2Str =
        '${toThousands(controller.truncateTo2(actual2).toStringAsFixed(2))} ${controller.currency.value.abbr}';
    return WalletInfoText(
      title: 'actual_amt_colon'.tr,
      isNextLine: false,
      info: Text(
        controller.isAlipayOrBank() ? actual2Str : '$actual1Str = $actual2Str',
        style: contentTextStyle,
      ),
    );
  }

  Widget buildDepositReminder() {
    final contentTextStyle = TextStyle(
      color: appnewColors.text2,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
    final depositAmountForOneTime =
        '${controller.selectedChannel.value?.range ?? 0} ${controller.selectedChannel.value?.tokenType ?? ''}';

    final reminder = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: appnewColors.bg4,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (!controller.isAlipayOrBank()) {
              return WalletInfoText(
                title: 'blockchain_protocol'.tr,
                info: Text(
                  controller.protocal,
                  style: contentTextStyle.copyWith(
                    color: appnewColors.text2,
                  ),
                ),
              );
            }
            return SizedBox();
          }),
          Obx(() {
            return SizedBox(height: !controller.isAlipayOrBank() ? 12.h : 0);
          }),
          WalletInfoText(
            title: 'single_deposit_amount'.tr,
            info: Text(
              depositAmountForOneTime,
              style:
                  contentTextStyle.copyWith(color: appColors.textRedErrorColor),
            ),
          ),
          Obx(() {
            return SizedBox(height: !controller.isAlipayOrBank() ? 12.h : 0);
          }),
          Obx(() {
            if (!controller.isAlipayOrBank()) {
              return WalletInfoText(
                title: 'real_time_exchange_rate'.tr,
                info: Text(
                  controller.realtimeCurrencyRate,
                  style: contentTextStyle,
                ),
              );
            }
            return SizedBox();
          }),
          Obx(() {
            return SizedBox(
                height: controller.entereddepositAmount.value.isNotEmpty
                    ? 12.h
                    : 0);
          }),
          Obx(() {
            if (controller.entereddepositAmount.value.isNotEmpty) {
              return buildFeeReminder();
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
    return ShadowContainerBuilder.buildContentContainer(
      Padding(
        padding: EdgeInsets.all(0.r),
        child: reminder,
      ),
      8.r,
    );
  }

  Widget buildFastDepositAddress() {
    return Column(
      children: [
        _buildTopTips(),
        SizedBox(height: 17.h),
        _buildStepBar(),
        SizedBox(height: 34.h),
        _buildProtocolSelector(),
        _buildAddressCard(),
        SizedBox(height: 10.h),
        _buildQrCode(),
        SizedBox(height: 3.h),
        _buildMinDeposit(),
        SizedBox(height: 15.h),
        _buildWarning(),
        SizedBox(height: 18.h),
        _buildRateText(),
        SizedBox(height: 6.h),
      ],
    );
  }

  /// 顶部提示
  Widget _buildTopTips() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'USDT价格稳定，流通性高，不受监管',
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: appnewColors.text22),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '了解更多>',
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: appnewColors.textFourth),
          ),
        )
      ],
    );
  }

  /// 步骤栏
  Widget _buildStepBar() {
    final steps = ['选择钱包', '选择协议', '输入充币数量', '完成充币'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 21.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps
                .map(
                  (e) => Text(
                    e,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: appnewColors.text2),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(width: 25.w),
        Image.asset(
          Assets.popupClose,
          fit: BoxFit.fill,
          width: 10.r,
          height: 10.r,
        ),
      ],
    );
  }

  /// 协议选择
  Widget _buildProtocolSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择协议',
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: appnewColors.text22),
        ),
        SizedBox(height: 13.h),
        Row(
          children: [
            _protocolItem('TRC20', 0),
            // const SizedBox(width: 12),
            // _protocolItem('ERC20', 1),
          ],
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _protocolItem(String text, int index) {
    final selected = 0 == index;
    return GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: appnewColors.bg14,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: selected ? appnewColors.textBlue : appnewColors.bg5,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: appnewColors.textBlue),
              ),
            ),
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
        ));
  }

  /// 地址卡片
  Widget _buildAddressCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '充币地址',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: appnewColors.text22),
              ),
              const Spacer(),
              Text(
                '加送0.3%，每日最高优惠388.00元',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: appnewColors.text25),
              ),
              SizedBox(width: 3.w),
              Container(
                  margin: EdgeInsets.only(right: 7.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: appnewColors.bg1,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: appnewColors.text25, width: 1.w),
                  ),
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 12.w,
                    color: appnewColors.text25,
                  ))
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedChannel.value?.fastDepositAddress ?? "",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: appnewColors.text22),
              ),
              GestureDetector(
                onTap: () {
                  AppUtils.copy(
                      controller.selectedChannel.value?.fastDepositAddress ??
                          "");
                },
                child: Text(
                  '复制',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: appnewColors.textBlue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// 二维码
  Widget _buildQrCode() {
    return Column(
      children: [
        Container(
          height: 176.w,
          width: 176.w,
          decoration: BoxDecoration(
            color: appnewColors.bg21.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: QrImageView(
            data: controller.selectedChannel.value?.fastDepositAddress ?? "",
            version: QrVersions.auto,
            size: 176.w,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appnewColors.bgBlue,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 44.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              '保存二维码',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: appnewColors.text4),
            ),
          ),
        ),
      ],
    );
  }

  /// 最低充值
  Widget _buildMinDeposit() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: appnewColors.text44,
            height: 1.6,
          ),
          children: [
            TextSpan(
              text: '至少充入',
            ),
            TextSpan(
              text: ' 2.00 USDT',
              style: TextStyle(
                fontSize: 14.sp,
                color: appnewColors.text25,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: '，否则无法到账',
            ),
          ],
        ),
      ),
    );
  }

  /// 风险提示
  Widget _buildWarning() {
    return Text(
      textAlign: TextAlign.center,
      '温馨提示：该支付方式目前仅支持USDT币种，存款协议仅支持TRC20（网络类型Tron）其他币种均不支持，充值币种或网络类型错误将导致资金无法找回！！！',
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: appnewColors.text25,
      ),
    );
  }

  /// 汇率说明
  Widget _buildRateText() {
    var rate = controller.realtimeCurrencyRate.replaceAll(" ", "");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appnewColors.bg28, width: 1.w),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: appnewColors.text44,
            height: 1.6,
          ),
          children: [
            TextSpan(
              text: "($rate ${'real_time_exchange_rate'.tr})",
              style: TextStyle(
                fontSize: 12.sp,
                color: appnewColors.text25,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: '（实时变化，充值成功后自动到账，建议使用冷钱包进行转账，不要直接使用交易所，冷钱包不需要手续费）',
            ),
          ],
        ),
      ),
    );
  }

  Widget downloadView(BuildContext context) {
    var channel = controller.selectedChannel.value;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A13183B),
            offset: Offset(0, -1),
            blurRadius: 2.r,
          )
        ],
      ),
      child: Container(
        height: 68.r,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Container(
          height: 48.r,
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          decoration: BoxDecoration(
            color: appnewColors.bg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: appnewColors.bg1,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: SKNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: channel?.img ?? "",
                  placeholderType: 2,
                ),
              ),
              SizedBox(
                width: 4.r,
              ),
              Text(
                '${channel?.name ?? ''} 0手续费 秒到账',
                style:
                    TextStyle(color: appnewColors.textWhite, fontSize: 14.sp),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  AppUtils.launchH5(channel?.wdlUrl ?? '');
                },
                child: Container(
                  height: 30.r,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  decoration: BoxDecoration(
                    color: appnewColors.bg1,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '下载${channel?.name ?? ''}',
                    style: TextStyle(
                        color: appnewColors.textSecond, fontSize: 12.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
