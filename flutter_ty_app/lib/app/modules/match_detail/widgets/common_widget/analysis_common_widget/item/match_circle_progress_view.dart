import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/new_analyze_progress_paint.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../models/analysis/analysis_data_model.dart';

class MatchCircleProgressView extends StatefulWidget {
  ///背景圆形色值
  final List<Color>? backgroundColor;

  ///当前进度 0-1 (比如0.33表示33%)
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
  final String? imgPath;
  final NewAnalyzeMatchResultItem analyzeMatchResultItem;
  final String? leftString;
  final String? rightString;

  MatchCircleProgressView(this.analyzeMatchResultItem,
      {super.key,
        required this.progress,
        required this.width,
        required this.height,
        this.imgPath,
        this.centerContent,
        this.leftString,
        this.rightString,
        this.backgroundColor,
        this.progressColor = Colors.blue,
        this.progressWidth = 7.0});

  @override
  _MatchCircleProgressViewState createState() =>
      _MatchCircleProgressViewState();
}

class _MatchCircleProgressViewState extends State<MatchCircleProgressView>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Tween<double> tween;
  double? oldProgress;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    oldProgress = widget.progress;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    tween = Tween<double>(begin: 0.0, end: oldProgress);
    animation = tween.animate(curvedAnimation);

    controller.forward();
  }

  @override
  void didUpdateWidget(MatchCircleProgressView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查关键属性是否发生变化
    if (oldWidget.progress != widget.progress ||
        oldWidget.analyzeMatchResultItem != widget.analyzeMatchResultItem ||
        oldWidget.leftString != widget.leftString ||
        oldWidget.rightString != widget.rightString ||
        oldWidget.imgPath != widget.imgPath) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    // 如果控制器已经 disposed，重新初始化
    if (controller.isDismissed) {
      _initializeAnimation();
      return;
    }

    controller.stop();
    tween
      ..begin = oldProgress ?? 0.0
      ..end = widget.progress;

    controller
      ..value = 0.0
      ..forward();

    oldProgress = widget.progress;

    // 强制重建
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 36.w, right: 4.w),
                child: Text(
                  widget.leftString ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: (12.sp),
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12.w,
                  ),
                  Text(
                    widget.analyzeMatchResultItem.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Get.theme.resultTextColor,
                        fontSize: (10.sp),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Container(
                    width: widget.width,
                    height: widget.height,
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: animation!,
                        builder: (context, child) {
                          final currentProgress = animation?.value ?? 0.0;

                          return CustomPaint(
                            painter: NewAnalyzeProgressPaint(
                              currentProgress, // 直接传递进度值 (0-1)
                              widget.progressWidth,
                              progressColor: widget.progressColor,
                              backgroundColor: widget.backgroundColor,
                            ),
                            child: Center(
                              child: widget.imgPath != null && widget.imgPath!.isNotEmpty
                                  ? ImageView(
                                widget.imgPath!,
                                width: 16.w,
                                height: 16.w,
                                boxFit: BoxFit.fitWidth,
                              )
                                  : Text(
                                '${(currentProgress * 100).toInt()}%',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 36.w, left: 4.w),
                child: Text(
                  widget.rightString ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: (12.sp),
                      color: Get.theme.oddsButtonValueFontColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}