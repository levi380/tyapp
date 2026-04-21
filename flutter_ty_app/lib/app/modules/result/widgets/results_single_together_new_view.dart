import '../../login/login_head_import.dart';
import '../../unsettled_bets/widgets/dashed_line_painter_view.dart';
import '../../unsettled_bets/widgets/single_together_settled_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-998323de-6c52-4771-a2e1-96f8fe57bb0f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果体育注单串关列表控件视图Widget 】】】
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

class ResultsSingleTogetherNewView extends StatefulWidget {
  const ResultsSingleTogetherNewView({
    Key? key,
    required this.marketValue,
    required this.oddFinally,
    this.eov = "",
    required this.playName,
    required this.scoreBenchmark,
    required this.matchInfo,
    this.settleScore = "",
    this.betResult = "",
    required this.sportName,
    required this.matchName,
    required this.topType,
    required this.bottomType,
    required this.betResultColor,
    required this.iconUrl,
  }) : super(key: key);

  final String marketValue,
      oddFinally,
      eov,
      matchName,
      playName,
      scoreBenchmark,
      matchInfo,
      settleScore,
      betResult,
      sportName,
      iconUrl;

  final bool betResultColor;

  /// topType:0  是不显示头部的线条
  /// topType:1  显示头部的线条
  final int topType;

  /// bottomType:0  不显示线条
  /// bottomType:1  显示实线蓝色线条
  /// bottomType:2  显示虚线蓝色线条
  final int bottomType;

  @override
  State<ResultsSingleTogetherNewView> createState() =>
      _SingleTogetherViewState();
}

class _SingleTogetherViewState extends State<ResultsSingleTogetherNewView> {
  @override
  Widget build(BuildContext context) {
    var language = Get.locale?.languageCode ?? "";


    ///产品要求，4260需求回退，暂时不上线，等待通知......，topHeight，ovalBorderSize
    ///头部线条高度
    //  int topHeight = 4;
    //  ///单个圆圈大小
    //  int ovalBorderSize = 16;

    ///头部线条高度
    int topHeight = 10;
    ///单个圆圈大小
    int ovalBorderSize = 6;

    ///线条高度
    int height = 118;

    ///适配多语言
    if (language == 'my') {
      height = 130;
    } else if (['ru', 'hi'].contains(language)) {
      height = 124;
    }

    if (widget.scoreBenchmark.isEmpty) {
      height = height - 20;
    }
    ///赛事说明
    if(widget.matchName.isEmpty){
      height = height - 20;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ///左边折叠线
        _LeftFoldStyle(topHeight, ovalBorderSize, height),

        ///右边串关信息Widget
        SingleTogetherSettledView(
            height: height + topHeight + ovalBorderSize,
            marketValue: widget.marketValue,
            oddFinally: widget.oddFinally,
            eov: widget.eov,
            scoreBenchmark: widget.scoreBenchmark,
            betResultColor: widget.betResultColor,
            playName: widget.playName,
            matchInfo: widget.matchInfo,
            settleScore: widget.settleScore,
            betResult: widget.betResult,
            sportName: widget.sportName,
            matchName: widget.matchName,),
      ],
    );
  }

  ///折叠线
  Widget _LeftFoldStyle(int topHeight, int ovalBorderSize, int height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 1.w,
          height: topHeight.h,
          color: widget.topType == 0
              ? null
              : Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
        ),
        ///产品要求，4260需求回退，暂时不上线，等待通知......，ImageView
        Container(
          width: ovalBorderSize.h,
          height: ovalBorderSize.h,
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
      // ImageView(
      //   widget.iconUrl,
      //   width: ovalBorderSize.h,
      //   height: ovalBorderSize.h,
      // ),
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
    );
  }
}
