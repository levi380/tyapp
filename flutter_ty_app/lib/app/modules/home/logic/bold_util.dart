import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';



/// Utility class for processing bold match highlights.
class BoldUtil {
  /// Maps the outcome type (otd) to a list of match highlights.
  /// 
  /// [hps] - The match highlights to process.
  /// Returns a map where the key is the outcome type and the value is a list of match highlights.
  static Map<int, List<MatchHpsHlOl>> getFromBoldMatchHps(MatchHps hps) {
    Map<int, List<MatchHpsHlOl>> map = {};
    // Check if there are any highlights to process.
    if (hps.hl.isEmpty) {
      return map;
    }
    // Get the first highlight list.
    MatchHpsHl hpsHl = hps.hl.first;

    // Process each outcome in the highlight list.
    for (var element in hpsHl.ol) {
      // Determine the outcome type and add the element to the corresponding list in the map.
      switch (element.otd) {
        case 1: // 主胜
          map.addAll({1: map[1] ?? []..add(element)});
          break;
        case 0: // 平
          map.addAll({0: map[0] ?? []..add(element)});
          break;
        case 2: // 客胜
          map.addAll({2: map[2] ?? []..add(element)});
          break;
        case -1: // 其他
          map.addAll({-1: map[-1] ?? []..add(element)});
          element.on = LocaleKeys.list_other.tr; // Set the outcome name for '其他'.
          break;
      }
    }
    return map;
  }
}
