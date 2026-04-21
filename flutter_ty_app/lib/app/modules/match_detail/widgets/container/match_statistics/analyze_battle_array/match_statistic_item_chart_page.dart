import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
import 'package:flutter_ty_app/app/utils/extension.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';


import 'widget/match_statistic_header_widget.dart';
import 'widget/match_statistic_grid_widget.dart';
import 'widget/match_statistic_list_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 正面交手页面
    】】】
 *
 */
class MatchStatisticItemChartPage extends StatefulWidget {
  MatchStatisticItemChartPage({super.key, required this.tag});

  final String tag;

  @override
  State<MatchStatisticItemChartPage> createState() =>
      _MatchStatisticItemChartPageState();
}

class _MatchStatisticItemChartPageState
    extends State<MatchStatisticItemChartPage> {
  /// 构建主视图
  /// 组合头部、网格和列表组件，形成完整的正面交手页面
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchStatisticController>(
      tag: widget.tag,
      builder: (controller) {
        return Container(
          color: Get.theme.tabPanelBackgroundColor,
          alignment: Alignment.centerLeft,
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              // 头部组件：显示比赛队伍和比赛信息
              MatchStatisticHeaderWidget.build(
                controller: controller,
                tag: widget.tag,
              ).sliver,

              // 网格组件：显示统计数据网格
              MatchStatisticGridWidget.build(
                controller: controller,
                context: context,
              ).sliver,
              
              // 以往数据标题
              if (controller.state.pageList.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  ${LocaleKeys.analysis_football_matches_past_data.tr}",
                    style: TextStyle(
                        fontSize: TyTextScaler.instance().scale(14.sp),
                        color: AppColor.color303442),
                  ),
                ).sliver,

              SizedBox(
                height: 16.w,
              ).sliver,
              
              // 列表组件：显示历史交手记录
              MatchStatisticListWidget.build(
                controller: controller,
                tag: widget.tag,
              ).sliver,
            ],
          ),
        );
      },
    );
  }

}
