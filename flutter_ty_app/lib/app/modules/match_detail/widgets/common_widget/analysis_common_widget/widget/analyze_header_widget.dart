import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../result/widgets/results_index_widget.dart';
import 'helpers/match_countdown_helper.dart';
import 'helpers/match_stage_content_helper.dart';
import 'widgets/match_stage_display_widget.dart';
import 'widgets/team_info_widget.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛积分 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事分析（比分、时间、赛事阶段）头部控件
    】】】
 *
 */
class AnalyzeHeaderWidget extends StatefulWidget {
  final String? leftCenterName;
  final String? rightCenterName;
  final bool? showCenter;

  AnalyzeHeaderWidget({
    super.key,
    required this.tag,
    this.showCenter,
    this.leftCenterName,
    this.rightCenterName,
  });

  final String tag;

  @override
  State<AnalyzeHeaderWidget> createState() => _AnalyzeHeaderWidgetState();
}

class _AnalyzeHeaderWidgetState extends State<AnalyzeHeaderWidget> {
  /// 赛事实体
  MatchEntity? match;

  /// 倒计时辅助类
  MatchCountdownHelper? _countdownHelper;

  /// 赛事阶段内容辅助类
  MatchStageContentHelper? _contentHelper;

  @override
  void initState() {
    super.initState();
    _initializeMatchData();
    _initializeCountdown();
    _registerEventListeners();
  }

  /// 初始化赛事实体数据
  /// 从控制器中获取赛事实体
  void _initializeMatchData() {
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: widget.tag);
    match = detailController.detailState.match;
  }

  /// 初始化倒计时
  /// 创建倒计时辅助类并启动倒计时
  void _initializeCountdown() {
    _countdownHelper = MatchCountdownHelper(
      match: match,
      isMounted: () => mounted,
      isScrolling: () => isScrolling,
      onStateUpdate: () {
        if (mounted) {
          setState(() {
            // 更新内容辅助类
            _updateContentHelper();
          });
        }
      },
    );
    _countdownHelper?.initEvent();
    _updateContentHelper();
  }

  /// 更新内容辅助类
  /// 根据倒计时状态更新赛事阶段内容辅助类
  void _updateContentHelper() {
    _contentHelper = MatchStageContentHelper(
      match: match,
      startTime: _countdownHelper?.startTime ?? false,
      longTime: _countdownHelper?.longTime ?? "",
    );
  }

  /// 注册事件监听器
  /// 监听联赛修改等事件，触发倒计时重新初始化
  void _registerEventListeners() {
    // 联赛修改触发初始化
    Bus.getInstance().on(EventType.matchTimeInit, (_) {
      _countdownHelper?.initEvent();
      _updateContentHelper();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _countdownHelper?.dispose();
    Bus.getInstance().off(EventType.matchTimeInit);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnalyzeHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果赛事实体发生变化，可以在这里重新初始化
    // if (oldWidget.match?.mgt != match?.mgt) {
    //   _countdownHelper?.initEvent();
    // }
  }

  /// 构建主Widget
  /// 返回包含球队信息和赛事阶段的Stack布局
  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return const SizedBox.shrink();
    }

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildVsTeam(match!),
        ],
      ),
    );
  }

  /// 构建VS球队布局
  /// 包含主队、客队信息以及中间的赛事阶段显示
  /// [match] 赛事实体
  Widget _buildVsTeam(MatchEntity match) {
    // 判断是否为点球大战
    bool isShootout = (["34", "50", "120"].contains(match.mmp) ||
        match.mscMap.containsKey("S170"));

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 主队信息
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TeamInfoWidget(
                    teamType: 1,
                    match: match,
                    tag: widget.tag,
                    centerName: widget.leftCenterName,
                    isShootout: isShootout,
                  ),
                ],
              ),
            ),
            // 客队信息
            Expanded(
              child: TeamInfoWidget(
                teamType: 2,
                match: match,
                tag: widget.tag,
                centerName: widget.rightCenterName,
                isShootout: isShootout,
              ),
            ),
          ],
        ),
        // 中间的赛事阶段显示
        if (widget.showCenter == true && _contentHelper != null)
          Center(
            child: MatchStageDisplayWidget(
              match: match,
              contentHelper: _contentHelper!,
            ),
          ),
      ],
    );
  }
}
