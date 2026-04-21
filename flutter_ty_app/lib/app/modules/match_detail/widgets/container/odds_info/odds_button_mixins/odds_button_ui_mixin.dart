import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'package:get/get.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../../home/controllers/home_controller.dart';
import '../../../../constants/theme_constant.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';
import '../odds_button_widgets/detail_odds_name.dart';
import '../odds_button_widgets/odds_result.dart';
import 'odds_button_state_mixin.dart';

/// 赔率按钮UI组件混入类
/// 提供构建子组件的方法
mixin OddsButtonUiMixin on State<OddsButton>, OddsButtonStateMixin {
  /// 构建赔率名称组件
  Widget buildOddsName(MatchHpsHlOl ol, {Color? textColor}) {
    if (widget.isDetail) {
      // 详情页：使用专门的赔率名称组件
      return DetailOddsName(
        textColor: textColor,
        ol: ol,
        fullscreen: widget.fullscreen,
        selected: selected,
        match: widget.match,
        hps: widget.hps,
        hl: widget.hl,
      );
    } else {
      // 非详情页：计算赔率名称并显示
      String oddsName = OddsUtil.oddsName(
          ol: ol,
          match: widget.match!,
          hps: widget.hps!,
          hl: widget.hl!,
          name: widget.name,
          playId: widget.playId);

      if (oddsName.isEmpty) {
        return Container();
      }

      // 根据语言调整字体大小
      double sFontSize = isIPad ? 12.sp : 10.sp;
      if (OddsUtil.isBurmese(oddsName)) {
        sFontSize = isIPad ? 9.sp : 8.sp;
      }

      return Text(
        oddsName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textScaler: MediaQuery.textScalerOf(context),
        style: TextStyle(
          fontSize: widget.isDetail ? sFontSize : sFontSize.scale,
          color: textColor ?? widget.nameColor ?? _getOddsNameColor(),
          fontWeight: FontWeight.w400,
          fontFamily: 'PingFang SC',
        ),
      );
    }
  }

  /// 获取赔率名称颜色
  Color _getOddsNameColor() {
    if (selected) {
      return Get.theme.oddsButtonSelectFontColor;
    }
    return Get.isDarkMode
        ? const Color(0x4Dffffff) // 深色模式
        : const Color(0xFFAFB3C8); // 浅色模式
  }

  /// 构建赔率值组件
  Widget buildOddsValue(MatchHpsHlOl ol) {
    if (ol.result != null) {
      // 有赛果：显示赛果组件
      return OddsResult(
        ol: ol,
        isDetail: widget.isDetail,
      );
    }

    // 无赛果：显示赔率值（可能有变化状态）
    double detailFontSize = widget.fullscreen ? 15 : (isIPad ? 18.sp : 15.sp);
    if (['my'].contains(Get.locale?.languageCode)) {
      detailFontSize = widget.fullscreen ? 13 : (isIPad ? 17.sp : 13.sp);
    }

    // 确定使用哪个赔率值和状态
    String oddsValue;
    int tempStatus;

    if (ol.dov != 0) {
      // 使用副赔率
      oddsValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
          ol.dov,
          ol.ov2,
          widget.hps!.hpid,
          widget.hps!.hsw.split(','),
          int.tryParse(widget.match!.csid) ?? 0,
          ol.cds);
      tempStatus = status2;
    } else {
      // 使用主赔率
      oddsValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
          ol.ov,
          ol.ov2,
          widget.hps!.hpid,
          widget.hps!.hsw.split(','),
          int.tryParse(widget.match!.csid) ?? 0,
          ol.cds);
      tempStatus = status;
    }

    // 赔率值显示组件
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // 上升箭头
        if (tempStatus == 10 && oddsValue != "-")
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_up.svg',
              width: widget.fullscreen
                  ? 10
                  : (isIPad && widget.isDetail ? 15.w : 10.w),
            ),
          ),
        // 下降箭头
        if (tempStatus == -10 && oddsValue != "-")
          Positioned(
            left: 0,
            child: ImageView(
              'assets/images/detail/odds_down.svg',
              width: widget.fullscreen
                  ? 10
                  : (isIPad && widget.isDetail ? 15.w : 10.w),
            ),
          ),
        // 赔率值文本（特殊玩法除外）
        if (!playIdConfig.customGallbladder.contains(widget.hps!.hpid))
          Text(
            oddsValue,
            maxLines: 1,
            textScaler: MediaQuery.textScalerOf(context),
            style: TextStyle(
              fontSize: _getOddsValueFontSize(detailFontSize),
              color: _getOddsValueColor(tempStatus, oddsValue),
              fontWeight: FontWeight.bold,
              fontFamily: "Akrobat",
            ),
          ).marginOnly(
            left: _getOddsValueMarginLeft(),
            right: widget.direction == OddsTextDirection.vertical
                ? _getOddsValueMarginRight()
                : 0,
          )
      ],
    );
  }

  /// 获取赔率值字体大小
  double _getOddsValueFontSize(double detailFontSize) {
    if (widget.isDetail) {
      return detailFontSize;
    }

    if (size.width <= 360) {
      return 10.sp.scale;
    }

    return isIPad ? 14.sp.scale : 12.sp.scale;
  }

  /// 获取赔率值颜色
  Color _getOddsValueColor(int tempStatus, String oddsValue) {
    // 无变化或无效赔率值
    if (tempStatus == 0 || oddsValue == "-") {
      if (selected) {
        return widget.fullscreen
            ? Colors.white.withValues(alpha: 0.9)
            : Get.theme.oddsButtonSelectFontColor;
      }
      return widget.fullscreen
          ? Colors.white.withValues(alpha: 0.9)
          : Get.theme.oddsButtonValueFontColor;
    }

    // 变化状态颜色
    return tempStatus == 10
        ? ThemeConstant.oddsRiseColor // 红色上升
        : ThemeConstant.oddsFallColor; // 绿色下降
  }

  /// 获取赔率值左边距
  double _getOddsValueMarginLeft() {
    return widget.fullscreen ? 10 : (isIPad && widget.isDetail ? 15.w : 10.w);
  }

  /// 获取赔率值右边距（垂直布局时使用）
  double _getOddsValueMarginRight() {
    return widget.fullscreen ? 10 : (isIPad && widget.isDetail ? 15.w : 10.w);
  }

  /// 锁图标组件
  Widget lockImage() {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: widget.fullscreen ? 16 : (isIPad ? 25 : 16),
    );
  }

  /// 占位符组件
  Widget placeholder() {
    return Text(
      "-",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: widget.fullscreen
            ? Colors.white.withValues(alpha: 0.5)
            : Get.theme.oddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 波胆玩法空数据处理
  /// 根据波胆数据是否完整决定显示占位符还是锁图标
  Widget bodanClose() {
    bool hasFirstMap = TyHomeController.to.firstMap != null;
    bool hasLastMap = TyHomeController.to.lastMap != null;

    // 两个map都没有
    if (!hasFirstMap && !hasLastMap) {
      return placeholder();
    }

    // 只有firstMap且是type=1
    if (!hasLastMap && hasFirstMap && widget.type == 1) {
      return placeholder();
    }

    // 只有lastMap且是type=0
    if (hasLastMap && !hasFirstMap && widget.type == 0) {
      return placeholder();
    }

    // 其他情况显示锁图标
    return lockImage();
  }

  /// 构建赛果显示
  List<Widget> buildResult(MatchHpsHlOl valueol) {
    return [
      buildOddsName(valueol),
      if (widget.direction == OddsTextDirection.horizontal)
        const SizedBox(width: 2),
      buildOddsValue(valueol),
    ];
  }

  /// 构建锁盘显示（详情页用）
  List<Widget> buildLock(MatchHpsHlOl ol) {
    List<Widget> widgets = [];

    // 详情页且非VR体育：显示赔率名称
    if (widget.isDetail && Get.currentRoute != Routes.vrSportDetail) {
      widgets.add(buildOddsName(ol).marginOnly(bottom: 2));
    }

    // 锁图标
    widgets.add(lockImage());
    return widgets;
  }

  /// 构建列表锁盘显示
  List<Widget> buildListLock(MatchHpsHlOl ol,
      {Color? textColor, bool isShowLock = true}) {
    List<Widget> widgets = [];

    // 非VR体育：显示赔率名称
    if (Get.currentRoute != Routes.vrSportDetail) {
      widgets.add(
          buildOddsName(ol, textColor: textColor).marginOnly(bottom: 4.h));
    }

    // 是否显示锁图标
    if (isShowLock) {
      widgets.add(lockImage());
    }

    return widgets;
  }

  /// 处理锁盘状态
  List<Widget> handleLockState(MatchHpsHlOl ol, String oddsName) {
    // 检查是否为胆拖玩法（customGallbladder）
    bool isGallbladder =
        playIdConfig.customGallbladder.contains(widget.hps!.hpid);

    if (isGallbladder) {
      return _buildGallbladderLock(ol, oddsName);
    } else {
      return _buildNormalLock(ol, oddsName);
    }
  }

  /// 构建胆拖玩法的锁盘显示
  List<Widget> _buildGallbladderLock(MatchHpsHlOl ol, String oddsName) {
    if (widget.isDetail) {
      // 详情页：显示文字和锁图标
      return buildListLock(
        ol,
        textColor: context.isDarkMode ? Colors.black : Colors.black26,
        isShowLock: true,
      );
    } else if (!widget.secondaryPaly) {
      // 非详情页且非次级玩法：显示文字（无锁图标）
      return buildListLock(
        ol,
        textColor: context.isDarkMode ? Colors.black : Colors.black26,
        isShowLock: false,
      );
    } else {
      // 次级玩法：特殊处理波胆和组合玩法
      if (widget.playId == playIdConfig.hpsBold ||
          widget.playId == playIdConfig.hpsCompose) {
        return [placeholder()];
      }

      // 其他次级玩法：只显示赔率名称（如果有）
      if (oddsName.isNotEmpty && widget.playId != playIdConfig.hpsBold) {
        return [buildOddsName(ol)];
      }

      return [];
    }
  }

  /// 构建普通玩法的锁盘显示
  List<Widget> _buildNormalLock(MatchHpsHlOl ol, String oddsName) {
    if (widget.isDetail) {
      // 详情页：显示赔率名称和锁图标
      return buildLock(ol);
    } else if (!widget.secondaryPaly) {
      // 非详情页且非次级玩法：显示列表锁样式
      return buildListLock(ol);
    } else {
      // 次级玩法：波胆或组合玩法显示锁图标，其他显示赔率名称+锁图标
      if (widget.playId == playIdConfig.hpsBold ||
          widget.playId == playIdConfig.hpsCompose) {
        return [lockImage()];
      }

      List<Widget> widgets = [];
      if (oddsName.isNotEmpty && widget.playId != playIdConfig.hpsBold) {
        widgets.add(buildOddsName(ol));
      }
      widgets.add(lockImage());
      return widgets;
    }
  }
}
