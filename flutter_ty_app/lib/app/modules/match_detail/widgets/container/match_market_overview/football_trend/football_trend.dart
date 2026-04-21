import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/football_trend/football_trend_head.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/football_trend/football_trend_line_chart.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_market_overview/football_trend/football_trend_remark.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球走势
    】】】
 *
 */
class FootballTrend extends StatefulWidget {
  const FootballTrend({super.key, required this.tag});

  final String tag;

  @override
  State<FootballTrend> createState() => _FootballTrendState();
}

class _FootballTrendState extends State<FootballTrend> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          FootballTrendHead(tag: widget.tag),
          FootballTrendLineChart(tag: widget.tag),
          FootballTrendRemark(tag: widget.tag),
          Padding(padding: EdgeInsets.only(bottom: 80.w)),
        ],
      ),
    );
  }
}
