import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filbet/api/api.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../controllers/bet_first_deposit_controller.dart';

//投注/首存豪礼
class BettingFirstDepositView extends GetView<BettingFirstDepositController> {
  const BettingFirstDepositView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: appnewColors.bg15,
        appBar: CustomAppbar.normalTitle(
          bgColor: Colors.white,
          title: controller.detailBean.value?.promo?.name ?? "",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildTab(),
              _buildList(),
              _buildWebView(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    if (controller.topIamges.value.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Image.network(
          staticImageResolver(controller.topIamges.value ?? ""),
          fit: BoxFit.fitWidth,
        ),
      );
    } else {
      return Text("");
    }
  }

  Widget _buildTab() {
    return Padding(
      padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              _tabItem(
                text: '流水豪礼',
                selected: controller.selIndex.value == 0,
                selIndex: 0,
              ),
              SizedBox(width: 11.w),
              _tabItem(
                text: '首存豪礼',
                selected: controller.selIndex.value == 1,
                selIndex: 1,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildsGiftInfo(),
        ],
      ),
    );
  }

  Widget _buildsGiftInfo() {
    if (controller.selIndex.value == 0 && controller.bettingGift.value != null) {
      return _buildResult();
    } else if (controller.selIndex.value == 1 && controller.firstDepositGift.value != null) {
      return _buildResult();
    } else {
      return _buildInfo();
    }
  }

  Widget _buildResult() {
    String prizeName = "";
    String claimedAt = "";
    if (controller.selIndex.value == 0) {
      claimedAt = formatTimestampToTime02(controller.bettingGift.value?.claimedAt ?? 0);
      prizeName = "已兑换有效流水豪礼:${controller.bettingGift.value?.prizeName ?? ""}";
    } else {
      claimedAt = formatTimestampToTime02(controller.firstDepositGift.value?.claimedAt ?? 0);
      prizeName = "已兑换有效首存豪礼:${controller.firstDepositGift.value?.prizeName ?? ""}";
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: appnewColors.bg19.withAlpha(8),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 23.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: appnewColors.bg8,
              ),
            ),
            child: Text(
              '有效投注额',
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 15.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Text(
              prizeName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF383B42),
              ),
            ),
          ),

          /// 时间
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Text(
              '申请兑换时间：$claimedAt',
              style: TextStyle(color: Color(0xFF88898E), fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 6.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.WELFARE_CENTER, arguments: {'tabIndex': 1});
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 23.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: appnewColors.bg8,
                  ),
                ),
                child: Text(
                  '查看奖品状态',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),

          /// 红色提示
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Text(
              '您已完成申请，彩金审核中，审核通过后需在兑奖记录进行领取操作，请关注兑奖记录中的审核状态。',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: appnewColors.textRed,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 29.h),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: appnewColors.bg19.withAlpha(8),
              blurRadius: 4.r,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Image.asset(Assets.activityIconActivityRules),
            Html(
              shrinkWrap: true,
              data: controller.h5Summary.value ?? '',
              onLinkTap: (
                String? url,
                Map<String, String> attributes,
                element,
              ) {},
            )
          ],
        ));
  }

  Widget _buildList() {
    return Obx(() {
      List list = [];
      if (controller.selIndex.value == 0) {
        //当前选中流水豪礼
        list = controller.betConfigGiftList;
      } else {
        //当前选中首存豪礼
        list = controller.firstConfigGiftList;
      }
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: appnewColors.bg19.withAlpha(8),
              blurRadius: 4.r,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 163 / 264, // 关键：控制卡片高度
          ),
          itemBuilder: (context, index) {
            return _rewardItem(list, index);
          },
        ),
      );
    });
  }

  Widget _rewardItem(list, index) {
    var itemModel = list[index];
    String img = "";
    String name = "";
    String name2 = "";
    String money = "";
    String type = "";
    String bonusAmount = itemModel["prize_content"]['bonus_amount'];
    String waterMultiple = "0";
    bool isNext = false;
    if (controller.selIndex.value == 0) {
      // 是否可以兑换
      isNext = double.parse(controller.betting.value ?? "0").toInt() > double.parse(bonusAmount).toInt();
    } else {
      // 是否可以兑换
      isNext = double.parse(controller.firstDeposit.value ?? "0").toInt() > double.parse(bonusAmount).toInt();
    }
    if (controller.selIndex.value == 0) {
      //当前选中流水豪礼
      type = "流水豪礼";
      name2 = "需有效投注金额";
      money = "${itemModel["valid_bet_amount"]}";
    } else {
      name2 = "需首存金额";
      //当前选中首存豪礼
      type = "首存豪礼";
      money = "${itemModel["deposit_amount"]}";
    }
    img = itemModel["prize_image"];
    name = itemModel["prize_name"];
    waterMultiple = itemModel["prize_content"]['water_multiple'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 奖励图
          Stack(
            children: [
              Container(
                height: 134.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appnewColors.bgBlue,
                    width: 2.w,
                  ),
                ),
                child: SKNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img ?? "",
                  borderRadius: 5.r,
                  placeholderType: 2,
                  height: 134.w,
                ),
              ),

              /// 顶部凹槽装饰（可选）
              // Positioned(
              //   top: 0,
              //   left: 31.w,
              //   right: 31.w,
              //   child: Container(
              //     height: 22.h,
              //     decoration: BoxDecoration(
              //       color: Color(0xFF7FB2FF),
              //       borderRadius: BorderRadius.vertical(
              //         bottom: Radius.circular(6.r),
              //       ),
              //     ),
              //   ),
              // ),

              /// 中部标签
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: appnewColors.bg8,
                      ),
                      border: Border.all(
                        color: appnewColors.bg20,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 23.h),

          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text1,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            name2,
            style: TextStyle(
              fontSize: 12.sp,
              color: appnewColors.text36,
            ),
          ),

          Text(
            '¥ ${money}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: appnewColors.textBlue,
            ),
          ),

          const Spacer(),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 13.w),
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isNext ? appnewColors.bg8 : appnewColors.bg7,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () async {
                  if (UserService.to.state.isVisitor) {
                    //跳转到登录页面
                  } else if (!isNext) {
                  } else {
                    var show = itemModel["success_tip"]['show'];
                    var title = itemModel["success_tip"]['title'];
                    var content = itemModel["success_tip"]['content'];

                    var result = false;
                    if (show == 1) {
                      //是否展示弹窗 1=展示 2=不展示
                      result = await Get.dialog(SkBaseDialog(
                        bgColor: Colors.white,
                        callback: () {
                          Get.back();
                        },
                        cancelCallback: () {},
                        showFooterBtn: false,
                        showDeleteBtn: false,
                        title: title,
                        showDeleteBtnType: '2',
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                              child: Text(
                                content,
                                style:
                                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: appnewColors.text1),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back(result: true);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  gradient: LinearGradient(
                                    colors: appnewColors.bg8,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "确认",
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back(result: false);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 30.h),
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(color: Color(0xffD8DCE7), width: 1.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "取消",
                                    style: TextStyle(
                                        fontSize: 12.sp, fontWeight: FontWeight.w500, color: appnewColors.text1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    } else {
                      result = true;
                    }

                    // 申请确认弹窗
                    if (result) {
                      var result2 = await Get.bottomSheet(Container(
                        height: 337.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12.r))),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '申请确认',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.sp, fontWeight: FontWeight.w300, color: appnewColors.text1),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(Icons.close, size: 20),
                                  )
                                ],
                              ),
                            ),

                            // SizedBox(height: 20.h),

                            _infoRow('发放钱包：', '场馆钱包'),
                            Divider(height: 24.h),

                            _infoRow('礼金金额：', "$bonusAmount 元"),
                            Divider(height: 24.h),

                            _infoRow('流水要求：', "${double.parse(waterMultiple) * double.parse(bonusAmount)} 元"),
                            Divider(height: 24.h),

                            Text(
                              '温馨提示:活动期间仅可兑换一次投注豪礼,确认后不可修改。'
                              '请注意申请后需要等待平台审核通过,在兑换记录内手动领取该礼金。',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: appnewColors.tip1,
                                // height: 1.5,
                              ),
                            ),

                            SizedBox(height: 15.h),

                            /// 底部按钮
                            SizedBox(
                              height: 40.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.back(result: true);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: appnewColors.bgBlue,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Text(
                                        '取消',
                                        style: TextStyle(
                                          color: appnewColors.textBlue,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        var isSuccess = controller.promoClaim(index);
                                        Get.back(result: isSuccess);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: appnewColors.bgBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        padding: EdgeInsets.zero,
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        '确定',
                                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));

                      if (result2) {
                        await Get.bottomSheet(Container(
                          height: 223.h,
                          padding: EdgeInsets.symmetric(horizontal: 17.w),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12.r))),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '申请成功',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.sp, fontWeight: FontWeight.w500, color: appnewColors.text1),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.close, size: 20),
                                    )
                                  ],
                                ),
                              ),

                              // SizedBox(height: 30.h),
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: appnewColors.text37,
                                      height: 1.6,
                                    ),
                                    children: [
                                      TextSpan(text: '您已完成申请,彩金审核中,审核通过后需在兑奖记录进行领取操作,请关注'),
                                      TextSpan(
                                        text: '兑奖记录',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: appnewColors.textBlue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '中的审核状态',
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 33.h),

                              /// 确定按钮（渐变）
                              SizedBox(
                                width: double.infinity,
                                height: 40.h,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: appnewColors.btnbg1,
                                      ),
                                    ),
                                    child: Text(
                                      '确定',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ));
                      }
                    }
                  }
                },
                child: Center(
                  child: Text(
                    '立即兑换',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: appnewColors.textSecond, fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(color: appnewColors.textBlue, fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    var amount = "";
    var image = "";
    if (controller.selIndex.value == 0) {
      //当前选中流水豪礼
      var list = controller.betConfigGiftList;
      amount = list.isNotEmpty ? list.last["valid_bet_amount"] : "";
      image = list.isNotEmpty ? list.last["prize_image"] : "";
    } else {
      var list = controller.firstConfigGiftList;
      amount = list.isNotEmpty ? list.last["deposit_amount"] : "";
      image = list.isNotEmpty ? list.last["prize_image"] : "";
    }

    return Obx(() {
      String typeName = "";
      double progress = 0.0;
      String currentMoney = "0.0";
      String bonusAmount = "0.0";
      if (controller.selIndex.value == 0) {
        var list = controller.betConfigGiftList;
        bonusAmount = list.isNotEmpty ? list.last["prize_content"]['bonus_amount'] : "";
        //当前选中流水豪礼
        typeName = "有效投注金额";
        currentMoney = UserService.to.state.isVisitor ? "还未登录" : controller.betting.value ?? "0.00";
      } else {
        var list = controller.firstConfigGiftList;
        bonusAmount = list.isNotEmpty ? list.last["prize_content"]['bonus_amount'] : "";
        //当前选中首存豪礼
        typeName = "首存金额";
        currentMoney = UserService.to.state.isVisitor ? "还未登录" : controller.firstDeposit.value ?? "0.00";
      }
      if (bonusAmount.isEmpty || double.parse(bonusAmount) <= 0) {
        progress = 0.0;
      } else {
        progress = (double.parse(currentMoney ?? "0") / double.parse(bonusAmount ?? "0")).clamp(0.0, 1.0);
      }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: appnewColors.bg19.withAlpha(8),
              blurRadius: 4.r,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 23.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: appnewColors.bg8,
                        ),
                      ),
                      child: Text(
                        typeName,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Row(
                        children: [
                          Text(
                            currentMoney,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: appnewColors.text32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!UserService.to.state.isVisitor)
                            Text(
                              'yuan'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: appnewColors.text32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      width: 54.w,
                      height: 54.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: const Color(0xFF6EA8FF),
                          width: 2.w,
                        ),
                      ),
                      child: SKNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image ?? "",
                        borderRadius: 5.r,
                        placeholderType: 2,
                        height: 134.w,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),

            SizedBox(width: 4.h),

            /// 进度条
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4.w,
                  backgroundColor: const Color(0xFFEDEFF3),
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xFF6EA8FF),
                  ),
                ),
              ),
            ),

            SizedBox(width: 4.h),

            //todo 填充数据
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '终极豪礼\n¥ $amount',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: appnewColors.text1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _tabItem({
    required String text,
    required bool selected,
    required int selIndex,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.selIndex.value = selIndex;
        },
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: selected ? appnewColors.bgBlue : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
