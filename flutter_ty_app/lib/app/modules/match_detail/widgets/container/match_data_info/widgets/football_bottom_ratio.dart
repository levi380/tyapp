// 导入数据存储控制器，用于管理全局数据状态
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
// 导入登录相关的通用导入文件，包含常用的Flutter和GetX依赖
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
// 导入比赛数据控制器，用于管理比赛数据的业务逻辑和状态
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';

import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/match_predict_goal.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import 'football_shot_progress_row.dart';

/**
 * 足球底部比例组件
 * 
 * 功能说明：
 * - 用于显示足球比赛中的射正、射偏等统计数据
 * - 以线性进度条的形式展示主队和客队的数据对比
 * - 根据数据值动态计算进度条的比例
 * - 支持显示预期进球、预期失球等预测数据
 * 
 * 使用场景：
 * - 在足球数据页面中显示比赛过程中的统计数据
 * - 实时展示双方队伍的对比数据，以线性进度条形式呈现
 */
class FootballBottomRatio extends StatelessWidget {
  // 构造函数，使用const关键字优化性能
  // super.key: 传递给父类StatelessWidget的key，用于Widget树中的唯一标识
  // required this.controller: 必需的参数，传入MatchDataController实例
  // required this.dataController: 必需的参数，传入DataStoreController实例
  // required this.manColor: 必需的参数，传入主队颜色（用于进度条显示）
  // required this.awayColor: 必需的参数，传入客队颜色（用于进度条显示）
  const FootballBottomRatio({
    super.key,
    required this.controller,
    required this.dataController,
    required this.manColor,
    required this.awayColor,
  });

  // 定义控制器属性，类型为MatchDataController
  // 该控制器负责管理比赛数据的状态和业务逻辑
  final MatchDataController controller;
  // 定义数据存储控制器属性，类型为DataStoreController
  // 该控制器负责管理全局数据状态
  final DataStoreController dataController;
  // 定义主队颜色属性，类型为Color
  // 用于进度条的颜色显示，通常为红色系
  final Color manColor;
  // 定义客队颜色属性，类型为Color
  // 用于进度条的颜色显示，通常为橙色或黄色系
  final Color awayColor;

