import 'package:carousel_slider/carousel_slider.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart' show AppNavigator;
import 'package:filbet/src/dialog/dialog_kfview_new.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/src/mine/joinUs/controller/jpin_us_controller.dart';
import 'package:filbet/src/splash/splash_view.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/social_launcher.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:filbet/widgets/custom_scffold.dart';

class JoinUsView extends GetView<JoinUsController> {
  const JoinUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        title: 'hyjh'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.mineIconHyjhBg),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildSwiperContentView(context),
          )),
    );
  }

  Widget _buildPageFirst() {
    return _buildPageShell(
      title: "代理合营计划".tr,
      subtitle: "是成为传奇？还是传奇的歌颂者？".tr,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.mineIcJoinUsBg1, width: 272.w),
          _buildCommonFirstItem(
            Assets.mineIconYeechat,
            '合营部Yeechat',
            'skhykf',
            () {
              SocialLauncher.openYeeChat('skhykf');
            },
          ),
          _buildCommonFirstItem(
            Assets.mineIconTelegram,
            '合营部telegram',
            '@skgfhy',
            () {
              SocialLauncher.openTelegram('@skgfhy');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageSecond() {
    return _buildPageShell(
      title: "财富之路事半功倍".tr,
      subtitle: "4大优势造就行业翘楚".tr,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 20.w),
              Expanded(child: _buildCommonSecondItem("会员统计".tr, "数据实时更新".tr)),
              SizedBox(width: 19.w),
              Expanded(child: _buildCommonSecondItem("团队分析".tr, "智能分析数据".tr)),
              SizedBox(width: 20.w),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              Expanded(
                  child: _buildCommonSecondItem("多维度数据统计".tr, "运营动态及时调整".tr)),
              SizedBox(width: 19.w),
              Expanded(
                  child: _buildCommonSecondItem("多种提现方式".tr, "银行卡、USD等".tr)),
              SizedBox(width: 20.w),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageThird() {
    return _buildPageShell(
      title: "用户喜欢的娱乐平台".tr,
      subtitle: "聚集于体育及多元化娱乐".tr,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconLabelRow(
            [
              (asset: Assets.mineIcJoinusSafe, label: "更安全".tr),
              (asset: Assets.mineIcJoinusProfession, label: "更专业".tr),
              (asset: Assets.mineIcJoinusConvenience, label: "更便捷".tr),
              (asset: Assets.mineIcJoinusFast, label: "更快捷".tr),
            ],
            horizontalPadding: 32,
            spacing: 29,
            iconWidth: 56,
            fontSize: 16,
          ),
          SizedBox(height: 60.h),
          Image.asset(Assets.mineIcJoinUsBg3, width: 324.w),
        ],
      ),
    );
  }

  Widget _buildSwiperContentView(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              if (index == 0) {
                return _buildPageFirst();
              }
              if (index == 1) {
                return _buildPageSecond();
              }
              if (index == 2) {
                return _buildPageThird();
              }
              return Container();
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              height: double.infinity,
              // autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.currentIndex.value = index;
              },
            ),
          ),
          Positioned(
            bottom: 38.h,
            left: 0,
            right: 0,
            child: Center(
              child: CustomPageIndicator(
                activeIndex: controller.currentIndex.value,
                itemCount: 3,
                dotHeight: 4.h,
                dotWidth: 12.w,
                activeColor: appColors.textMain2Color,
                inactiveColor: appnewColors.bg2,
                showShadow: false,
                spacing: 6.w,
              ),
            ),
          ),
          // if (controller.currentIndex.value == 2)
          // Positioned(
          //   bottom: 64.h,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: buildjoinUsButton(),
          //   ),
          // )
        ],
      );
    });
  }

  Widget buildjoinUsButton() {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          SkBaseDialog(
            bgColor: Colors.transparent,
            showFooterBtn: false,
            showDeleteBtn: true,
            showDeleteBtnType: '2',
            child: DialogKfviewNew(
              customServices: controller.customServices.value,
            ),
          ),
        );
      },
      child: Container(
        width: Get.width - 24.w,
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(44.r),
          gradient: LinearGradient(
            colors: [
              Color(0xff7EB2FF),
              Color(0xff5EA1FF),
              Color(0xff4895FF),
              Color(0xff78B1FF),
            ], // 定义渐变色
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            'join_us'.tr,
            style: TextStyle(
              color: appColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// 页面通用外壳：标题 + 副标题 + 自定义内容
  Widget _buildPageShell({
    required String title,
    required String subtitle,
    required Widget content,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appColors.textMainColor,
              fontFamily: 'PingFang SC',
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            style: TextStyle(
              color: appColors.inputTextStyleColor,
              fontFamily: 'PingFang SC',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15.h),
          content,
        ],
      ),
    );
  }

  Widget _buildIconLabelItem(String asset, String label,
      {double iconWidth = 32, double fontSize = 14}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(asset, width: iconWidth.w),
        Text(
          label,
          style: TextStyle(
            color: appColors.inputTextStyleColor,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildIconLabelRow(
    List<({String asset, String label})> items, {
    double horizontalPadding = 14,
    double spacing = 25,
    double iconWidth = 32,
    double fontSize = 14,
  }) {
    return Row(
      children: [
        SizedBox(width: horizontalPadding.w),
        ...items.asMap().entries.expand((e) {
          final isLast = e.key == items.length - 1;
          return [
            Expanded(
                child: _buildIconLabelItem(e.value.asset, e.value.label,
                    iconWidth: iconWidth, fontSize: fontSize)),
            if (!isLast) SizedBox(width: spacing.w),
          ];
        }),
        SizedBox(width: horizontalPadding.w),
      ],
    );
  }

  Widget _buildCommonFirstItem(
      String icon, String title, String subTitle, GestureTapCallback? jump) {
    return Container(
      height: 68.r,
      margin: EdgeInsets.only(top: 10.r, left: 15.r, right: 15.r),
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFEFEFE),
            Color(0xFFFDFDFF),
            Color(0xFFF3F6FF),
            Color(0xFFFDFDFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEBF1FD),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 36.r,
            height: 36.r,
          ),
          SizedBox(
            width: 15.r,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: appColors.textMainColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    color: appColors.inputTextStyleColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              AppUtils.copy(subTitle);
            },
            child: Container(
              height: 28.r,
              width: 60.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFAFAFC),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEDECF2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '复制',
                style: TextStyle(
                  color: appnewColors.textSecond,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.r),
          InkWell(
            onTap: jump,
            child: Container(
              height: 28.r,
              width: 60.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4C96FF),
                    Color(0xFF4C96FF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEDECF2),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '咨询',
                style: TextStyle(
                  color: appnewColors.textWhite,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonSecondItem(String title, String subTitle) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE8F3FF),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.mineIcJoinusStatic,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            title,
            style: TextStyle(
                color: appColors.textMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
          Text(
            subTitle,
            style: TextStyle(
                color: appColors.inputTextStyleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
