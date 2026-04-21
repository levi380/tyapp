import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_market_overview_logic.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';

/// 足球走势 - 走势图区域
///
/// 使用 Echarts 展示 [chartMap]；Windows 下显示“不支持”，无数据时显示 [NoData]。
class FootballTrendLineChart extends StatelessWidget {
  const FootballTrendLineChart({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
      id: 'getLineChart',
      tag: tag,
      builder: (controller) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 480.w,
          child: controller.state.chartMap == null
              ? NoData(top: 30.h)
              : (Platform.isWindows
                  ? Container(
                      child: Text(
                        'window不支持',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: context.isDarkMode
                              ? MatchMarketOverviewState.footballTrendTextColorDark
                              : MatchMarketOverviewState.footballTrendTextColorLight,
                        ),
                      ),
                    )
                  : Echarts(
                      option: jsonEncode(controller.state.chartMap),
                    )),
        );
      },
    );
  }
}
