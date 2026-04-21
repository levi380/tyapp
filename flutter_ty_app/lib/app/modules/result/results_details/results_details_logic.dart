import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../generated/locales.g.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9176c2a2-fe19-41b2-9ee1-2cf24db8b7c1-xq 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果详情】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 ResultsDetailslogic】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  赛果详情 ResultsDetailslogic
    - ResultsDetailslogic
    ```
    ///赛事
    bool event = false;

    ///bet
    bool bet = false;

    ///回放
    bool playback = false;

    ///精彩回放title
    List<String> videoHead = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,
    ];

    ///精彩回放title 多了点球大战
    List<String> videoHead1 = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,

    ///点球大战
    LocaleKeys.football_playing_way_penalty_shootout.tr,
    ];


    /// 头部渲染 对象
    HeaderModel headerMap = HeaderModel();

    /// 头部选择联赛列表
    List<MatchEntity> headMatchList = [];

    /// 当前联赛
    late MatchEntity currentMatch;

    /// 使用默认详情
    late MatchDetailController detailController;

    /// 记录请求次数
    int requestCount = 0;
    ```
    】】】
 *
 */

class ResultsDetailslogic {
  String mid = '';
  bool headMenu = false;
  bool playVideo = false;
  String playVideoUrl = '';

  bool allExpand = true;

  ///赛事
  bool event = false;

  ///bet
  bool bet = false;

  ///回放
  bool playback = false;

  RxBool loading = false.obs;

  /// 记录请求次数
  int requestCount = 0;

  ///精彩回放title
  List<String> videoHead = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,
  ];

  ///精彩回放title 多了点球大战
  List<String> videoHead1 = [
    ///全部
    LocaleKeys.highlights_type_all.tr,

    ///进球
    LocaleKeys.highlights_type_goal.tr,

    ///角球
    LocaleKeys.highlights_type_corner.tr,

    ///罚牌
    LocaleKeys.highlights_type_penalty.tr,

    ///点球大战
    LocaleKeys.football_playing_way_penalty_shootout.tr,
  ];

  bool shootout = false;
  ResultsDetailslogic() {
    ///Initialize variables
  }
}
