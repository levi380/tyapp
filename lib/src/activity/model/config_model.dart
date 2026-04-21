class PageRiddleConfigBean {
  int? pageNum;
  int? pageType;
  int? active;
  String? title;
  int? pinTop;
  String? webPageNoTabImg;
  String? webPageTabImg;
  String? appPageNoTabImg;
  String? appPageTabImg;
  String? webContentImg;
  String? appContentImg;
  String? webBackImg;
  String? appBackImg;
  List<int>? vipRequire;
  int? accountInfo;
  int? bindPhone;
  int? groupNum;
  Map? group;
  String? webSummary;
  String? appSummary;

  PageRiddleConfigBean(
      {this.pageNum,
      this.pageType,
      this.active,
      this.title,
      this.pinTop,
      this.webPageNoTabImg,
      this.webPageTabImg,
      this.appPageNoTabImg,
      this.appPageTabImg,
      this.webContentImg,
      this.appContentImg,
      this.webBackImg,
      this.appBackImg,
      this.vipRequire,
      this.accountInfo,
      this.bindPhone,
      this.groupNum,
      this.group,
      this.webSummary,
      this.appSummary});

  PageRiddleConfigBean.fromJson(Map json) {
    pageNum = json['page_num'];
    pageType = json['page_type'];
    active = json['active'];
    title = json['title'];
    pinTop = json['pin_top'];
    webPageNoTabImg = json['web_page_no_tab_img'];
    webPageTabImg = json['web_page_tab_img'];
    appPageNoTabImg = json['app_page_no_tab_img'];
    appPageTabImg = json['app_page_tab_img'];
    webContentImg = json['web_content_img'];
    appContentImg = json['app_content_img'];
    webBackImg = json['web_back_img'];
    appBackImg = json['app_back_img'];
    vipRequire = json['vip_require'].cast<int>();
    accountInfo = json['account_info'];
    bindPhone = json['bind_phone'];
    groupNum = json['group_num'];
    group = json['group'];
    webSummary = json['web_summary'];
    appSummary = json['app_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_num'] = this.pageNum;
    data['page_type'] = this.pageType;
    data['active'] = this.active;
    data['title'] = this.title;
    data['pin_top'] = this.pinTop;
    data['web_page_no_tab_img'] = this.webPageNoTabImg;
    data['web_page_tab_img'] = this.webPageTabImg;
    data['app_page_no_tab_img'] = this.appPageNoTabImg;
    data['app_page_tab_img'] = this.appPageTabImg;
    data['web_content_img'] = this.webContentImg;
    data['app_content_img'] = this.appContentImg;
    data['web_back_img'] = this.webBackImg;
    data['app_back_img'] = this.appBackImg;
    data['vip_require'] = this.vipRequire;
    data['account_info'] = this.accountInfo;
    data['bind_phone'] = this.bindPhone;
    data['group_num'] = this.groupNum;
    data['group'] = this.group;
    data['web_summary'] = this.webSummary;
    data['app_summary'] = this.appSummary;
    return data;
  }
}

class PageRiddleConfigGroupBean {
  int? groupId;
  String? icon;
  String? contestInfo;
  String? leagueName;
  String? appTitle;
  String? mainTeamName;
  String? mainTeamIcon;
  String? visitingTeamName;
  String? visitingTeamIcon;
  int? active;
  String? bounsPool;
  int? payoutStatus;
  int? submissionDeadline;
  int? gameTime;
  String? platformId;
  String? gameId;
  String? gameUrl;
  String? gameType;
  int? gameAreaNum;
  Map? gameArea;
  int? showResultBtn;
  String? showResultAmount;
  int? showResultCount;
  List<ShowResult>? showResult;
  PageRiddleConfigGroupBean(
      {this.groupId,
      this.icon,
      this.contestInfo,
      this.leagueName,
      this.appTitle,
      this.mainTeamName,
      this.mainTeamIcon,
      this.visitingTeamName,
      this.visitingTeamIcon,
      this.active,
      this.bounsPool,
      this.payoutStatus,
      this.submissionDeadline,
      this.gameTime,
        this.platformId,
        this.gameId,
        this.gameType,
        this.gameUrl,
      this.gameAreaNum,
      this.gameArea,
      this.showResultBtn,
      this.showResultAmount,
      this.showResultCount,
      this.showResult});

