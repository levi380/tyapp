class MainMenu {
  int mi;
  String code;
  int type;
  /// 用于区分置顶的入参数： 1:滚球  2:今日  3:早盘  4:电子竞技  5:串关  6:热门页面
  int munuId;

  MainMenu(this.mi, this.code,this.type,this.munuId);

  get isChampion => mi == 400;

  get isEarly => mi == 3;

  get isPlay => mi == 1;

  get isMatchBet => mi == 6;

  get isToday => mi == 2;

  @override
  String toString() {
    return 'Menu{mi: $mi, code: $code}';
  }
  ///一级菜单
  static List<MainMenu> menuList = [
    MainMenu(2, 'today',3,2), // 今日
    MainMenu(1, 'play',1,1), // 滚球
    MainMenu(3, 'early',4,3), // 早盘
    MainMenu(6, 'match_bet',11,5), // 串关
    MainMenu(400, 'champion',100,-1), // 冠军
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainMenu &&
              runtimeType == other.runtimeType &&
              mi == other.mi &&
              type == other.type &&
              code == other.code &&
              munuId == other.munuId;
}
