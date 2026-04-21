import 'package:flutter_ty_app/app/services/models/res/analyze_array_person_entity.dart';

/**
 * 阵型处理辅助类
 * 提供通用的阵型处理辅助方法，减少重复代码
 */
class BattleArrayFormationHelper {
  /// 解析阵型字符串
  /// 返回 [length1, length2, length3, number]
  static List<int> parseFormation(String data) {
    if (data.isEmpty) {
      return [0, 0, 0, 0];
    }
    
    int number = int.tryParse(data.substring(data.length - 1, data.length)) ?? 0;
    List<String> number_columns = data.split('-');
    number_columns.removeLast();
    
    if (number_columns.isEmpty || number_columns.length < 2) {
      return [0, 0, 0, number];
    }
    
    int length1 = int.tryParse(number_columns[0]) ?? 0;
    int length2 = int.tryParse(number_columns[1]) ?? 0;
    int length3 = 0;
    if (number_columns.length >= 3) {
      length3 = int.tryParse(number_columns[2]) ?? 0;
    }
    
    return [length1, length2, length3, number];
  }

  /// 创建带颜色的球员列表
  /// [list] 球员列表
  /// [colorType] 颜色类型
  static List<Up> createColoredPlayerList(List<Up>? list, int colorType) {
    return (list ?? []).map((e) {
      e.colorType = colorType;
      return e;
    }).toList();
  }

  /// 创建带颜色的球员列表（反转）
  /// [list] 球员列表
  /// [colorType] 颜色类型
  static List<Up> createColoredPlayerListReversed(List<Up>? list, int colorType) {
    return (list ?? []).reversed.toList().map((e) {
      e.colorType = colorType;
      return e;
    }).toList();
  }

  /// 获取守门员（第一个球员）
  /// [lineUpData] 阵容数据
  static Up getGoalkeeper(AnalyzeArrayPersonEntity? lineUpData) {
    Up one = lineUpData?.up?.first ?? Up();
    one.colorType = Up.GRAY;
    return one;
  }

  /// 获取前锋（最后一个球员，排除主教练）
  /// [lineUpData] 阵容数据
  static Up? getForward(AnalyzeArrayPersonEntity? lineUpData) {
    if (lineUpData?.up?.last.positionName == "主教练") {
      List<Up>? upList = lineUpData?.up;
      if (upList == null || upList.length < 2) {
        return null;
      }
      Up five = upList[upList.length - 2];
      five.colorType = Up.RED;
      return five;
    } else {
      Up? five = lineUpData?.up?.last;
      if (five != null) {
        five.colorType = Up.RED;
      }
      return five;
    }
  }

  /// 获取子列表并设置颜色
  /// [lineUpData] 阵容数据
  /// [start] 起始索引
  /// [end] 结束索引
  /// [colorType] 颜色类型
  /// [reversed] 是否反转
  static List<Up> getSublistWithColor(
    AnalyzeArrayPersonEntity? lineUpData,
    int start,
    int end,
    int colorType, {
    bool reversed = false,
  }) {
    List<Up>? sublist = lineUpData?.up;
    if (sublist == null || start >= sublist.length) {
      return [];
    }
    int actualEnd = end > sublist.length ? sublist.length : end;
    List<Up> list = sublist.sublist(start, actualEnd);
    if (reversed) {
      list = list.reversed.toList();
    }
    return list.map((e) {
      e.colorType = colorType;
      return e;
    }).toList();
  }
}

