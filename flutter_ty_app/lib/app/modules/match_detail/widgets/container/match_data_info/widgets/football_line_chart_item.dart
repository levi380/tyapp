
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_data_model.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// 足球数据折线图 - 单条数据项（标题 + 主队值 + 图标 + 客队值）
///
/// [rowSpaceBetween] 为 true 时内层 Row 使用 spaceBetween，否则 center
class FootballLineChartItem extends StatelessWidget {
  final NewAnalyzeMatchResultItem item;
  final bool rowSpaceBetween;

  const FootballLineChartItem({
    super.key,
    required this.item,
    this.rowSpaceBetween = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item.title,
          style: TextStyle(
            fontWeight: MatchDataState.lineChartTitleFontWeight,
            fontSize: MatchDataState.lineChartTitleFontSize.sp,
            color: Get.theme.resultTextColor,
          ),
        ),
        SizedBox(height: 4.w),
        Row(
          mainAxisAlignment: rowSpaceBetween
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Text(
              '${item.home.toInt()}',
              style: TextStyle(
                fontWeight: MatchDataState.lineChartValueFontWeight,
                fontSize: MatchDataState.lineChartValueFontSize.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
            SizedBox(width: 6.w),
            _buildIcon(item.icon),
            SizedBox(width: 6.w),
            Text(
              '${item.away.toInt()}',
              style: TextStyle(
                fontWeight: MatchDataState.lineChartValueFontWeight,
                fontSize: MatchDataState.lineChartValueFontSize.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIcon(String iconTitle) {
    String iconStr = 'corner.svg';
    if (iconTitle == 'red_card') {
      iconStr = 'red.svg';
    } else if (iconTitle == 'yellow_card') {
      iconStr = 'yellow.svg';
    } else if (iconTitle == 'whistle_img') {
      iconStr = 'whistle.svg';
    } else if (iconTitle == 'time_out_img') {
      iconStr = 'time_out.svg';
    }
    return ImageView(
      'assets/images/bets/$iconStr',
      width: 12.w,
      height: 12.w,
    );
  }
}
