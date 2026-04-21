import 'package:common_utils/common_utils.dart';
import 'package:filbet/src/mine/controllers/mine_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_rebate_controller.dart';
import 'package:filbet/src/mine/vip/models/member_vip_rate.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HorizontalScrollableTable extends StatelessWidget {
  HorizontalScrollableTable({super.key});

  final VipRebateController controller = Get.find();
  final MineController mineLogic = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.platformList.isEmpty) {
        return Container();
      }
      int cols = 11;
//行数，对应的是有多少级vip
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // 设置横向滚动
        child: DataTable(
            columnSpacing: 20.0,
            dividerThickness: 0.01,
            // 设置行分割线厚度为0，去除分割线
            border: TableBorder.all(width: 1, color: Colors.transparent),
            columns: [
              DataColumn(
                  label: Container(
                      width: 66.w,
                      child: Text("VIP${"vip_level".tr}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp)))),
              ...controller.platformList
                  .map(
                    (el) => DataColumn(
                        label: Container(
                      width: 66.w,
                      child: Text(el.platformName ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    )),
                  )
                  .toList()
            ],
            rows: List.generate(cols, (index) {
              return DataRow(
                  color: WidgetStateProperty.all(
                      index % 2 == 0 ? appColors.white : Colors.transparent),
                  cells: [
                    DataCell(
                      Container(
                        width: 66.w,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/new/mine/vip_bonus_level_$index${index == (mineLogic.vipInfo.value?.currentLevel ?? 0) ? "_sel" : ""}.webp",
                                width: 24.w),
                            Text(
                              "VIP$index",
                              style: TextStyle(
                                  color: index ==
                                          (mineLogic.vipInfo.value
                                                  ?.currentLevel ??
                                              0)
                                      ? appColors.borderMain2Color
                                      : appColors.textMainColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...controller.platformList
                        .map((subEl) => DataCell(
                              onTap: () {
                                controller.queryMemberVipRebateGames(
                                    subEl.platformName ?? '',subEl.platformId ?? '');
                              },
                              Container(
                                width: 66.w,
                                alignment: Alignment.center,
                                child: Text(
                                  "${toStringAsFixed2(convertRebate(subEl.maxRebateRates, index))}%",
                                  style: TextStyle(
                                      color: index ==
                                              (mineLogic.vipInfo.value
                                                      ?.currentLevel ??
                                                  0)
                                          ? appColors.borderMain2Color
                                          : appColors.textMainColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList()
                  ]);
            })),
      );
    });
  }

  String convertRebate(MaxRebateRates? maxRebateRates, int index) {
    switch (index) {
      case 0:
        return maxRebateRates?.zero ?? '';
      case 1:
        return maxRebateRates?.one ?? '';
      case 2:
        return maxRebateRates?.two ?? '';
      case 3:
        return maxRebateRates?.three ?? '';
      case 4:
        return maxRebateRates?.four ?? '';
      case 5:
        return maxRebateRates?.five ?? '';
      case 6:
        return maxRebateRates?.six ?? '';
      case 7:
        return maxRebateRates?.seven ?? '';
      case 8:
        return maxRebateRates?.eight ?? '';
      case 9:
        return maxRebateRates?.nine ?? '';
      case 10:
        return maxRebateRates?.ten ?? '';
      default:
        return '';
    }
  }
}
