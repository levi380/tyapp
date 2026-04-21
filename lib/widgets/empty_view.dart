import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 空数据状态枚举（带多语言和图标资源）
enum EmptyState {
  noMessage("No_new_notifications", Assets.emptyNoMessage), // 无消息
  noDeposit("no_data", Assets.emptyNoDeposit), // 存取无记录
  noBet("no_data_bet", Assets.emptyNoBet), // 投注无记录
  noTransaction("no_data_transaction", Assets.emptyNoDeposit), // 交易无记录
  noData("no_data", Assets.emptyNoData), // 红利无记录
  noWelfare("no_data", Assets.emptyNoWelfare); // 红利无记录

  final String i18nKey;
  final String iconPath;

  const EmptyState(this.i18nKey, this.iconPath);

  /// 获取本地化后的文案
  String get text => i18nKey.tr;

  /// 获取空状态图标路径
  String get icon => iconPath;
}

class EmptyView extends StatelessWidget {
  final double? bottom;
  final double? top;
  final double? iconWidth;
  final double? iconHeight;

  /// 空状态
  final EmptyState state;

  EmptyView({
    super.key,
    this.top,
    this.bottom,
    this.iconWidth,
    this.iconHeight,
    this.state = EmptyState.noData, // 默认无消息
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        // ✅ 让整个内容居中
        child: Container(
      margin: EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0),
      child: Column(
        mainAxisAlignment:
            top != null ? MainAxisAlignment.start : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 空状态图标
          Image.asset(
            state.icon, // 使用传入的枚举里的图标
            width: iconWidth ?? 140.w,
            height: iconHeight ?? 140.w,
          ),
          SizedBox(width: 10.h),

          /// 文案
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 1.h,
              //   width: 80.w,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //       colors: [
              //         appColors.textSecond2Color.withValues(alpha: 0.0),
              //         appColors.textSecond2Color.withValues(alpha: 0.47),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(width: 10.w),
              Text(state.text, // 使用枚举里的文案
                  style: TextStyle(
                      color: appnewColors.text2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500)),
              // SizedBox(width: 10.w),
              // Container(
              //   height: 1.h,
              //   width: 80.w,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //       colors: [
              //         appColors.textSecond2Color.withValues(alpha: 0.47),
              //         appColors.textSecond2Color.withValues(alpha: 0.0),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    ));
  }
}
