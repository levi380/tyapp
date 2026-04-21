import 'package:flutter/material.dart';

import '../../../../../widgets/image_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注列表+赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情玩法组件集合】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    -  箭头动画
    】】】
 *
 */
class ArrowAnimation extends StatefulWidget {
  const ArrowAnimation({super.key});
  @override
  State<ArrowAnimation> createState() => _ArrowAnimationState();
}

class _ArrowAnimationState extends State<ArrowAnimation> {
  bool _isVisible = true;
  double _positionX = 5;

  @override
  void initState() {
    super.initState();
    // _startBlinking();
    _startMoving();
  }

  void _startMoving() {
    // Future.delayed(const Duration(milliseconds: 700), () {
    //   if (mounted) {
    //     setState(() {
    //       _positionX = _positionX == 0.0 ? 5.w : 0.0;
    //     });
    //     _startMoving();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: 12,
        height: 8,
        child: Stack(
          children: [
            AnimatedPositioned(
              left: _positionX,
              duration: const Duration(milliseconds: 500),
              child: const ImageView(
                "assets/images/detail/ico_douarrow_left.svg",
                boxFit: BoxFit.fill,
                width: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
