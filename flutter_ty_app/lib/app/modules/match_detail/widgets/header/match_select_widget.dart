import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_api_service.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/match_select_widget_cell.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import 'match_select_widget_header.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 下拉联赛选择】】】
    【【【 AUTO_PARAGRAPH_TITLE 下拉联赛选择组件】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 下拉联赛、切换联赛
    】】】
 *
 */
class MatchSelectWidget extends StatefulWidget {
  const MatchSelectWidget({
    super.key,
    this.tag,
    required this.match
  });

  /// 当前选中的比赛信息
  final MatchEntity match;

  /// GetBuilder标签，用于区分不同的控制器实例
  final String? tag;

  @override
  State<MatchSelectWidget> createState() => _MatchSelectWidgetState();
}

class _MatchSelectWidgetState extends State<MatchSelectWidget> {

  // ============= 常量定义 =============

  /// 定时刷新间隔（秒）
  static const int _kRefreshInterval = 5;

  /// 最大高度
  static const double _kMaxHeight = 720;

  /// iPad最小高度
  static const double _kIPadMinHeight = 150;

  /// 普通设备最小高度
  static const double _kNormalMinHeight = 100;

  /// 水平内边距
  static const double _kHorizontalPadding = 14;

  /// 标题区域垂直内边距
  static const double _kTitleVerticalPadding = 10;

  /// 标题区域水平内边距
  static const double _kTitleHorizontalPadding = 15;

  // ============= 状态变量 =============

  /// 定时器，用于定期刷新数据
  Timer? timer;

  /// 赛事详情控制器
  late final MatchDetailController controller;

  // ============= 生命周期 =============

  @override
  void initState() {
    super.initState();
    _initController();
    _fetchInitialData();
    _startRefreshTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  /// 初始化控制器
  void _initController() {
    controller = Get.find<MatchDetailController>(tag: widget.tag);
  }

  /// 获取初始数据并展开面板
  void _fetchInitialData() {
    // 获取赛事列表数据
    controller.fetchMatchListData();

    // 在下一帧设置展开状态，确保动画效果
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.detailState.isMatchSelectExpand.value = true;
    });
  }

  /// 启动定时刷新器
  void _startRefreshTimer() {
    _cancelTimer(); // 先取消已有定时器

    timer = Timer.periodic(
        const Duration(seconds: _kRefreshInterval),
        _handleTimerTick
    );
  }

  /// 处理定时器触发
  void _handleTimerTick(Timer timer) {
    // 只在组件挂载且面板展开时刷新数据
    if (mounted && controller.detailState.isMatchSelectExpand.value) {
      controller.fetchMatchListData();
    }
  }

  /// 取消定时器
  void _cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
      /// 这里的tag和id不能修改，用于精细化更新
      tag: widget.tag,
      id: matchSelectGetBuildId,
      builder: _buildContent,
    );
  }

  /// 构建主要内容
  Widget _buildContent(MatchDetailController controller) {
    // 过滤掉当前选中的比赛
    final List<MatchEntity> filteredMatchListData = _filterCurrentMatch(controller);

    return Container(
      constraints: _buildContainerConstraints(),
      color: Get.theme.matchSelectBackgroundColor,
      child: Column(
        children: [
          // 头部组件（包含关闭按钮等）
          MatchSelectWidgetHeader(
              match: widget.match,
              controller: controller
          ),

          // 标题区域（显示当前赛事名称和数量）
          if (filteredMatchListData.isNotEmpty)
            _buildTitleSection(filteredMatchListData),

          // 赛事列表
          _buildMatchList(controller),
        ],
      ),
    );
  }

  /// 过滤掉当前选中的比赛
  List<MatchEntity> _filterCurrentMatch(MatchDetailController controller) {
    return controller.detailState.matchListData
        .where((item) => item.mid != widget.match.mid)
        .toList();
  }

  /// 构建容器约束
  BoxConstraints _buildContainerConstraints() {
    return BoxConstraints(
      maxHeight: _kMaxHeight.h,
      minHeight: isIPad ? _kIPadMinHeight.h : _kNormalMinHeight.h,
    );
  }

  /// 构建标题区域
  Widget _buildTitleSection(List<MatchEntity> filteredMatchListData) {
    return Container(
      color: Get.theme.matchSelectBackgroundColor,
      padding: EdgeInsets.symmetric(
          vertical: _kTitleVerticalPadding.h,
          horizontal: _kTitleHorizontalPadding.w
      ),
      child: Row(
        children: [
          // 当前赛事名称
          Flexible(
            child: Text(
              widget.match.tn,
              style: _buildTitleTextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 其他赛事数量
          Text(
            "(${filteredMatchListData.length})",
            style: _buildTitleTextStyle(),
          ),
        ],
      ),
    );
  }

  /// 构建标题文本样式
  TextStyle _buildTitleTextStyle() {
    return TextStyle(
      color: _getTitleTextColor(),
      fontSize: _getTitleFontSize(),
      fontFamily: 'PingFang SC',
      fontWeight: FontWeight.w700,
    );
  }

  /// 获取标题文本颜色
  Color _getTitleTextColor() {
    return !Get.isDarkMode
        ? Get.theme.matchSelectTitleColor
        : Colors.white;
  }

  /// 获取标题字体大小
  double _getTitleFontSize() {
    return isIPad ? 20.sp : 16.sp;
  }

  /// 构建赛事列表
  Widget _buildMatchList(MatchDetailController controller) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: _kHorizontalPadding.w),
        scrollDirection: Axis.vertical,
        itemCount: controller.detailState.matchListData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildListItem(controller, index),
        separatorBuilder: _buildListSeparator,
      ),
    );
  }

  /// 构建列表项
  Widget _buildListItem(MatchDetailController controller, int index) {
    final matchItem = controller.detailState.matchListData[index];

    // 如果是当前选中的赛事，不显示（但保留位置）
    if (matchItem == widget.match) {
      return const SizedBox();
    }

    // 返回可点击的赛事选择项
    return MatchSelectWidgetCell(
      match: matchItem,
      index: index,
      controller: controller,
    );
  }

  /// 构建列表分割线
  Widget _buildListSeparator(BuildContext context, int index) {
    return Container(
      color: Get.theme.betPanelUnderlineColor,
      height: 0.5,
    );
  }
}