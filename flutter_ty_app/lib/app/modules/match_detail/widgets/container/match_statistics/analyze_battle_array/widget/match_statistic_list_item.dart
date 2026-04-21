import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/main.dart';

/// 正面交手列表单行
///
/// 展示一条历史交手：日期、主队名+图标、比分、客队名+图标
/// [record] 为该条交手数据；[leftUrl]/[rightUrl] 为主客队图标；[leftTeamName]/[rightTeamName] 用于与 record 主客队对应
class MatchStatisticListItem extends StatelessWidget {
  final List<AnalyzeTeamVsHistoryEntity> record;
  final String? leftUrl;
  final String? rightUrl;
  final String? leftTeamName;
  final String? rightTeamName;

  const MatchStatisticListItem({
    super.key,
    required this.record,
    this.leftUrl,
    this.rightUrl,
    this.leftTeamName,
    this.rightTeamName,
  });

  @override
  Widget build(BuildContext context) {
    if (record.isEmpty) return const SizedBox.shrink();
    final item = record.first;
    final errorImageLeft = (leftTeamName == item.homeTeamName)
        ? 'assets/images/detail/default_team_home.svg'
        : 'assets/images/detail/default_team_away.svg';
    final errorImageRight = (rightTeamName == item.homeTeamName)
        ? 'assets/images/detail/default_team_home.svg'
        : 'assets/images/detail/default_team_away.svg';

    return Container(
      alignment: Alignment.center,
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.centerLeft,
              child: Text(
                FormatDate.formatDate(
                  int.tryParse(item.beginTime ?? '0') ?? 0,
                  formatString: 'yyyy/MM/dd',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 12.sp,
                  color: Get.theme.oddsTeamNameFontColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => ToastUtils.show(item.homeTeamName ?? ''),
                  child: SizedBox(
                    width: 60.w,
                    child: Text(
                      item.homeTeamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isIPad ? 15.sp : 12.sp,
                        color: Get.theme.tabPanelSelectedColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  width: 24.w,
                  height: 24.w,
                  alignment: Alignment.center,
                  child: ImageView(
                    leftUrl ?? '',
                    isLocalImage: false,
                    cdn: true,
                    width: 24.w,
                    height: 24.w,
                    errorWidget: ImageView(
                      errorImageLeft,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${item.homeTeamScore}- ${item.awayTeamScore}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 11.sp,
                  color: Get.theme.tabPanelSelectedColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: ImageView(
                    rightUrl ?? '',
                    boxFit: BoxFit.fill,
                    width: 24.w,
                    height: 24.w,
                    isLocalImage: false,
                    cdn: true,
                    errorWidget: ImageView(
                      errorImageRight,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                InkWell(
                  onTap: () => ToastUtils.show(item.awayTeamName ?? ''),
                  child: SizedBox(
                    width: 60.w,
                    child: Text(
                      item.awayTeamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isIPad ? 15.sp : 12.sp,
                        color: Get.theme.tabPanelSelectedColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
