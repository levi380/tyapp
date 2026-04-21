import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 圆形自定义控件
    】】】
 *
 */
class MatchLineProgressView extends StatefulWidget {
  ///背景圆形色值
  final Color backgroundColor;

  final Color? leftColor;
  final Color? rightColor;

  final Color? leftBackgroundColor;
  final Color? rightBackgroundColor;

  ///当前进度 0-100
  final double leftProgress;

  final double rightProgress;

  ///进度条颜色
  final Color progressColor;

  ///圆环宽度
  final double progressWidth;

  ///宽度
  final double width;

  ///高度
  final double height;
  final String? centerContent;
  final String home;
  final String away;
  MatchLineProgressView(this.home, this.away,
      {super.key,
      required this.leftProgress,
      required this.rightProgress,
      required this.width,
      required this.height,
      this.centerContent,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.leftColor,
      this.rightColor,
      this.leftBackgroundColor = Colors.grey,
      this.rightBackgroundColor = Colors.grey,
      this.progressWidth = 10.0});

  @override
  _MatchLineProgressViewState createState() => _MatchLineProgressViewState();
}

class _MatchLineProgressViewState extends State<MatchLineProgressView>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Tween<double> tween;
  double? oldProgress;

  @override
  void initState() {
    super.initState();
    oldProgress = widget.leftProgress;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
    tween.end = widget.leftProgress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
    oldProgress = widget.leftProgress;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (oldProgress != widgets.leftProgress) {
    //   startAnimation();
    // }
    return Container(
      margin: EdgeInsets.only(top: 12.w),
      child: Column(
        children: [
          Center(
            child: Text(
              widget.centerContent ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 50.w,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 2.w),
              child: Text(
                widget.home,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
            Expanded(
              child: Container(
                height: 8,
                child: ClipRRect(
                    // 边界半径（`borderRadius`）属性，圆角的边界半径。
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //需要反过来
                    child: Container(
                      width: widget.width,
                      height: 8,
                      child: RepaintBoundary(
                        child: CustomPaint(
                          painter: LeftLineProgressPaint(
                              widget.leftProgress, widget.progressWidth,
                              backgroundColor: widget.backgroundColor,
                              progressColor: widget.progressColor),
                          child: SizedBox(),
                        ),
                      ),
                    )

                    // LinearProgressIndicator(
                    //   value:(1-widget.leftProgress),
                    //   backgroundColor: (widget.leftProgress==0)?(widget.leftBackgroundColor??Colors.grey):(widget.leftColor??Color(0xffF2F2F6)),
                    //   valueColor: AlwaysStoppedAnimation<Color>(widget.leftBackgroundColor??Colors.grey),
                    // ),
                    ),
              ),
            ),
            Expanded(
                child: Container(
              width: 160,
              height: 8,
              child: ClipRRect(
                  // 边界半径（`borderRadius`）属性，圆角的边界半径。
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    width: widget.width,
                    height: 20.w,
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: RightLineProgressPaint(
                            widget.rightProgress, widget.progressWidth,
                            backgroundColor: widget.backgroundColor,
                            progressColor: widget.progressColor),
                        child: SizedBox(),
                      ),
                    ),
                  )),
            )),
            Container(
              width: 50.w,
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                widget.away,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            )
          ])
        ],
      ),
    );
  }
}

class RightLineProgressPaint extends CustomPainter {
  RightLineProgressPaint(
      this.progress, //进度
      this.width, //画笔宽度
      {this.backgroundColor, //背景画笔颜色
      this.progressColor}) {
    //背景画笔
    paintBg = Paint()
      ..strokeWidth = 40.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke; // 画笔风格，线
    //进度画笔
    paintProgress = Paint()
      ..color = progressColor ?? Color(0xFFF53F3F)
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线

    //进度画笔
    paintProgress2 = Paint()
      ..color = progressColor ?? Color(0xFFF53F3F)
      ..strokeWidth = 40.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为直角
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }
  final Color? progressColor;
  final Color? backgroundColor;
  final double progress;
  final double width;
  var paintBg;
  var paintProgress;
  var paintProgress2;
  @override
  void paint(Canvas canvas, Size size) {
    // 画背景进度
    paintBg.shader = LinearGradient(
      colors: [backgroundColor!, backgroundColor!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    paintProgress2.shader = const LinearGradient(
      colors: [Color(0xFFFFCC54), Color(0xFFFF8A2D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paintBg);
    // AppLogger.debug("============>进度  ${progress}");
    if (progress > 0) {
      canvas.drawLine(
          Offset(0, 0), Offset(size.width * progress, 0), paintProgress2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LeftLineProgressPaint extends CustomPainter {
  LeftLineProgressPaint(
      this.progress, //进度
      this.width, //画笔宽度
      {this.backgroundColor, //背景画笔颜色
      this.progressColor}) {
    //背景画笔
    paintBg = Paint()
      ..strokeWidth = 40.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke; // 画笔风格，线
    //进度画笔
    paintProgress = Paint()
      ..color = progressColor ?? Color(0xFFF53F3F)
      ..strokeWidth = 40.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线

    //进度画笔
    paintProgress2 = Paint()
      ..color = progressColor ?? Color(0xFFF53F3F)
      ..strokeWidth = 40.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为直角
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }
  final Color? progressColor;
  final Color? backgroundColor;
  final double progress;

  final double width;

  var paintBg;
  var paintProgress;
  var paintProgress2;
  @override
  void paint(Canvas canvas, Size size) {
    // AppLogger.debug("============>progress  ${progress}");
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    // 画背景进度
    paintBg.shader = LinearGradient(
      colors: [backgroundColor!, backgroundColor!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    paintProgress2.shader = const LinearGradient(
      colors: [Color(0xFF6621FF), Color(0xFF46B1FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paintBg);
    if (progress > 0) {
      canvas.drawLine(Offset(size.width - size.width * progress, 2),
          Offset(size.width, 0), paintProgress2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
