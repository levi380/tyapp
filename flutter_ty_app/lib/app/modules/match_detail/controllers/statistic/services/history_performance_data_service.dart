import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity_electronic_football_entity.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../models/analysis/analysis_model.dart';

/**
 * 历史表现数据服务类
 * 负责处理历史表现数据的查找、转换和统计
 */
class HistoryPerformanceDataService {
  /**
   * 根据类型查找数据
   * [dataList] 历史表现数据列表
   * [gridListDataBeans] 网格数据Bean列表，用于填充数据
   * 根据expressingType（0-全部，1-主场，2-客场）填充对应的数据Bean
   * name2: 前5场比赛的状态数组
   * name4: 平均进球数
   * 返回：排名和队伍名称的Map
   */
  static Map<String, String> findByType(
    List<HistoricalPerformancePBBeanEntity> dataList,
    List<GridListDataBean> gridListDataBeans,
  ) {
    for (HistoricalPerformancePBBeanEntity entity in dataList) {
      // expressingType == 0: 全部比赛
      if (entity.expressingType == 0) {
        gridListDataBeans[0].name2 = [
          entity.firstStatus ?? -1,
          entity.secondStatus ?? -1,
          entity.thirdStatus ?? -1,
          entity.fourthStatus ?? -1,
          entity.fifthStatus ?? -1
        ];
        gridListDataBeans[0].name4 = "${entity.averageGoal}";
      }
      // expressingType == 1: 主场比赛
      else if (entity.expressingType == 1) {
        gridListDataBeans[1].name2 = [
          entity.firstStatus ?? -1,
          entity.secondStatus ?? -1,
          entity.thirdStatus ?? -1,
          entity.fourthStatus ?? -1,
          entity.fifthStatus ?? -1
        ];
        gridListDataBeans[1].name4 = "${entity.averageGoal}";
      }
      // expressingType == 2: 客场比赛
      else if (entity.expressingType == 2) {
        gridListDataBeans[2].name2 = [
          entity.firstStatus ?? -1,
          entity.secondStatus ?? -1,
          entity.thirdStatus ?? -1,
          entity.fourthStatus ?? -1,
          entity.fifthStatus ?? -1
        ];
        gridListDataBeans[2].name4 = "${entity.averageGoal}";
      }
    }

    String rank = "";
    String teamName = "";
    if (dataList.isNotEmpty) {
      rank = dataList.first.expressionRanking ?? "";
      teamName = dataList.first.teamCnName ?? "";
    }

    return {"rank": rank, "teamName": teamName};
  }

  /**
   * 根据类型查找电子足球数据
   * [dataList] 电子足球历史表现数据列表
   * [gridListDataBeansElectronicFootball] 电子足球网格数据Bean列表
   * [tabIndex] 当前tab索引，0为主队，1为客队
   * 根据tabIndex选择主队或客队数据，填充全部、主场、客场的数据Bean
   */
  static void findByTypeElectronicFootball(
    List<HistoricalPerformancePBBeanEntityElectronicFootballEntity> dataList,
    List<GridListDataBean> gridListDataBeansElectronicFootball,
    int tabIndex,
  ) {
    if (dataList.length >= 2) {
      HistoricalPerformancePBBeanEntityElectronicFootballEntity entity =
          HistoricalPerformancePBBeanEntityElectronicFootballEntity.fromJson(
              {});

      // 根据tabIndex选择主队或客队数据
      if (tabIndex == 0) {
        entity = dataList[0];
      } else if (tabIndex == 1) {
        entity = dataList[1];
      }



      Get.log("=========>entity  ${entity.toJson()}");

      // 全部比赛数据
      gridListDataBeansElectronicFootball[0].name2 = entity.summary ?? [];
      gridListDataBeansElectronicFootball[0].name4 =
          "${entity.summaryAvg?.toStringAsFixed(2)}";

      gridListDataBeansElectronicFootball[0].name3 =
      "${(((getCountColor(gridListDataBeansElectronicFootball[0].name2,1)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[0].name2,2)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[0].name2,0)*100)/5).toInt())}%";
      

      // 主场比赛数据
      gridListDataBeansElectronicFootball[1].name2 = entity.home ?? [];
      gridListDataBeansElectronicFootball[1].name4 =
          "${entity.homeAvg?.toStringAsFixed(2)}";
      gridListDataBeansElectronicFootball[1].name3 =
      "${(((getCountColor(gridListDataBeansElectronicFootball[1].name2,1)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[1].name2,2)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[1].name2,0)*100)/5).toInt())}%";



      // 客场比赛数据
      gridListDataBeansElectronicFootball[2].name2 = entity.away ?? [];
      gridListDataBeansElectronicFootball[2].name4 =
          "${entity.awayAvg?.toStringAsFixed(2)}";


      gridListDataBeansElectronicFootball[2].name3 =
      "${(((getCountColor(gridListDataBeansElectronicFootball[2].name2,1)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[2].name2,2)*100)/5).toInt())}%/${(((getCountColor(gridListDataBeansElectronicFootball[2].name2,0)*100)/5).toInt())}%";


    }
  }


  static int getCountColor(List<int> name2, int type) {
    int i=0;
    name2.map((e) {
      if(e==type) {
        i++;
      }
    }).toList();

    // 负
    if (type == 0) {
    //   胜
    } else if (type == 1) {
    //   平
    } else if (type == 2) {
    }
    return i;
  }
  /// 获取进球数
  /// [entity] 历史表现实体
  /// 统计前5场比赛中状态为0（进球）的场次数量
  static int getjinQiu(HistoricalPerformancePBBeanEntity entity) {
    int total = 0;
    if ((entity.firstStatus ?? -1) == 0) {
      total++;
    }
    if ((entity.secondStatus ?? -1) == 0) {
      total++;
    }
    if ((entity.thirdStatus ?? -1) == 0) {
      total++;
    }
    if ((entity.fourthStatus ?? -1) == 0) {
      total++;
    }
    if ((entity.fifthStatus ?? -1) == 0) {
      total++;
    }
    return total;
  }
}

