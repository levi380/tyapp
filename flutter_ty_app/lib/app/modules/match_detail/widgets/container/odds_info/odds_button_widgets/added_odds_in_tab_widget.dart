import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../../main.dart';
import '../../../../../../core/format/project/module/format-odds-conversion-mixin.dart';

import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../models/odds_button_enum.dart';

/**
 * 优惠赔率（玩法集）组件
 *
 * 用于在赛事详情页的玩法标签中展示带有优惠折扣的赔率项
 * 主要特点：
 * - 支持锁盘状态（不可投注）
 * - 支持赔率升降指示（红升绿降）
 * - 显示原始赔率和优惠后的赔率
 * - 适配全屏/非全屏模式
 * - 支持缅甸语等特殊语言的字体大小适配
 */
class AddedOddsInTabWidget extends StatefulWidget {
  const AddedOddsInTabWidget({
    super.key,
    required this.ol,
    required this.match,
    required this.hps,
    required this.hl,
    required this.fullscreen,
    this.status = 0,
    this.status2 = 0,
    required this.selected,
  });

  /// 赔率选项数据（包含赔率值、名称等信息）
  final MatchHpsHlOl ol;

  /// 比赛实体数据
  final MatchEntity match;

  /// 玩法集数据
  final MatchHps hps;

  /// 盘口数据
  final MatchHpsHl hl;

  /// 是否全屏模式（影响字体大小和布局）
  final bool fullscreen;

  /// 主赔率状态：10=上升，-10=下降，0=无变化
  final int status;

  /// 优惠后赔率状态：10=上升，-10=下降，0=无变化
  final int status2;

  /// 当前玩法是否被选中
  final bool selected;

  @override
  State<AddedOddsInTabWidget> createState() => _AddedOddsInTabWidgetState();
}

