/// VR 赛马投注卡片数据模型
class VrHorseCardModel {
  /// 队伍名称
  final String teamName;

  /// 赔率
  final String odds;

  /// 赔率是否上升
  final bool isOddsUp;

  /// 赔率是否下降
  final bool isOddsDown;

  /// 联赛名称
  final String leagueName;

  /// 比赛双方
  final String matchName;

  /// 投注玩法名称
  final String betName;

  /// 盘口类型（如欧洲盘）
  final String handicapType;

  /// 构造函数
  VrHorseCardModel({
    this.teamName = '',
    this.odds = '',
    this.isOddsUp = false,
    this.isOddsDown = false,
    this.leagueName = '',
    this.matchName = '',
    this.betName = '',
    this.handicapType = '',
  });

  /// 模拟数据
  factory VrHorseCardModel.mock() {
    return VrHorseCardModel(
      teamName: '阿根廷 +0/0.5',
      odds: '9.99',
      isOddsUp: false,
      isOddsDown: false,
      leagueName: '2022 PESI欧洲超级联赛',
      matchName: '阿根廷 VS 克罗地亚',
      betName: '上半场大小-附加盘 (0-0)',
      handicapType: '欧洲盘',
    );
  }
}