  /**
   * 构建Widget树
   * 
   * 该方法根据数据状态构建底部比例组件：
   * 1. 检查数据是否为空，为空则返回空组件
   * 2. 计算射正、射偏数据的比例
   * 3. 显示射正、射偏的线性进度条
   * 4. 显示预期进球、预期失球等预测数据
   * 
   * 参数：
   * - context: 构建上下文，提供访问主题、媒体查询等信息的接口
   * 
   * 返回：
   * - Widget: 返回包含所有比例数据的Column组件
   */
  @override
  Widget build(BuildContext context) {
    // 获取控制器中的状态对象，包含所有数据状态
    MatchDataState state = controller.state;
    // 判断：如果第三组数据列表为空，返回空组件
    // totalThreeListData存储的是射正、射偏等统计数据
    if (state.totalThreeListData.isEmpty) {
      // 返回一个空的SizedBox，不占用任何空间
      return const SizedBox();
    }
    // 判断：如果当前选中的页面索引超出数据列表长度，返回空组件
    // 防止数组越界异常
    if (state.totalThreeListData.length <= state.currentTitlePageIndex) {
      // 返回一个空的SizedBox，不占用任何空间
      return const SizedBox();
    }
    // 判断：如果当前选中页面的数据列表为空，返回空组件
    if (state.totalThreeListData[state.currentTitlePageIndex].isEmpty) {
      // 返回一个空的SizedBox，不占用任何空间
      return const SizedBox();
    }

    // 初始化数据列表，用于存储格式化后的数据
    // dataLists: 存储组合格式的数据（如："4/2"表示射正4次射偏2次）
    List<String> dataLists = [];
    // dataListsSeparate: 存储分离格式的数据（如：["4", "2", "2", "1"]分别表示主队射正、客队射正、主队射偏、客队射偏）
    List<String> dataListsSeparate = [];
    // dataListRateSeparate: 存储进度条比例数据（如：[0.8, 0.2, 0.5, 0.5]分别表示主队射正比例、客队射正比例、主队射偏比例、客队射偏比例）
    List<double> dataListRateSeparate = [0, 0, 0, 0];

    // 判断：如果当前选中页面的数据列表长度>=2（包含射正和射偏两个数据项）
    if (state.totalThreeListData[state.currentTitlePageIndex].length >= 2) {
      // 设置组合格式的数据列表
      // 第一个元素：主队射正/主队射偏（如："4/2"）
      // 第二个元素：客队射正/客队射偏（如："3/1"）
      dataLists = [
        // 主队射正次数/主队射偏次数
        "${state.totalThreeListData[state.currentTitlePageIndex][0].home.toInt()}/${state.totalThreeListData[state.currentTitlePageIndex][1].home.toInt()}",
        // 客队射正次数/客队射偏次数
        "${state.totalThreeListData[state.currentTitlePageIndex][0].away.toInt()}/${state.totalThreeListData[state.currentTitlePageIndex][1].away.toInt()}"
      ];
      // 设置分离格式的数据列表
      // 分别存储：主队射正、客队射正、主队射偏、客队射偏
      dataListsSeparate = [
        // 主队射正次数
        "${state.totalThreeListData[state.currentTitlePageIndex][0].home.toInt()}",
        // 客队射正次数
        "${state.totalThreeListData[state.currentTitlePageIndex][0].away.toInt()}",
        // 主队射偏次数
        "${state.totalThreeListData[state.currentTitlePageIndex][1].home.toInt()}",
        // 客队射偏次数
        "${state.totalThreeListData[state.currentTitlePageIndex][1].away.toInt()}"
      ];
      // 获取主队射正数值（转换为double类型，用于计算比例）
      double home1 =
          state.totalThreeListData[state.currentTitlePageIndex][0].home.toDouble();
      // 获取客队射正数值（转换为double类型，用于计算比例）
      double away1 =
          state.totalThreeListData[state.currentTitlePageIndex][0].away.toDouble();
      // 获取主队射偏数值（转换为double类型，用于计算比例）
      double home2 =
          state.totalThreeListData[state.currentTitlePageIndex][1].home.toDouble();
      // 获取客队射偏数值（转换为double类型，用于计算比例）
      double away2 =
          state.totalThreeListData[state.currentTitlePageIndex][1].away.toDouble();
      // 初始化主队射正进度条比例（左侧进度条）
      double la1 = 0;
      // 初始化客队射正进度条比例（右侧进度条）
      double ra1 = 0;
      // 初始化主队射偏进度条比例（左侧进度条）
      double la2 = 0;
      // 初始化客队射偏进度条比例（右侧进度条）
      double ra2 = 0;
      // 判断：如果主队射正或客队射正不为0（有数据）
      if (home1 != 0 || away1 != 0) {
        // 判断：如果主队射正等于客队射正（平局）
        if (home1 == away1) {
          // 设置主队和客队进度条比例都为1（各占50%）
          la1 = 1;
          ra1 = 1;
        } 
        // 判断：如果主队射正大于客队射正（主队占优）
        else if (home1 > away1) {
          // 主队进度条比例为1（占满），客队进度条比例为客队/主队的比值
          la1 = 1;
          ra1 = away1 / home1;
        } 
        // 如果客队射正大于主队射正（客队占优）
        else {
          // 客队进度条比例为1（占满），主队进度条比例为主队/客队的比值
          ra1 = 1;
          la1 = home1 / away1;
        }
      }
      // 判断：如果主队射偏或客队射偏不为0（有数据）
      if (home2 != 0 || away2 != 0) {
        // 判断：如果主队射偏等于客队射偏（平局）
        if (home2 == away2) {
          // 设置主队和客队进度条比例都为1（各占50%）
          la2 = 1;
          ra2 = 1;
        } 
        // 判断：如果主队射偏大于客队射偏（主队占优）
        else if (home2 > away2) {
          // 主队进度条比例为1（占满），客队进度条比例为客队/主队的比值
          la2 = 1;
          ra2 = away2 / home2;
        } 
        // 如果客队射偏大于主队射偏（客队占优）
        else {
          // 客队进度条比例为1（占满），主队进度条比例为主队/客队的比值
          ra2 = 1;
          la2 = home2 / away2;
        }
      }
      // 将计算得到的进度条比例存储到列表中
      // 顺序为：主队射正比例、客队射正比例、主队射偏比例、客队射偏比例
      dataListRateSeparate = [la1, ra1, la2, ra2];
    }

    // 返回一个Column组件，垂直排列所有子组件
    return Column(
      // Column的子组件列表
      children: [
        // 添加垂直间距：6.w，用于与上方内容的间隔
        SizedBox(height: 6.w),
        // 使用Column垂直排列射正、射偏数据
        Column(
          // 使用map方法遍历当前选中页面的数据列表
          children: state.totalThreeListData[state.currentTitlePageIndex].map((e) {
            // 获取当前数据项在列表中的索引位置
            // index=0表示射正数据，index=1表示射偏数据
            int index =
                state.totalThreeListData[state.currentTitlePageIndex].indexOf(e);
            // 判断：如果射正和射偏数据都为"0/0"（无数据）
            if (dataLists[0] == "0/0" && dataLists[1] == "0/0") {
              // 返回空组件，不显示
              return const SizedBox();
            }
            if (index == 1) {
              return FootballShotProgressRow(
                label: LocaleKeys.match_result_shot_off.tr,
                leftValue: dataListsSeparate[2],
                rightValue: dataListsSeparate[3],
                leftProgress: dataListRateSeparate[2],
                rightProgress: dataListRateSeparate[3],
                leftColor: manColor,
                rightColor: awayColor,
                progressWidth: 60,
              );
            }
            return FootballShotProgressRow(
              label: LocaleKeys.match_result_shoot_right.tr,
              leftValue: dataListsSeparate[0],
              rightValue: dataListsSeparate[1],
              leftProgress: dataListRateSeparate[0],
              rightProgress: dataListRateSeparate[1],
              leftColor: manColor,
              rightColor: awayColor,
              progressWidth: 54,
            );
          }).toList(), // 将map结果转换为List，作为Column的children
        ),
        // 使用Column垂直排列预期进球、预期失球等预测数据
        Column(
          // 使用map方法遍历state.four列表
          // four存储的是预期进球、预期失球等预测数据
          children: state.four.map((eValue) {
            // 判断：如果主队和客队的预测值都为0（无数据）
            // 使用isEqual方法比较数值是否相等（处理浮点数比较）
            if (eValue.home.isEqual(0) && eValue.away.isEqual(0)) {
              // 返回空组件，不显示
              return const SizedBox();
            }
            // 创建MatchPredictInfoModel对象，用于传递给MatchPredictGoal组件
            MatchPredictInfoModel e = MatchPredictInfoModel(
              // 设置左侧标题（主队预测值）
              // 如果主队预测值为0，显示"-"，否则显示数值（去除".0"后缀）
              leftTitle: eValue.home.isEqual(0)
                  ? "-"
                  : "${eValue.home}".replaceAll(".0", ""),
              // 设置右侧标题（客队预测值）
              // 如果客队预测值为0，显示"-"，否则显示数值（去除".0"后缀）
              rightTitle: eValue.away.isEqual(0)
                  ? "-"
                  : "${eValue.away}".replaceAll(".0", ""),
              // 设置中心标题（数据项标题，如："预期进球"、"预期失球"等）
              centerTitle: eValue.title,
            );

            // 返回MatchPredictGoal组件，显示预期数据
            return MatchPredictGoal(data: e);
          }).toList(), // 将map结果转换为List，作为Column的children
        )
      ],
    );
  }
}
