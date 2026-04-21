import 'package:flutter/material.dart';

import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';


import '../../../../../../core/format/project/module/format-odds-conversion-mixin.dart';

import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';

import '../../../../constants/detail_constant.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';
import '../odds_button_widgets/added_odds_in_tab_widget.dart';
import '../odds_button_widgets/added_odds_widget.dart';
import 'odds_button_state_mixin.dart';
import 'odds_button_ui_mixin.dart';

/// 赔率按钮核心混入类
/// 负责主要的UI构建流程
mixin OddsButtonMixin on State<OddsButton>, OddsButtonStateMixin, OddsButtonUiMixin {

  /// 构建赔率按钮主体
  /// 根据赔率类型和配置返回不同的布局
  buildBody(MatchHpsHlOl ol, // 赔率数据
      MatchHpsHlOl valueol, // 显示用的赔率数据
      ) {
    // 安全检查：确保必要数据存在
    if (widget.match == null || widget.hps == null || widget.hl == null) {
      return lockImage(); // 数据缺失时显示锁图标
    }

    // 1、在玩法集tab  2、详情玩法集显示特殊优惠赔率组件
    if (curCategoryTabId == ADDED_ODDS_CATEGORY_ID &&
        (widget.ol?.isInAddedTab ?? false)) {
      return AddedOddsInTabWidget(
        ol: ol,
        match: widget.match!,
        hps: widget.hps!,
        hl: widget.hl!,
        fullscreen: widget.fullscreen,
        selected: selected,
        // status: status,
        status2: status2,
      );
    }

    // 详情页且开启优惠赔率时，显示优惠赔率组件
    if (addedOddsOpen && widget.isDetail) {
      return AddedOddsWidget(
        ol: ol,
        match: widget.match!,
        hps: widget.hps!,
        hl: widget.hl!,
        fullscreen: widget.fullscreen,
        selected: selected,
        status2: status2,
      );
    }

    // 根据方向返回垂直或水平布局
    return widget.direction == OddsTextDirection.vertical
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildContent(ol, valueol),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildContent(ol, valueol),
    );
  }

  /// 构建赔率内容
  /// 根据赔率状态（赛果、锁盘、开盘）返回不同的组件
  buildContent(MatchHpsHlOl ol, MatchHpsHlOl valueol) {
    // 1. 赛果展示：如果赔率有结果，显示赛果
    if (ol.result != null) {
      return buildResult(ol);
    }

    // 2. 计算赔率按钮状态
    OddsButtonState state = OddsUtil.betState(
        widget.match!.mhs, widget.hl!.hs, ol, widget.hps!.hsw,
        csid: widget.match!.csid);

    // 3. 获取赔率名称
    String oddsName = OddsUtil.oddsName(
        ol: ol,
        match: widget.match!,
        hps: widget.hps!,
        hl: widget.hl!,
        name: widget.name,
        playId: widget.playId);

    // 4. 锁盘状态处理
    if (state == OddsButtonState.lock) {
      return handleLockState(ol, oddsName);
    }
    // 5. 开盘状态处理
    else if (state == OddsButtonState.open) {
      return _handleOpenState(ol, valueol, oddsName);
    }
    // 6. 其他状态处理
    else {
      return _handleOtherState(ol);
    }
  }

  /// 处理开盘状态
  List<Widget> _handleOpenState(MatchHpsHlOl ol, MatchHpsHlOl valueol,
      String oddsName) {
    if (!widget.secondaryPaly) {
      // 非次级玩法：显示赔率名称和赔率值
      List<Widget> widgets = [];

      // 显示赔率名称的条件：
      // 1. 有赔率名称且赔率值有效，或
      // 2. 是详情页
      String oddsValue = TYFormatOddsConversionMixin.computeValueByCurOddType(
          valueol.ov,
          valueol.ov2,
          widget.hps!.hpid,
          widget.hps!.hsw.split(','),
          int.tryParse(widget.match!.csid) ?? 0,
          ol.cds);

      if ((oddsName.isNotEmpty && oddsValue != "-") || widget.isDetail) {
        widgets.add(buildOddsName(ol));
        if (widget.direction == OddsTextDirection.horizontal) {
          widgets.add(const SizedBox(width: 2));
        }
      }

      widgets.add(buildOddsValue(valueol));
      return widgets;
    } else {
      // 次级玩法：显示赔率名称和赔率值
      List<Widget> widgets = [];
      if (oddsName.isNotEmpty) {
        widgets.add(buildOddsName(ol));
        if (widget.direction == OddsTextDirection.horizontal) {
          widgets.add(const SizedBox(width: 2));
        }
      }
      widgets.add(buildOddsValue(valueol));
      return widgets;
    }
  }

  /// 处理其他状态（非锁盘、非开盘）
  List<Widget> _handleOtherState(MatchHpsHlOl ol) {
    if (widget.isDetail) {
      // 详情页：显示锁盘样式
      return buildLock(ol);
    }

    // 非详情页：根据条件显示占位符或锁图标
    if (!widget.secondaryPaly) {
      return [placeholder()];
    } else {
      return widget.playId == playIdConfig.hps15Minutes
          ? [placeholder()]
          : [lockImage()];
    }
  }
}
