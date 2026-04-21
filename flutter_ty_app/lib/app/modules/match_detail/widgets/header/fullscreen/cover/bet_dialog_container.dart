import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../controllers/match_tools_methods.dart';
import '../../../container/odds_info_container.dart';
import '../../../tab/bet_mode_tab_widget.dart';

/**
 * 【【【 AUTO_DOCUMENT_MENU 投注弹窗容器组件 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 全屏投注弹窗容器 】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 投注弹窗容器组件 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 全屏模式下显示投注弹窗的容器组件
 * - 包含比分展示、玩法Tab切换和投注列表三部分
 * - 根据是否有状态栏自动调整布局和尺寸
 * - 使用SafeArea确保在刘海屏设备上的正常显示
 * 】】】
 */
class BetDialogContainer extends StatelessWidget {
  /// 比赛数据实体，包含对阵双方信息、比分等
  final MatchEntity match;

  /// 页面唯一标识tag，用于区分不同实例的状态管理
  final String tag;

  /// 当前方向是否有状态栏
  /// true: 横屏时状态栏在左侧或右侧
  /// false: 横屏时状态栏在上方或下方
  final bool hasStatusBar;

  const BetDialogContainer({
    super.key,
    required this.match,
    required this.tag,
    required this.hasStatusBar,
  });

  @override
  Widget build(BuildContext context) {
    // 计算弹窗宽度：基础宽度375 + 状态栏高度（如果有状态栏）
    // 注：横屏时状态栏可能在一侧，需要为状态栏留出空间
    double width = 375 + (hasStatusBar ? MediaQuery.of(context).padding.top : 0);

    return Container(
      height: 1.sh, // 使用屏幕高度
      width: width,
      // 布局内边距，右侧根据是否有状态栏调整
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        // 如果有状态栏，右侧留出状态栏高度的空间，避免内容被状态栏遮挡
        right: hasStatusBar ? Get.statusBarHeight : 16,
      ),
      color: Colors.transparent,
      child: SafeArea(
        // 禁用左侧、顶部、右侧的安全区域，因为这些位置已经有内边距处理
        left: false,
        top: false,
        right: false,
        child: Column(
          children: [
            // 比分展示行
            _buildScoreRow(),
            const SizedBox(height: 6), // 间距
            // 玩法模式Tab切换组件
            BetModeTab(tag: tag, fullscreen: true),
            // 投注信息列表容器，使用Expanded占满剩余空间
            Expanded(child: OddsInfoContainer(tag: tag, refresh: true)),
          ],
        ),
      ),
    );
  }

  /// 【【【构建比分展示行】】】
  /// 显示主队名、比分、客队名，居中布局
  Widget _buildScoreRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTeamName(match.mhn, rightMargin: 16), // 主队名，右边距16
        _buildScoreText(), // 比分文本
        _buildTeamName(match.man, leftMargin: 16), // 客队名，左边距16
      ],
    );
  }

  /// 【【【构建队伍名称Widget】】】
  /// @param name 队伍名称
  /// @param leftMargin 左边距
  /// @param rightMargin 右边距
  /// @return 限制宽度的队伍名称文本组件
  Widget _buildTeamName(String name, {double? leftMargin, double? rightMargin}) {
    return SizedBox(
      width: 120, // 固定宽度，避免名称过长影响布局
      child: Text(
        name,
        maxLines: 1, // 单行显示
        overflow: TextOverflow.ellipsis, // 超出显示省略号
        // 根据是否有右边距决定文本对齐方式
        // 有右边距说明是主队名，右对齐；没有右边距说明是客队名，左对齐
        textAlign: rightMargin != null ? TextAlign.right : TextAlign.left,
        style: _teamNameStyle,
      ).marginOnly(left: leftMargin ?? 0, right: rightMargin ?? 0),
    );
  }

  /// 【【【构建比分文本】】】
  /// 根据比赛状态显示不同内容：
  /// 1. 电竞比赛中：显示"进行中"
  /// 2. 非电竞且比赛未开始(ms=110)：显示"vs"
  /// 3. 其他情况：显示实际比分
  Widget _buildScoreText() {
    // 判断是否为电竞比赛且正在进行
    bool isEportsScoring = eSportsScoring(match);
    // 获取比分文本
    final score = isEportsScoring
        ? LocaleKeys.mmp_eports_scoring.tr // 电竞进行中
        : match.ms != 110 ? getMsc(match.msc) : "vs"; // 非电竞：有比分显示比分，无比分显示vs

    return Text(
      score,
      style: _scoreStyle,
    );
  }

  /// 【【【队伍名称文本样式】】】
  /// - 颜色：白色
  /// - 字号：14
  /// - 字体：PingFang SC（中文字体）
  /// - 字重：500（中等）
  static const TextStyle _teamNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'PingFang SC',
    fontWeight: FontWeight.w500,
  );

  /// 【【【比分文本样式】】】
  /// - 颜色：白色
  /// - 字号：14
  /// - 字体：PingFang HK（中文字体，适用于比分数字）
  /// - 字重：600（半粗），比分需要更突出显示
  static const TextStyle _scoreStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'PingFang HK',
    fontWeight: FontWeight.w600,
  );
}