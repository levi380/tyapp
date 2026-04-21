import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../models/analysis/analysis_model.dart';

/// 正面交手圆形进度条 - 右侧标签列（名称 + 说明）
class AnalyzeStatisticCircleProgressLabel extends StatelessWidget {
  final GridColorBean item;

  const AnalyzeStatisticCircleProgressLabel({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100.w),
                child: Text(
                  item.name2,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.w),
          Container(
            constraints: BoxConstraints(maxWidth: 100.w),
            child: Text(
              item.name3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Get.theme.oddsTeamNameFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