  PageRiddleConfigGroupBean.fromJson(Map json) {
    groupId = json['group_id'];
    icon = json['icon'];
    contestInfo = json['contest_info'];
    leagueName = json['league_name'];
    appTitle = json['app_title'];
    mainTeamName = json['main_team_name'];
    mainTeamIcon = json['main_team_icon'];
    visitingTeamName = json['visiting_team_name'];
    visitingTeamIcon = json['visiting_team_icon'];
    active = json['active'];
    bounsPool = json['bouns_pool'];
    payoutStatus = json['payout_status'];
    submissionDeadline = json['submission_deadline'];
    gameTime = json['game_time'];
    platformId = json['platform_id'];
    gameId = json['game_id'];
    gameType = json['game_type'];
    gameUrl = json['game_url'];
    gameAreaNum = json['game_area_num'];
    gameArea = json['game_area'];
    showResultBtn = json['show_result_btn'];
    showResultAmount = json['show_result_amount'];
    showResultCount = json['show_result_count'];
    if (json['show_result'] != null) {
      showResult = <ShowResult>[];
      json['show_result'].forEach((v) {
        showResult!.add(new ShowResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['icon'] = this.icon;
    data['contest_info'] = this.contestInfo;
    data['app_title'] = this.appTitle;
    data['league_name'] = this.leagueName;
    data['main_team_name'] = this.mainTeamName;
    data['main_team_icon'] = this.mainTeamIcon;
    data['visiting_team_name'] = this.visitingTeamName;
    data['visiting_team_icon'] = this.visitingTeamIcon;
    data['active'] = this.active;
    data['bouns_pool'] = this.bounsPool;
    data['payout_status'] = this.payoutStatus;
    data['submission_deadline'] = this.submissionDeadline;
    data['game_time'] = this.gameTime;
    data['platform_id'] = this.platformId;
    data['game_id'] = this.gameId;
    data['game_type'] = this.gameType;
    data['game_url'] = this.gameUrl;
    data['game_area_num'] = this.gameAreaNum;
    data['show_result_btn'] = this.showResultBtn;
    data['show_result_amount'] = this.showResultAmount;
    data['show_result_count'] = this.showResultCount;
    if (this.showResult != null) {
      data['show_result'] = this.showResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowResult {
  String? username;
  String? winAmount;

  ShowResult({this.username, this.winAmount});

  ShowResult.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    winAmount = json['win_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['win_amount'] = this.winAmount;
    return data;
  }
}

class GameArea1Bean {
  int? areaId;
  String? title;
  Map? choice;

  GameArea1Bean({this.areaId, this.title, this.choice});

  GameArea1Bean.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    title = json['title'];
    choice = json['choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['title'] = this.title;
    data['choice'] = this.choice;
    return data;
  }
}

class ChoiceBean {
  String? s1;
  String? s2;
  String? s3;

  ChoiceBean({this.s1, this.s2, this.s3});

  ChoiceBean.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    return data;
  }
}

class PageContestConfig {
  int? pageNum;
  int? pageType;
  int? active;
  String? title;
  int? pinTop;
  String? webContentImg;
  String? appContentImg;
  String? webBackImg;
  String? appBackImg;
  List<PageContestConfigGroup>? group;
  int? applyEnter;
  int? applyEnterDisplayAt;
  int? applyMode;
  int? vipRequire;
  int? indicatorRequire;
  String? indicatorRequireValue;
  int? phoneRequire;
  int? applyRecordBtn;
  int? accountInfoRequire;
  String? applySuccessAlertTitle;
  String? applySuccessAlertText;
  String? webSummary;
  String? appSummary;

  PageContestConfig(
      {this.pageNum,
      this.pageType,
      this.active,
      this.title,
      this.pinTop,
      this.webContentImg,
      this.appContentImg,
      this.webBackImg,
      this.appBackImg,
      this.group,
      this.applyEnter,
      this.applyEnterDisplayAt,
      this.applyMode,
      this.vipRequire,
      this.indicatorRequire,
      this.indicatorRequireValue,
      this.phoneRequire,
      this.applyRecordBtn,
      this.accountInfoRequire,
      this.applySuccessAlertTitle,
      this.applySuccessAlertText,
      this.webSummary,
      this.appSummary});

  PageContestConfig.fromJson(Map json) {
    pageNum = json['page_num'];
    pageType = json['page_type'];
    active = json['active'];
    title = json['title'];
    pinTop = json['pin_top'];
    webContentImg = json['web_content_img'];
    appContentImg = json['app_content_img'];
    webBackImg = json['web_back_img'];
    appBackImg = json['app_back_img'];
    if (json['group'] != null) {
      group = <PageContestConfigGroup>[];
      json['group'].forEach((v) {
        group!.add(new PageContestConfigGroup.fromJson(v));
      });
    }
    applyEnter = json['apply_enter'];
    applyEnterDisplayAt = json['apply_enter_display_at'];
    applyMode = json['apply_mode'];
    vipRequire = json['vip_require'];
    indicatorRequire = json['indicator_require'];
    indicatorRequireValue = json['indicator_require_value'];
    phoneRequire = json['phone_require'];
    applyRecordBtn = json['apply_record_btn'];
    accountInfoRequire = json['account_info_require'];
    applySuccessAlertTitle = json['apply_success_alert_title'];
    applySuccessAlertText = json['apply_success_alert_text'];
    webSummary = json['web_summary'];
    appSummary = json['app_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_num'] = this.pageNum;
    data['page_type'] = this.pageType;
    data['active'] = this.active;
    data['title'] = this.title;
    data['pin_top'] = this.pinTop;
    data['web_content_img'] = this.webContentImg;
    data['app_content_img'] = this.appContentImg;
    data['web_back_img'] = this.webBackImg;
    data['app_back_img'] = this.appBackImg;
    if (this.group != null) {
      data['group'] = this.group!.map((v) => v.toJson()).toList();
    }
    data['apply_enter'] = this.applyEnter;
    data['apply_enter_display_at'] = this.applyEnterDisplayAt;
    data['apply_mode'] = this.applyMode;
    data['vip_require'] = this.vipRequire;
    data['indicator_require'] = this.indicatorRequire;
    data['indicator_require_value'] = this.indicatorRequireValue;
    data['phone_require'] = this.phoneRequire;
    data['apply_record_btn'] = this.applyRecordBtn;
    data['account_info_require'] = this.accountInfoRequire;
    data['apply_success_alert_title'] = this.applySuccessAlertTitle;
    data['apply_success_alert_text'] = this.applySuccessAlertText;
    data['web_summary'] = this.webSummary;
    data['app_summary'] = this.appSummary;
    return data;
  }
}

class PageContestConfigGroup {
  int? id;
  String? contestInfo;
  String? appTitle;
  String? leagueName;
  String? mainTeamName;
  String? mainTeamIcon;
  String? visitingTeamName;
  String? visitingTeamIcon;
  int? gameTime;
  String? platformId;
  String? gameId;
  String? gameUrl;
  String? gameType;
  int? active;

  PageContestConfigGroup(
      {this.id,
      this.contestInfo,
      this.appTitle,
      this.leagueName,
      this.mainTeamName,
      this.mainTeamIcon,
      this.visitingTeamName,
      this.visitingTeamIcon,
      this.gameTime,
      this.platformId,
      this.gameId,
      this.gameType,
      this.gameUrl,
      this.active});

  PageContestConfigGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contestInfo = json['contest_info'];
    leagueName = json['league_name'];
    appTitle = json['app_title'];
    mainTeamName = json['main_team_name'];
    mainTeamIcon = json['main_team_icon'];
    visitingTeamName = json['visiting_team_name'];
    visitingTeamIcon = json['visiting_team_icon'];
    gameTime = json['game_time'];
    platformId = json['platform_id'];
    gameId = json['game_id'];
    gameType = json['game_type'];
    gameUrl = json['game_url'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contest_info'] = this.contestInfo;
    data['league_name'] = this.leagueName;
    data['app_title'] = this.appTitle;
    data['main_team_name'] = this.mainTeamName;
    data['main_team_icon'] = this.mainTeamIcon;
    data['visiting_team_name'] = this.visitingTeamName;
    data['visiting_team_icon'] = this.visitingTeamIcon;
    data['game_time'] = this.gameTime;
    data['platform_id'] = this.platformId;
    data['game_id'] = this.gameId;
    data['game_type'] = this.gameType;
    data['game_url'] = this.gameUrl;
    data['active'] = this.active;
    return data;
  }
}
