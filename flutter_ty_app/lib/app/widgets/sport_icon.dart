import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

Widget sportIcon(
    {required int index,
    required double width,
    required double height,
    required bool isSelected}) {
  if (index == 0) {
    if (isSelected) {
      return ImageView(
        'assets/images/sports/icon_hot_select.png',
        width: width,
        height: height,
        boxFit: BoxFit.contain,
      );
    } else {
      return ImageView(
        Get.isDarkMode
            ? 'assets/images/sports/icon_hot_n.png'
            : 'assets/images/sports/icon_hot_l.png',
        width: width,
        height: height,
        boxFit: BoxFit.contain,
      );
    }
  }
  if (isSelected) {
    return ImageView(
      'assets/images/sport/sportstab_ico_${index}_sel.png',
      width: width,
      height: height,
      boxFit: BoxFit.contain,
    );
  } else {
    if (Get.isDarkMode) {
      return ImageView(
        'assets/images/sport/sportstab_ico_${index}_nor_night.png',
        width: width,
        height: height,
        boxFit: BoxFit.contain,
      );
    } else {
      return ImageView(
        'assets/images/sport/sportstab_ico_${index}_nor.png',
        width: width,
        height: height,
        boxFit: BoxFit.contain,
      );
    }
  }
}

Widget leagueIcon(
    {required int index,
    required double width,
    required double height,
    required bool isSelected}) {
  if (isSelected) {
    return ImageView(
      'assets/images/league/sportstab_ico_${index}_sel_league.png',
      width: width,
      height: height,
      boxFit: BoxFit.fitHeight,
    );
  } else {
    if (Get.isDarkMode) {
      return ImageView(
        'assets/images/league/sportstab_ico_${index}_nor_night_league.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    } else {
      return ImageView(
        'assets/images/league/sportstab_ico_${index}_nor_league.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    }
  }
}
