import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/betRecord/betRecordDetail/controllers/bet_record_detail_controller.dart';
import 'package:filbet/src/mine/betRecord/controllers/bet_record_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_decoration.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/filter/filter_bottom_sheet.dart';
import 'package:filbet/widgets/filter/filterBar.dart';
import 'package:filbet/widgets/filter/filter_model.dart';
import 'package:filbet/widgets/filter/date_range_picker.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/home/platform_name_model.dart';
import 'package:filbet/src/mine/betRecord/bet_record_model.dart';

class BetRecordDetailView extends GetView<BetRecordDetailController> {
  const BetRecordDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        title: 'bet_detail'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: Container(
        // margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: appnewColors.shadowBg, // 阴影颜色
              offset: Offset(0, 4), // 阴影偏移 (x, y)
              blurRadius: 1.r, // 模糊程度（越大越柔）
              spreadRadius: 0, // 阴影扩散范围
            ),
          ],
          gradient: LinearGradient(
            colors: [
              const Color(0xff4491FF),
              const Color(0xff86B8FF),
              const Color(0xff86B8FF),
              appnewColors.bg5,
              appnewColors.bg5,
              appnewColors.bg5,
            ],
            begin: Alignment.topCenter, // 从上
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///基本信息
              _buildRecordInfoWidget(0),
              _buildline(),

              ///结算信息
              _buildRecordInfoWidget(1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildline() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 20.w,
      child: Row(
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(radius.r),
              borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(12),
                // bottomLeft: Radius.circular(12),
                topRight: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),

              color: appnewColors.bg5,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            width: Get.width - 40.w - 18 * 2 - 5,
            child: DashedDivider(
              color: appnewColors.colorLine,
              dashWidth: 8,
              dashSpace: 4,
              thickness: 1,
            ),
          ),
          Spacer(),
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(radius.r),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
              ),

              color: appnewColors.bg5,
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildRecordInfoWidget(int index) {
    return Container(
      margin:
          EdgeInsets.only(top: index == 0 ? 10.h : 0, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(radius.r),
        borderRadius: index == 0
            ? BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            : BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
        color: appColors.white,
      ),
      padding: index == 1 ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: 20.w, bottom: 11.h, top: index == 0 ? 20.h : 0),
                child: Row(
                  children: [
                    Image.asset(
                      index == 0 ? Assets.homeJsIcon1 : Assets.homeJsIcon2,
                      width: 18.w,
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        index == 0 ? 'basicInfo'.tr : 'settlementInfo'.tr,
                        style: TextStyle(
                            color: appnewColors.text1,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                )),
            (controller.betRecordItem.value.gameType == "4")
                ? _isSportsfoItem(index)
                : _buildRecordInfoItem(index),
          ],
        ),
      ),
    );
  }

  _isSportsfoItem(index) {
    if (index == 1) {
      return _buildRecordInfoItem(index);
    }

    List<Widget> widgetlist = [];
    if (controller.betRecordItem.value.gameType == "4") {
      List<dynamic> detailList =
          json.decode(controller.betRecordItem.value.detail);

      if (detailList.isEmpty) {
        return [];
      }
      // 如果只取第一个元素
      Map<String, dynamic> detail = detailList[0];
      if (detail.isEmpty) {
        return [];
      }

      widgetlist = [
        Container(
            margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
            padding: EdgeInsets.only(
                top: 10.h, bottom: 5.h, left: 11.w, right: 11.w),
            child: Column(
              children: [
                _buildContextInfoItem(
                    title: 'venue'.tr,
                    context: platformName(
                        controller.betRecordItem.value.platformId)),
                _buildContextInfoItem(
                    title: 'betType'.tr, context: detail["series_value"] ?? ""),
                _buildContextInfoItem(
                    title: 'event'.tr,
                    context: detail["competition_name"] ?? ""),
                _buildContextInfoItem(
                    title: 'matchTeams'.tr,
                    context: detail["event_name"] ?? ""),
                _buildContextInfoItem(
                    title: 'gameplay'.tr, context: detail["bet_type"] ?? ""),
                _buildContextInfoItem(
                    title: 'bet_content'.tr,
                    context: detail["fav_team"] + "@" + detail["odds"]),
              ],
            ))
      ];

      if (detailList.length > 1) {
        for (int i = 1; i < detailList.length; i++) {
          Map<String, dynamic> item = detailList[i];

          widgetlist.addAll([
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 10, right: 10),
              color: Color(0xffCFE9FF),
            ),
            Container(
                margin: EdgeInsets.only(
                  bottom: 10.h,
                  left: 10.w,
                  right: 10.w,
                ),
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 5.h, left: 11.w, right: 11.w),
                child: Column(
                  children: [
                    _buildContextInfoItem(
                        title: 'event'.tr,
                        context: item["competition_name"] ?? ""),
                    _buildContextInfoItem(
                        title: 'matchTeams'.tr,
                        context: item["event_name"] ?? ""),
                    _buildContextInfoItem(
                        title: 'gameplay'.tr, context: item["bet_type"] ?? ""),
                    _buildContextInfoItem(
                        title: 'bet_content'.tr,
                        context: item["fav_team"] + "@" + item["odds"]),
                  ],
                ))
          ]);

          // 也可以构建 UI、模型等
        }
      }
    }

    return Container(
        // margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        // padding:
        //     EdgeInsets.only(top: 20.h, bottom: 5.h, left: 11.w, right: 11.w),
        // decoration: BoxDecoration(
        //   color: appColors.bgColor,
        //   borderRadius: BorderRadius.circular(12.r),
        // ),
        child: Column(
      children: widgetlist,
    ));
  }

  List<Widget> body() {
// 0所有 1视讯 2捕鱼 3老虎机 4体育 棋牌 7bingo

    // 如果只取第一个元素

    if (controller.betRecordItem.value.gameType == "5") {
      Map<String, dynamic> detail = {};
      try {
        detail = json.decode(controller.betRecordItem.value.detail);
      } catch (e) {}

      return [
        _buildContextInfoItem(
            title: 'venue'.tr,
            context: platformName(controller.betRecordItem.value.platformId)),
        _buildContextInfoItem(
            title: 'game'.tr, context: controller.betRecordItem.value.gameName),
        if (detail.isNotEmpty)
          _buildContextInfoItem(
              title: 'roundNumber'.tr, context: detail["game_table"] ?? ""),
      ];
    } else if (controller.betRecordItem.value.gameType == "1") {
      if (controller.betRecordItem.value.detail == "[]") {
        return [];
      }
      Map<String, dynamic> detail =
          json.decode(controller.betRecordItem.value.detail);
      if (detail.isEmpty) {
        return [];
      }

      return [
        _buildContextInfoItem(
            title: 'venue'.tr,
            context: platformName(controller.betRecordItem.value.platformId)),
        _buildContextInfoItem(
            title: 'gameTable'.tr, context: detail["table_code"] ?? ""),
        _buildContextInfoItem(
            title: 'bet_content'.tr, context: detail["bet_area"] ?? ""),
        _buildContextInfoItem(
            title: 'odds'.tr, context: '${detail["odds"] ?? ""}'),
        _buildContextInfoItem(
            title: 'roundResult'.tr, context: detail["bet_result"] ?? ""),
        _buildContextInfoItem(
            title: 'rounds'.tr, context: detail["round_count"] ?? ""),
      ];
    } else if (controller.betRecordItem.value.gameType == "3" ||
        controller.betRecordItem.value.gameType == "7") {
      return [
        _buildContextInfoItem(
            title: 'venue'.tr,
            context: platformName(controller.betRecordItem.value.platformId)),
        _buildContextInfoItem(
            title: 'game'.tr, context: controller.betRecordItem.value.gameName),
        _buildContextInfoItem(
            title: 'roundNumber'.tr,
            context: controller.betRecordItem.value.roundid),
      ];
    }

    return [
      _buildContextInfoItem(
          title: 'venue'.tr,
          context: platformName(controller.betRecordItem.value.platformId)),
      _buildContextInfoItem(
          title: 'game'.tr, context: controller.betRecordItem.value.gameName),
      _buildContextInfoItem(
          title: 'roundNumber'.tr,
          context: controller.betRecordItem.value.roundid),
    ];
  }

  Widget _buildRecordInfoItem(int index) {
    final isSettlement =
        double.tryParse(controller.betRecordItem.value.netAmount) != null;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
      padding: EdgeInsets.only(top: 10, bottom: 5.h, left: 11.w, right: 11.w),
      child: Column(
        children: index == 0
            ? body()
            : [
                _buildContextInfoItem(
                  title: 'bet'.tr,
                  context: controller.betAmount,
                  textStyle: appColors.textMainStyle_12_500,
                ),
                _buildContextInfoItem(
                  title: 'valid_bet'.tr,
                  context: controller.betRecordItem.value.betRecordType ==
                          BetRecordType.settled
                      ? controller.validBetAmount
                      : "--",
                  textStyle: appColors.textMainStyle_12_500,
                ),
                _buildContextInfoItem(
                  title: 'win_loss'.tr,
                  context: controller.betRecordItem.value.betRecordType ==
                          BetRecordType.settled
                      ? controller.winOrLost
                      : "--",
                  textStyle: controller.isWin
                      ? appColors.textGreenStyle_12_500
                      : appColors.textMainStyle_12_500,
                ),
                _buildContextInfoItem(
                    title: 'order_status'.tr, context: controller.settleResult),
                _buildContextInfoItem(
                    title: 'order_no'.tr,
                    context:
                        controller.betRecordItem.value.bill_no_hash.toString(),
                    isShowCopy: true),
                _buildContextInfoItem(
                    title: 'bet_time'.tr, context: controller.betTime),
                if (controller.betRecordItem.value.betRecordType.code == 1)
                  _buildContextInfoItem(
                      title: 'settle_time'.tr, context: controller.settleTime),
                _buildContextInfoItem(
                    title: 'stat_time'.tr,
                    context: controller.statisticsTime,
                    bottom: 5.h),
              ],
      ),
    );
  }

  ///文本左右排版信息
  Widget _buildContextInfoItem({
    required String title,
    String? context,
    TextStyle? textStyle,
    double? bottom,
    bool isShowCopy = false,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: bottom ?? 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: appnewColors.text2, fontSize: 12.sp),
          ),
          SizedBox(width: 12.w),
          isShowCopy
              ? Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          context ?? '',
                          style: textStyle ??
                              TextStyle(
                                  color: appnewColors.text1, fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      InkWell(
                        onTap: () {
                          if (context == null || context.isEmpty) {
                            return;
                          }

                          // 复制注单号到剪切板
                          Clipboard.setData(ClipboardData(text: context));

                          AppUtils.showToast(
                            "copy_success_text".tr,
                          );
                        },
                        child: Image.asset(
                          Assets.mineCopyOrder,
                          width: 14.w,
                          height: 17.w,
                        ),
                      )
                    ],
                  ),
                )
              : Flexible(
                  child: Text(
                    context ?? '',
                    style: textStyle ??
                        TextStyle(color: appnewColors.text1, fontSize: 12.sp),
                  ),
                ),
        ],
      ),
    );
  }

  platformName(String pid) {
    for (PlatFormNameModel element
        in GlobalService.to.state.allPlatformNameConfig) {
      print('element.platformId = ${element.id} (${pid})');
      if (element.id == pid) {
        return element.name ?? "";
      }
    }
    return "";
  }
}

class DashedDivider extends StatelessWidget {
  final double height; // 线条高度
  final double dashWidth; // 每个短线宽度
  final double dashSpace; // 短线间隔
  final Color color; // 颜色
  final double thickness; // 粗细

  const DashedDivider({
    super.key,
    this.height = 1,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.color = Colors.grey,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedLinePainter(
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          color: color,
          thickness: thickness,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final double thickness;

  _DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
