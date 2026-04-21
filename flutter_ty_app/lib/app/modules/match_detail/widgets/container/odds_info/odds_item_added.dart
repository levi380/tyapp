
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/added_temp.dart'
    show AddedTemp;

import 'package:flutter_ty_app/main.dart';

// 优化导入：合并到全局导入部分，这里只保留实际使用的模板
import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../login/login_head_import.dart';
import '../../../controllers/match_detail_controller.dart';

/// 盘口详情项组件 - 支持展开/收起动画
/// 显示单个玩法盘口，点击标题可展开显示详细赔率信息
class OddsItemAdded extends StatefulWidget {
  const OddsItemAdded({
    super.key,
    required this.item,
    this.tag,
    required this.index,
  });

  final MatchHps item; // 盘口数据
  final int index; // 在列表中的索引
  final String? tag; // GetX控制器标签，用于多实例区分

  @override
  State<OddsItemAdded> createState() => _OddsItemAddedState();
}

class _OddsItemAddedState extends State<OddsItemAdded>
    with SingleTickerProviderStateMixin {
  // 动画控制器 - 控制展开/收起动画
  late final AnimationController _controller;

  // 动画曲线 - 控制动画速度变化
  late final Animation<double> _animation;

  // 尺寸变化补间 - 控制高度从0到1的变化
  late final Tween<double> _sizeTween;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  /// 初始化动画相关对象
  void _initializeAnimation() {
    // 创建动画控制器，200毫秒持续时间
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // 使用缓动曲线使动画更自然
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    // 创建尺寸补间动画，从0(收起)到1(完全展开)
    _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放动画控制器资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      tag: widget.tag,
      // 唯一ID确保只有特定盘口数据变化时重建
      id: "hpid_${widget.item.hpid}_${widget.item.topKey}_${widget.item.hid}",
      builder: (controller) {
        return _buildOddsItemContent(controller);
      },
    );
  }

  /// 构建盘口项主要内容
  Widget _buildOddsItemContent(MatchDetailController controller) {
    final MatchHps item = widget.item;
    final MatchEntity? match = DataStoreController.to.getMatchById(item.mid);
    final bool isFullscreen = controller.detailState.fullscreen.value;

    // 处理展开/收起动画
    _handleToggleAnimation(item, controller);

    // 检查是否需要隐藏该盘口
    if (_shouldHideItem(item, controller)) {
      return const SizedBox.shrink(); // 使用SizedBox.shrink替代空Container
    }

    return _buildOddsItemContainer(item, controller, isFullscreen);
  }

  /// 构建盘口项容器
  Widget _buildOddsItemContainer(
      MatchHps item,
      MatchDetailController controller,
      bool isFullscreen,
      ) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        left: _getMarginValue(isFullscreen),
        right: _getMarginValue(isFullscreen),
        bottom: isFullscreen ? 8 : 8.w,
      ),
      decoration: _buildContainerDecoration(isFullscreen, controller),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 标题栏（可点击展开/收起）
          _buildTitleSection(item, controller, isFullscreen),

          // 展开时的分隔线
          if (item.hshow == SHOW_YES) _buildDivider(isFullscreen, controller),

          // 赔率详情内容（带展开动画）
          _buildOddsDetailContent(item, controller),
        ],
      ),
    );
  }

  /// 构建容器装饰
  BoxDecoration _buildContainerDecoration(
      bool isFullscreen,
      MatchDetailController controller,
      ) {
    final Color backgroundColor = isFullscreen
        ? Colors.white.withValues(alpha: 0.08)
        : Get.theme.betPanelBackGroundColor;

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(isFullscreen ? 8 : 8.r),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A000000), // 10%透明度的黑色阴影
          blurRadius: 12,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// 构建标题部分
  Widget _buildTitleSection(
      MatchHps item,
      MatchDetailController controller,
      bool isFullscreen,
      ) {
    return InkWell(
      onTap: () => controller.setHShow(item), // 点击切换展开状态
      child: Stack(
        children: [
          // 标题文本区域
          _buildTitleBackground(item, controller, isFullscreen),

          // 右侧图标区域
          _buildTitleIcons(item, controller, isFullscreen),
        ],
      ),
    );
  }

  /// 构建标题背景和文本
  Widget _buildTitleBackground(
      MatchHps item,
      MatchDetailController controller,
      bool isFullscreen,
      ) {
    final double titleHeight = _getTitleHeight(isFullscreen);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isFullscreen ? 12 : 12.w,
      ),
      height: titleHeight,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isFullscreen ? 50 : 50.w,
        ),
        child: _buildTitleText(item, controller, isFullscreen),
      ),
    );
  }

  /// 构建标题文本
  Widget _buildTitleText(
      MatchHps item,
      MatchDetailController controller,
      bool isFullscreen,
      ) {
    return Text(
      item.hpn, // 盘口名称
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: isFullscreen
            ? Colors.white.withValues(alpha: 0.9)
            : Get.theme.betPanelFontColor,
        fontWeight: FontWeight.w600,
        fontSize: _getTitleFontSize(isFullscreen),
      ),
    );
  }

  /// 构建右侧图标（展开箭头等）
  Widget _buildTitleIcons(
      MatchHps item,
      MatchDetailController controller,
      bool isFullscreen,
      ) {
    final double titleHeight = _getTitleHeight(isFullscreen);
    final double iconSize = _getIconSize(isFullscreen);

    return SizedBox(
      height: titleHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 展开/收起箭头图标
          _buildExpandArrowIcon(item, isFullscreen, iconSize),
        ],
      ),
    );
  }

  /// 构建展开箭头图标
  Widget _buildExpandArrowIcon(
      MatchHps item,
      bool isFullscreen,
      double iconSize,
      ) {
    // 根据展开状态旋转箭头
    final double arrowRotation = item.hshow == SHOW_YES ? 0 : -0.25;

    return AnimatedRotation(
      duration: const Duration(milliseconds: 200),
      turns: arrowRotation,
      child: ImageView(
        _getArrowIconPath(isFullscreen),
        width: iconSize,
        height: iconSize,
      ),
    ).marginOnly(
      right: isFullscreen ? 10 : 10.w,
      left: isFullscreen ? 8 : 8.w,
    );
  }

  /// 构建分隔线
  Widget _buildDivider(bool isFullscreen, MatchDetailController controller) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(
        horizontal: isFullscreen ? 8 : 8.w,
      ),
      color: isFullscreen
          ? Colors.white.withValues(alpha: 0.08)
          : Get.theme.betPanelUnderlineColor,
    );
  }

  /// 构建赔率详情内容（带动画）
  Widget _buildOddsDetailContent(
      MatchHps item,
      MatchDetailController controller,
      ) {
    return SizeTransition(
      sizeFactor: _sizeTween.animate(_animation),
      axisAlignment: -1.0, // 从顶部开始展开
      child: _buildOddWidget(item, controller),
    );
  }

  /// 处理展开/收起动画
  void _handleToggleAnimation(MatchHps item, MatchDetailController controller) {
    if (controller.detailState.toggleAnimate) {
      // 使用addPostFrameCallback确保在下一帧执行动画
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _updateAnimationState(item);
          controller.detailState.toggleAnimate = false;
        } catch (e) {
          Get.log("oddsItem _handleToggleAnimation error: $e");
        }
      });
    } else {
      // 直接设置动画状态（无过渡）
      _setImmediateAnimationState(item);
    }
  }

  /// 更新动画状态（带动画）
  void _updateAnimationState(MatchHps item) {
    if (item.hshow == SHOW_YES) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  /// 立即设置动画状态（无动画）
  void _setImmediateAnimationState(MatchHps item) {
    if (item.hshow == SHOW_YES) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }
  }

  /// 检查是否需要隐藏该项
  bool _shouldHideItem(MatchHps item, MatchDetailController controller) {
    final String route = Get.currentRoute;

    // 比赛结果详情页显示所有项
    if (route == Routes.matchResultsDetails) {
      return false;
    }

    // 检查是否应该移除或隐藏
    return _shouldRemoveItem(item) || _shouldHideByCondition(item);
  }

  /// 判断是否应该移除该项（所有子盘口都关盘）
  bool _shouldRemoveItem(MatchHps item) {
    // 检查所有子盘口是否都处于关盘状态(hs == 2)
    return item.hl.every((hlItem) => hlItem.hs == 2);
  }

  /// 根据条件判断是否隐藏
  bool _shouldHideByCondition(MatchHps item) {
    return item.hl.isEmpty;
  }

  /// 构建赔率模板组件
  Widget _buildOddWidget(MatchHps item, MatchDetailController controller) {
    return AddedTemp(
      matchHps: item,
      fullscreen: controller.detailState.fullscreen.value,
    );
  }

  // ========== 工具方法 ==========

  /// 获取边距值
  double _getMarginValue(bool isFullscreen) {
    return isFullscreen ? 5 : 5.w;
  }

  /// 获取标题高度
  double _getTitleHeight(bool isFullscreen) {
    if (isFullscreen) return 36;
    return isIPad ? 50.h : 36.h;
  }

  /// 获取标题字体大小
  double _getTitleFontSize(bool isFullscreen) {
    if (isFullscreen) return 13;
    return isIPad ? 18.sp : 13.sp;
  }

  /// 获取图标大小
  double _getIconSize(bool isFullscreen) {
    if (isFullscreen) return 12;
    return isIPad ? 16.w : 12.w;
  }

  /// 获取箭头图标路径
  String _getArrowIconPath(bool isFullscreen) {
    if (isFullscreen) {
      return 'assets/images/detail/ico_arrowdown_nor_night.svg';
    }
    return Get.isDarkMode
        ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
        : 'assets/images/detail/ico_arrowdown_nor.svg';
  }
}