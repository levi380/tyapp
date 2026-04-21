import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_painter.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast_layout_delegate.dart';

import '../../../../../../vr/vr_sport_detail/import_head.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 带箭头的 Toast 主类-代理类
    】】】
 *
 */
class ArrowToastWidget extends StatefulWidget {
  final String message;
  final Offset targetPosition;
  final ToastAlignment alignment;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double arrowWidth;
  final double arrowHeight;
  final double distance;
  final VoidCallback onDismiss;

  const ArrowToastWidget({
    Key? key,
    required this.message,
    required this.targetPosition,
    required this.alignment,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.elevation,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.distance,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _ArrowToastWidgetState createState() => _ArrowToastWidgetState();
}

class _ArrowToastWidgetState extends State<ArrowToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();

    // 设置自动消失
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          widget.onDismiss();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: Material(
        color: Colors.transparent,
        child: CustomSingleChildLayout(
          delegate: ArrowToastLayoutDelegate(
            targetPosition: widget.targetPosition,
            alignment: widget.alignment,
            distance: widget.distance,
            arrowHeight: widget.arrowHeight,
          ),
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: _buildToastWithArrow(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToastWithArrow() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: _getCrossAxisAlignment(),
      children: [
        if (widget.alignment == ToastAlignment.bottom) _buildArrow(),
        _buildToastContent(),
        if (widget.alignment == ToastAlignment.top) _buildArrow(),
      ],
    );
  }

  Widget _buildToastContent() {
    return Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        constraints: const BoxConstraints(
          maxWidth: 250,
          minWidth: 80,
        ),
        child: Text(
          widget.message,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return CustomPaint(
      size: Size(widget.arrowWidth, widget.arrowHeight),
      painter: ArrowPainter(
        direction: widget.alignment == ToastAlignment.top
            ? ArrowDirection.down
            : ArrowDirection.up,
        color: widget.backgroundColor,
      ),
    );
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (widget.alignment) {
      case ToastAlignment.left:
        return CrossAxisAlignment.end;
      case ToastAlignment.right:
        return CrossAxisAlignment.start;
      default:
        return CrossAxisAlignment.center;
    }
  }
}