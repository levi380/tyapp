import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../../login/login_head_import.dart';

/// 篮球历史交战列表头部组件
/// 用于显示历史交战列表的表头，包括赛果、让球、大小等列标题
class BasketBallHistoryWarListHeadWidget {
  /// 构建历史交战列表头部
  /// 返回包含列标题的容器组件
  static Widget build() {
    Map<int, String> map = {
      0: LocaleKeys.analysis_football_matches_results.tr,
      1: LocaleKeys.analysis_football_matches_turn_around.tr,
      2: LocaleKeys.analysis_football_matches_size.tr,
    };

    return Container(
      height: 34.w,
      decoration: BoxDecoration(
        color: Get.theme.tabPanelHeadColor,
        border: Border.symmetric(
          horizontal: BorderSide(color: MatchStatisticMatchHistoryState.borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _buildHeaderColumn(
                  map[0] ??
                      LocaleKeys.types_competitions_menu_itme_name_results.tr,
                ),
                _buildHeaderColumn(
                  map[1] ??
                      LocaleKeys.types_competitions_menu_itme_name_results.tr,
                ),
                _buildHeaderColumn(
                  map[2] ??
                      LocaleKeys.types_competitions_menu_itme_name_results.tr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建表头列
  /// [text] 列标题文本
  /// 返回包含文本的扩展组件
  static Widget _buildHeaderColumn(String text) {
    return Expanded(
      child: Container(
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text,
          style: TextStyle(
            fontSize: isIPad
                ? MatchStatisticMatchHistoryState.basketBallHistoryWarListHeadFontSizeIPad.sp
                : MatchStatisticMatchHistoryState.basketBallHistoryWarListHeadFontSize.sp,
            color: Get.theme.dataContainerTextColor,
          ),
        ),
      ),
    );
  }
}

