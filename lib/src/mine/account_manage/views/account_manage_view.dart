import 'package:filbet/generated/assets.dart';
import 'package:filbet/mixin/security_verification_mixin.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/first_deposit_hint_dialog.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/dialog/withdraw_deposit_hint_dialog.dart';
import 'package:filbet/src/mine/verity_identity/validation_type.dart';
import 'package:filbet/src/security/security_component.dart';
import 'package:filbet/src/security/security_controller.dart';
import 'package:filbet/src/security/widgets/bottom_safe_verify.dart';
import 'package:filbet/src/withdraw/wallet_account_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/dialog/safe_verify_dialog.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/pop_up_view.dart';
import 'package:filbet/widgets/sk_bottom_sheet.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/account_manage_controller.dart';

class AccountManageView extends GetView<AccountManageController> {
  const AccountManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.white,
        title: '账户管理'.tr,
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop, _) {},
        child: _buildPageWithTabBar(),
      ),
    );
  }

  Widget _buildPageWithTabBar() {
    return Obx(() {
      return Column(
        children: [
          _buildTypeTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildPageWidget(
                    type: AccountManageChangeType.usdtAccount, tabIndex: 0),
                _buildPageWidget(
                    type: AccountManageChangeType.bankAccount, tabIndex: 1),
                _buildPageWidget(
                    type: AccountManageChangeType.otherAccount, tabIndex: 2),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTypeTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        border: Border(
          bottom: BorderSide(
            color: appnewColors.colorLine, // 颜色
            width: 1.0, // 粗细
          ),
        ),
      ),
      height: 44.h,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        tabs: List.generate(controller.tabTypeList.length, (index) {
          Map<String, dynamic> itemMap = controller.tabTypeList[index];
          String title = itemMap['title'];
          return Tab(
            child: SizedBox(
                height: 20.h,
                child: Text(
                  title,
                )),
          );
        }),
        unselectedLabelStyle: TextStyle(
            color: appnewColors.text2,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            color: appnewColors.textBlue,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.zero,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(2.r),
          borderSide: BorderSide(width: 2, color: appnewColors.bg),
          insets: EdgeInsets.symmetric(horizontal: 5.w), // 控制宽度
        ),
      ),
    );
  }

  Widget _buildPageWidget({
    required AccountManageChangeType type,
    required int tabIndex,
  }) {
    return Column(
      children: [
        if (controller.mFilterList.isEmpty)
          Expanded(
            child: Container(
              width: double.infinity,
              color: appnewColors.bg4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      tabIndex == 0 || tabIndex == 2
                          ? Assets.mineIconEmptyUsdt
                          : Assets.mineIconEmptyBank,
                      width: 189.w,
                      height: 189.w),
                  SizedBox(width: 200.w, child: _buildAddAccount(tabIndex)),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == controller.mFilterList.length - 1) {
                  return Column(
                    children: [
                      itemWalletCard(controller.mFilterList[index], tabIndex),
                      _buildAddAccount(tabIndex),
                      SizedBox(height: 20.h),
                    ],
                  );
                } else {
                  return itemWalletCard(
                      controller.mFilterList[index], tabIndex);
                }
              },
              itemCount: controller.mFilterList.length,
            ),
          )
      ],
    );
  }

  Widget _buildAddAccount(int tabIndex) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                right: 15.w, left: 15.w, top: 15.h, bottom: 10.h),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: appnewColors.bg, // 按钮蓝色
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: InkWell(
              child: Center(
                child: Text(
                  tabIndex == 0
                      ? "添加虚拟币地址".tr
                      : tabIndex == 1
                          ? "add_bank_card".tr
                          : "添加账户".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () async {
                //20260120 添加账户时不需要强制设置支付密码（产品要求）
                // var hasPayPwd = controller.securityData.value?.hasPayPwd ?? false;
                // if (!hasPayPwd) {
                //   _buildPaymentPassword();
                //   return;
                // }

                if (tabIndex == 0) {
                  var result = await Get.toNamed(Routes.ADD_USDT);
                  if (result) {
                    controller.loadWalletAccountList();
                  }
                } else if (tabIndex == 1) {
                  if (!AppUtils.addBankCardEnable()) {
                    return;
                  }
                  var result = await Get.toNamed(Routes.ADD_BANK_CARD);
                  if (result is bool && result) {
                    controller.loadWalletAccountList();
                  }
                } else {
                  var result = await Get.toNamed(Routes.ADD_ACCOUNT);
                  if (result) {
                    controller.loadWalletAccountList();
                  }
                }
              },
            )),
        Text(
          tabIndex == 0
              ? "每种虚拟币地址最多绑定5条".tr
              : tabIndex == 1
                  ? "最多支持添加10张银行卡".tr
                  : "每种账户最多绑定5条".tr,
          style: TextStyle(
              color: appnewColors.textFifth,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget itemWalletCard(WalletAccountModel item, int tabIndex) {
    String tempName = "";
    if (item.paymentType == 1) {
      tempName = item.name ?? "";
    } else if (item.paymentType == 6) {
      tempName = item.addressInfo?.bankName ?? "";
    } else {
      tempName = item.name ?? "";
    }
    var addressInfo = item.addressInfo;
    var address = item.address;
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3EC0B8),
            Color(0xFF46C6C5),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 24.w,
                    width: 24.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: item.paymentType == 1
                        ? Image.asset(
                            Assets.currencyUsdt,
                            height: 14.w,
                            width: 14.w,
                          )
                        : item.paymentType == 7
                            ? SvgPicture.asset(
                                Assets.mineChannelCny7,
                                height: 14.w,
                                width: 14.w,
                              )
                            : item.paymentType == 8
                                ? Image.asset(
                                    Assets.mineWechatPay,
                                    height: 14.w,
                                    width: 14.w,
                                  )
                                : SKNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: addressInfo?.img ?? "",
                                    placeholderType: 2,
                                    borderRadius: 18.r,
                                    height: 24.w,
                                    width: 24.w,
                                  ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tempName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item.tokenType,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                  child: Image.asset(Assets.mineIconWhiteDelete,
                      width: 16.w, height: 16.h),
                  onTap: () async {
                    String phone = UserService.to.state.userInfo.phone ?? '';
                    String needEmail =
                        UserService.to.state.userInfo.email ?? "";
                    if (phone.isNotEmpty || needEmail.isNotEmpty) {
                      String? needEmail = UserService.to.state.userInfo.email;
                      String? needPhone = UserService.to.state.userInfo.phone;
                      var isResult =
                          await Get.toNamed(Routes.VERIFY, arguments: {
                        'needEmail': needEmail,
                        'needPhone': needPhone,
                        'verityType': ValidationType.deleteData,
                        'deleteId': item.id,
                      });
                      if (isResult is bool && isResult) {
                        controller.deleteUSDTWalletAddress();
                      }
                    }
                  })
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.isObscured
                      ? item.decAddress
                      : tabIndex == 1
                          ? StringUtils.maskCard(item.address ?? "")
                          : StringUtils.frontFourBackFourCard(item.address),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                child: Image.asset(
                  item.isObscured
                      ? Assets.loginShowPwd
                      : Assets.mineHideAccountAddress,
                  width: 16.w,
                  height: 16.w,
                  color: Colors.white,
                ),
                onTap: () async {
                  if (!item.isObscured) {
                    if (item.decAddress.isNotEmpty) {
                      controller.setObscured(item, item.decAddress);
                    } else {
                      String phone = UserService.to.state.userInfo.phone ?? '';
                      String needEmail =
                          UserService.to.state.userInfo.email ?? "";
                      if (phone.isNotEmpty || needEmail.isNotEmpty) {
                        var isResult = await Get.toNamed(Routes.VERITY_IDENTITY,
                            arguments: {
                              'needEmail': needEmail,
                              'needPhone': phone,
                              'accountId': item.id ?? "",
                              'verityType': ValidationType.checkAccount,
                            });
                        if (isResult != null && isResult.isNotEmpty) {
                          controller.setObscured(item, isResult);
                        }
                      }
                    }
                  } else {
                    controller.setObscured(item, item.decAddress);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 输入 纯数字 或 已带空格格式均可
  static String bankCard(String card) {
    String number = card.replaceAll(" ", "");
    if (number.length <= 8) return card;
    String first = number.substring(0, 4);
    String last = number.substring(number.length - 4);
    return "$first **** $last";
  }

  void _buildPaymentPassword() async {
    final popUp = Obx(() {
      return PopUpView.withCancelActionButton(
        title: 'set_pay_pwd'.tr,
        content: buildSetPaymentPassword(),
        showClose: false,
        canConfirmAction: controller.canSetPaymentPassword,
        onCofirm: () async {
          String newPwd = controller.newPaymentPasswordController.text;
          final isSuccess = await controller.setPaymentPassword(
            newPwd,
          );
          if (isSuccess) {
            while (Get.isBottomSheetOpen ?? false) {
              Get.back();
            }
          } else {
            if (Get.isBottomSheetOpen ?? false) Get.back();
          }
        },
        onCancel: controller.earseTextControllers,
      );
    });

    await Get.bottomSheet(
      popUp,
      isScrollControlled: true,
    );
  }

  Widget buildSetPaymentPassword() {
    return Column(
      children: [
        buildSecurityPasswordTextFieldContentWithTitle(
          'pay_pwd'.tr,
          hintText: 'input_pay_pwd'.tr,
          controller: controller.newPaymentPasswordController,
          onChanged: (val) => controller.newPaymentPassword.value = val,
          maxLength: 6,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20.h),
        buildSecurityPasswordTextFieldContentWithTitle(
          'confirm_pwd'.tr,
          hintText: 'reenter_pay_pwd'.tr,
          controller: controller.confirmPaymentPasswordController,
          onChanged: (val) => controller.confirmPaymentPassword.value = val,
          maxLength: 6,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
