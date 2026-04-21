import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/data/match_data_tab_manager.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';

import '../../../../../../../main.dart';
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
class FootballCategoryTabs extends StatelessWidget {
  // 构造函数，使用const关键字优化性能
  // super.key: 传递给父类StatelessWidget的key，用于Widget树中的唯一标识
  // required this.controller: 必需的参数，传入MatchDataController实例用于控制数据状态
  const FootballCategoryTabs({super.key, required this.controller});

  // 定义控制器属性，类型为MatchDataController
  // 该控制器负责管理比赛数据的状态和业务逻辑
  final MatchDataController controller;

  /// 构建足球数据分类标签页组件
  /// 
  /// 该方法构建一个横向滚动的标签页组件，用于切换不同的数据分类：
  /// 1. 创建圆角背景容器，包含所有分类标签
  /// 2. 每个标签可点击，点击后切换到对应的分类
  /// 3. 当前选中的标签显示不同的背景色和样式
  /// 4. 标签文本支持溢出省略
  /// 
  /// 参数：
  /// - context: 构建上下文，提供访问主题、媒体查询等信息的接口
  /// 
  /// 返回：
  /// - Widget: 返回包含所有分类标签的容器组件
  @override
  Widget build(BuildContext context) {
    // 返回一个Container容器，作为整个标签页组件的根节点
    return Container(
      // 设置外边距：垂直方向6.w（屏幕宽度比例），水平方向100.w
      // 垂直边距用于与上下内容的间距，水平边距用于居中显示
      margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 100.w),
      // 设置内边距：垂直方向2.w，用于标签内容与容器边界的间距
      padding: EdgeInsets.symmetric(vertical: 2.w),
      // 设置容器装饰样式
      decoration: BoxDecoration(
        // 设置背景颜色，使用主题中的分析文本标签背景色
        // 该颜色会根据当前主题（日间/夜间）自动适配
        color: Get.theme.analsTextTabBgColor,
        // 设置圆角，使用BorderRadius.all创建四个角都是8.w的圆角
        // 使容器呈现圆角矩形的视觉效果
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      // 子组件：使用Row横向排列所有标签
      child: Row(
        // 使用map方法遍历controller.state.currentTitlePage列表
        // currentTitlePage包含所有可用的分类标签名称（如：["全场", "90分钟", "加时赛"]）
        children: controller.state.currentTitlePage.map((e) {
          // 对每个标签名称e，创建一个Expanded组件
          // Expanded确保每个标签平均分配可用空间
          return Expanded(
            // 使用InkWell提供点击水波纹效果
            child: InkWell(
              // 点击事件处理：当用户点击标签时执行
              onTap: () {
                // 调用控制器的setCurrentTitlePage方法
                // 参数为当前标签在列表中的索引位置
                // 该方法会更新当前选中的分类索引，触发UI刷新
                controller
                    .setCurrentTitlePage(controller.state.currentTitlePage.indexOf(e));
              },
              // InkWell的子组件：包含标签的视觉内容
              child: Container(
                // 设置内容对齐方式为居中
                alignment: Alignment.center,
                // 设置标签高度为25.w（屏幕宽度比例）
                height: 25.w,
                // 设置内边距：水平2.w，垂直2.w
                // 用于标签文字与容器边界的间距
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                // 根据是否选中设置不同的装饰样式
                decoration:
                    // 判断条件：当前标签的索引是否等于控制器中记录的选中索引
                    controller.state.currentTitlePageIndex ==
                            controller.state.currentTitlePage.indexOf(e)
                        // 如果选中：显示带背景色的圆角容器
                        ? BoxDecoration(
                            // 设置圆角，与父容器保持一致
                            borderRadius: BorderRadius.circular(8.w),
                            // 设置背景颜色为标签面板背景色，用于突出显示选中状态
                            color: Get.theme.tabPanelBackgroundColor,
                          )
                        // 如果未选中：不设置装饰（返回null，使用默认样式）
                        : null,
                // 标签文字内容
                child: Text(
                  // 显示标签名称（如："全场"、"90分钟"等）
                  e,
                  // 设置文字溢出处理方式：使用省略号（...）表示
                  overflow: TextOverflow.ellipsis,
                  // 设置最大行数为1行，防止文字换行
                  maxLines: 1,
                  // 设置文字样式
                  style: TextStyle(
                    // 字体大小：iPad设备使用14.sp，其他设备使用10.sp
                    // sp是屏幕像素比例单位，确保在不同设备上显示一致
                    fontSize: isIPad
                        ? MatchDataState.categoryTabFontSizeIPad.sp
                        : MatchDataState.categoryTabFontSize.sp,
                    // 字体粗细：400为正常粗细
                    fontWeight: MatchDataState.categoryTabFontWeight,
                    // 文字颜色：使用主题中的分析第二标签面板选中字体颜色
                    // 该颜色会根据当前主题自动适配
                    color: Get.theme.analyzeSecondTabPanelSelectedFontColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(), // 将map结果转换为List，作为Row的children
      ),
    );
  }
}
