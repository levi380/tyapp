import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../extension/color_extension.dart';
import 'information_vr_icon_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单item信息展示Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示重要信息、结果和可选的分数基准，具有明显的视觉效果。
    - `InformationImportantView`：接收三个参数：
    - `information`：字符串类型，表示需要展示的重要信息。
    - `outcome`：字符串类型，表示结果。
    - `scoreBenchmark`：字符串类型，表示可选的分数基准，默认为空字符串。
    - 返回一个包含重要信息的 `Container`，具有圆角和背景色：
    - **信息文本**：展示 `information`，使用白色字体并居中对齐。
    - **结果文本**：展示 `outcome`，使用白色字体。
    - **分数基准文本**：如果 `scoreBenchmark` 不为空，则展示该文本。
    - 通过检查 `scoreBenchmark` 是否为空，决定是否渲染相关的文本和间距。
    】】】
 *
 */
class InformationImportantView extends StatelessWidget {
  const InformationImportantView({
    Key? key,
    required this.information,
    required this.outcome,
    this.scoreBenchmark = "",
    this.vrIcons = const [],
  }) : super(key: key);

  final String information, outcome, scoreBenchmark;
  final List<String> vrIcons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
        color: isFootballBasketballTemplate ? HexColor(footballBasketballTemplateThemeColor) : Color(Get.isDarkMode ? 0xFF127DCC : 0xff179CFF),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isIPad ? 16.h : 14.h,
        horizontal: 2.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            information,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              height: 1.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 6.h,
          ),

          _regular(vrIcons).marginOnly(
            bottom: 6.h,
          ),

          ///下注是的比分
          if (scoreBenchmark.isNotEmpty)
            Text(
              scoreBenchmark,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }

  ///区分正常赛事 和vr体育赛事
  Widget _regular(List<String> vrIcons) {
    if (vrIcons.isEmpty) {
      return Text(
        outcome,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          height: 1.0,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,

      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: getChildren(vrIcons),
    );
  }

  ///vr图标Widget
  List<Widget> getChildren(List<String> vrIcons) {
    List<Widget> listChildrenView = [];

    ///vr图标Widget
    if (vrIcons.isNotEmpty)
      listChildrenView.add(
        InformationVrIconView(vrIcons: vrIcons),
      );

    listChildrenView.add(Text(
      outcome,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
    return listChildrenView;
  }
}
