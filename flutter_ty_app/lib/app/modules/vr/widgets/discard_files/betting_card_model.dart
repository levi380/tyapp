/// 投注卡片数据模型
/// 用于购物车详情对话框中的投注项展示
class BettingCardModel {
  /// 队伍名称（如：阿根廷 +0/0.5）
  final String teamName;

  /// 赔率值
  final String odds;

  /// 联赛名称
  final String leagueName;

  /// 比赛双方名称
  final String matchName;

  /// 投注玩法名称
  final String betName;

  /// 盘口类型（如：欧洲盘）
  final String handicapType;

  /// 构造函数
  BettingCardModel({
    this.teamName = '',
    this.odds = '',
    this.leagueName = '',
    this.matchName = '',
    this.betName = '',
    this.handicapType = '',
  });

  /// 生成模拟数据
  factory BettingCardModel.mock() {
    return BettingCardModel(
      teamName: '阿根廷 +0/0.5',
      odds: '9.99',
      leagueName: '2022 PESI欧洲超级联赛',
      matchName: '阿根廷 VS 克罗地亚',
      betName: '上半场大小-附加盘 (0-0)',
      handicapType: '欧洲盘',
    );
  }
}
