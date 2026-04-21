/// pid : 509
/// wallet : "DB棋牌"
/// locked : 0
/// maintained : 1

class PlatformModel {
  PlatformModel({
    this.pid,
    this.name,
    this.maintained,
  });

  String? pid;
  String? name;
  int? maintained; // 维护状态 1=正常 2=维护中
}
