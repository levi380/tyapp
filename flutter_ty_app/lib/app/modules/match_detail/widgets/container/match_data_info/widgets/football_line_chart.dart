import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';

import 'football_line_chart_item.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球数据控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据 足球页面0-组件拆分
    】】】
 *
 */
class FootballLineChart extends StatelessWidget {
  // 构造函数，使用const关键字优化性能
  // super.key: 传递给父类StatelessWidget的key，用于Widget树中的唯一标识
  // required this.controller: 必需的参数，传入MatchDataController实例
  const FootballLineChart({super.key, required this.controller});

  // 定义控制器属性，类型为MatchDataController
  // 该控制器负责管理比赛数据的状态和业务逻辑
  final MatchDataController controller;

  /**
   * 构建Widget树
   * 
   * 该方法根据数据状态构建不同的UI布局：
   * 1. 如果数据为空或索引越界，返回空组件
   * 2. 如果数据项<=3个，使用Row横向排列
   * 3. 如果数据项>3个，使用SingleChildScrollView支持横向滚动
   * 
   * 参数：
   * - context: 构建上下文，提供访问主题、媒体查询等信息的接口
   * 
   * 返回：
   * - Widget: 返回数据展示容器组件
   */
  @override
  Widget build(BuildContext context) {
    // 判断：如果第二组数据列表为空，返回空组件
    // totalSecondListData存储的是黄牌、红牌、角球等统计数据
    if (controller.state.totalSecondListData.isEmpty) {
      // 返回一个空的SizedBox，不占用任何空间
      return const SizedBox();
    }
    // 判断：如果当前选中的页面索引超出数据列表长度，返回空组件
    // 防止数组越界异常
    if (controller.state.totalSecondListData.length <=
        controller.state.currentTitlePageIndex) {
      // 返回一个空的SizedBox，不占用任何空间
      return const SizedBox();
    }

    // 获取当前选中页面索引对应的数据列表
    // currentTitlePageIndex表示当前选中的时间段（如：0=全场，1=90分钟，2=加时赛）
    final list =
        controller.state.totalSecondListData[controller.state.currentTitlePageIndex];

    // 返回数据展示容器
    return Container(
      // 设置容器宽度为屏幕宽度（1.sw表示屏幕宽度）
      width: 1.sw,
      // 设置上边距为12.w，用于与上方内容的间距
      margin: EdgeInsets.only(top: 12.w),
      // 设置水平内边距为48.w，用于内容与容器边界的间距
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      // 根据数据项数量选择不同的布局方式
      child: list.length <= 3
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: list
                  .map((e) => FootballLineChartItem(
                        item: e,
                        rowSpaceBetween: false,
                      ))
                  .toList(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: list
                    .map((e) => FootballLineChartItem(
                          item: e,
                          rowSpaceBetween: true,
                        ))
                    .toList(),
              ),
            ),
    );
  }

}
