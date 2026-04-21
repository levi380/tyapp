import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../global/data_store_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../utils/odds_util.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
import '../../../models/odds_button_enum.dart';

/**
 * 冠军投注按钮组件
 * 功能：显示赔率按钮，支持变赔动画、赛果展示、锁定状态、选中状态
 */
class ChampionOddsButton extends StatefulWidget {
  const ChampionOddsButton({
    super.key,
    this.width,
    this.height,
    this.name,
    this.direction = OddsTextDirection.vertical,
    this.match,
    this.hps,
    this.ol,
    required this.betType,
    this.fullscreen = false,
    this.radius,
  });

  final double? width;
  final double? height;
  final MatchEntity? match;
  final MatchHps? hps;
  final MatchHpsHlOl? ol;

  /// 投注项文本（不同模板拼接方式不同）
  final String? name;

  /// 文本排列方向：水平或垂直
  final OddsTextDirection direction;

  final OddsBetType betType;
  final bool fullscreen;

  /// 圆角大小
  final double? radius;

  @override
  State<ChampionOddsButton> createState() => _ChampionOddsButtonState();
}

class _ChampionOddsButtonState extends State<ChampionOddsButton> {
  /// 赔率变化状态：10 红升，-10 绿降，0 无变化
  int status = 0;

  /// 记录旧赔率，用于比较变化
  int oldOv = 0;

  Timer? timer;
  bool selected = false; // 是否选中

  /// 投注类型
  OddsBetType oddsBetType = OddsBetType.common;

