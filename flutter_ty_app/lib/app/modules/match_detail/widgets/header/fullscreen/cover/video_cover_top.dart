import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../controllers/match_tools_methods.dart';

/**
 * 【【【 AUTO_DOCUMENT_MENU 全屏顶部信息栏组件 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 全屏视频顶部信息栏 】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 视频全屏顶部控制与信息展示组件 】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 全屏视频播放器顶部的控制与信息展示区域
 * - 包含返回按钮、比分展示、玩法切换三大核心功能
 * - 采用半透明渐变背景，不影响视频内容观看
 * - 响应式布局适配不同屏幕尺寸
 * - 支持电竞和传统体育赛事的比分展示逻辑
 * 】】】
 */
class VideoCoverTop extends StatelessWidget {
  /// 比赛数据实体
  /// 包含对阵双方信息、比赛状态、比分等核心数据
  final MatchEntity match;

  /// 返回按钮点击回调
  /// 用于退出全屏模式或返回上一级页面
  final VoidCallback onBack;

  /// 当前选中的玩法类型名称
  /// 如："全场让球"、"大小盘"等，用于显示在玩法切换按钮上
  final String currentPlayType;

  /// 玩法切换按钮点击回调
  /// 点击后弹出玩法选择面板，用户可以切换不同的玩法类型
  final VoidCallback onLineChange;

  const VideoCoverTop({
    super.key,
    required this.match,
    required this.onBack,
    required this.currentPlayType,
    required this.onLineChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 固定高度110，确保有足够的触摸区域且不占用过多视频空间
      height: 110,
      // 使用屏幕宽度，确保全屏覆盖
      width: 1.sw,
      // 顶部渐变背景：从顶部完全不透明渐变到底部完全透明
      // 既提供操作背景，又渐隐到视频内容
      decoration: BoxDecoration(gradient: _topGradient),
      child: Column(
        // 内容顶部对齐，确保按钮和信息区域在顶部显示
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 顶部安全间距20，为系统状态栏留出空间
          const SizedBox(height: 20),
          Container(
            // 水平内边距36，确保内容不紧贴屏幕边缘
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              // 三栏布局：返回按钮(左)、比分展示(中)、玩法切换(右)
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧：返回按钮
                _buildBackButton(),
                // 中间：比分展示区域
                _buildScoreDisplay(),
                // 右侧：玩法切换按钮
                _buildLineChangeButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 【【【构建返回按钮】】】
  /// 返回按钮设计特点：
  /// - 固定尺寸：宽24px，高44px，提供舒适的触摸区域
  /// - 垂直居中：使用Alignment.center确保图标在容器中垂直居中
  /// - 夜间模式图标：使用带_night后缀的图标，适配深色背景
  /// - 点击反馈：使用InkWell提供水波纹效果
  /// - 图标尺寸：8x14px，与原生系统返回箭头尺寸一致
  Widget _buildBackButton() {
    return InkWell(
      onTap: onBack,
      child: Container(
        width: 24,
        height: 44,
        alignment: Alignment.center,
        child: const ImageView(
          "assets/images/detail/icon_arrowleft_nor_night.svg", // 夜间模式返回箭头
          boxFit: BoxFit.fill, // 填充整个图标区域
          width: 8,
          height: 14,
        ),
      ),
    );
  }

  /// 【【【构建比分展示区域】】】
  /// 显示主队名、比分、客队名，采用水平居中布局
  /// 设计特点：
  /// - 主队名在左，比分在中，客队名在右
  /// - 主客队名与比分之间有固定间距16px
  /// - 使用专用方法构建各部分，确保样式一致性
  Widget _buildScoreDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 主队名称，右侧间距16
        _buildTeamName(match.mhn, rightMargin: 16),
        // 比分文本，根据比赛状态动态显示
        _buildScoreText(),
        // 客队名称，左侧间距16
        _buildTeamName(match.man, leftMargin: 16),
      ],
    );
  }

  /// 【【【构建队伍名称Widget】】】
  /// 统一构建主客队名称的显示样式
  /// @param name 队伍名称
  /// @param leftMargin 左边距，用于客队名
  /// @param rightMargin 右边距，用于主队名
  /// 设计特点：
  /// - 使用固定文本样式，确保视觉一致性
  /// - 通过外边距控制队伍名称与比分的间距
  /// - 不限制宽度，允许名称根据内容自然扩展
  Widget _buildTeamName(String name, {double? leftMargin, double? rightMargin}) {
    return Text(
      name,
      style: _teamNameStyle,
    ).marginOnly(left: leftMargin ?? 0, right: rightMargin ?? 0);
  }

  /// 【【【构建比分文本】】】
  /// 比分显示逻辑：
  /// 1. 首先判断是否为电竞比赛且正在进行中
  /// 2. 如果是电竞比赛：显示"进行中"（国际化）
  /// 3. 如果是传统体育比赛：
  ///    - 比赛已开始(ms!=110)：显示实际比分，如"1:0"
  ///    - 比赛未开始(ms=110)：显示"vs"
  /// 关键方法说明：
  /// - eSportsScoring(): 判断电竞比赛是否正在进行
  /// - getMsc(): 从msc字段解析并格式化比分字符串
  Widget _buildScoreText() {
    // 判断是否为电竞比赛且正在进行
    final bool isEportsScoring = eSportsScoring(match);
    // 获取比分文本
    final String score = isEportsScoring
        ? LocaleKeys.mmp_eports_scoring.tr // 电竞进行中
        : match.ms != 110 ? getMsc(match.msc) : "vs"; // 传统体育：有比分显示比分，无比分显示vs

    return Text(
      score,
      style: _scoreStyle,
    );
  }

  /// 【【【构建玩法切换按钮】】】
  /// 允许用户在全屏状态下快速切换不同玩法
  /// 设计特点：
  /// - 最小宽度48px，确保短文本也能正常显示
  /// - 高度24px，与文字大小匹配
  /// - 白色1px边框，圆角4px，提供视觉边界
  /// - 内边距控制：外层padding:2px，内层padding:4px
  /// - 使用StrutStyle强制行高，确保文本垂直居中
  /// - 单行显示，超出显示省略号
  Widget _buildLineChangeButton() {
    return InkWell(
      onTap: onLineChange,
      child: Container(
        // 最小宽度约束，避免按钮过窄
        constraints: const BoxConstraints(minWidth: 48),
        height: 24,
        padding: const EdgeInsets.all(2), // 外层内边距，用于边框效果
        child: Container(
          alignment: Alignment.center,
          // 内层内边距，控制文字与边框的间距
          padding: const EdgeInsets.symmetric(horizontal: 4),
          // 边框装饰：白色1px边框，圆角4px
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            currentPlayType,
            maxLines: 1,
            style: _lineTextStyle,
            // StrutStyle确保文本垂直居中，不受字体影响
            strutStyle: const StrutStyle(forceStrutHeight: true, height: 1),
          ),
        ),
      ),
    );
  }

