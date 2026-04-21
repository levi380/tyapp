import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/format_score_util3.dart';
import '../../../../login/login_head_import.dart';

class PenaltyItem extends StatelessWidget {
  const PenaltyItem(
      {super.key,
      required this.match,
      required this.teamStr,
      required this.isHomeTeam,
      required this.index});

  final MatchEntity match;
  final String teamStr;
  final bool isHomeTeam;
  final int index;

  @override
  Widget build(BuildContext context) {
    final result = FormatScore3.isShootout(match, index, teamStr);
    // print(result);
    if (result == "-1") {
      return ImageView(
        "assets/images/detail/overtime_goal_default.svg",
        width: 14.w,
      );
    }

    if (result == "1") {
      return ImageView(
        isHomeTeam
            ? "assets/images/detail/overtime_goal_home.svg"
            : "assets/images/detail/overtime_goal_away.svg",
        width: 14.w,
      );
    }

    if (result == "0") {
      return ImageView(
        isHomeTeam
            ? "assets/images/detail/overtime_not_goal_home.svg"
            : "assets/images/detail/overtime_not_goal_away.svg",
        width: 14.w,
      );
    }

    return ImageView(
      "assets/images/detail/overtime_goal_default.svg",
      width: 14.w,
    );
  }
}
