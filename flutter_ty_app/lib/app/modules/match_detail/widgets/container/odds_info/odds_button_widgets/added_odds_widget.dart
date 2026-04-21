import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../../main.dart';
import '../../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';
import '../../../../../../utils/sport.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../models/odds_button_enum.dart';

/**
 * 优惠赔率组件
 *
 * 【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
 * 【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
 * 【【【 AUTO_DOCUMENT_TITLE 数据】】】
 * 【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
 * 【【【 AUTO_PARAGRAPH_CONTENT
 * - 优惠赔率
 * 】】】
 *
 * 该组件用于在赛事分析页面展示带有优惠折扣的赔率项
 * 主要特点：
 * - 垂直布局（Column），适用于分析页面的展示风格
 * - 支持锁盘状态（不可投注）
 * - 支持赔率升降指示（红升绿降）
 * - 显示原始赔率和优惠后的赔率（带箭头指向）
 * - VR体育特殊处理：锁盘时不显示赔率名称
 */
class AddedOddsWidget extends StatefulWidget {
  const AddedOddsWidget({
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
  State<AddedOddsWidget> createState() => _AddedOddsWidgetState();
}

class _AddedOddsWidgetState extends State<AddedOddsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildContent(widget.ol),
    );
  }

  /**
   * 根据赔率状态构建对应的内容
   *
   * 赔率状态判断逻辑：
   * - lock: 锁盘状态，根据体育类型显示锁图标（VR体育不显示赔率名称）
   * - open: 可投注状态，显示赔率名称（上方）+赔率值（下方）
   * - 其他状态：默认为锁盘状态
   *
   * @param ol 赔率选项数据
   * @return 组件列表（垂直排列）
   */
  _buildContent(MatchHpsHlOl ol) {
    // 获取赔率按钮状态（锁定/开启）
    OddsButtonState state = OddsUtil.betState(
        widget.match.mhs, widget.hl.hs, ol, widget.hps.hsw,
        csid: widget.match.csid);

    if (state == OddsButtonState.lock) {
      // 锁盘状态：根据体育类型决定是否显示名称
      return _buildLock(ol);
    } else if (state == OddsButtonState.open) {
      // 可投注状态：上方显示赔率名称，下方显示赔率值
      return <Widget>[
        _buildOddsName(ol), // 赔率名称（上方）
        _buildOddsValue(ol), // 赔率值（下方）
      ];
    } else {
      // 其他状态默认锁盘
      return _buildLock(ol);
    }
  }

  /// 构建赔率名称文本（位于上方）
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

    // 构建赔率名称文本（单行显示，溢出省略）
    return Text(
      name, // 直接显示赔率名称，不拼接玩法集名称
      overflow: TextOverflow.ellipsis,
      maxLines: 1, // 单行显示（与InTab版本不同）
      style: TextStyle(
        fontSize: sFontSize,
        // 选中状态下的颜色处理
        color: widget.selected
            ? widget.fullscreen
                ? Colors.white.withValues(alpha: 0.9) // 全屏选中：白色半透明
                : Get.theme.addedOddsButtonNameFontColor // 非全屏选中：主题色
            : widget.fullscreen
                ? Colors.white.withValues(alpha: 0.3) // 全屏未选中：浅白色
                : Get.theme.addedOddsButtonNameFontColor, // 非全屏未选中：主题色
        fontWeight: FontWeight.w400,
        fontFamily: "PingFang SC",
      ),
    );
  }

  /// 构建赔率值（包含原始赔率和优惠后赔率，位于下方）
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
        // 主赔率上升指示器（红箭头向上）- 位于左侧
        if (widget.status == 10 || widget.status2 == 10)
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_up.svg',
              width: widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w),
            ),
          ),

        // 主赔率下降指示器（绿箭头向下）- 位于左侧
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
                              : Get.theme.addedOddsButtonNameFontColor
                          : widget.fullscreen
                              ? Colors.white.withValues(alpha: 0.9)
                              : Get.theme.addedOddsButtonNameFontColor)
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
                            : Get.theme.addedOddsButtonValueFontColor
                        : widget.fullscreen
                            ? Color(0xFF127DCC) // 全屏默认：蓝色
                            : Get.theme.addedOddsButtonValueFontColor)
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
   * 锁盘时根据体育类型决定显示：
   * - VR体育 (csid=1)：只显示锁图标，不显示赔率名称
   * - 其他体育：显示赔率名称 + 锁图标（垂直排列）
   *
   * @param ol 赔率选项数据
   * @return 组件列表
   */
  _buildLock(MatchHpsHlOl ol) {
    return <Widget>[
      // 赔率名称 - VR体育锁盘不展示赔率项名称
      // SportData.sportCsid_1.toString() = "1" (VR体育)
      if (widget.match.csid != SportData.sportCsid_1.toString() &&
          Get.currentRoute != Routes.vrSportDetail)
        _buildOddsName(ol),

      // 锁图标
      _lockImage()
    ];
  }

  /// 构建锁盘图标
  _lockImage() {
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
