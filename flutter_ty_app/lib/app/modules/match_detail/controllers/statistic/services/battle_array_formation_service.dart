import 'package:flutter_ty_app/app/modules/match_detail/states/battle_array_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_array_person_entity.dart';
import 'battle_array_formation_helper.dart';

/**
 * 阵型过滤服务类
 * 负责处理足球阵型的过滤和格式化逻辑
 */
class BattleArrayFormationService {
  /// 过滤客队阵型
  static void filterAwayArray(
    BattleArrayState state,
    String data,
    int index,
  ) {
    if (data.isEmpty) {
      return;
    }
    state.football_filtered_data_away.clear();
    
    // 解析阵型
    List<int> formation = BattleArrayFormationHelper.parseFormation(data);
    int length1 = formation[0];
    int length2 = formation[1];
    int length3 = formation[2];
    state.number = formation[3];
    
    if (length1 == 0 || length2 == 0) {
      return;
    }

    if (data.startsWith("4-2-3")) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_away);
      List<Up> two = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 1, 5, Up.BLUE, reversed: true);
      List<Up> three = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 5, 7, Up.YELLOW, reversed: true);
      List<Up> four = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 7, 10, Up.YELLOW, reversed: true);
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_away);

      state.football_filtered_data_away.add([one]);
      state.football_filtered_data_away.add(two);
      state.football_filtered_data_away.add(three);
      state.football_filtered_data_away.add(four);
      if (five != null) {
        state.football_filtered_data_away.add([five]);
      }
    } else if (data.startsWith("4-3-2")) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_away);
      List<Up> two = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 1, 5, Up.BLUE, reversed: true);
      List<Up> three = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 5, 8, Up.YELLOW, reversed: true);
      List<Up> four = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 8, 10, Up.YELLOW, reversed: true);
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_away);
      
      state.football_filtered_data_away.add([one]);
      state.football_filtered_data_away.add(two);
      state.football_filtered_data_away.add(three);
      state.football_filtered_data_away.add(four);
      if (five != null) {
        state.football_filtered_data_away.add([five]);
      }
    } else if (data.startsWith("3-5-1")) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_away);
      List<Up> two = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 1, 4, Up.BLUE, reversed: true);
      List<Up> three = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 4, 9, Up.YELLOW, reversed: true);
      List<Up> four = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 9, 10, Up.YELLOW, reversed: true);
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_away);
      
      state.football_filtered_data_away.add([one]);
      state.football_filtered_data_away.add(two);
      state.football_filtered_data_away.add(three);
      state.football_filtered_data_away.add(four);
      if (five != null) {
        state.football_filtered_data_away.add([five]);
      }
    } else if (data.startsWith("3-4-2")) {
      dealData342(state, false);
    } else {
      // 通用阵型处理
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_away);
      List<Up> two = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, 1, length1 + 1, Up.BLUE, reversed: true);
      List<Up> three = BattleArrayFormationHelper.getSublistWithColor(
          state.line_up_data_away, length1 + 1, length1 + 1 + length2, 
          Up.YELLOW, reversed: true);
      
      List<Up> four = [];
      if (length3 > 0) {
        int startIndex = length1 + 1 + length2;
        int endIndex = startIndex + length3;
        four = BattleArrayFormationHelper.getSublistWithColor(
            state.line_up_data_away, startIndex, endIndex, 
            data.split('-').length == 2 ? Up.RED : Up.YELLOW, reversed: true);
      }
      
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_away);
      
      state.football_filtered_data_away.add([one]);
      state.football_filtered_data_away.add(two);
      state.football_filtered_data_away.add(three);
      if (four.isNotEmpty) {
        state.football_filtered_data_away.add(four);
      }
      if (five != null && data.split('-').length != 2) {
        state.football_filtered_data_away.add([five]);
      }
    }
  }

  /// 过滤主队阵型
  static void filterHomeArray(
    BattleArrayState state,
    String data,
    int index,
  ) {
    if (data.isEmpty) {
      return;
    }
    
    // 解析阵型
    List<int> formation = BattleArrayFormationHelper.parseFormation(data);
    int length1 = formation[0];
    int length2 = formation[1];
    int length3 = formation[2];
    state.number = formation[3];
    
    if (length1 == 0 || length2 == 0) {
      return;
    }
    
    // 主队
    state.football_filtered_data_home.clear();
    if (data.startsWith("3-5-2")) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_home);
      List<Up> two = state.line_up_data_home?.up?.sublist(1, 4) ?? [];
      List<Up> three = state.line_up_data_home?.up?.sublist(4, 9) ?? [];
      List<Up> four = state.line_up_data_home?.up?.sublist(9, 11) ?? [];
      state.football_filtered_data_home.add(four);
      state.football_filtered_data_home.add(three);
      state.football_filtered_data_home.add(two);
      state.football_filtered_data_home.add([one]);
    } else if (data.startsWith("4-3-3")) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_home);
      List<Up> two = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(1, 5), Up.BLUE);
      List<Up> three = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(5, 8), Up.YELLOW);
      List<Up> four = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(8, 11), Up.RED);
      state.football_filtered_data_home.add(four);
      state.football_filtered_data_home.add(three);
      state.football_filtered_data_home.add(two);
      state.football_filtered_data_home.add([one]);
    } else if (data.startsWith("3-4-2")) {
      dealData342(state, true);
    } else {
      // 通用阵型处理
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_home);
      List<Up> two = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(1, length1 + 1), Up.BLUE);
      List<Up> three = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(length1 + 1, length1 + 1 + length2),
          Up.YELLOW);
      
      List<Up> four = [];
      if (length3 > 0) {
        int startIndex = length1 + 1 + length2;
        int endIndex = startIndex + length3;
        four = BattleArrayFormationHelper.createColoredPlayerList(
            state.line_up_data_home?.up?.sublist(startIndex, endIndex), Up.YELLOW);
      }

      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_home);
      
      if (five != null) {
        state.football_filtered_data_home.add([five]);
      }
      if (four.isNotEmpty) {
        state.football_filtered_data_home.add(four);
      }
      state.football_filtered_data_home.add(three);
      state.football_filtered_data_home.add(two);
      state.football_filtered_data_home.add([one]);
    }
  }

  /// 处理3-4-2阵型
  static void dealData342(BattleArrayState state, bool isHomeTeam) {
    if (isHomeTeam) {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_home);
      List<Up> two = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(1, 4), Up.BLUE);
      List<Up> three = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(4, 8), Up.YELLOW);
      List<Up> four = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_home?.up?.sublist(8, 10), Up.YELLOW);
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_home);
      
      if (five != null) {
        state.football_filtered_data_home.add([five]);
      }
      state.football_filtered_data_home.add(four);
      state.football_filtered_data_home.add(three);
      state.football_filtered_data_home.add(two);
      state.football_filtered_data_home.add([one]);
    } else {
      Up one = BattleArrayFormationHelper.getGoalkeeper(state.line_up_data_away);
      List<Up> two = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_away?.up?.sublist(1, 4), Up.BLUE);
      List<Up> three = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_away?.up?.sublist(4, 8), Up.YELLOW);
      List<Up> four = BattleArrayFormationHelper.createColoredPlayerList(
          state.line_up_data_away?.up?.sublist(8, 10), Up.YELLOW);
      Up? five = BattleArrayFormationHelper.getForward(state.line_up_data_away);
      
      state.football_filtered_data_away.add([one]);
      state.football_filtered_data_away.add(two);
      state.football_filtered_data_away.add(three);
      state.football_filtered_data_away.add(four);
      if (five != null) {
        state.football_filtered_data_away.add([five]);
      }
    }
  }

  /// 获取结束长度
  static int getEndLength(List<Up>? list, int index) {
    if (index > (list?.length ?? 0)) {
      return list?.length ?? 0;
    }
    if (index < 0) {
      index = 0;
    }
    return index;
  }

  /// 判断是否显示项目
  static bool showItem(
    BattleArrayState state,
    bool first,
    Up? item,
  ) {
    AnalyzeArrayPersonEntity? entity = (state.curMainTab == 0
        ? state.line_up_data_home
        : state.line_up_data_away);
    if (first) {
      if (entity == null ||
          entity.up?.isEmpty == true ||
          entity.up?.first == null) {
        return false;
      }
    } else {
      if (entity == null ||
          entity.up?.isEmpty == true ||
          entity.up?.last == null) {
        return false;
      }
    }

    bool show = ((state.number == 3 && (item?.position ?? 0) > 8) ||
            item?.position == 1 ||
            (state.number == 2 && (item?.position ?? 0) > 9) ||
            (state.number == 1 && (item?.position ?? 0) > 10)) &&
        (item?.position ?? 0) <= 11;
    if (item?.homeFormation == "4-3-3" && first == false) {
      show = false;
    }
    return show;
  }
}

