import 'package:card_swiper/card_swiper.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/vip/models/menber_vip_gift_config.dart';
import 'package:filbet/src/mine/vip/privilege/controllers/vip_privilege_logic.dart';
import 'package:filbet/src/mine/vip/privilege/views/vip_progess_bar.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart' show toStringAsFixed2, toThousands;
import 'package:filbet/utils/string_utils.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';

class VipRPrivilegeView extends GetView<VipRPrivilegeController> {
  const VipRPrivilegeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      needAppbar: false,
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: appnewColors.bg7),
        ),
        child: SafeArea(
          child: Column(
            children: [
              titleView(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => controller.settingList.isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  SizedBox(height: 40.r),
                                  _buildProgressbarWidget(),
                                  _buildCurrentPrivilegeWidget(),
                                  buildBanner(),
                                  _buildPrivilegeContent(),
                                  upgradePromotionView(),
                                  lookVipDetailView(),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleView(BuildContext context) {
    return SizedBox(
      height: 44.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 44.r,
              height: 44.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Image.asset(
                Assets.homeHomeBack,
                width: 16.r,
                height: 16.r,
              ),
            ),
          ),
          Text(
            "vip_privilege".tr,
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 44.r),
        ],
      ),
    );
  }

  Widget _buildProgressbarWidget() {
    return Stack(
      children: [
        Center(
          child: VipSemicircleProgressBar(
            total: controller.settingList.length,
            current: UserService.to.state.vipInfo.value?.currentLevel ?? 0,
            backgroundColor: appColors.white,
            size: 200.0.w,
            // 增大尺寸以容纳VIP文案
            progressColor: appnewColors.bg61A2FF,
            tickColor: Color(0xFF8A8EFE),
            showVipText: true,
            tickWidth: 2,
            vipTextStyle: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
            ),
          ),
        ),
        Positioned(
          bottom: 60.h,
          left: (Get.width - 50.w) / 2,
          child: Container(
            width: 50.w,
            height: 50.w,
            child: Obx(() {
              return Image.asset(
                UserService.to.state.avatarImgUrl,
                width: 50.w, // 减去边框宽度，确保图片完全在边框内
                height: 50.w,
                fit: BoxFit.fill,
              );
            }),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 26.h,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  UserService.to.state.nicknamelabel,
                  style: TextStyle(
                      color: appColors.textMainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 4.w),
                Image.asset(
                  Assets.mineIcVipCrown,
                  fit: BoxFit.fill,
                  width: 18.w,
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 32.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.mineIcLevelRectangle),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Text(
                      "V${UserService.to.state.vipInfo.value?.currentLevel ?? 0}",
                      style: TextStyle(
                          color: appColors.textWhiteColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentPrivilegeWidget() {
    String? timeCount = UserService.to.state.vipInfo.value?.keepDate;
    if (timeCount == null ||
        timeCount.isEmpty ||
        double.parse(timeCount) == 0) {
      timeCount = "---";
    } else {
      timeCount = DateTime.fromMillisecondsSinceEpoch(int.parse(timeCount))
          .toString()
          .split(".")
          .first;
    }

    String allTips = "keep_level_tip".tr.replaceAll("{m}", timeCount);
    List<String> tipsList = allTips.split(timeCount);
    double needDeposite = double.parse(
            UserService.to.state.vipInfo.value?.targetDeposit ?? "0") -
        double.parse(UserService.to.state.vipInfo.value?.currentDeposit ?? "0");
    if (needDeposite < 0) {
      needDeposite = 0;
    }
    double needTurnOver = double.parse(
            UserService.to.state.vipInfo.value?.targetTurnover ?? "0") -
        double.parse(
            UserService.to.state.vipInfo.value?.exchangeVipCurrentTurnover ??
                "0");
    if (needTurnOver < 0) {
      needTurnOver = 0;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20.h, left: (Get.width - 200.w) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                            color: appColors.textMainColor,
                            borderRadius: BorderRadius.circular(3.w)),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "${"current_deposit".tr}(${controller.coinSymbol}):",
                        style: TextStyle(
                            color: appColors.inputTextStyleColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: Get.width - 180.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    toStringAsFixed2(UserService.to.state
                                        .vipInfo.value?.currentDeposit),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: appnewColors.text1,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "(${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentDeposit)}/${controller.isMaxLevel ? "-" : toStringAsFixed2(UserService.to.state.vipInfo.value?.targetDeposit)})",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: appnewColors.text1,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              // Text(
                              //   "${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentDeposit)}" +
                              //       "(${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentDeposit)}/${controller.isMaxLevel ? "-" : toStringAsFixed2(UserService.to.state.vipInfo.value?.targetDeposit)})",
                              //   style: TextStyle(
                              //       color: appColors.textMainColor,
                              //       fontSize: 12.sp,
                              //       fontWeight: FontWeight.w400),
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  if (!controller.isMaxLevel)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                                color: appColors.textMainColor,
                                borderRadius: BorderRadius.circular(3.w)),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "vip_need_deposite_to".tr,
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          toStringAsFixed2(needDeposite.toString()),
                          style: TextStyle(
                              color: appnewColors.text1,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "vip_need_deposite_to_1".tr,
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "VIP${UserService.to.state.vipInfo.value?.targetLevel ?? 0}",
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                            color: appColors.textMainColor,
                            borderRadius: BorderRadius.circular(3.w)),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "${"current_turnover".tr}(${controller.coinSymbol}):",
                        style: TextStyle(
                            color: appColors.inputTextStyleColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                          constraints:
                              BoxConstraints(maxWidth: Get.width - 180.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      toStringAsFixed2(UserService
                                          .to
                                          .state
                                          .vipInfo
                                          .value
                                          ?.exchangeVipCurrentTurnover),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: appnewColors.text1,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "(${toStringAsFixed2(UserService.to.state.vipInfo.value?.exchangeVipCurrentTurnover)}/${controller.isMaxLevel ? "-" : (toStringAsFixed2(UserService.to.state.vipInfo.value?.targetTurnover))})",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: appnewColors.text1,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                // Text(
                                //   "${toStringAsFixed2(UserService.to.state.vipInfo.value?.exchangeVipCurrentTurnover)}" +
                                //       "(${toStringAsFixed2(UserService.to.state.vipInfo.value?.exchangeVipCurrentTurnover)}/${controller.isMaxLevel ? "-" : (UserService.to.state.vipInfo.value?.targetTurnover)})",
                                //   style: TextStyle(
                                //       color: appColors.textMainColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                              )
                            ],
                          ))
                    ],
                  ),
                  if (!controller.isMaxLevel)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                                color: appColors.textMainColor,
                                borderRadius: BorderRadius.circular(3.w)),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "vip_need_turnor_to".tr,
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          toStringAsFixed2(needTurnOver.toString()),
                          style: TextStyle(
                              color: appnewColors.text1,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "vip_need_turnor_to_1".tr,
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "VIP${UserService.to.state.vipInfo.value?.targetLevel ?? 0}",
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  if (UserService.to.state.vipInfo.value?.currentLevel != 0)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                              color: appColors.textMainColor,
                              borderRadius: BorderRadius.circular(3.w)),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "${"keep_turnover".tr}(${controller.coinSymbol}):",
                          style: TextStyle(
                              color: appColors.inputTextStyleColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentTurnover)}",
                          style: TextStyle(
                              color: appColors.textMainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "(${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentTurnover)}/${toStringAsFixed2(UserService.to.state.vipInfo.value?.currentKeepTurnover)})",
                          style: TextStyle(
                              color: appColors.textMainColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.dialog(SkBaseDialog(
                                  title: "tip".tr,
                                  showDeleteBtn: false,
                                  showDeleteBtnType: '1',
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20.r),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: appColors.textMainColor,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: tipsList.first,
                                              ),
                                              TextSpan(
                                                text: timeCount,
                                                style: TextStyle(
                                                  color:
                                                      appColors.textMain2Color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: tipsList.last,
                                              ),
                                            ],
                                          ),
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
                                                        width: 1,
                                                        color: appnewColors
                                                            .colorLine))),
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
                            },
                            child: Image.asset(
                              Assets.mineIcQuestion,
                              width: 12.w,
                            ))
                      ],
                    )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildBanner() {
    return SizedBox(
      height: 135.h * 1,
      child: Swiper(
        itemCount: controller.settingList.length,
        autoplay: false,
        loop: false,
        index: controller.cardIndex.value,
        viewportFraction: 0.9,
        // 显示左右部分
        onIndexChanged: (index) {
          controller.cardIndex.value = index;
          controller.resetPrivilegeList();
        },
        itemBuilder: (BuildContext context, int index) {
          MemberVipGifytConfigModel model = controller.settingList[index];
          return Stack(
            children: [
              Container(
                width: Get.width,
                margin: EdgeInsets.only(
                    left: controller.cardIndex.value == 0 ? 10.w : 6.w,
                    right: 10.w),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.w),
                        topRight: Radius.circular(12.w),
                        bottomLeft: Radius.circular(0.w),
                        bottomRight: Radius.circular(0.w)),
                    child: Image.asset(
                      controller.cardIndex.value == index
                          ? Assets.mineVipPriLevelActiveBg
                          : Assets.mineVipPriLevelBg,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                  top: 20.h,
                  left: 20.w,
                  child: Image.asset(
                    "assets/images/new/mine/vip_title_${model.vipLevel ?? 0}.webp",
                    // height: 56.h,
                    width: 90.w,
                    height: 32.h,
                  )),
              Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Obx(() => Text(
                                  controller.totalDeposite.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: appColors.white),
                                )),
                            Text(
                              "total_deposite".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: appColors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Obx(
                              () => Text(
                                controller.depositeRequirement.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: appColors.white),
                              ),
                            ),
                            Text(
                              "turnover_requirement".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: appColors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Obx(() => Text(
                                controller.keepLevelequirement.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: appColors.white),
                              )),
                          Text(
                            "${"keep_turnover".tr}${UserService.to.state.vipInfo.value?.keepDays ?? ''}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: appColors.white),
                          ),
                        ],
                      ))
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }

  Widget _buildPrivilegeContent() {
    return Obx(() {
      List<dynamic> realData = [];
      for (Map element in controller.privilegeList) {
        if (double.parse(element["result"]) > 0) {
          realData.add(element);
        }
      }
      return Transform.translate(
        offset: Offset(0, -6.h),
        child: Container(
            height: 300.h,
            padding: EdgeInsets.only(left: 28.w, top: 0.w, right: 28.w),
            margin: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.mineIconVipRrr,
                      fit: BoxFit.fitWidth,
                      width: 16.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Transform.rotate(
                          angle: pi, // 旋转 180 度
                          child: Image.asset(
                            Assets.mineIcVipPrivilegeIconLeft,
                            fit: BoxFit.fitWidth,
                            height: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Text(
                      "VIP${controller.settingList[controller.cardIndex.value].vipLevel}${"zun_xiang".tr}",
                      style: TextStyle(
                          color: appColors.textMainColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Expanded(
                      child: Container(
                        child: Transform.rotate(
                          angle: pi, // 旋转 180 度
                          child: Image.asset(
                            Assets.mineIcVipPrivilegeIconRight,
                            fit: BoxFit.fitWidth,
                            height: 14.h,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: 235.h,
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        top: 15.h,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 114 / 55,
                      ),
                      itemCount: realData.length,
                      // item数量
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = realData[index];
                        return Container(
                          child: Row(
                            children: [
                              Image.asset(
                                data["icon"],
                                width: 34.w,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        StringUtils.removeTrailingZeros(
                                            num.tryParse(data["result"]) ?? 0),
                                        style: TextStyle(
                                            color: appColors.textMainColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if ("weekly_redpacket".tr ==
                                          data["title"])
                                        InkWell(
                                          onTap: () {
                                            controller.showRedPacketTipsDialog(
                                                data["tips"]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 2.r),
                                            child: Image.asset(
                                              Assets.mineTipsRedpacket,
                                              width: 16.r,
                                              height: 16.r,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                        color: appColors.inputTextStyleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
              ],
            )),
      );
    });
  }

  Widget upgradePromotionView() {
    return Obx(() {
      if (controller.cardIndex.value >= controller.upgradeOffers.length) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 4.r),
                child: Image.asset(
                  Assets.mineIconVipRrr,
                  fit: BoxFit.fitWidth,
                  width: 16.w,
                ),
              ),
              SizedBox(height: 16.r),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28.r),
                child: Row(
                  children: [
                    Expanded(
                      child: Transform.rotate(
                        angle: pi, // 旋转 180 度
                        child: Image.asset(
                          Assets.mineIcVipPrivilegeIconLeft,
                          fit: BoxFit.fitWidth,
                          height: 14.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "VIP${controller.settingList[controller.cardIndex.value].vipLevel}晋级优惠",
                      style: TextStyle(
                          color: appColors.textMainColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Transform.rotate(
                        angle: pi, // 旋转 180 度
                        child: Image.asset(
                          Assets.mineIcVipPrivilegeIconRight,
                          fit: BoxFit.fitWidth,
                          height: 14.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              noUpgradeView()
            ],
          ),
        );
      }
      var model = controller.upgradeOffers[controller.cardIndex.value];
      controller.upgradeList[0].result = model.minTransfer;
      controller.upgradeList[1].result = '${model.bonusRatio}%';
      controller.upgradeList[2].result = model.maxBonus;
      controller.upgradeList[3].result = '${model.turnoverMultiple}倍';
      controller.upgradeList[4].result = convertCycle(model.applyCycle ?? 0);
      controller.upgradeList[5].result =
          model.platformIds?.isNotEmpty == true ? '指定场馆' : '全部场馆';
      return Container(
        margin: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4.r),
              child: Image.asset(
                Assets.mineIconVipRrr,
                fit: BoxFit.fitWidth,
                width: 16.w,
              ),
            ),
            SizedBox(height: 16.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: Row(
                children: [
                  Expanded(
                    child: Transform.rotate(
                      angle: pi, // 旋转 180 度
                      child: Image.asset(
                        Assets.mineIcVipPrivilegeIconLeft,
                        fit: BoxFit.fitWidth,
                        height: 14.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "VIP${controller.settingList[controller.cardIndex.value].vipLevel}晋级优惠",
                    style: TextStyle(
                        color: appColors.textMainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Transform.rotate(
                      angle: pi, // 旋转 180 度
                      child: Image.asset(
                        Assets.mineIcVipPrivilegeIconRight,
                        fit: BoxFit.fitWidth,
                        height: 14.h,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (model.status == 2)
              noUpgradeView()
            else ...[
              GridView.builder(
                padding: EdgeInsets.only(top: 15.h, left: 14.r, right: 14.r),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (Get.width - 44.r * 2) / 3 / 50.r,
                ),
                itemCount: controller.upgradeList.length,
                // item数量
                itemBuilder: (context, index) {
                  var data = controller.upgradeList[index];
                  return Column(
                    children: [
                      Text(
                        data.result ?? '',
                        style: TextStyle(
                          color: appColors.textMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data.title ?? '',
                        style: TextStyle(
                            color: appColors.inputTextStyleColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  );
                },
              ),
              Container(
                height: 70.r,
                margin: EdgeInsets.only(left: 14.r, right: 14.r, bottom: 20.r),
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F3FF),
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child: Row(
                  children: [
                    Text(
                      '选择场馆：',
                      style: TextStyle(
                        color: appnewColors.textSecond,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (model.canApply == true) {
                          controller.selectPlatform();
                        }
                      },
                      child: Container(
                        height: 30.r,
                        width: 122.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFAFBFF),
                              Color(0xFFF3F5FF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFE6ECFA),
                              offset: Offset(0, 4),
                              blurRadius: 4.r,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Obx(() {
                          return Text(
                            controller.platformModel.value.name == null
                                ? '— 请选择 —'
                                : controller.platformModel.value.name ?? '',
                            style: TextStyle(
                              color: Color(0xFF7087F9),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (model.canApply == true) {
                          controller.applyUpgradeOffer();
                        }
                      },
                      child: Container(
                        height: 30.r,
                        width: 73.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appnewColors.bg,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Text(
                          model.canApply == true ? '领取' : '等级不符',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      );
    });
  }

  Widget lookVipDetailView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.VIP_DETAIL);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "view_vip_detail".tr,
                style: TextStyle(
                    color: appColors.textMain2Color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 5.w,
              ),
              Image.asset(
                Assets.mineIcDetailArrow,
                height: 10.w,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget noUpgradeView() {
    return Container(
      height: 205.r,
      padding: EdgeInsets.only(top: 68.r),
      child: Column(
        children: [
          Text(
            '当前等级没有晋级优惠',
            style: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.r),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.VIP_DETAIL);
            },
            child: Container(
              height: 40.r,
              width: 170.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: appnewColors.bgBlue, width: 1),
              ),
              child: Text(
                'more_privilege'.tr,
                style: TextStyle(
                  color: appnewColors.textBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String convertCycle(num applyCycle) {
    switch (applyCycle) {
      case 1:
        return '仅1次';
      case 2:
        return '每周1次';
      case 3:
        return '每月1次';
      case 4:
        return '不限次数';
      default:
        return '仅一次';
    }
  }
}
