import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../main.dart'; // For isIPad
import '../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../services/models/res/vr_match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../utils/odds_util.dart';
import '../../../../../utils/vr_rank_icon_utils.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
import '../../../constants/theme_constant.dart';
import '../../../extension/theme_extension.dart';
import '../../../models/odds_button_enum.dart';

/**
 * VR虚拟体育投注按钮组件
 *
 * 功能说明：
 * 1. 展示VR赛事赔率按钮（支持垂直/水平两种布局）
 * 2. 支持赛果展示（赢、输、走水等）
 * 3. 支持排名图标显示（根据投注项名称或索引）
 * 4. 处理锁盘状态、无效赔率
 * 5. 管理选中状态，与购物车联动
 *
 * 使用场景：
 * - 模板9、10、11的VR虚拟体育投注按钮
 */
class VrOddsButton extends StatefulWidget {
  const VrOddsButton({
    super.key,
    this.width,
    this.height,
    this.direction = OddsTextDirection.vertical,
    required this.match,
    required this.hps,
    required this.ol,
    required this.hl,
    required this.isDetail,
    this.index,
  });

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 比赛信息实体
  final MatchEntity match;

  /// 盘口信息
  final MatchHps hps;

  /// 投注项信息
  final MatchHpsHlOl ol;

  /// 玩法信息
  final MatchHpsHl hl;

  /// 是否为详情页模式（影响字体大小和阴影效果）
  final bool isDetail;

  /// 列表索引，用于显示排名（如1,2,3...）
  final int? index;

  /// 文本排列方向：水平或垂直
  final OddsTextDirection direction;

  @override
  State<VrOddsButton> createState() => _VrOddsButtonState();
}

class _VrOddsButtonState extends State<VrOddsButton> {

  // ============= 状态变量 =============

  /// 按钮选中状态
  bool selected = false;

  /// VR期号（用于投注时传递）
  String? vrNo;

  // ============= 缓存常量（避免重复计算） =============

  /// 图标宽度
  late final double _iconWidth;

  /// 赔率名称字体大小
  late final double _nameFontSize;

  /// 赔率值字体大小
  late final double _valueFontSize;

  // ============= 生命周期 =============

  @override
  void initState() {
    super.initState();
    _initParams();
    _checkSelectionState();
    _subscribeToBusEvents();
  }

  @override
  void dispose() {
    _unsubscribeFromBusEvents();
    super.dispose();
  }

  // ============= 初始化方法 =============

  /// 初始化参数和尺寸常量
  void _initParams() {
    // 获取 VR 期号（仅在VR详情页需要）
    if (Get.currentRoute == Routes.vrSportDetail) {
      final VrMatchEntity? vrMatch = Get.arguments['vrMatch'];
      vrNo = vrMatch?.no;
    }

    // 初始化尺寸常量
    _iconWidth = isIPad ? 25.w : 20.w;

    _nameFontSize = widget.isDetail
        ? (isIPad ? 18.sp : 12.sp)
        : 10.sp;

    _valueFontSize = widget.isDetail
        ? (isIPad ? 20.sp : 16.sp)
        : 12.sp;
  }

  /// 检查并同步选中状态
  void _checkSelectionState() {
    final checked = ShopCartController.to.isCheck(widget.ol.oid);
    if (selected != checked) {
      selected = checked;
    }
  }

  /// 订阅事件总线
  void _subscribeToBusEvents() {
    Bus.getInstance().on(EventType.oddsButtonUpdate, _onOddsButtonUpdate);
  }

  /// 取消订阅事件总线
  void _unsubscribeFromBusEvents() {
    // 注意：如果需要精确移除特定回调，需要更复杂的实现
    // 这里简化处理，实际项目中可能需要按回调函数移除
    Bus.getInstance().off(EventType.oddsButtonUpdate);
  }

  // ============= 事件处理 =============

  /// 处理赔率按钮更新事件
  void _onOddsButtonUpdate(_) {
    if (!mounted) return;

    final checked = ShopCartController.to.isCheck(widget.ol.oid);
    if (selected != checked) {
      setState(() {
        selected = checked;
      });
    }
  }

  /// 处理按钮点击
  void _handleTap() {
    // 排除已出结果或锁盘状态
    if (widget.ol.result != null || widget.ol.os == 2) return;

    // 检查投注状态
    final state = OddsUtil.betState(
      widget.match.mhs,
      widget.hl.hs,
      widget.ol,
      widget.hps.hsw,
      csid: widget.match.csid,
    );

    // 只有开盘状态才能投注
    if (state == OddsButtonState.open) {
      ShopCartController.to.addBet(
        widget.match,
        widget.hps,
        widget.hl,
        widget.ol,
        betType: OddsBetType.vr,
        isDetail: widget.isDetail,
        vrNo: vrNo,
      );
    }
  }

