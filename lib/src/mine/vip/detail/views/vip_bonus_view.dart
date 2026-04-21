import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_bonus_controller.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_rules_view.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipBonusView extends GetView<VipBonunsController> {
  VipBonusView({super.key});

  final MineController mineLogic = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      needAppbar: false,
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              titleView(),
              _buildListWidget(),
              VipRuleView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h, bottom: 2.h),
          color: appColors.textWhiteColor,
          child: Row(
            children: [
              Container(
                width: 3.w,
                height: 16.h,
                decoration: BoxDecoration(
                    color: appnewColors.bg,
                    borderRadius: BorderRadius.circular(4.r)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "VIP提款额度",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: appColors.textMainColor),
              ),
              SizedBox(width: 5.r),
              Text(
                "VIP等级越高，每日取款次数和金额越多",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: appnewColors.textSecond),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListWidget() {
    return Column(
      children: [
        Container(
          height: 10.h,
          color: Colors.white,
        ),
        Container(
          height: 54.r,
          color: appnewColors.bg5,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'VIP${"vip_level".tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: appColors.textMainColor),
                ),
              ),
              Expanded(
                child: Text(
                  "日提款次数",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: appColors.textMainColor),
                ),
              ),
              Expanded(
                child: Text(
                  "每日提款总额度",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: appColors.textMainColor),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Column(
            children:
                List.generate(controller.vipSettingModels.length, (index) {
              var model = controller.vipSettingModels[index];
              return SizedBox(
                height: 54.h,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color:
                          index % 2 == 0 ? appColors.white : appnewColors.bg5,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/images/new/mine/vip_bonus_level_${model.vipLevel}${model.vipLevel == (mineLogic.vipInfo.value?.currentLevel ?? 0) ? "_sel" : ""}.webp",
                              width: 24.w),
                          Text(
                            "VIP${model.vipLevel}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: model.vipLevel ==
                                        (mineLogic
                                                .vipInfo.value?.currentLevel ??
                                            0)
                                    ? appColors.borderMain2Color
                                    : appColors.textMainColor),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      color:
                          index % 2 == 0 ? appColors.white : appnewColors.bg5,
                      alignment: Alignment.center,
                      child: Text(
                        '${model.dailyWithdrawTimes ?? '--'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: model.vipLevel ==
                                    (mineLogic.vipInfo.value?.currentLevel ?? 0)
                                ? appColors.borderMain2Color
                                : appColors.textMainColor),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      color:
                          index % 2 == 0 ? appColors.white : appnewColors.bg5,
                      alignment: Alignment.center,
                      child: Text(
                        _formatToWan(model.dailyWithdrawAmount),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: model.vipLevel ==
                                    (mineLogic.vipInfo.value?.currentLevel ?? 0)
                                ? appColors.borderMain2Color
                                : appColors.textMainColor),
                      ),
                    )),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  // 将金额转换为以万为单位显示
  String _formatToWan(String? amount) {
    if (amount == null || amount.isEmpty || amount == '--') {
      return '--';
    }
    try {
      final doubleValue = double.parse(amount);
      if (doubleValue < 10000) {
        return _formatNumber(doubleValue);
      }
      return '${_formatNumber(doubleValue / 10000)}万';
    } catch (e) {
      return '--';
    }
  }

  // 格式化数字：整数显示整数，小数保留2位
  String _formatNumber(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }
}
