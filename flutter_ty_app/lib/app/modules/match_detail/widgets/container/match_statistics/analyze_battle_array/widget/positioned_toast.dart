import '../../../../../../vr/vr_sport_detail/import_head.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 位置吐司的样式
    】】】
 *
 */
class PositionedToast extends StatefulWidget {
  final String message;
  final Duration duration;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final VoidCallback onDismiss;

  const PositionedToast({
    Key? key,
    required this.message,
    required this.duration,
    required this.alignment,
    required this.margin,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.elevation,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _PositionedToastState createState() => _PositionedToastState();
}

class _PositionedToastState extends State<PositionedToast>
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
      curve: Curves.easeOut,
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
    return Align(
      alignment: widget.alignment,
      child: Container(
        margin: widget.margin,
        child: ScaleTransition(
          scale: _animation,
          child: Material(
            elevation: widget.elevation,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.backgroundColor,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Text(
                widget.message,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}