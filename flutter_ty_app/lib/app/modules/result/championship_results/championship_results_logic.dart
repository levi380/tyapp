import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../services/models/res/mchampion_match_result_entity.dart';

import 'championship_results_controller.dart' hide DateItemModel;

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-245a3681-af98-492f-85f3-b3190a23bc35-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 冠军赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 冠军赛果   ChampionshipResultslogic】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  冠军赛果   ChampionshipResultslogic
    - ChampionshipResultslogic
    ```
    List<String> dateTimes = [];

    late List<MchampionMatchResultData> data = [];
    late List<SportItem> groupList = [];

    int dateIndex = 0;

    String md = '';

    bool downloadData = false;
    bool noData = false;
    bool returnToFirst = false;
    bool isExpandAll = true;
    String euid = '10000';
    String startTime = '';
    String endTime = '';

    RxBool loading = false.obs;
    String tid = '';
    /// 记录请求次数
    int requestCount = 0;
    ```
    】】】
 *
 */
class ChampionshipResultslogic {


  List<String> dateTimes = [];

  late List<MchampionMatchResultData> data = [];
  late List<SportItem> groupList = [];

  int dateIndex = 0;

  String md = '';

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String euid = '10000';
  String startTime = '';
  String endTime = '';

  RxBool loading = false.obs;
  String tid = '';
  /// 记录请求次数
  int requestCount = 0;

  ChampionshipResultslogic() {
    ///Initialize variables
  }
}
