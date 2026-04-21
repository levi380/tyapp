import 'package:flutter/material.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-4519467f-4c76-4f54-82a5-15e23fc90cf8 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 注单等待状态动画 】】】
    【【【 AUTO_PARAGRAPH_TITLE 动画实现】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 对一键投注的等待订单进行动画提示
    - 使用RotationTransition 旋转动画
    ```
    RotationTransition(
    turns: _controller,
    alignment: Alignment.center, // 沿着中心旋转
    child: widgets.child,
    )
    ```
    - 动画参数： 图片中心 每秒 360度旋转
    ```
    alignment: Alignment.center, // 沿着中心旋转
    AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
    )
    ```
    - 类似加载动画
    】】】
 *
 */
class BetWaitAnimate extends StatefulWidget {
  const BetWaitAnimate({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<BetWaitAnimate> createState() => _BetWaitAnimateState();
}

class _BetWaitAnimateState extends State<BetWaitAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..addStatusListener((status) {
        // 循环旋转
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      alignment: Alignment.center,
      child: widget.child,
    );
  }
}
