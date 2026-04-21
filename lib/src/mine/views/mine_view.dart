import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/sp_storage/sp_storage_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/services/user/user_state_view_extension.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/views/middle_info.dart';
import 'package:filbet/src/mine/views/user_enum.dart';

import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/utils/font_family.dart';
import 'package:filbet/widgets/common_button.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController> {
  const MineView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg2,
      needAppbar: false,
      body: SafeArea(
        child: _userView(context),
      ),
    );
  }

  _userView(context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        margin:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
        child: Column(
          children: [
            _userHeaderView(),
            _walletview(),
            _middle_listview(),
            footerView(),
            //_footerview()
          ],
        ),
      ),
    );
  }

  Widget _userHeaderView() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.h,
        top: 5.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userIcon().toBtn(
            onTap: () {
              Get.toNamed(Routes.USER_INFO);
            },
            radius: 100.r,
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2.r),
                      child: Text(
                        UserService.to.state.nicknamelabel,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: appnewColors.text1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/new/mine/vip_level_${controller.vipInfo.value?.currentLevel ?? 0}.webp",
                      width: 55.w,
                      height: 22.h,
                    )
                  ],
                ),
                _joinPlatformTime(),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          buildSupport(),
        ],
      ),
    );
    // }

    // );
  }

  Widget buildSupport() {
    return Column(
      children: [
        Row(
          spacing: 10.r,
          children: [
            GestureDetector(
              onTap: () {
                controller.jumpToSettingPage();
              },
              child: Container(
                width: 20.r,
                height: 20.r,
                child: Image.asset(
                  Assets.mineSetingIcon,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                AppNavigator.gotoMessage();
              },
              child: Container(
                width: 20.r,
                height: 20.r,
                child: Stack(
                  children: [
                    Image.asset(
                      Assets.mineIconMessage,
                      width: 20.r,
                      height: 20.r,
                    ),
                    if (UserService.to.state.totalUnread.value > 0)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF7255),
                            borderRadius: BorderRadius.circular(6.r),
                            border:
                                Border.all(color: appnewColors.bg1, width: 1),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.w,
        )
      ],
    );
  }

  Widget _joinPlatformTime() {
    return IntrinsicWidth(
        child: Container(
      height: 24.h,
      // width: 145,
      //  constraints: BoxConstraints(maxWidth: 350),
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.only(left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'joined_sk'.tr,
              style: TextStyle(
                color: appnewColors.text16,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: getDaysFromNow(UserService.to.state.userInfo.createdAt ?? 0)
                  .toString(),
              style: TextStyle(
                color: appnewColors.text16,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(
              text: 'day'.tr,
              style: TextStyle(
                color: appnewColors.text16,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _userIcon() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 48.w,
            width: 48.w,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 48.w,
                  height: 48.w,
                  child: Obx(() {
                    return Image.asset(
                      UserService.to.state.avatarImgUrl,
                      width: 48.w, // 减去边框宽度，确保图片完全在边框内
                      height: 48.w,
                      fit: BoxFit.fill,
                    );
                    // return UserService.to.state.avatar.isNotEmpty
                    //     ? SKNetworkImage(
                    //         imageUrl: UserService.to.state.avatar,
                    //         width: 47.w,
                    //         height: 47.h,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : Image.asset(
                    //         UserService.to.state.avatarImgUrl,
                    //         width: 47.w,
                    //         height: 47.h,
                    //         fit: BoxFit.cover,
                    //       );
                  }),
                ),
              ],
            ),
          ),
        ]);
  }

  int getDaysFromNow(int timestamp) {
    if (timestamp == 0) return 0;

    // 转换成 DateTime（乘 1000 把秒转换成毫秒）
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();

    // 去掉时间部分，只比较日期
    DateTime dateOnly = DateTime(date.year, date.month, date.day);
    DateTime nowOnly = DateTime(now.year, now.month, now.day);

    return nowOnly.difference(dateOnly).inDays + 1;
  }

  Widget _buildVipInfoWidget() {
    bool birthGift = UserService.to.state.userInfo.currentVipBirthHasGift == 1;
    bool weekGift = UserService.to.state.userInfo.currentVipWeekHasGift == 1;

    List<Map<String, dynamic>> data = [
      {"status": true, "title": "vip_level_up_bonus".tr},
      {"status": true, "title": "hight_rabate".tr},
      {"status": weekGift, "title": "weekly_redpacket".tr},
      {"status": birthGift, "title": "vip_birthday_bonus".tr}
    ];

    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 10.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: appnewColors.bg2)),
      child: Column(
        children: [
          Obx(
            () {
              double sliderValue = 0.0;
              if ((controller.vipInfo.value?.currentLevel ?? 0) >= 10) {
                sliderValue = 1;
              } else {
                sliderValue = controller.calculateProgress();
              }
              return Row(
                children: [
                  if ((controller.vipInfo.value?.currentLevel ?? 0) < 10)
                    Image.asset(
                      "assets/images/new/mine/vip_level_${controller.vipInfo.value?.currentLevel ?? 0}.webp",
                      width: 55.w,
                      height: 22.h,
                    )
                  else
                    Image.asset(
                      Assets.mineVipLevel9,
                      width: 55.w,
                      height: 22.h,
                    ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 2.r),
                      child: CustomSlider(
                        value: sliderValue,
                        sliderWidth:
                            Get.width - 28.w * 2 - 8.w * 2 - 55.w * 2 - 4.w,
                        trackHeight: 6.h,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  if ((controller.vipInfo.value?.currentLevel ?? 0) < 10)
                    Image.asset(
                      "assets/images/new/mine/vip_level_${(controller.vipInfo.value?.currentLevel ?? 0) + 1}.webp",
                      width: 55.w,
                      height: 22.h,
                    )
                  else
                    Image.asset(
                      Assets.mineVipLevel10,
                      width: 55.w,
                      height: 22.h,
                    )
                ],
              );
            },
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => Text(
                    controller.needString.value,
                    maxLines: 4,
                    style: TextStyle(color: Color(0xFF575D7A), fontSize: 10.sp),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.VIP_PRIVILEDGE);
                  },
                  child: Row(
                    children: [
                      Text(
                        "more_privilege".tr,
                        style: TextStyle(
                            color: Color(0xFF575D7A), fontSize: 10.sp),
                      ),
                      Container(
                        width: 12.w,
                        height: 12.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.mineIconArrowR,
                          width: 8.w,
                          height: 8.h,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: List.generate(data.length, (index) {
              Map<String, dynamic> map = data[index];
              bool status = map["status"];
              return Expanded(
                  child: InkWell(
                onTap: () {
                  if (index == 2) {
                    Get.toNamed(Routes.VIP_DETAIL);
                  } else {
                    EventBus.emit(EventType.onGoVip);
                  }
                },
                child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(
                        right: index < data.length - 1 ? 8.w : 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFFE3EBF5),
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          status ? Assets.mineIcVipOpen : Assets.mineIcVipClose,
                          width: 13.w,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          data[index]["title"],
                          style: TextStyle(
                              color: Color(0xFF545A78),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ));
            }),
          )
        ],
      ),
    );
  }

  _walletview() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 14.h, bottom: 14.h),
        decoration: BoxDecoration(
          color: appnewColors.bg3,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xffCBDAE9), // 阴影颜色
              spreadRadius: 2, // 阴影扩散范围
              blurRadius: 8, // 模糊程度
              offset: Offset(0, 4), // 阴影偏移量 (x, y)
            ),
          ],
        ),
        child: Column(children: [
          _buildVipInfoWidget(),
          Row(
            children: [
              Expanded(
                child: Obx(() => UserService.to.state.isVisitor == false
                    ? Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                //  height: 20.h,
                                width: 155.w,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        MineController.to.middleListClick(
                                          UserCenterItemType.myAssets,
                                        );
                                      },
                                      child: Text(
                                        "wallet_balance".tr,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: appnewColors.text1,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'PingFang SC',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Container(
                                      width: 20.w,
                                      height: 16.h,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        UserService.to.state.hideBalance
                                                    .value ==
                                                true
                                            ? Assets.homeEye
                                            : Assets.homeNoeye,
                                        width: 16.w,
                                        height: 16.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ).toBtn(
                                      onTap: () {
                                        UserService.to.state.hideBalance.value =
                                            !UserService
                                                .to.state.hideBalance.value;
                                        SpStorage.sethibalance(UserService
                                            .to.state.hideBalance.value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // width: 150.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        MineController.to.middleListClick(
                                          UserCenterItemType.myAssets,
                                        );
                                      },
                                      child: Text(
                                        UserService.to.state.hideBalance
                                                    .value ==
                                                true
                                            ? UserService
                                                .to.state.totalBalance.value
                                                .strforcurry()
                                            : "*****",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: FontFamily.din_bold,
                                            fontWeight: FontWeight.w700,
                                            color: appnewColors.textMain),
                                      ),
                                    ),
                                    // SizedBox(width: 5.w),
                                    if (GlobalService
                                            .to.state.currencyConfig.length >
                                        1)
                                      Container(
                                        width: 21.w,
                                        height: 15.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.mineIconQh,
                                          width: 16.w,
                                          height: 16.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ).toBtn(
                                        onTap: () async {
                                          if (GlobalService.to.state
                                                  .currencyConfig.length >
                                              1) {
                                            final currency = await UserService
                                                .to.state
                                                .presentChangeUserDefaultCurrencyBottomSheet();
                                            UserService.to.state.userInfo
                                                    .currency =
                                                int.parse(currency!.code);
                                            if (currency != null) {
                                              // SpStorage.setCurrency(
                                              //     currency.abbr);
                                              // UserService.to.state
                                              //     .currencyType = currency;
                                            }
                                          }
                                          controller.fetchMemberVipInfo();
                                        },
                                      ),
                                    SizedBox(width: 3.w),
                                    GestureDetector(
                                      onTap: () {
                                        controller.financewallet();
                                      },
                                      child: RotationTransition(
                                        //设置动画的旋转中心
                                        alignment: Alignment.center,
                                        //动画控制器
                                        turns: controller.animationController!,
                                        child: Image.asset(
                                          Assets.homeIconRefresh,
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox()),
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        // EventBus.emit(EventType.onGoRecharge);
                        Get.toNamed(Routes.DEPOSIT);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 36.w,
                            height: 38.h,
                            alignment: Alignment.center,
                            child: Image.asset(
                              Assets.mineMineDep,
                              width: 36.w,
                              height: 38.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            "deposit".tr,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF595F7C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 14.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.TRANSFER);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.w,
                          height: 38.h,
                          alignment: Alignment.center,
                          child: Image.asset(
                            Assets.mineMineTransfer,
                            width: 36.w,
                            height: 38.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "transfer".tr,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF595F7C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  InkWell(
                    onTap: () {
                      // EventBus.emit(EventType.onGoWithdraw);
                      Get.toNamed(Routes.WITHDRAW);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.w,
                          height: 38.h,
                          alignment: Alignment.center,
                          child: Image.asset(
                            Assets.mineMineWd,
                            width: 36.w,
                            height: 38.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "withdraw".tr,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF595F7C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ]));
  }

  _middle_listview() {
    return Stack(children: [
      Container(
          height: 36.w,
          padding: EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: Row(
            children: [
              Spacer(),
              Container(
                height: 36.w,
                width: 137.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.mineWelfarebg1), // 本地图片
                    fit: BoxFit.fill, // 拉伸/铺满
                  ),
                ),
              )
            ],
          )),

      Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
          height: 36.w,
        ),
        UserCenterMiddleInfoView(),
      ]),

      // 悬浮在上面的按钮
      Positioned(
        left: 0, // 距离右边 16
        top: 0,
        right: 0, // 距离底部 16
        child: Container(
          height: 36.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.mineWelfarebg2), // 本地图片
              fit: BoxFit.fill, // 拉伸/铺满
            ),
          ),
          child: Container(
            // alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              right: 10.w,
              bottom: 5.w,
            ),
            height: 36.w,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 5.w),
                  child: Image.asset(
                    Assets.mineWelfareText,
                    // width: 12.w,
                    height: 20.w,
                    fit: BoxFit.fill,
                  ),
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.only(top: 5.w),
                    child: Row(
                      children: [
                        Obx(() {
                          num amount = num.tryParse(
                                  UserService.to.state.welfareAmount.value) ??
                              0;
                          if (amount > 0) {
                            return Container(
                              width: 6.r,
                              height: 6.r,
                              margin: EdgeInsets.only(right: 5.r),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF7255),
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                    color: appnewColors.bg1, width: 1),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                        Text(
                          "welfare_received".tr,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: appnewColors.text4,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Image.asset(
                          Assets.mineWelfareback,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ).toBtn(
                      onTap: () {
                        Get.toNamed(Routes.WELFARE_CENTER)?.then((value) {
                          controller.financeWelfareWallet();
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget footerView() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.ABOUT_US);
      },
      child: Container(
        height: 52.r,
        margin: EdgeInsets.only(top: 10.r),
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        decoration: BoxDecoration(
          color: Color(0xFFF7F9FF),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFCBDAE9),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              Assets.mineIconAbout,
              width: 22.r,
              height: 22.r,
            ),
            SizedBox(width: 3.r),
            Text(
              '关于SK体育',
              style: TextStyle(
                color: appnewColors.text16,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  _footerview() {
    return Container(
        // width: Get.width,
        margin: EdgeInsets.fromLTRB(0, 12.h, 0, 0.h),
        padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 14.r),
        decoration: BoxDecoration(
          color: appnewColors.bg3,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),

          boxShadow: [
            BoxShadow(
              color: Color(0xffCBDAE9), // 阴影颜色
              spreadRadius: 2, // 阴影扩散范围
              blurRadius: 8, // 模糊程度
              offset: Offset(0, 4), // 阴影偏移量 (x, y)
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 37.h,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                children: [
                  Text(
                    "my_data".tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: appnewColors.text1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "today".tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: appnewColors.text2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 101.h,
              // color: Colors.red,
              padding: EdgeInsets.only(left: 8.w, right: 8.w),

              decoration: BoxDecoration(
                color: appnewColors.bg1,
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Expanded(child: Obx(
                    () {
                      return _buildFooteritem("settled_order".tr,
                          "${controller.betnumber}" + "note".tr, 0);
                    },
                  )),
                  Expanded(child: Obx(
                    () {
                      return _buildFooteritem("total_rebate".tr,
                          amountnojiStr(controller.betrebate.value), 2);
                    },
                  )),
                  Expanded(child: Obx(
                    () {
                      return _buildFooteritem("total_winloss".tr,
                          amountnojiStr(controller.betwin.value), 1);
                    },
                  )),
                ],
              ),
            ),
          ],
        ));
  }

  _buildFooteritem(String title, String text, int index) {
    return InkWell(
      onTap: () {
        controller.footerClick(index);
      },
      child: Row(
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: appnewColors.text2,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: appnewColors.text2,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: 16.w,
            height: 16.h,
            alignment: Alignment.center,
            child: Image.asset(
              Assets.mineIconArrowR,
              width: 10.w,
              height: 10.h,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
