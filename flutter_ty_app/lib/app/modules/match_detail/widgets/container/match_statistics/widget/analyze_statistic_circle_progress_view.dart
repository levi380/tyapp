
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../models/analysis/analysis_model.dart';
import 'match_circle_progress_paint.dart';
import 'analyze_statistic_circle_progress_label.dart';

typedef AnalyzeStatisticCircleProgressViewFunction = void Function(
    String message, TapDownDetails details);

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 正面交手-圆形控件
    】】】
 *
 */
class AnalyzeStatisticCircleProgressView extends StatefulWidget {
  ///背景圆形色值
  final Color backgroundColor;

  final AnalyzeStatisticCircleProgressViewFunction?
      analyzeStatisticCircleProgressViewFunction;

  ///当前进度 0-100
  final double progress;

  ///进度条颜色
  final Color progressColor;

  ///圆环宽度
  final double progressWidth;

  ///宽度
  final double width;

  ///高度
  final double height;
  final String? centerContent;
  final int index;
  final GridColorBean analyzeMatchResultItem;
  AnalyzeStatisticCircleProgressView(this.index, this.analyzeMatchResultItem,
      {super.key,
      required this.progress,
      required this.width,
      required this.height,
      this.centerContent,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.analyzeStatisticCircleProgressViewFunction,
      this.progressWidth = 6.0});

  @override
  _MatchCircleProgressViewState createState() =>
      _MatchCircleProgressViewState();
}

class _MatchCircleProgressViewState
    extends State<AnalyzeStatisticCircleProgressView>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Tween<double> tween;
  double? oldProgress;
  bool showSelect = false;
  Timer? _selectTimer;
  @override
  void initState() {
    super.initState();

    oldProgress = widget.progress;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    tween = Tween();
    tween.begin = 0.0;
    tween.end = oldProgress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
  }

  //这里是在重新赋值进度时，再次刷新动画
  void startAnimation() {
    controller.reset();
    tween.begin = oldProgress;
    tween.end = widget.progress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
    oldProgress = widget.progress;
  }

  @override
  void dispose() {
    _selectTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GridColorBean analyzeMatchResultItem = widget.analyzeMatchResultItem;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.w)),
          border: Border.all(color: Get.theme.betItemContentBgColor, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: MatchCircleProgressPaint(
                        animation?.value ?? 0,
                        widget.progressWidth,
                        analyzeMatchResultItem.colors,
                        backgroundColor: widget.progress == 0
                            ? const Color(0xFFd8d8d8)
                            : widget.backgroundColor,
                        progressColor: widget.progressColor),
                    child: child,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${analyzeMatchResultItem.name1}%",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: (14.sp),
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  ),
                ),
              )
            ),
          ),
          SizedBox(width: 4.w),
          AnalyzeStatisticCircleProgressLabel(item: analyzeMatchResultItem),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
               if(widget.analyzeStatisticCircleProgressViewFunction!=null ) {
                 widget.analyzeStatisticCircleProgressViewFunction!(analyzeMatchResultItem.name4??"",details);
               }
               _selectTimer?.cancel();
               if (!mounted) return;
               setState(() {
                 showSelect = true;
               });
               _selectTimer = Timer(const Duration(seconds: 2), () {
                 if (!mounted) return;
                 setState(() {
                   showSelect = false;
                 });
               });
              },
              child: Container(
                child: ImageView(
                  showSelect ?  "assets/images/bets/analyze_question2_select.png":"assets/images/bets/analyze_question2.png",
                  width: 14.w,
                  height: 14.w,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