class _AddedOddsInTabWidgetState extends State<AddedOddsInTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildContent(widget.ol),
    );
  }

  /**
   * 根据赔率状态构建对应的内容
   *
   * 赔率状态判断逻辑：
   * - lock: 锁盘状态，显示赔率名称+锁图标
   * - open: 可投注状态，显示赔率名称+赔率值（含优惠）
   * - 其他状态：默认为锁盘状态
   *
   * @param ol 赔率选项数据
   * @return 组件列表
   */
  _buildContent(MatchHpsHlOl ol) {
    // 获取赔率按钮状态（锁定/开启）
    OddsButtonState state = OddsUtil.betState(
        widget.match.mhs, widget.hl.hs, ol, widget.hps.hsw,
        csid: widget.match.csid);

    if (state == OddsButtonState.lock) {
      // 锁盘状态：只显示名称和锁图标
      return _buildLock(ol);
    } else if (state == OddsButtonState.open) {
      // 可投注状态：显示名称和赔率值
      return <Widget>[
        // 赔率名称（左侧）
        Expanded(
          child: _buildOddsName(ol).marginOnly(left: 8),
        ),
        // 赔率值（右侧，包含原始赔率和优惠赔率）
        _buildOddsValue(ol),
      ];
    } else {
      // 其他状态默认锁盘
      return _buildLock(ol);
    }
  }

  /// 构建赔率名称文本
  Widget _buildOddsName(MatchHpsHlOl ol) {
    // 获取格式化的赔率名称
    String name = OddsUtil.getOddsName(ol, widget.hps, widget.match);

    // 根据显示模式设置字体大小
    double sFontSize = widget.fullscreen
        ? 12
        : isIPad
            ? 16.sp
            : 12.sp;

    // 缅甸语特殊处理：字体调小（缅甸语字符较复杂）
    if (OddsUtil.isBurmese(name)) {
      sFontSize = widget.fullscreen
          ? 10
          : isIPad
              ? 14.sp
              : 8.sp;
    }

    // 构建赔率名称文本
    // ppHps?.hpn: 玩法集名称（如"让球"），name: 具体选项名称（如"主队"）
    return Text(
      (widget.ol.ppHps?.hpn ?? "") + " " + name,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: sFontSize,
        // 选中状态下的颜色处理
        color: widget.selected
            ? widget.fullscreen
                ? Colors.white.withValues(alpha: 0.9) // 全屏选中：白色半透明
                : Get.theme.oddsButtonNameFontColor // 非全屏选中：主题色
            : widget.fullscreen
                ? Colors.white.withValues(alpha: 0.3) // 全屏未选中：浅白色
                : Get.theme.oddsButtonNameFontColor, // 非全屏未选中：主题色
        fontWeight: FontWeight.w400,
        fontFamily: "PingFang SC",
      ),
    );
  }

  /// 构建赔率值（包含原始赔率和优惠后赔率）
  Widget _buildOddsValue(MatchHpsHlOl ol) {
    // 基础字体大小设置
    double detailFontSize = widget.fullscreen ? 15 : (isIPad ? 18.sp : 15.sp);

    // 缅甸语特殊字体大小（缅甸语数字显示较小）
    if (['my'].contains(Get.locale?.languageCode)) {
      detailFontSize = widget.fullscreen ? 13 : (isIPad ? 17.sp : 13.sp);
    }

    // 原始赔率值（根据当前赔率类型转换格式）
    String oddsValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
        ol.ov,
        ol.ov2,
        widget.hps.hpid,
        widget.hps.hsw.split(','),
        int.tryParse(widget.match.csid) ?? 0,
        ol.cds);

    // 优惠后赔率值（根据当前赔率类型转换格式）
    String dovValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
        ol.dov,
        ol.ov2,
        widget.hps.hpid,
        widget.hps.hsw.split(','),
        int.tryParse(widget.match.csid) ?? 0,
        ol.cds);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // 主赔率上升指示器（红箭头向上）
        if (widget.status == 10 || widget.status2 == 10)
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_up.svg',
              width: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
            ),
          ),

        // 主赔率下降指示器（绿箭头向下）
        if (widget.status == -10 || widget.status2 == -10)
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_down.svg',
              width: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
            ),
          ),

        // 赔率值主体（原始赔率 + 箭头 + 优惠赔率）
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 原始赔率（带删除线）
            Text(
              oddsValue,
              maxLines: 1,
              style: TextStyle(
                  fontSize: detailFontSize,
                  // 红升绿降：根据status设置颜色
                  color: widget.status == 0
                      ? (widget.selected
                          ? widget.fullscreen
                              ? Colors.white.withValues(alpha: 0.9)
                              : Get.theme.oddsButtonNameFontColor
                          : widget.fullscreen
                              ? Colors.white.withValues(alpha: 0.9)
                              : Get.theme.oddsButtonNameFontColor)
                      : widget.status == 10
                          ? const Color(0xFFE95B5B) // 红色（上升）
                          : const Color(0xFF4AB06A),
                  // 绿色（下降）
                  fontWeight: FontWeight.w600,
                  fontFamily: "Akrobat",
                  decoration: TextDecoration.lineThrough), // 删除线表示原始赔率
            ),

            // 右箭头（指向优惠后的赔率）
            ImageView(
              "assets/images/discount_odd/arrow_right.png",
              width: widget.fullscreen ? 10 : 10.w,
            ).marginOnly(left: widget.fullscreen ? 2 : 2.w),

            // 优惠后赔率
            Text(
              dovValue,
              maxLines: 1,
              style: TextStyle(
                fontSize: detailFontSize,
                // 红升绿降：根据status2设置颜色
                color: widget.status2 == 0
                    ? (widget.selected
                        ? widget.fullscreen
                            ? Color(0xFF127DCC) // 选中状态：蓝色
                            : Get.theme.oddsButtonValueFontColor
                        : widget.fullscreen
                            ? Color(0xFF127DCC) // 全屏默认：蓝色
                            : Get.theme.oddsButtonValueFontColor)
                    : widget.status2 == 10
                        ? const Color(0xFFE95B5B) // 红色（上升）
                        : const Color(0xFF4AB06A), // 绿色（下降）
                fontWeight: FontWeight.w600,
                fontFamily: "Akrobat",
              ),
            ).marginOnly(
                left: widget.fullscreen ? 2 : 2.w,
                right: widget.fullscreen ? 2 : 2.w),
          ],
        ).marginOnly(
            left: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
            right: (widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w)))
      ],
    );
  }

  /**
   * 构建锁盘状态下的内容
   *
   * 锁盘时只显示赔率名称和锁图标，不显示赔率值
   *
   * @param ol 赔率选项数据
   * @return 组件列表
   */
  _buildLock(MatchHpsHlOl ol) {
    return <Widget>[
      // 赔率名称
      _buildOddsName(ol).marginOnly(left: 8),
      const Spacer(),
      // 锁图标
      _lockImage().marginOnly(right: 8),
    ];
  }

  /// 构建锁盘图标
  Widget _lockImage() {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: widget.fullscreen
          ? 16
          : isIPad
              ? 25.w
              : 16.w,
    );
  }
}