  @override
  void initState() {
    oddsBetType = widget.betType;

    // 初始化旧赔率
    if (widget.ol != null) {
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
    }

    // 监听购物车更新事件，同步选中状态
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.ol?.oid);
        if (selected != checked) {
          setState(() {
            selected = checked;
          });
        }
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChampionOddsButton oldWidget) {
    selected = ShopCartController.to.isCheck(widget.ol?.oid);

    // 更新旧赔率（非详情页时更新）
    if (oldWidget.ol != widget.ol &&
        widget.ol != null &&
        Get.currentRoute != Routes.matchDetail) {
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 空数据处理：显示占位符
    if (widget.ol == null || ObjectUtil.isEmpty(widget.ol?.oid)) {
      return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.fullscreen
              ? Colors.white.withValues(alpha:0.08)
              : Get.theme.oddsButtonBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 4.w)),
        ),
        child: _buildPlaceholder(),
      );
    }

    selected = ShopCartController.to.isCheck(widget.ol?.oid);

    // 使用GetBuilder监听赔率数据变化
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getOid(widget.ol!.oid),
        builder: (controller) {
          // 获取最新的赔率数据
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
          _handleOddsChange(ol); // 处理赔率变化动画

          return InkWell(
            onTap: () => _handleButtonTap(context, ol),
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              padding: widget.direction == OddsTextDirection.horizontal
                  ? EdgeInsets.symmetric(
                  horizontal: widget.fullscreen ? 8 : 8.w)
                  : EdgeInsets.zero,
              decoration: _buildContainerDecoration(),
              child: _buildBody(widget.ol!, ol),
            ),
          );
        });
  }

  /// 构建容器装饰（背景色、圆角、阴影）
  ShapeDecoration _buildContainerDecoration() {
    return ShapeDecoration(
      color: selected
          ? widget.fullscreen
          ? Colors.white.withValues(alpha:0.2)
          : Get.theme.oddsButtonSelectedBackgroundColor
          : widget.fullscreen
          ? Colors.white.withValues(alpha:0.08)
          : Get.theme.oddsButtonBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 8)),
      shadows: [
        BoxShadow(
          color: widget.fullscreen
              ? Colors.transparent
              : Get.theme.oddsButtonShadowColor,
          blurRadius: 8,
          offset: Offset(0, 2.h),
          spreadRadius: 0,
        )
      ],
    );
  }

  /// 处理按钮点击事件
  void _handleButtonTap(BuildContext context, MatchHpsHlOl ol) {
    // 隐藏键盘
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    // 检查是否可以投注：有比赛数据、有盘口数据、无赛果、开盘状态
    if (widget.match != null &&
        widget.hps != null &&
        ol.result == null &&
        ol.os == 1) {
      ShopCartController.to.addBet(
        widget.match!,
        widget.hps!,
        null,
        ol,
        betType: oddsBetType,
        isDetail: true,
      );

      // 更新选中状态
      setState(() {
        selected = ShopCartController.to.isCheck(widget.ol?.oid);
      });
    }
  }

  /// 构建主体内容
  Widget _buildBody(MatchHpsHlOl ol, MatchHpsHlOl valueol) {
    if (widget.match == null || widget.hps == null) {
      return _buildClose(ol: valueol); // 占位符
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildContent(ol, valueol),
    );
  }

  /// 构建内容子组件（根据开盘状态区分）
  List<Widget> _buildContent(MatchHpsHlOl ol, MatchHpsHlOl valueol) {
    if (valueol.os == 1) {
      // 开盘状态：显示赔率名称和值
      return <Widget>[
        Expanded(child: _buildOddsName(valueol)),
        _buildOddsValue(valueol),
      ];
    } else {
      // 关盘状态：显示锁
      return _buildLock(valueol);
    }
  }

  /// 构建赔率值组件（支持变赔动画和赛果展示）
  Widget _buildOddsValue(MatchHpsHlOl ol) {
    // 无赛果：显示赔率
    if (ol.result == null) {
      return _buildOddsValueWithAnimation(ol);
    } else {
      // 有赛果：显示赛果文本
      return _buildResultText(ol);
    }
  }

  /// 构建带动画的赔率值
  Widget _buildOddsValueWithAnimation(MatchHpsHlOl ol) {
    double detailFontSize = _getOddsValueFontSize();

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // 上涨箭头
        if (status == 10)
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_up.svg',
              width: _getIconSize(),
            ),
          ),
        // 下跌箭头
        if (status == -10)
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_down.svg',
              width: _getIconSize(),
            ),
          ),
        // 赔率数值
        Text(
          _formatOddsValue(ol),
          maxLines: 1,
          style: TextStyle(
            fontSize: detailFontSize,
            color: _getOddsValueColor(),
            fontWeight: FontWeight.bold,
            fontFamily: "Akrobat",
          ),
        ).marginOnly(
            left: _getOddsValueLeftMargin(),
            right: _getOddsValueRightMargin()),
      ],
    );
  }

  /// 获取图标大小
  double _getIconSize() {
    return widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w);
  }

  /// 获取赔率值左侧边距
  double _getOddsValueLeftMargin() {
    return widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w);
  }

  /// 获取赔率值右侧边距
  double _getOddsValueRightMargin() {
    return widget.direction == OddsTextDirection.vertical
        ? (widget.fullscreen ? 10 : (isIPad ? 15.w : 10.w))
        : 0;
  }

  /// 获取赔率值字体大小
  double _getOddsValueFontSize() {
    double size = widget.fullscreen ? 15 : (isIPad ? 18.sp : 15.sp);
    if (['my'].contains(Get.locale?.languageCode)) {
      size = widget.fullscreen ? 13 : (isIPad ? 17.sp : 13.sp);
    }

    // 详情页以外的页面需要缩放
    if (Get.currentRoute != Routes.matchDetail) {
      size = size.scale;
    }
    return size;
  }

  /// 获取赔率值颜色（根据状态和选中状态）
  Color _getOddsValueColor() {
    if (status != 0) {
      return status == 10 ? const Color(0xFFE95B5B) : const Color(0xFF4AB06A);
    }

    if (selected) {
      return widget.fullscreen
          ? Colors.white.withValues(alpha:0.9)
          : Get.theme.oddsButtonSelectFontColor;
    }

    return widget.fullscreen
        ? Colors.white.withValues(alpha:0.9)
        : Get.theme.oddsButtonValueFontColor;
  }

  /// 格式化赔率值
  String _formatOddsValue(MatchHpsHlOl ol) {
    return TYFormatOddsConversionMixin.computeValueByCurOddType(
      ol.ov,
      ol.ov2,
      widget.hps!.hpid,
      ["1"], // 冠军只有欧赔
      int.tryParse(widget.match!.csid) ?? 0,
      ol.cds,
    );
  }

  /// 构建赛果文本
  Widget _buildResultText(MatchHpsHlOl ol) {
    int result = ol.result!;
    String resultText = _getResultText(result);
    double fontSize = _getResultFontSize(resultText);

    return Text(
      resultText,
      maxLines: 1,
      style: TextStyle(
        fontSize: fontSize,
        color: _getResultColor(result),
        fontWeight: _getResultFontWeight(),
        fontFamily: "Akrobat",
      ),
    );
  }

  /// 获取赛果文本
  String _getResultText(int result) {
    if ([0, 1, 2, 3, 4, 5, 6].contains(result)) {
      return "virtual_sports_result_$result".tr;
    }
    return LocaleKeys.virtual_sports_result_0.tr;
  }

  /// 获取赛果字体大小
  double _getResultFontSize(String text) {
    double size = isIPad ? 17.sp : 15.sp;
    if (OddsUtil.isBurmese(text)) {
      size = isIPad ? 12.sp : 11.sp;
    }

    if (Get.currentRoute != Routes.matchDetail) {
      size = size.scale;
    }
    return size;
  }

  /// 获取赛果颜色
  Color _getResultColor(int result) {
    if (Get.currentRoute == Routes.vrSportDetail) {
      return Get.theme.oddsButtonVrResultValueFontColor;
    }

    return (result == 4 || result == 5)
        ? const Color(0xFFE95B5B)
        : Get.theme.oddsButtonValueFontColor;
  }

  /// 获取赛果字体粗细
  FontWeight _getResultFontWeight() {
    return Get.currentRoute == Routes.vrSportDetail
        ? FontWeight.w700
        : FontWeight.w400;
  }

  /// 处理赔率变化（变赔动画）
  void _handleOddsChange(MatchHpsHlOl ol) {
    if (ol.ov == oldOv) return;

    // 延迟一帧执行动画，避免布局冲突
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;

      setState(() {
        _updateOddsChangeStatus(ol);
      });

      // 3秒后清除动画状态
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 3), (t) {
        if (mounted) {
          setState(() {
            status = 0;
            t.cancel();
          });
        }
      });
    });
  }

  /// 更新赔率变化状态
  void _updateOddsChangeStatus(MatchHpsHlOl ol) {
    if (oldOv != 0) {
      int newValue = (ol.ov / 1000).ceil();
      int oldValue = (oldOv / 1000).ceil();

      if (newValue > oldValue) {
        status = 10; // 上涨
      } else if (newValue < oldValue) {
        status = -10; // 下跌
      } else {
        status = 0; // 无变化
      }
    } else {
      status = 0;
    }
    oldOv = ol.ov;
  }

  /// 构建关闭/锁定状态
  Widget _buildClose({MatchHpsHlOl? ol}) {
    return _buildLockImage();
  }

  /// 构建锁定状态的组件列表
  List<Widget> _buildLock(MatchHpsHlOl ol) {
    return <Widget>[
      // 非VR体育且非详情页时显示赔率名称
      if (widget.match?.csid != "1" && Get.currentRoute != Routes.vrSportDetail)
        _buildOddsName(ol),
      _buildLockImage(),
    ];
  }

  /// 构建锁图标
  Widget _buildLockImage() {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: widget.fullscreen ? 16 : (isIPad ? 25 : 16),
    );
  }

  /// 构建占位符
  Widget _buildPlaceholder() {
    return Text(
      "-",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: widget.fullscreen
            ? Colors.white.withValues(alpha:0.5)
            : Get.theme.oddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 构建赔率名称
  Widget _buildOddsName(MatchHpsHlOl ol) {
    String name = ObjectUtil.isEmptyString(ol.on) ? ol.ot : ol.on;
    double fontSize = _getOddsNameFontSize(name);

    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        color: _getOddsNameColor(),
        fontWeight: FontWeight.w400,
        fontFamily: "PingFang SC",
      ),
    );
  }

  /// 获取赔率名称字体大小
  double _getOddsNameFontSize(String name) {
    double size = widget.fullscreen
        ? 12
        : isIPad ? 16.sp : 12.sp;

    if (OddsUtil.isBurmese(name)) {
      size = widget.fullscreen
          ? 10
          : isIPad ? 14.sp : 8.sp;
    }

    if (Get.currentRoute != Routes.matchDetail) {
      size = size.scale;
    }
    return size;
  }

  /// 获取赔率名称颜色
  Color _getOddsNameColor() {
    if (selected) {
      return widget.fullscreen
          ? Colors.white.withValues(alpha:0.9)
          : Get.theme.oddsButtonSelectFontColor;
    }

    return widget.fullscreen
        ? Colors.white.withValues(alpha:0.5)
        : Get.theme.oddsButtonNameFontColor;
  }
}