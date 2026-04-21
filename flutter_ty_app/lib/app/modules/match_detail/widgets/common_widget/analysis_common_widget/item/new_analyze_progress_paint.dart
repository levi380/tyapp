import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewAnalyzeProgressPaint extends CustomPainter {
  NewAnalyzeProgressPaint(
      this.progress, //进度
      this.width,  //画笔宽度
      {this.backgroundColor, //背景画笔颜色
        this.progressColor}) {
    //背景画笔
    paintBg = Paint()
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.stroke; // 画笔风格，线
    //进度画笔
    paintProgress = Paint()
      ..color = progressColor??Color(0xFFF53F3F)
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke;// 画笔风格，线

    //进度画笔
    paintProgress2= Paint()
      ..color = progressColor??Color(0xFFF53F3F)
      ..strokeWidth = width

      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.square // 笔触设置为直角
      ..style = PaintingStyle.stroke;// 画笔风格，线
  }
  final Color? progressColor;
  final  List<Color>? backgroundColor;
  final double progress;

  final double width;

  var paintBg;
  var paintProgress;
  var paintProgress2;
  @override
  void paint(Canvas canvas, Size size) {
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    double radius = size.width > size.height ? size.height / 2-5.w : size.width / 2-5.w;
    if(progress>0) {
      // 画背景进度
      paintBg.shader =const LinearGradient(
        colors: [Color.fromRGBO(23, 156, 255, 1),Color.fromRGBO(23, 156, 255, 1)],

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    }else{
      // 画背景进度
      paintBg.shader =LinearGradient(
        colors: backgroundColor?? [Color.fromRGBO(23, 156, 255, 1), Color.fromRGBO(23, 156, 255, 1)],
        
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    paintProgress2.shader =const LinearGradient(
      colors: [Color(0xFFFEBE55), Color(0xFFFEBE55)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paintBg);


    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, -3.14/2,2*3.14*progress, false, paintProgress2);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}