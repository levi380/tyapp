import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../controllers/statistic/history_performance_controller.dart';
import 'history_performance_content.dart';

/// 历史表现页面
/// 
/// 负责显示赛事的历史表现数据，包括：
/// - 标签页切换（主场/客场）
/// - 队伍信息展示
/// - 历史数据列表
/// - 数据趋势图表
class HistoryPerformancePage extends StatefulWidget {
  /// 赛事标识
  final String tag;
  
  /// 是否为电子足球
  final bool isElectronicFootball;

  HistoryPerformancePage(
      {super.key, required this.tag, required this.isElectronicFootball});

  @override
  State<StatefulWidget> createState() {
    return HistoryPerformancePageState();
  }
}

/// 历史表现页面状态类
/// 
/// 负责管理页面的状态和构建主界面结构
class HistoryPerformancePageState extends State<HistoryPerformancePage> {
  /// 构建主界面
  /// 
  /// 包含：
  /// - 标签栏（主场/客场切换）
  /// - 标签页内容区域
  /// 
  /// 返回包含完整历史表现页面的 Widget
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryPerformanceController>(
        tag: widget.tag,
        init: HistoryPerformanceController(tag: widget.tag),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 标签栏

              SizedBox(
                height: 8.w,
              ),
              // 标签页内容区域
              Expanded(
                  child: HistoryPerformanceContent.buildPageView1(
                      controller, widget.tag, widget.isElectronicFootball))
            ],
          );
        });
  }
}
