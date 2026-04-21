import '../../../../../../../main.dart';
import '../../../../../../extension/num_extension.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/odds_util.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../extension/theme_extension.dart';

class DetailOddsName extends StatelessWidget {
  const DetailOddsName(
      {super.key,
      required this.ol,
      this.textColor,
      this.selectTextColor,
      this.match,
      this.hps,
      this.hl,
      required this.fullscreen,
      required this.selected});

  final MatchHpsHlOl ol;
  final Color? textColor;
  final Color? selectTextColor;
  final MatchEntity? match;
  final MatchHps? hps;
  final MatchHpsHl? hl;
  final bool fullscreen;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    String name = OddsUtil.getOddsName(ol, hps, match!);

    double sFontSize = fullscreen
        ? 12
        : isIPad
            ? 16.sp
            : 12.sp;
    // if (['my'].contains(Get.locale?.languageCode)) {
    if (OddsUtil.isBurmese(name)) {
      sFontSize = fullscreen
          ? 10
          : isIPad
              ? 14.sp
              : 8.sp;
    }
    // String otvName = OddsUtil.olOtvName(ol);
    if (name.contains("%dbx")) {
      List<String> nameList = name.split("%dbx");
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              nameList.safeFirst ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: sFontSize,
                color: selected
                    ? fullscreen
                        ? Colors.white.withValues(alpha: 0.9)
                        : Get.theme.oddsButtonSelectFontColor
                    : fullscreen
                        ? Colors.white.withValues(alpha: 0.5)
                        : Get.theme.oddsButtonNameFontColor,
                fontWeight: FontWeight.w400,
                fontFamily: "PingFang SC",
              ),
            ),
          ),
          Text(
            nameList.safeLast ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: sFontSize,
              color: selected
                  ? fullscreen
                      ? Colors.white.withValues(alpha: 0.9)
                      : Get.theme.oddsButtonSelectFontColor
                  : fullscreen
                      ? Colors.white.withValues(alpha: 0.5)
                      : Get.theme.oddsButtonNameFontColor,
              fontWeight: FontWeight.w400,
              fontFamily: "PingFang SC",
            ),
          )
        ],
      );
    }
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min, //让Row宽度由内容决定
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  OddsUtil.splitOddsName(name)[0],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: sFontSize,
                    color: selected
                        ? (selectTextColor ??
                            (fullscreen
                                ? Colors.white.withValues(alpha: 0.9)
                                : Get.theme.oddsButtonSelectFontColor))
                        : (textColor ??
                            (fullscreen
                                ? Colors.white.withValues(alpha: 0.5)
                                : Get.theme.oddsButtonNameFontColor)),
                    fontWeight: FontWeight.w400,
                    fontFamily: "PingFang SC",
                  ),
                ),
              ),
              if (OddsUtil.splitOddsName(name).length > 1)
                Text(
                  OddsUtil.splitOddsName(name)[1],
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: sFontSize,
                    color: selected
                        ? (selectTextColor ??
                            (fullscreen
                                ? Colors.white.withValues(alpha: 0.9)
                                : Get.theme.oddsButtonSelectFontColor))
                        : (textColor ??
                            (fullscreen
                                ? Colors.white.withValues(alpha: 0.5)
                                : Get.theme.oddsButtonNameFontColor)),
                    fontWeight: FontWeight.w400,
                    fontFamily: "PingFang SC",
                  ),
                ),
            ],
          ),
        ));
  }
}
