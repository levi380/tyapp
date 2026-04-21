/**
 * @Author xlight
 * @Date 2024/2/14 15:50
 */

// 欧洲赔率  1
// 香港赔率  2
// 马来赔率  3
// 英式赔率  4
// 美式赔率  5
// 印尼赔率  6

import 'package:flutter_ty_app/generated/locales.g.dart';

class BetOddsConstantModel {
  final String label;
  final String value;
  final String icon;
  final String id;
  final String handicapType;

  const BetOddsConstantModel({
    required this.label,
    required this.value,
    required this.icon,
    required this.id,
    required this.handicapType,
  });
}

///按照需求上面的顺序
const oddsConstant = [
  BetOddsConstantModel(
    label: LocaleKeys.odds_EU,
    value: "EU",
    icon: 'panda-icon-contryEU',
    id: '1',
    handicapType: '0',
  ), //欧洲盘
  BetOddsConstantModel(
    label: LocaleKeys.odds_HK,
    value: "HK",
    icon: 'panda-icon-contryHK',
    id: '2',
    handicapType: '1',
  ), //香港盘
  BetOddsConstantModel(
    label: LocaleKeys.odds_MY,
    value: "MY",
    icon: 'panda-icon-contryML',
    id: '3',
    handicapType: '4',
  ), //马来盘
  BetOddsConstantModel(
    label: LocaleKeys.odds_ID,
    value: "ID",
    icon: 'panda-icon-contryYN',
    id: '6',
    handicapType: '3',
  ), //印尼盘
  BetOddsConstantModel(
    label: LocaleKeys.odds_US,
    value: "US",
    icon: 'panda-icon-contryUS',
    id: '5',
    handicapType: '2',
  ), //美式盘
  BetOddsConstantModel(
    label: LocaleKeys.odds_GB,
    value: "GB",
    icon: 'panda-icon-contryUK',
    id: '4',
    handicapType: '5',
  ), //英式盘
];
