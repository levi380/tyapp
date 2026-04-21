enum FilterType {
  ///币种
  currency,

  ///场馆类型
  game,

  ///状态
  status,

  ///交易类型--有二级分类
  transaction,

  ///日期
  date,

  ///红利--有二级分类
  welfare,

  ///交易类型子级 -存款
  tradeDeposit,

  ///交易类型子级 -取款
  tradeWithdrawal,

  ///交易类型子级 -场馆游戏
  tradeGame,

  ///交易类型子级 -返水
  tradeRebate,

  ///交易类型子级 -活动
  tradeActivity,

  ///交易类型子级 -调整
  tradeAdjust,

  ///红利子级 -返水
  welfareRebate,

  ///红利子级 -活动
  welfareActivity;
}

class FilterModel {
  ///里面筛选列表头部标题
  final String title;

  ///1级分类
  List<SubFilterModel>? list;

  ///类型 1/2级 用作判断
  FilterType type;

  ///点击确认按钮后的模型
  SubFilterModel currentModel;

  ///选中的模型 但是未点确定按钮
  SubFilterModel? selectModel;
  int selectIndex;
  FilterModel({
    required this.type,
    required this.title,
    required this.currentModel,
    this.selectModel,
    this.list,
    this.selectIndex = 0,
  });
}

class SubFilterModel {
  ///筛选显示的名称 ?? name 为空则显示name 用于'全部' 显示成'全部类型'
  final String? showName;

  ///名称
  String name;

  ///值 传递给后台的
  String value;

  ///子级
  final FilterModel? filterModel; //子级
  SubFilterModel(
      {required this.name,
      required this.value,
      this.filterModel,
      this.showName});
}