  // ============= 构建方法 =============

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return InkWell(
      onTap: _handleTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        padding: _buildPadding(),
        clipBehavior: Clip.antiAlias,
        decoration: _buildDecoration(theme),
        child: _buildBody(),
      ),
    );
  }

  /// 构建内边距
  EdgeInsets _buildPadding() {
    if (widget.isDetail) {
      return EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h);
    }
    return EdgeInsets.symmetric(vertical: 2.h);
  }

  /// 构建容器装饰
  ShapeDecoration _buildDecoration(ThemeData theme) {
    return ShapeDecoration(
      color: selected
          ? theme.oddsButtonSelectedBackgroundColor
          : theme.oddsButtonBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r)
      ),
      shadows: _buildShadows(theme),
    );
  }

  /// 构建阴影（仅详情页模式需要）
  List<BoxShadow>? _buildShadows(ThemeData theme) {
    if (!widget.isDetail) return null;

    return [
      BoxShadow(
        color: theme.oddsButtonShadowColor,
        blurRadius: 8,
        offset: Offset(0, 2.h),
        spreadRadius: 0,
      )
    ];
  }

  // ============= 内容构建 =============

  /// 构建主体内容（根据方向选择布局）
  Widget _buildBody() {
    if (widget.direction == OddsTextDirection.vertical) {
      return _buildVerticalLayout();
    } else {
      return _buildHorizontalLayout();
    }
  }

  /// 垂直布局
  Widget _buildVerticalLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTopRow(),
        SizedBox(height: isIPad ? 12.h : 6.h),
        _buildBottomValue(),
      ],
    );
  }

  /// 水平布局
  Widget _buildHorizontalLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTopRow(),
        _buildBottomValue(),
      ],
    );
  }

  /// 构建顶部行（图标和名称区域）
  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconDisplay(),
        if (widget.direction == OddsTextDirection.horizontal)
          Container(
            margin: EdgeInsets.only(left: 4.w),
            child: _buildOddsName(),
          ),
      ],
    );
  }

  /// 构建底部区域（赔率值或结果）
  Widget _buildBottomValue() {
    // 1. 优先显示赛果（如果已出结果）
    if (widget.ol.result != null) {
      return _buildResultText();
    }

    // 2. 计算赔率值
    final oddsValue = _computeOddsValue();

    // 3. 处理锁盘或无效赔率
    if (widget.ol.os == 2 || oddsValue.isEmpty) {
      return _buildLock();
    }

    // 4. 正常显示赔率
    return _buildOddsValue(oddsValue);
  }

  /// 计算赔率值
  String _computeOddsValue() {
    return TYFormatOddsConversionMixin.computeValueByCurOddType(
      widget.ol.ov,
      widget.ol.ov2,
      widget.hps.hpid,
      widget.hps.hsw.split(','),
      int.tryParse(widget.match.csid) ?? 0,
      widget.ol.cds,
    );
  }

  // ============= 子组件构建 =============

  /// 构建赔率名称文本
  Widget _buildOddsName() {
    return Text(
      widget.ol.on,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: _nameFontSize,
        color: Get.theme.oddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 构建赔率值文本
  Widget _buildOddsValue(String oddsValue) {
    return Text(
      oddsValue,
      style: TextStyle(
        fontSize: _valueFontSize,
        color: Get.theme.oddsButtonValueFontColor,
        fontWeight: FontWeight.w400,
        fontFamily: "Akrobat",
      ),
    );
  }

  /// 构建赛果文本
  Widget _buildResultText() {
    final result = widget.ol.result!;
    final resultText = _getResultText(result);
    final textStyle = _getResultTextStyle(result);

    return Text(
      resultText,
      style: textStyle,
    );
  }

  /// 获取赛果文本
  String _getResultText(int result) {
    if ([0, 1, 2, 3, 4, 5, 6].contains(result)) {
      return "virtual_sports_result_$result".tr;
    }
    return LocaleKeys.virtual_sports_result_0.tr;
  }

  /// 获取赛果文本样式
  TextStyle _getResultTextStyle(int result) {
    final isWinOrHalfWin = (result == 4 || result == 5);
    final isVrDetail = Get.currentRoute == Routes.vrSportDetail;

    return TextStyle(
      fontSize: widget.isDetail ? (isIPad ? 19 : 15.sp) : 12.sp,
      color: isVrDetail
          ? Get.theme.oddsButtonVrResultValueFontColor
          : (isWinOrHalfWin
          ? ThemeConstant.vrOddsButtonWinColor
          : Get.theme.oddsButtonValueFontColor),
      fontWeight: FontWeight.w700,
      fontFamily: "Akrobat",
    );
  }

  /// 构建锁盘图标
  Widget _buildLock() {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: 16.w,
      height: 16.w,
    );
  }

  /// 构建图标显示（支持单图标和多图标）
  Widget _buildIconDisplay() {
    final iconKeys = _extractIconKeys();

    if (iconKeys.isEmpty) return const SizedBox();

    // 单图标直接返回
    if (iconKeys.length == 1) {
      return _buildSingleIcon(iconKeys.first);
    }

    // 多图标水平排列
    return _buildMultipleIcons(iconKeys);
  }

  /// 提取图标Key
  List<String> _extractIconKeys() {
    List<String> keys = [];

    if (widget.index != null) {
      // 使用索引作为排名（索引从0开始，显示需要+1）
      keys.add((widget.index! + 1).toString());
    } else if (widget.ol.on.contains("/")) {
      // 投注项名称可能包含多个排名，如 "1/2"
      keys.addAll(widget.ol.on.split("/").map((e) => e.trim()));
    }

    return keys;
  }

  /// 构建多个图标（带间距）
  Widget _buildMultipleIcons(List<String> iconKeys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconKeys.map((key) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: _buildSingleIcon(key),
        );
      }).toList(),
    );
  }

  /// 构建单个排名图标
  Widget _buildSingleIcon(String rankKey) {
    final csid = int.tryParse(widget.match.csid) ?? 1002;

    // 优先使用工具类获取图标路径
    String iconPath = VrRankIconUtils.getRankIcon(csid, rankKey);

    // 兜底图：使用通用排名图标
    if (iconPath.isEmpty) {
      iconPath = 'assets/images/vr/vr_dog_horse_rank$rankKey.png';
    }

    return ImageView(
      iconPath,
      width: _iconWidth,
    );
  }
}