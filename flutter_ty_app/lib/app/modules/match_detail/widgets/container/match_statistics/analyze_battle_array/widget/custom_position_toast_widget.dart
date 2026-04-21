import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_painter.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/arrow_toast.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义箭筒 Toast 主类-代理类
    】】】
 *
 */
class CustomPositionToastWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final Offset position;
  final VoidCallback onDismiss;
  final double? arrowWidth;
  final double? arrowHeight;
  final bool isLeft;
  final ToastAlignment? alignment;
  final Widget? contentWidget;
  CustomPositionToastWidget({
    Key? key,
    required this.message,
    required this.duration,
    required this.position,
    required this.onDismiss,
    this.arrowWidth,
    this.arrowHeight,
    this.alignment,
    required this.isLeft,
    this.contentWidget,
  }) : super(key: key);

  @override
  _CustomPositionToastWidgetState createState() =>
      _CustomPositionToastWidgetState();
}

class _CustomPositionToastWidgetState extends State<CustomPositionToastWidget>
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
      left: widget.position.dx,
      top: widget.position.dy,
      child: widget.contentWidget??ScaleTransition(
          scale: _animation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: widget.isLeft ? 0.068.sw : 0.515.sw),
                child: _buildArrow(),
              ),
              Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(8.0),
                color: context.isDarkMode
                    ? Colors.black.withAlpha(190)
                    : Get.theme.betItemContentBgColor,
                child: Container(
                    width: 0.6.sw,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.message,
                          maxLines: 3,
                          style: TextStyle(
                            color: Get.theme.analsTextTabSelectColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }

  Widget _buildArrow() {
    return Container(
      child: CustomPaint(
        size: Size(20.w, 10.w),
        painter: ArrowPainter(
          direction: widget.alignment == ToastAlignment.top
              ? ArrowDirection.down
              : ArrowDirection.up,
          color: context.isDarkMode
              ? Colors.black.withAlpha(190)
              : Get.theme.betItemContentBgColor,
        ),
      ),
    );
  }
}
