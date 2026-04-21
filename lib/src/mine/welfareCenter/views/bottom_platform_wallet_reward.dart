import 'dart:convert';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/homegame_model.dart';
import 'package:filbet/src/mine/welfareCenter/models/platform_model.dart';
import 'package:filbet/src/mine/welfareCenter/views/bottom_platform_list.dart';
import 'package:filbet/src/mine/welfareCenter/welfare_item_model.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';
import '../controllers/welfare_center_controller.dart';

class BottomPlatformWalletReward extends StatelessWidget {
  BottomPlatformWalletReward({super.key, required this.item}) {
    final list = _platformListFor(item);
    if (list.isNotEmpty) {
      platformModel.value = list.first;
    }
  }

  final WelfareItemModel item;
  final platformModel = VenueModel().obs;
  final WelfareCenterController controller = Get.find();

  List<VenueModel> get platformList => _platformListFor(item);

  static List<VenueModel> _platformListFor(WelfareItemModel item) {
    List<VenueModel> platforms = [];
    List<dynamic> pidList = [];
    if (item.plats != null && item.plats!.isNotEmpty) {
      try {
        pidList = jsonDecode(item.plats!) as List<dynamic>;
        // 按照 platformIds 的顺序排序
        platforms = pidList
            .map((platformId) {
              return GlobalService.to.state.allGameConfig.firstWhere(
                (item) => (item.id ?? '') == platformId,
                orElse: () => VenueModel(), // 如果找不到，返回空对象
              );
            })
            .where((item) => item.id != null)
            .toList(); // 过滤掉空对象

        platforms = GlobalService.to.state.allGameConfig
            .where((item) => pidList.contains(item.id))
            .toList();
      } catch (e) {}
    }
    return platforms;
  }

  // 常量
  static const double _borderRadius = 16.0;
  static const double _itemHeight = 44.0;
  static const double _borderWidth = 1.0;
  static const Color _borderColor = Color(0xffE9E9E9);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(_borderRadius.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          _buildContent(),
          _buildBtn(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 20.h,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // 解析数值，避免重复计算
    final amount = _parseDouble(item.amount);
    final water = _parseDouble(item.water);
    final modHis = item.modHis ?? {};
    final rollRequirement = (water * amount).toStringAsFixed(2);

    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                _buildItem(
                  "reward_wallet".tr,
                  'platform_wallet'.tr,
                  false,
                ),
                Obx(() {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (c) {
                          return BottomPlatformList(
                            models: platformList,
                            platformSelect: (model) {
                              platformModel.value = model;
                            },
                          );
                        },
                      );
                    },
                    child: _buildItem(
                      "select_platform".tr,
                      platformModel.value.id == null
                          ? 'please_select'.tr
                          : platformModel.value.name ?? '',
                      false,
                      hasArrow: true,
                    ),
                  );
                }),
                _buildItem(
                  "reward_amount".tr,
                  '¥${amount.toStringAsFixed(2)}',
                  true,
                ),
                Obx(() {
                  num multiple = (num.tryParse(
                          modHis['${platformModel.value.id}'] ?? '0') ??
                      0);
                  String multipleAmount =
                      (amount * multiple).toStringAsFixed(2);
                  return _buildItem(
                    "roll_req".tr,
                    item.type == 17 ? '¥$multipleAmount' : '¥$rollRequirement',
                    true,
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  /// 解析字符串为 double，失败返回 0.0
  double _parseDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  Widget _buildItem(String title, String value, bool isHighlight,
      {bool hasArrow = false}) {
    return Container(
      height: _itemHeight.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _borderColor,
            width: _borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text2,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isHighlight ? appnewColors.textBlue : appnewColors.text1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (hasArrow)
            Image.asset(
              Assets.mineIconArrowRight,
              width: 14.r,
              height: 14.r,
            ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 20.w),
      child: Stack(
        children: [
          Center(
            child: Text(
              "领取确认".tr,
              style: TextStyle(
                color: appnewColors.text1,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: Get.back,
              child: Container(
                width: 30.w,
                height: 30.w,
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.mineIconCloes,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: appnewColors.bg, width: 1), // 边框颜色和宽度
                foregroundColor: appnewColors.bg, // 文字颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 圆角
                ),
                // 内边距
              ),
              onPressed: () => Get.back(),
              child: Text(
                "cancel".tr,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // 禁用时背景色
                  }
                  return appnewColors.bg; // 默认背景色
                }),
                foregroundColor:
                    MaterialStateProperty.all(appnewColors.text4), // 文字颜色
              ),
              onPressed: () {
                if (platformModel.value.id == null) {
                  AppUtils.showToast("请选择场馆");
                  return;
                }
                controller.memberinsert(item,
                    platformId: platformModel.value.id);
                Get.back();
              },
              child: Text(
                "confirm".tr,
                style: TextStyle(fontSize: 14.sp, color: appnewColors.text4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
