import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'normal_results_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-aac9743b-8526-4a48-b939-39e894116a65-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果  NormalResultslogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果  NormalResultslogic
    - NormalResultslogic
    ```
    bool leftShow = false;
    bool rightShow = false;

    int dateIndex = 0;
    int firstIndex = 0;
    int lastIndex = 0;
    int typeFilterIndex = 0;
    String sportid = '101';

    bool downloadData = false;
    bool noData = false;
    bool returnToFirst = false;
    bool isExpandAll = true;
    String typePicture = 'assets/images/detail/bg/football.jpg';
    String euid = '1';
    String tid = '';

    RxBool loading = false.obs;

    /// 记录请求次数
    int requestCount = 0;



    /// 通知图片展示
    bool isIcon = false;

    /// 通知mid
    String mid = '';
    ```
    】】】
 *
 */

class NormalResultslogic {
  bool leftShow = false;
  bool rightShow = false;

  int dateIndex = 0;
  int firstIndex = 0;
  int lastIndex = 0;
  int typeFilterIndex = 0;
  String sportid = '101';

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String typePicture = 'assets/images/detail/bg/football.jpg';
  String euid = '1';
  String tid = '';

  RxBool loading = false.obs;

  /// 记录请求次数
  int requestCount = 0;



  /// 通知图片展示
  bool isIcon = false;

  /// 通知mid
  String mid = '';

  NormalResultslogic() {
    ///Initialize variables
  }

  /// 获取普通赛果的菜单
  static List<TypeModel> getMenu() {
    List<SportConfigInfo> originList = ConfigController.to.menuInit;

    List<TypeModel> res =
        originList.where((element) => int.parse(element.mi) < 300).map((e) {
      var euid = int.parse(e.mi) - 100;
      TypeModel item = TypeModel('', euid, '');
      return item;
    }).toList();

    return res;
  }
}
