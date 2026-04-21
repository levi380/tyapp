import '../../../../main.dart';
import '../../login/login_head_import.dart';
import 'dashed_line_painter_view.dart';
import 'information_line_view.dart';
import 'information_view.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单串关旧版列表控件视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示与单场赛事相关的市场价值、赔率、玩法、分数基准等信息。
    - 构造函数
    - `SingleTogetherView`：接收多个参数以初始化组件，包括：
    - `marketValue`：市场价值。
    - `oddFinally`：最终赔率。
    - `playName`：玩法名称。
    - `scoreBenchmark`：分数基准。
    - `matchInfo`：比赛信息。
    - `settleScore`：结算分数（可选）。
    - `betResult`：投注结果（可选）。
    - `sportName`：体育名称。
    - `topType` 和 `bottomType`：控制是否显示线条的类型。
    - `betResultColor`：投注结果颜色标识。
    - 使用 `StatefulWidget`，允许组件在生命周期内维护状态。
    - 根据当前语言代码调整组件的高度，以适应不同语言的文本显示。
    - 根据 `settleScore` 和 `scoreBenchmark` 是否为空调整高度。
    - 使用 `Row` 和 `Column` 进行层次布局，确保信息的清晰展示。
    - 在左侧显示状态指示器（线条和圆形图标），右侧展示赛事信息。
    - 根据 `topType` 和 `bottomType` 的值决定是否显示顶部和底部的线条。
    - 使用 `CustomPaint` 绘制虚线或实线，增强视觉效果。
    - 使用多个 `InformationLineView` 组件来展示不同的信息行。
    - 通过条件渲染控制哪些信息行需要显示。
    】】】
 *
 */
class SingleTogetherView extends StatefulWidget {
  const SingleTogetherView({
    Key? key,
    required this.marketValue,
    required this.oddFinally,
    required this.playName,
    required this.scoreBenchmark,
    required this.matchInfo,
    this.settleScore = "",
    this.betResult = "",
    required this.sportName,
    required this.topType,
    required this.bottomType,
    required this.betResultColor,
  }) : super(key: key);

  final String marketValue,
      oddFinally,
      playName,
      scoreBenchmark,
      matchInfo,
      settleScore,
      betResult,
      sportName;

  final bool betResultColor;

  /// topType:0  是不显示头部的线条
  /// topType:1  显示头部的线条
  final int topType;

  /// bottomType:0  不显示线条
  /// bottomType:1  显示实线蓝色线条
  /// bottomType:2  显示虚线蓝色线条
  final int bottomType;

  @override
  State<SingleTogetherView> createState() => _SingleTogetherViewState();
}

class _SingleTogetherViewState extends State<SingleTogetherView> {
  @override
  Widget build(BuildContext context) {
    var language = Get.locale?.languageCode ?? "";
    int height = 122;

    ///适配多语言
    if (language == 'my') {
      height = 135;
    } else if (['ru', 'hi'].contains(language)) {
      height = 128;
    }

    if (widget.settleScore.isEmpty && widget.betResult.isEmpty) {
      height = height - 20;
    }
    if (widget.scoreBenchmark.isEmpty) {
      height = height - 20;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 1.w,
              height: Get.locale?.languageCode == 'zh' ? 8.h : 5.h,
              color: widget.topType == 0
                  ? null
                  : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
            ),
            Container(
              width: 6.w,
              height: 6.w,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(
                      context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: widget.bottomType == 2
                  ? RepaintBoundary(
                      child: CustomPaint(
                        size: Size(1, height.h),
                        painter: DashedLinePainter(
                          color: Color(
                            context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: height.h,
                      width: 1.w,
                      color: widget.bottomType == 0
                          ? null
                          : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                    ),
            ),
          ],
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.marketValue,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha: 0.8999999761581421)
                            : const Color(0xFF303442),
                        fontSize: isIPad ? 16.sp : 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.oddFinally,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color:
                          Color(context.isDarkMode ? 0xFF127DCC : 0xFF179CFF),
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              InformationLineView(
                top: 4,
                information: widget.playName,
                multiLine: false,
                Type: 0,
              ),
              if (widget.scoreBenchmark.isNotEmpty)
                InformationLineView(
                  top: 4,
                  information: widget.scoreBenchmark,
                  multiLine: false,
                  Type: 0,
                ),
              InformationLineView(
                top: 4,
                information: widget.matchInfo,
                multiLine: false,
                Type: 1,
              ),
              if (widget.settleScore.isNotEmpty || widget.betResult.isNotEmpty)
                InformationView(
                  top: 4,
                  information: widget.settleScore,
                  outcome: widget.betResult,
                  InformationColorType: widget.betResultColor ? 3 : 0,
                ),
              InformationLineView(
                top: 4,
                multiLine: false,
                information: widget.sportName,
              ),
              SizedBox(height: 4.w)
            ],
          ),
        ),
      ],
    );
  }
}
