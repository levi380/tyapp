import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/platform_wallet_model.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/src/mine/my_assets/my_assets_controller.dart';
import 'package:filbet/src/mine/transfer/widgets/title_and_amount.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/widgets/over_lay_dialog.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyAssetsView extends GetView<MyAssetsController> {
  const MyAssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        bgColor: Colors.transparent,
        title: 'my_assets'.tr,
        actions: [
          GestureDetector(
            onTap: () {
              AppNavigator.toTransactionRecord();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.r),
              child: Text(
                'trade_record'.tr,
                style: TextStyle(
                  color: appnewColors.textMain,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 15.r),
            child: Container(
              decoration: BoxDecoration(
                color: appnewColors.bg,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topView(),
                  centerView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 25.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return titleAndAmount(
                key: controller.globalKey,
                '总资产（元）',
                controller.totalAmount.value.toFixed2(),
                titleIcon: Assets.mineIconQuestion,
                amountIcon: Assets.mineIconRefresh,
                isRotating: controller.isRefreshing.value, onIconTap: () {
              controller.queryWalletList();
            }, onTitleIconTap: () {
              final RenderBox? renderBox = controller.globalKey.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox != null && renderBox.hasSize) {
                final Offset position = renderBox.localToGlobal(Offset.zero);
                Get.dialog(
                  OverLayWidget(
                    position.dy -
                        MediaQuery.of(Get.context!).padding.top +
                        16.r,
                    position.dx - 32.r,
                    '总资产= 中心钱包+锁定金额+场馆钱包总和（不统计未结算注单)',
                    Assets.mineBgOverlay2,
                  ),
                  barrierColor: Colors.transparent,
                );
              } else {
                Get.dialog(
                  OverLayWidget(
                    90.r,
                    78.r,
                    '总资产= 中心钱包+锁定金额+场馆钱包总和（不统计未结算注单)',
                    Assets.mineBgOverlay1,
                  ),
                  barrierColor: Colors.transparent,
                );
              }
            });
          }),
          recycleView(),
        ],
      ),
    );
  }

  Widget centerView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 14.r),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          walletView(),
          depositView(),
          platformView(),
        ],
      ),
    );
  }

  Widget walletView() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '${'center_wallet'.tr}${'center_wallet_unit'.tr}',
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 64.r,
          margin: EdgeInsets.only(top: 17.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: appnewColors.colorLine4),
          ),
          child: Row(
            children: [
              Obx(() {
                return walletItemView('center_wallet'.tr,
                    '¥${controller.centerAmount.value.toFixed2()}');
              }),
              Obx(() {
                return walletItemView('lock_amount'.tr,
                    '¥${controller.lockAmount.value.toFixed2()}');
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget depositView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.r),
      child: Wrap(
        children: controller.items.map((item) {
          return InkWell(
            onTap: () {
              controller.clickItem(item);
            },
            child: SizedBox(
              width: (Get.width - 32.r * 2) / 4,
              child: Column(
                children: [
                  Image.asset(
                    item.icon ?? '',
                    width: 28.r,
                    height: 28.r,
                  ),
                  Text(
                    item.name ?? '',
                    style: TextStyle(
                      color: appnewColors.textMain,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget platformView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: appnewColors.colorLine4),
      ),
      child: Column(
        children: [
          platformTitleView(),
          Obx(() {
            if (!controller.isExpanded.value) {
              return SizedBox.shrink();
            }
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 9.r),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 4.r,
                crossAxisSpacing: 4.r,
                childAspectRatio: (Get.width - 32.r * 2 - 4.r * 5) / (4 * 50.r),
              ),
              itemBuilder: (context, index) {
                var model = controller.walletList[index];
                return platformItemView(model);
              },
              itemCount: controller.walletList.length,
            );
          }),
        ],
      ),
    );
  }

  Widget platformTitleView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.r, horizontal: 9.r),
      child: Row(
        children: [
          Text(
            'platform_balance'.tr,
            style: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () {
              controller.oneKeyRecycle();
            },
            child: Container(
              height: 22.r,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 7.r),
              margin: EdgeInsets.only(left: 10.r),
              decoration: BoxDecoration(
                border: Border.all(color: appnewColors.bg),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'one_recycle'.tr,
                style: TextStyle(
                  color: appnewColors.bg,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              controller.toggleExpand();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  return Text(
                    controller.isExpanded.value
                        ? 'close_detail'.tr
                        : 'expand_detail'.tr,
                    style: TextStyle(
                      color: appnewColors.textSecond,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
                SizedBox(width: 4.r),
                Obx(() {
                  return Transform.rotate(
                    angle:
                        controller.isExpanded.value ? 3.14159 : 0, // 展开时旋转180度
                    child: Image.asset(
                      Assets.mineArrowDown,
                      width: 10.r,
                      height: 9.r,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget platformItemView(PlatformWalletModel model) {
    return Container(
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

  Widget recycleView() {
    return Container(
      height: 30.r,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.r),
    );
  }

  Widget walletItemView(String title, String amount) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.mineIconDeposit,
                width: 20.r,
                height: 20.r,
                color: appnewColors.textMain,
              ),
              SizedBox(width: 4.r),
              Text(
                title,
                style: TextStyle(
                  color: appnewColors.textSecond,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.r),
          Text(
            amount,
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
