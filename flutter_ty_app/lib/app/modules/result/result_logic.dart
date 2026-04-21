import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 Resultlogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 Resultlogic
    - Resultlogic
    ```
    ///VR菜单
    late List<VirtualMenusData> vRMenuListData = [];

    /// 选择联赛的tid
    String tid = '';

    ///赛果头部标题
    List<String> titleList = [
    LocaleKeys.app_h5_match_normal_results.tr,
    LocaleKeys.app_h5_match_game_results.tr,
    LocaleKeys.app_h5_match_vr_results.tr,
    LocaleKeys.app_h5_match_championship_results.tr,
    ];

    ```
    】】】
 *
 */

class Resultlogic {
  /// 选择联赛的tid
  String tid = '';
  int titleIndex = 0;
  ///赛果头部标题
  List<String> titleList = [
    LocaleKeys.app_h5_match_normal_results.tr,
    LocaleKeys.app_h5_match_game_results.tr,
    LocaleKeys.app_h5_match_vr_results.tr,
    LocaleKeys.app_h5_match_championship_results.tr,
  ];

  Resultlogic() {
    ///Initialize variables
  }
}
