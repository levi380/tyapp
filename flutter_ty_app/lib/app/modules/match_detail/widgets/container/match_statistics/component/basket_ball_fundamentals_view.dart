import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import '../../../../../login/login_head_import.dart';
import 'basket_ball_history_war_widget.dart';
import 'basket_ball_recent_war_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球本赛季数据
    】】】
 *
 */
/// 篮球基础数据视图
/// 用于展示篮球比赛的历史交战和近期战绩数据
class BasketBallFundamentalsView extends StatefulWidget {
  /// 构造函数
  /// [tag] 控制器标签，用于标识不同的控制器实例
  BasketBallFundamentalsView({required this.tag});

  /// 控制器标签
  final String tag;

  @override
  State<BasketBallFundamentalsView> createState() =>
      _BasketBallFundamentalsViewState();
}

/// 篮球基础数据视图状态类
class _BasketBallFundamentalsViewState
    extends State<BasketBallFundamentalsView> {
  /// 构建主视图
  /// 返回包含历史交战和近期战绩的列表视图
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeasonStatisticController>(
      tag: widget.tag,
      init: SeasonStatisticController(tag: widget.tag),
      builder: (controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          alignment: Alignment.topCenter,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // 历史交战
              BasketBallHistoryWarWidget.build(
                controller: controller,
                tag: widget.tag,
              ),
              // 近期战绩
              BasketBallRecentWarWidget.build(
                controller: controller,
                tag: widget.tag,
              ),
            ],
          ),
        );
      },
    );
  }
}
