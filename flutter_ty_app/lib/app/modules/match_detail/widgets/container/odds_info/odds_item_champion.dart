import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info/odds_action_logic.dart'; // 导入特定扩展
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../widgets/image_view.dart';
import '../../../constants/theme_constant.dart';
import '../../../controllers/match_detail_controller.dart';
import 'templates/champion_temp.dart';

/**
 * 冠军玩法组件
 *
 * 功能说明：
 * 1. 展示冠军盘口信息（标题、时间、截盘信息）
 * 2. 支持展开/折叠动画
 * 3. 支持盘口置顶功能
 * 4. 适配全屏/非全屏模式
 * 5. 支持深色/浅色主题
 */
class OddsItemChampion extends StatefulWidget {
  const OddsItemChampion({
    super.key,
    required this.item,
    this.tag,
    required this.index,
  });

  /// 盘口数据实体
  final MatchHps item;

  /// 列表索引，用于置顶操作
  final int index;

  /// GetBuilder tag，用于区分不同的控制器实例
  final String? tag;

  @override
  State<OddsItemChampion> createState() => _OddsItemChampionState();
}

class _OddsItemChampionState extends State<OddsItemChampion>
    with SingleTickerProviderStateMixin {
  // ============= 动画控制器 =============

  /// 展开/收起动画控制器
  late final AnimationController _controller;

  /// 动画曲线
  late final Animation<double> _animation;

  /// 尺寸补间动画
  late final Tween<double> _sizeTween;

  // ============= 常量定义 =============

  /// 默认动画持续时间
  static const Duration _kAnimationDuration = Duration(milliseconds: 200);

  /// 展开状态标识
  static const String SHOW_YES = "yes";

  // ============= 生命周期 =============

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 初始化动画控制器
  void _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _sizeTween = Tween(begin: 0, end: 1);
  }

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    // 用于精细化更新的唯一ID，基于盘口ID和索引组合
    final String updateId =
        "hpid_${widget.item.hpid}_${widget.item.topKey}_${widget.item.hid}";

    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      id: updateId,
      builder: (controller) {
        // 获取当前盘口数据和对应的比赛信息
        final MatchHps item = widget.item;
        final MatchEntity? match = _findMatchByMid(item.mid, controller);

        // 如果没有对应的比赛信息，则不显示
        if (match == null) return const SizedBox.shrink();

        // 同步动画状态与数据状态
        _syncAnimationState(item, controller);

        // 预计算常用状态标志，避免重复计算
        final bool isFullscreen = controller.detailState.fullscreen.value;
        final bool isDarkMode = Get.isDarkMode;

        return Container(
          clipBehavior: Clip.hardEdge,
          margin: _buildContainerMargin(isFullscreen),
          decoration: _buildContainerDecoration(isFullscreen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 1. 头部区域 (点击可展开/折叠)
              _buildHeader(item, controller, match, isFullscreen, isDarkMode),

              // 2. 分隔线 (展开时可见)
              if (item.hshow == SHOW_YES) _buildDivider(isFullscreen),

              // 3. 可展开的主体内容（冠军投注项列表）
              _buildExpandableContent(item, match, isFullscreen),
            ],
          ),
        );
      },
    );
  }

  /// 根据比赛ID查找对应的比赛信息
  MatchEntity? _findMatchByMid(String mid, MatchDetailController controller) {
    return controller.detailState.championMatchs
        .firstWhereOrNull((e) => e.mid == mid);
  }

  /// 构建容器外边距
  EdgeInsets _buildContainerMargin(bool isFullscreen) {
    return EdgeInsets.only(
      left: isFullscreen ? 5 : 5.w,
      right: isFullscreen ? 5 : 5.w,
      bottom: isFullscreen ? 8 : 8.w,
    );
  }

  /// 构建容器装饰（背景色、圆角、阴影）
  BoxDecoration _buildContainerDecoration(bool isFullscreen) {
    return BoxDecoration(
      color: isFullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.betPanelBackGroundColor,
      borderRadius: BorderRadius.circular(isFullscreen ? 8 : 8.r),
      boxShadow: const [
        BoxShadow(
          color: ThemeConstant.oddsItemBoxShadowColor,
          blurRadius: 12,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    );
  }

  /// 构建分隔线
  Widget _buildDivider(bool isFullscreen) {
    return Container(
      height: 0.5,
      color: isFullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.betPanelUnderlineColor,
    );
  }

  /// 构建可展开的内容区域（带动画）
  Widget _buildExpandableContent(
      MatchHps item, MatchEntity match, bool isFullscreen) {
    return SizeTransition(
      sizeFactor: _sizeTween.animate(_animation),
      child: ChampionTemp(
        matchHps: item,
        fullscreen: isFullscreen,
        match: match,
      ),
    );
  }

  // ============= 头部构建方法 =============

  /// 构建整个头部区域
  Widget _buildHeader(MatchHps item, MatchDetailController controller,
      MatchEntity match, bool isFullscreen, bool isDarkMode) {
    return InkWell(
      onTap: () => _handleHeaderTap(item, controller),
      child: Stack(
        children: [
          // 中间内容 (标题和时间)
          _buildHeaderCenter(item, match, isFullscreen),

          // 右侧内容 (置顶图标 + 箭头图标)
          _buildHeaderRight(item, controller, isFullscreen, isDarkMode),
        ],
      ),
    );
  }

  /// 处理头部点击事件
  void _handleHeaderTap(MatchHps item, MatchDetailController controller) {
    controller.setHShow(item);
  }

  /// 构建头部中间标题区域
  Widget _buildHeaderCenter(
    MatchHps item,
    MatchEntity match,
    bool isFullscreen,
  ) {
    final double height = _getHeaderHeight(isFullscreen);
    final double paddingHorizontal = isFullscreen ? 50 : 50.w;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isFullscreen ? 12 : 12.w,
      ),
      height: height,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: _buildTitleContent(item, isFullscreen, match),
      ),
    );
  }

  /// 获取头部高度
  double _getHeaderHeight(bool isFullscreen) {
    return isFullscreen ? 50 : (isIPad ? 64.h : 50.h);
  }

  /// 构建标题内容列
  Widget _buildTitleContent(
      MatchHps item, bool isFullscreen, MatchEntity match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 第一行：前缀图标 + 赛事名称
        _buildTitleFirstRow(item, isFullscreen, match),

        // 第二行：时间和截盘信息
        _buildTitleSecondRow(item),
      ],
    );
  }

  /// 构建标题第一行（前缀图标 + 赛事名称）
  Widget _buildTitleFirstRow(
      MatchHps item, bool isFullscreen, MatchEntity match) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPrefixIcon(isFullscreen),
        4.horizontalSpace,
        _buildMatchName(match, isFullscreen),
      ],
    );
  }

  /// 构建前缀图标
  Widget _buildPrefixIcon(bool isFullscreen) {
    return ImageView(
      Get.locale?.languageCode == "zh"
          ? 'assets/images/detail/outright_prefix.svg'
          : 'assets/images/detail/outright_prefix_en.svg',
      width: isFullscreen ? 20 : 20.w,
    );
  }

  /// 构建赛事名称（带宽度限制）
  Widget _buildMatchName(MatchEntity match, bool isFullscreen) {
    final String matchName = (match.tn != null && match.tn!.isNotEmpty)
        ? match.tn!
        : (match.onTn ?? "");

    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: _getMatchNameMaxWidth(isFullscreen)),
      child: Text(
        matchName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _getMatchNameColor(isFullscreen),
          fontWeight: FontWeight.w600,
          fontSize: _getMatchNameFontSize(isFullscreen),
        ),
      ),
    );
  }

  /// 获取赛事名称最大宽度
  double _getMatchNameMaxWidth(bool isFullscreen) {
    return 1.sw - (isFullscreen ? 160 : 160.w);
  }

  /// 获取赛事名称颜色
  Color _getMatchNameColor(bool isFullscreen) {
    return isFullscreen
        ? Colors.white.withValues(alpha: 0.9)
        : Get.theme.betPanelFontColor;
  }

  /// 获取赛事名称字体大小
  double _getMatchNameFontSize(bool isFullscreen) {
    return isFullscreen ? 12 : (isIPad ? 17.sp : 12.sp);
  }

  /// 构建标题第二行（时间和截盘信息）
  Widget _buildTitleSecondRow(MatchHps item) {
    return Text(
      _formatChampionTime(item.hmed),
      textAlign: TextAlign.right,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: _getTimeTextColor(),
        fontSize: _getTimeFontSize(),
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 获取时间文本颜色
  Color _getTimeTextColor() {
    return Get.isDarkMode
        ? Colors.white.withValues(alpha: 0.3)
        : ThemeConstant.textGrayColor;
  }

  /// 获取时间文本字体大小
  double _getTimeFontSize() {
    final bool isFullscreen = widget.item.hshow == SHOW_YES; // 复用状态判断
    return isFullscreen ? 10 : (isIPad ? 14.sp : 10.sp);
  }

  /// 格式化冠军盘口时间字符串
  /// 格式：时间(时区)截盘
  String _formatChampionTime(String hmed) {
    // 转换时间戳
    final timestamp = TimeZoneUtils.convertTimeToTimestamp(hmed,
        isMilliseconds: true, returnMilliseconds: true);

    // 格式化时间
    final timeStr = DateUtil.formatDateMs(timestamp,
        format: LocaleKeys.time7.tr, isUtc: true);

    // 获取时区
    final timezone = TimeZoneUtils.getTimeZoneString();

    return "$timeStr($timezone)${LocaleKeys.match_main_cut_off.tr}";
  }

  // ============= 右侧操作区域 =============

  /// 构建右侧操作区域 (置顶 + 箭头图标)
  Widget _buildHeaderRight(MatchHps item, MatchDetailController controller,
      bool isFullscreen, bool isDarkMode) {
    final double containerHeight = _getHeaderHeight(isFullscreen);

    return SizedBox(
      height: containerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 置顶按钮
          _buildPinButton(
              item, controller, isFullscreen, isDarkMode, containerHeight),

          // 箭头图标 (带旋转动画)
          _buildArrowIcon(item, isFullscreen, isDarkMode),
        ],
      ),
    );
  }

  /// 构建置顶按钮
  Widget _buildPinButton(MatchHps item, MatchDetailController controller,
      bool isFullscreen, bool isDarkMode, double containerHeight) {
    final double pinSize = _getPinIconSize(isFullscreen);
    final double pinClickAreaSize =
        _getPinClickAreaSize(isFullscreen, containerHeight);

    return InkWell(
      onTap: () => _handlePinTap(item, controller),
      child: Container(
        width: pinClickAreaSize,
        height: containerHeight,
        alignment: Alignment.center,
        child: ImageView(
          _getPinIconAsset(item.hton != "0", isFullscreen, isDarkMode),
          width: pinSize,
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }

  /// 处理置顶点击
  void _handlePinTap(MatchHps item, MatchDetailController controller) {
    controller.setHton(item, widget.index);
  }

  /// 获取置顶图标大小
  double _getPinIconSize(bool isFullscreen) {
    return isFullscreen ? 16 : (isIPad ? 20.w : 16.w);
  }

  /// 获取置顶按钮点击区域大小
  double _getPinClickAreaSize(bool isFullscreen, double containerHeight) {
    return isFullscreen ? 36 : (isIPad ? 50.h : 36.h);
  }

  /// 构建箭头图标（带旋转动画）
  Widget _buildArrowIcon(MatchHps item, bool isFullscreen, bool isDarkMode) {
    final double arrowSize = _getArrowIconSize(isFullscreen);

    return AnimatedRotation(
      duration: _kAnimationDuration,
      turns: item.hshow == SHOW_YES ? 0 : -0.25, // 展开时0°，收起时-90°(-0.25圈)
      child: ImageView(
        _getArrowIconAsset(isFullscreen, isDarkMode),
        width: arrowSize,
        height: arrowSize,
      ),
    ).marginOnly(
      right: isFullscreen ? 10 : 10.w,
      left: isFullscreen ? 8 : 8.w,
    );
  }

  /// 获取箭头图标大小
  double _getArrowIconSize(bool isFullscreen) {
    return isFullscreen ? 12 : (isIPad ? 16.w : 12.w);
  }

  // ============= 图标资源路径 =============

  /// 获取置顶图标资源路径
  String _getPinIconAsset(bool isPinned, bool isFullscreen, bool isDarkMode) {
    if (isPinned) {
      // 已置顶状态
      return isDarkMode
          ? 'assets/images/detail/list_pintop_sel_night.svg'
          : 'assets/images/detail/list_pintop_sel.svg';
    } else {
      // 未置顶状态
      if (isFullscreen) {
        return 'assets/images/detail/list_pintop_nor_night.svg';
      }
      return isDarkMode
          ? 'assets/images/detail/list_pintop_nor_night.svg'
          : 'assets/images/detail/list_pintop_nor.svg';
    }
  }

  /// 获取箭头图标资源路径
  String _getArrowIconAsset(bool isFullscreen, bool isDarkMode) {
    if (isFullscreen) {
      return 'assets/images/detail/ico_arrowdown_nor_night.svg';
    }
    return isDarkMode
        ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
        : 'assets/images/detail/ico_arrowdown_nor.svg';
  }

  // ============= 动画状态同步 =============

  /// 同步动画控制器与数据状态
  void _syncAnimationState(MatchHps item, MatchDetailController controller) {
    // 如果是通过控制器请求动画（例如批量切换）
    if (controller.detailState.toggleAnimate) {
      _handleAnimatedToggle(item, controller);
    } else {
      // 立即更新无动画（例如：初始加载或单个切换）
      _syncAnimationWithoutAnimation(item);
    }
  }

  /// 处理带动画的展开/折叠
  void _handleAnimatedToggle(MatchHps item, MatchDetailController controller) {
    // 使用 post frame callback 在构建后触发动画，避免布局冲突
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      try {
        if (item.hshow == SHOW_YES) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        // 重置标志以防止重复动画
        controller.detailState.toggleAnimate = false;
      } catch (e) {
        AppLogger.debug("OddsItemChampion动画执行异常: $e");
      }
    });
  }

  /// 同步动画状态但不播放动画
  void _syncAnimationWithoutAnimation(MatchHps item) {
    if (item.hshow == SHOW_YES) {
      if (_controller.value != 1.0) _controller.value = 1.0;
    } else {
      if (_controller.value != 0.0) _controller.value = 0.0;
    }
  }
}