  /// 【【【顶部渐变背景样式】】】
  /// 线性渐变从顶部中心到底部中心
  /// 颜色值说明：
  /// 位置0.0: RGB(0,0,0) 不透明度1.0 → 完全不透明
  /// 位置0.3: RGB(0,0,0) 不透明度0.87 → 87%不透明
  /// 位置0.6: RGB(0,0,0) 不透明度0.4 → 40%不透明
  /// 位置1.0: RGB(0,0,0) 不透明度0.0 → 完全透明
  /// 这种渐变设计在视频顶部创建柔和的遮罩层
  static const LinearGradient _topGradient = LinearGradient(
    begin: Alignment.topCenter, // 渐变起始点：顶部中心
    end: Alignment.bottomCenter, // 渐变结束点：底部中心
    colors: [
      Color.fromRGBO(0, 0, 0, 1),      // 完全不透明的黑色
      Color.fromRGBO(0, 0, 0, 0.87),   // 87%不透明的黑色
      Color.fromRGBO(0, 0, 0, 0.4),    // 40%不透明的黑色
      Color.fromRGBO(0, 0, 0, 0),      // 完全透明
    ],
  );

  /// 【【【队伍名称文本样式】】】
  /// 设计规范：
  /// - 颜色：白色，在深色背景下清晰可读
  /// - 字号：14px，适中的阅读大小
  /// - 字体：PingFang SC，中文字体优化
  /// - 字重：500（中等），提供适当的视觉重量
  static const TextStyle _teamNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'PingFang SC',
    fontWeight: FontWeight.w500,
  );

  /// 【【【比分文本样式】】】
  /// 设计规范：
  /// - 颜色：白色，突出显示比分
  /// - 字号：14px，与队伍名称保持一致
  /// - 字体：PingFang HK，香港字体，数字显示更美观
  /// - 字重：600（半粗），比分需要更突出显示
  static const TextStyle _scoreStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'PingFang HK',
    fontWeight: FontWeight.w600,
  );

  /// 【【【玩法切换按钮文本样式】】】
  /// 设计规范：
  /// - 颜色：白色，与边框颜色一致
  /// - 字号：12px，适合按钮内的小尺寸文字
  /// - 字体：PingFang SC，中文字体优化
  /// - 字重：600（半粗），确保在按钮内清晰可读
  static const TextStyle _lineTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'PingFang SC',
    fontWeight: FontWeight.w600,
  );
}