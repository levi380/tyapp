import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../models/analysis/analysis_model.dart';
import 'match_static2_item_chart_item3_center.dart';
import 'match_static2_item_chart_item3_right.dart';

/**
 * 历史表现 - Item 数据行
 *
 * 【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT - 历史表现-Item数据 】】】
 */
class MatchStatic2ItemChartItem3 extends StatelessWidget {
  const MatchStatic2ItemChartItem3(this.gridListDataBean, {super.key});

  final GridListDataBean gridListDataBean;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 25.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${gridListDataBean.name1}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 11.sp,
                  color: Get.theme.tabPanelSelectedColor,
                ),
              ),
            ),
          ),
          MatchStatic2ItemChartItem3Center(bean: gridListDataBean),
          MatchStatic2ItemChartItem3Right(bean: gridListDataBean),
        ],
      ),
    );
  }
}
