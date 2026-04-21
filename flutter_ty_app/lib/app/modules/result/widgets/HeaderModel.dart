import '../../../services/models/res/match_entity.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情列表 列表渲染model HeaderModel 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情列表 列表渲染model HeaderModel
    - HeaderModel
    ```
    // 比分
    late String score = '';

    // 比索时间
    late String time = '';

    // 状态 是否已结束
    late String status = '';
    ```
    】】】
 *
 */

class HeaderModel {
  // 比分
  late String score = '';

  // 比索时间
  late String time = '';

  // 状态 是否已结束
  late String status = '';
}

// 列表渲染model
class TidDataList {
  late List<MatchEntity> list;
  late String tnjc;
  late String tid;
  late String mid;
  late String tn;
  bool isExpand = true;
}
