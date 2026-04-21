import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import '../helpers/match_stage_content_helper.dart';

/// 赛事阶段显示Widget
/// 封装了赛事阶段、开赛时间以及倒计时等信息的显示
class MatchStageDisplayWidget extends StatelessWidget {
  /// 赛事实体
  final MatchEntity? match;
  
  /// 赛事阶段内容辅助类
  final MatchStageContentHelper contentHelper;

  /// 构造函数
  /// [match] 赛事实体
  /// [contentHelper] 赛事阶段内容辅助类
  const MatchStageDisplayWidget({
    super.key,
    required this.match,
    required this.contentHelper,
  });

  /// 构建赛事阶段显示内容
  /// 返回包含赛事阶段、开赛时间以及倒计时等信息的Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 展示赛事阶段，开赛时间以及倒计时等
          if (match?.ms != 110) MatchStage(match: match!, isMatchSelect: true),
          SizedBox(height: isIPad ? 8.h : 4.h),
          // 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
          // 比赛分数or开赛时间
          if (contentHelper.getMatchStageContentBottom() != "")
            Column(
              children: [
                AutoSizeText(
                  contentHelper.getMatchStageContentBottom(),
                  maxLines: 1,
                  style: TextStyle(
                    color: Get.theme.tabIndicatorColor,
                    fontSize: 12.sp,
                    fontFamily: 'Akrobat',
                    fontWeight:
                        match?.ms != 110 ? FontWeight.w700 : FontWeight.w300,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}