import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../models/analysis/analysis_model.dart';

/// 历史表现 Item 行 - 右侧 name4 文本列
class MatchStatic2ItemChartItem3Right extends StatelessWidget {
  final GridListDataBean bean;

  const MatchStatic2ItemChartItem3Right({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 32.w,
              height: 18.w,
              child: Text(
                bean.name4,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 11.sp,
                  fontWeight: FontWeight.w700,
                  color: Get.theme.tabPanelSelectedColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
