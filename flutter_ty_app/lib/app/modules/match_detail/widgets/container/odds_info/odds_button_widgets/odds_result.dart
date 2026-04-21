import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../main.dart';
import '../../../../../../extension/num_extension.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../extension/theme_extension.dart';

class OddsResult extends StatelessWidget {
  const OddsResult({super.key, required this.ol, required this.isDetail});

  final MatchHpsHlOl ol;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    // 赛果展示
    // "0": '未知',
    // "1": '未知',
    // "2": '走水',
    // "3": '输',
    // "4": '赢',
    // "5": '赢半',
    // "6": '输半',
    int result = ol.result!;
    String resultText = "";
    if ([0, 1, 2, 3, 4, 5, 6].contains(result)) {
      resultText = "virtual_sports_result_$result".tr;
    } else {
      LocaleKeys.virtual_sports_result_0.tr;
    }
    double sFontSize = isIPad ? 17.sp : 15.sp;
    // if (['my'].contains(Get.locale?.languageCode)) {
    if (OddsUtil.isBurmese(resultText)) {
      sFontSize = isIPad ? 12.sp : 11.sp;
    }
    return Text(
      resultText,
      maxLines: 1,
      style: TextStyle(
        fontSize: isDetail ? sFontSize : sFontSize.scale,
        // vr赛果颜色不区分
        color: Get.currentRoute == Routes.vrSportDetail
            ? Get.theme.oddsButtonVrResultValueFontColor
            : ((result == 4 || result == 5)
                ? const Color(0xFFE95B5B)
                : Get.theme.oddsButtonValueFontColor),
        fontWeight: Get.currentRoute == Routes.vrSportDetail
            ? FontWeight.w700
            : FontWeight.w400,
        fontFamily: "Akrobat",
      ),
    );
  }
}
