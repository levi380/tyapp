import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:get/get.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../services/models/res/vr_match_entity.dart';
import '../../../../controllers/match_detail_controller.dart';
import '../../../../models/odds_button_enum.dart';

/// 赔率按钮状态混入类
/// 管理状态变量和数据变化逻辑
mixin OddsButtonStateMixin on State<OddsButton> {
  // 赔率变化状态：10表示红色上升，-10表示绿色下降，0表示无变化
  int status = 0;
  int status2 = 0; // 第二赔率状态，用于特殊玩法
  int oldOv = 0; // 记录旧的主赔率值
  int oldDov = 0; // 记录旧的副赔率值

  Timer? timer; // 主赔率变化计时器，用于3秒后清除变化状态
  Timer? timer2; // 副赔率变化计时器

  bool selected = false; // 是否被选中（用于高亮显示）

  // 投注类型：普通、VR体育、电竞等
  OddsBetType oddsBetType = OddsBetType.common;
  String? vrNo; // VR体育编号

  late Size size; // 组件大小

  // 是否显示优惠赔率
  bool addedOddsOpen = true;

  // 玩法集ID
  String curCategoryTabId = "0";

  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  /// 调整投注类型
  /// 根据当前路由设置不同的投注类型
  void adjustOddsBetType() {
    switch (Get.currentRoute) {
      case Routes.vrSportDetail:
        oddsBetType = OddsBetType.vr;
        VrMatchEntity? vrMatch = Get.arguments['vrMatch'];
        vrNo = vrMatch?.no;
        break;
      case Routes.DJView:
        oddsBetType = OddsBetType.esport;
        break;
      // 默认已经是 OddsBetType.common
    }
  }

  /// 处理赔率变化
  /// 监控赔率值变化并设置变化状态（红升绿降）
  void oddsChange(MatchHpsHlOl ol) {
    _handleMainOddsChange(ol);
    _handleSecondaryOddsChange(ol);
  }

  /// 处理主赔率变化
  void _handleMainOddsChange(MatchHpsHlOl ol) {
    if (ol.ov != oldOv) {
      status = 0; // 重置状态

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) return;

        setState(() {
          // 计算变化方向
          int oldValue = (oldOv / 1000).ceil();
          int newValue = (ol.ov / 1000).ceil();

          if (oldOv != 0) {
            if (newValue > oldValue) {
              status = 10; // 上升
            } else if (newValue < oldValue) {
              status = -10; // 下降
            } else {
              status = 0; // 无变化
            }
          }
          oldOv = ol.ov; // 更新旧值
        });

        // 启动计时器，3秒后清除变化状态
        timer?.cancel();
        timer = Timer.periodic(const Duration(seconds: 3), (t) {
          if (!mounted) return;

          setState(() {
            status = 0; // 清除变化状态
          });
          t.cancel();
        });
      });
    }
  }

  /// 处理副赔率变化
  void _handleSecondaryOddsChange(MatchHpsHlOl ol) {
    if (ol.dov != oldDov) {
      status2 = 0; // 重置状态

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) return;

        setState(() {
          // 计算变化方向
          int oldValue = (oldDov / 1000).ceil();
          int newValue = (ol.dov / 1000).ceil();

          if (oldDov != 0) {
            if (newValue > oldValue) {
              status2 = 10; // 上升
            } else if (newValue < oldValue) {
              status2 = -10; // 下降
            } else {
              status2 = 0; // 无变化
            }
          }
          oldDov = ol.dov; // 更新旧值
        });

        // 启动计时器，3秒后清除变化状态
        timer2?.cancel();
        timer2 = Timer.periodic(const Duration(seconds: 3), (t) {
          if (!mounted) return;

          setState(() {
            status2 = 0; // 清除变化状态
          });
          t.cancel();
        });
      });
    }
  }

  // 玩法集id
  void initCurCategoryTab() {
    if (widget.isDetail &&
        widget.match != null &&
        Get.isRegistered<MatchDetailController>(tag: widget.match!.mid)) {
      MatchDetailController detailController =
          Get.find<MatchDetailController>(tag: widget.match!.mid);
      curCategoryTabId = detailController.detailState.curCategoryTabId;
    }
  }
}
