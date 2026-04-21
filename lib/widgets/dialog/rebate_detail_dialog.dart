import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/vip/models/resp_vip_rate_detail.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RebateDetailDialog extends StatelessWidget {
  RebateDetailDialog(
      {super.key, required this.platformName, required this.models});

  final String platformName;
  final List<VipRateDetail> models;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            contentView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      height: 48.r,
      decoration: BoxDecoration(
        color: appnewColors.bg,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.r),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              '$platformName${'rebate_detail'.tr}',
              style: TextStyle(
                color: appnewColors.textWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(16.r),
                child: Image.asset(
                  Assets.imagesCloseWhite,
                  width: 13.r,
                  height: 13.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentView() {
    Map<int, IntrinsicColumnWidth> columnWidths = {};
    for (int index = 0; index <= models.length; index++) {
      columnWidths[index] = IntrinsicColumnWidth();
    }
    return Container(
      padding: EdgeInsets.all(10.r),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // 设置横向滚动
        child: Table(
          border: TableBorder.all(color: appnewColors.colorLine, width: 1),
          columnWidths: columnWidths,
          children: buildTableRowView(),
        ),
      ),
    );
  }

  List<TableRow> buildTableRowView() {
    return [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((value) {
      return TableRow(
        children: buildTableRowChildren(value),
      );
    }).toList();
  }

  List<Widget> buildTableRowChildren(int index) {
    List<Widget> widgets = models.map((value) {
      return Container(
        height: 32.r,
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        color: index == -1 ? appnewColors.bg5 : null,
        alignment: Alignment.center,
        child: Text(
          index == -1
              ? value.name ?? ''
              : '${convertRebate(value.rebateRates, index)}%',
          style: TextStyle(
            color: appnewColors.text1,
            fontSize: 14.sp,
          ),
        ),
      );
    }).toList();
    widgets.insert(
      0,
      Container(
        height: 32.r,
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        color: index == -1 ? appnewColors.bg5 : null,
        alignment: Alignment.center,
        child: Text(
          index == -1 ? "VIP${"vip_level".tr}" : "VIP$index",
          style: TextStyle(
            color: appnewColors.text1,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
    return widgets;
  }

  String convertRebate(RebateRates? maxRebateRates, int index) {
    switch (index) {
      case 0:
        return maxRebateRates?.zero.toString() ?? '';
      case 1:
        return maxRebateRates?.one.toString() ?? '';
      case 2:
        return maxRebateRates?.two.toString() ?? '';
      case 3:
        return maxRebateRates?.three.toString() ?? '';
      case 4:
        return maxRebateRates?.four.toString() ?? '';
      case 5:
        return maxRebateRates?.five.toString() ?? '';
      case 6:
        return maxRebateRates?.six.toString() ?? '';
      case 7:
        return maxRebateRates?.seven.toString() ?? '';
      case 8:
        return maxRebateRates?.eight.toString() ?? '';
      case 9:
        return maxRebateRates?.nine.toString() ?? '';
      case 10:
        return maxRebateRates?.ten.toString() ?? '';
      default:
        return '';
    }
  }
}
