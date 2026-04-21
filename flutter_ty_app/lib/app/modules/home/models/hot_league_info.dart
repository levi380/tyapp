import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/config_controller_ext.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';

/// Model class for hot league information.
class HotLeagueInfo {
  late String name;
  late String normal;
  late String selected;
  late String night;
  late String eid;
  late String tid;
  bool show = true;

  SportConfigInfo sportConfigInfo;


  /// Constructor for HotLeagueInfo.
  HotLeagueInfo(this.sportConfigInfo) {
    Map<String, dynamic>? icon =
        ConfigController.to.getIcon(sportConfigInfo.mi);

    int? i = icon?['i'];

    ///联赛数据>0 或者 i== 1常驻
    show = (sportConfigInfo.ct ?? 0) > 0 || i == 1;

    name = ConfigController.to.getName(sportConfigInfo.mi);
    normal = icon?['lnd'] ?? '';
    selected = icon?['l'] ?? '';
    night = icon?['lnn'] ?? '';
    eid = icon?['eid'] ?? '';
    tid = icon?['tid'] ?? '';
    // AppLogger.debug(
    //     'icon ${icon?['i']} - ${icon?['m']} count = ${sportConfigInfo.ct} $name');
  }

  /// Convert the object to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['sportConfigInfo'] = sportConfigInfo.toJson();
    return data;
  }
}
