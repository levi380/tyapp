
import 'package:flutter_ty_app/app/modules/home/models/play_info.dart';

import '../../../services/models/res/match_entity.dart';

class SecondaryStateModel {
  final KySwitch kySwitch;
  final int currentPlayType;
  final bool showOvertime;
  final bool showPenalty;
  final List<PlayInfo> plays;
  final List<PlayInfo> subPlays;

  const SecondaryStateModel({
    required this.kySwitch,
    required this.currentPlayType,
    required this.showOvertime,
    required this.showPenalty,
    required this.plays,
    required this.subPlays,
  });

  SecondaryStateModel copyWith({
    KySwitch? kySwitch,
    int? currentPlayType,
    bool? showOvertime,
    bool? showPenalty,
    List<PlayInfo>? plays,
    List<PlayInfo>? subPlays,
  }) {
    return SecondaryStateModel(
      kySwitch: kySwitch ?? this.kySwitch,
      currentPlayType: currentPlayType ?? this.currentPlayType,
      showOvertime: showOvertime ?? this.showOvertime,
      showPenalty: showPenalty ?? this.showPenalty,
      plays: plays ?? this.plays,
      subPlays: subPlays ?? this.subPlays,
    );
  }
}