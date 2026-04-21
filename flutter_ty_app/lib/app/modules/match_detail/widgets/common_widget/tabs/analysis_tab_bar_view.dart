import 'package:flutter/material.dart';
import '../../../../../widgets/keep_alive_wrapper.dart';

class AnalysisTabBarView extends TabBarView {
  /// 是否可以滑动切换
  final bool isSlideSwitch;

  AnalysisTabBarView({
    super.key,
    required List<Widget> children,
    super.controller,
    this.isSlideSwitch = false,
  }) : super(
          children: children.map((e) => KeepAliveWrapper(child: e)).toList(),
          physics: isSlideSwitch
              ? const ScrollPhysics()
              : const NeverScrollableScrollPhysics(),
        );
}
