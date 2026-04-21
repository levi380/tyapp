/**
 * 盘面选择器模型类
 * 
 * 包含选择器相关的数据模型：
 * - SelectBean: 一级选择器模型
 * - ChildSelectBean: 二级选择器模型
 * - ThirdChildSelectBean: 三级选择器模型
 */

/**
 * 一级选择器模型
 * 
 * 用于表示走势图的一级选择项，包含名称、值和子选项列表
 */
class SelectBean {
  /// 选择项名称
  String? name;
  
  /// 选择项值（玩法ID）
  int? value;
  
  /// 子选择项列表（二级选择器）
  List<ChildSelectBean>? datas;

  SelectBean({this.name, this.value, this.datas});
}

/**
 * 二级选择器模型
 * 
 * 用于表示走势图的二级选择项，包含名称、值和三级选项列表
 */
class ChildSelectBean {
  /// 选择项值
  String? value;
  
  /// 选择项名称
  String? name;
  
  /// 三级选择项列表
  List<ThirdChildSelectBean>? datas;

  ChildSelectBean({this.value, this.name, this.datas});
}

/**
 * 三级选择器模型
 * 
 * 用于表示走势图的三级选择项，包含名称和值
 */
class ThirdChildSelectBean {
  /// 选择项值
  String? value;
  
  /// 选择项名称
  String? name;

  ThirdChildSelectBean({this.value, this.name});
}

