import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../services/models/res/analyze_match_information_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 下拉赛事选择项
    】】】
 *
 */
class MatchMarketItem extends StatelessWidget {
  final AnalyzeMatchInformationEntity? sThirdMatchInformationDTOList;
  final int index;
  MatchMarketItem(this.index, this.sThirdMatchInformationDTOList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 28.w),
      alignment: Alignment.center,
      child: Text(
        sThirdMatchInformationDTOList!.content.toString(),
        style: TextStyle(
          color: Get.theme.tabPanelSelectedColor,
          fontSize: isIPad ? 16.sp : 12.sp,
        ),
      ),
    );
  }
}
