import 'package:filbet/app/modules/daily_signin/model/daily_sign_detail.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/daily_signin_controller.dart';

class DailySigninView extends GetView<DailySigninController> {
  const DailySigninView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.test();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.activityDaySignBg), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            _appBar(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  _topView(),
                  // _signInfo(),
                  _signList(),
                  Container(
                    margin: EdgeInsets.only(top: 19.h, bottom: 14.h),
                    child: Image.asset(
                      Assets.activityDayBottomLogo,
                      width: 30.w,
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
  _appBar() {
    return Obx(() => CustomAppbar.normalTitle(
        title: controller.detailModel.value.name ?? "",
        bgColor: Colors.transparent,
        leftBackColor: appnewColors.text6));
  }

  Widget _topView() {
    return Container(
      height: 314.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              Assets.activityIconSigninTopBg,
              width: 331.w,
              height: 274.h,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: _signInfo(),
          ),
          Positioned(
            bottom: 40.h,
            right: 0,
            child: Image.asset(
              Assets.activityDayGold,
              width: 63.w,
            ),
          )
        ],
      ),
    );
  }

  //连续签到奖励
  Widget _signInfo() {
    var paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter, // 从上
        end: Alignment.bottomCenter, // 到下
        colors: [Color(0xffFFEFCE), Color(0xffFECB62)],
      ).createShader(
        Rect.fromLTWH(0, 0, 200, 70),
      ); // 控制渐变区域大小
    return Stack(
      children: [
        Align(
            child: Container(
          height: 73.h,
          width: 307.w,
          margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 60.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.activityIconSignInfoBg), // 本地图片
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 1.sw,
                height: 64.h,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Obx(
                              () => SizedBox(
                                child: Text(
                                  controller.detailModel.value.currentStreak ?? "",
                                  style: TextStyle(
                                    height: 1.0,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 4.0,
                                        color: appnewColors.textShadowColor,
                                      ),
                                    ],
                                    foreground: paint,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "consecutiveSignInDays".tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12.sp,
                                height: 1.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "againSign".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.sp,
                                    height: 1.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Obx(() => Text(
                                      controller.detailModel.value.streakTarget ?? "",
                                      style: TextStyle(
                                        height: 1.0,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: appnewColors.textShadowColor,
                                          ),
                                        ],
                                        foreground: paint,
                                      ),
                                    )),
                              ),
                              Text(
                                "day".tr,
                                style: TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "obtainable".tr,
                                style: TextStyle(
                                    height: 1.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Obx(() => Text(
                                      controller.detailModel.value.streakTargetAmt ?? "",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 22.sp,
                                        height: 1.0,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: appnewColors.textShadowColor,
                                          ),
                                        ],
                                        foreground: paint,
                                      ),
                                    )),
                              ),
                              Text(
                                "yuan".tr,
                                style: TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ],
    );
  }

  //每日签到奖励
  Widget _signList() {
    return Container(
      margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 14.h),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                "daySign3".tr,
                style: TextStyle(
                    color: appnewColors.text9, fontSize: 12.sp, fontFamily: 'PingFang SC', fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Obx(
            () => GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              // 禁止GridView滚动
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 一行 5 个
                //crossAxisSpacing: 4, // 水平间距
                mainAxisExtent: 100.w, // 高度固定为 120
              ),
              itemCount: controller.detailModel.value.days?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _sigItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sigItem(index) {
    Days days = controller.detailModel.value.days?[index] ?? Days();
    var enable = days.status == 0;
    String dateStr = days.date ?? "";
    DateTime dateTime = DateTime.parse(dateStr); // 解析字符串
    String formattedTime = DateFormat("MM.dd").format(dateTime); // 格式化
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(enable ? Assets.activityIconSiginIn : Assets.activityIconNoSiginIn), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Text(
            formattedTime,
            style: TextStyle(color: getStatusColor(days.status), fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 7.h),
          Align(
            child: Image.asset(
              getCenterImg(days.status),
              width: 26.w,
              height: 26.w,
            ),
          ),
          if (enable)
            GestureDetector(
              child: Container(
                width: 56.w,
                padding: EdgeInsets.only(top: 2.w, bottom: 5.w),
                // height: 21.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.w),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff33DD85), Color(0xff03B25A)]),
                  border: Border.all(color: Color(0xff39DE89), width: 1.w),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff56897C).withAlpha(40),
                      offset: const Offset(0, 2),
                      blurRadius: 4.r,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  "立即签到".tr,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                controller.promosignClaim(days);
              },
            ),
          if ([1, 3].contains(days.status))
            Container(
              width: 56.w,
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 10.h,
              ),
              alignment: Alignment.center,
              child: Text(
                getStatusStr(days.status),
                style: TextStyle(color: getStatusColor2(days.status), fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
          if (days.status == 4)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                "\$${days.rewardAmt}",
                style: TextStyle(color: appnewColors.text12, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }

  String getCenterImg(staus) {
    if (staus == 1) {
      return Assets.activitySignedIn;
    } else if (staus == 3) {
      return Assets.activityGrayGold;
    } else {
      return Assets.activityGoldGold;
    }
  }

  String getStatusStr(staus) {
    if (staus == 1) {
      return "signed".tr;
    } else if (staus == 3) {
      return "expired".tr;
    } else {
      return "未开始".tr;
    }
  }

  Color getStatusColor(staus) {
    if (staus == 1) {
      return appnewColors.text13;
    } else if (staus == 3) {
      return appnewColors.text10;
    } else {
      return appnewColors.text13;
    }
  }

  Color getStatusColor2(staus) {
    if (staus == 1) {
      return appnewColors.text14;
    } else if (staus == 3) {
      return appnewColors.text10;
    } else {
      return appnewColors.text13;
    }
  }
}
