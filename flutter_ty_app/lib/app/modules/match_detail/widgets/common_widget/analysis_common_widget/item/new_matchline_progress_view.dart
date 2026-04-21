

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

// 数据 数据百分比
class NewMatchLineProgressView extends StatefulWidget {
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

  NewMatchLineProgressView(this.home, this.away,
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

class _MatchLineProgressViewState extends State<NewMatchLineProgressView>
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
      margin: EdgeInsets.only(top: 6.w,left: 12.w,right: 12.w),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(
            widget.home,
            style: TextStyle(
                fontSize: (12.sp), color: Get.theme.tabPanelSelectedColor),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                color: widget.backgroundColor,
              ),
              child: ClipRRect(
                  // 边界半径（`borderRadius`）属性，圆角的边界半径。
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //需要反过来
                  child: Container(
                    width: widget.width,
                    height: 8.w,
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: LeftLineProgressPaint(
                            widget.leftProgress, widget.progressWidth,
                            backgroundColor: widget.backgroundColor,
                            progressColor: widget.progressColor),
                        child: SizedBox(),
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  color: widget.backgroundColor,
                ),
            width: 160,
            height: 5,
            child: ClipRRect(
                // 边界半径（`borderRadius`）属性，圆角的边界半径。
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  width: widget.width,
                  height: widget.height,
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
          SizedBox(
            width: 4.w,
          ),
          Text(
            widget.away,
            style: TextStyle(
                fontSize: (12.sp), color: Get.theme.tabPanelSelectedColor),
          ),
        ])
      ]),
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
      ..strokeWidth = 20.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke; // 画笔风格，线

    //进度画笔
    paintProgress2 = Paint()
      ..color = progressColor ?? Color(0xFFF53F3F)
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为直角
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }

  final Color? progressColor;
  final Color? backgroundColor;
  final double progress;
  final double width;
  var paintBg;
  var paintProgress2;

  @override
  void paint(Canvas canvas, Size size) {
    // 画背景进度
    paintBg.shader = (progress == 0)
        ? LinearGradient(
            colors: [backgroundColor!, backgroundColor!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, 0))
        : LinearGradient(
            colors: [Colors.transparent, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    paintProgress2.shader = const LinearGradient(
      colors: [Color(0xFFFEBE55), Color(0xFFFEBE55)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paintBg);
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
  final Color? progressColor;
  final Color? backgroundColor;
  final double progress;
  final double width;
  var paintBg;
  var paintProgress2;

  LeftLineProgressPaint(
      this.progress, //进度
      this.width, //画笔宽度
      {this.backgroundColor, //背景画笔颜色
      this.progressColor}) {
    //背景画笔
    paintBg = Paint()
      ..strokeWidth = 20.w
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke; // 画笔风格，线
    //进度画笔
    paintProgress2 = Paint()
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为直角
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBg.shader = (progress == 0)
        ? LinearGradient(
            colors: [backgroundColor!, backgroundColor!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, 0))
        : LinearGradient(
            colors: [Colors.transparent, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, 0));

    paintProgress2.shader = const LinearGradient(
      colors: [Color.fromRGBO(23, 156, 255, 1),Color.fromRGBO(23, 156, 255, 1)],
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
