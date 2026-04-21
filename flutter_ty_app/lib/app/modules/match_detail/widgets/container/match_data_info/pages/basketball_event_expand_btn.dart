import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../common_widget/analysis_common_widget/item/analyze_divider.dart';

/// 篮球事件页 - 展开/收起按钮
class BasketballEventExpandBtn extends StatelessWidget {
  final MatchDataController controller;

  const BasketballEventExpandBtn({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnalyzeDivider(),
        SizedBox(height: 12.w),
        InkWell(
          onTap: () => controller.setExpandImport(),
          child: Center(
            child: Container(
              height: 23.w,
              decoration: BoxDecoration(
                border: Border.all(color: Get.theme.betItemTabSelectedColor),
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.state.isExpandImport
                        ? LocaleKeys.bet_pack_up.tr
                        : LocaleKeys.bet_record_pack_down.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Get.theme.betItemTabSelectedColor,
                    ),
                  ),
                  Icon(
                    controller.state.isExpandImport
                        ? Icons.arrow_drop_up_rounded
                        : Icons.arrow_drop_down_rounded,
                    size: 23.w,
                    fill: 1,
                    color: Get.theme.betItemTabSelectedColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
