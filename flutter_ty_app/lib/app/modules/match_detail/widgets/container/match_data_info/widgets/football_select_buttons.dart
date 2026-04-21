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
class FootballSelectButtons extends StatelessWidget {
  // 构造函数，使用const关键字优化性能
  // super.key: 传递给父类StatelessWidget的key，用于Widget树中的唯一标识
  // required this.controller: 必需的参数，传入MatchDataController实例
  const FootballSelectButtons({super.key, required this.controller});

  // 定义控制器属性，类型为MatchDataController
  // 该控制器负责管理比赛数据的状态和业务逻辑
  final MatchDataController controller;

  /**
   * 构建Widget树
   * 
   * 该方法根据数据状态构建选择按钮组件：
   * 1. 创建外层容器，设置背景色和内边距
   * 2. 创建内层容器，设置圆角背景
   * 3. 遍历事件列表，为每个事件创建可点击的按钮
   * 4. 根据选中状态显示不同的样式
   * 
   * 参数：
   * - context: 构建上下文，提供访问主题、媒体查询等信息的接口
   * 
   * 返回：
   * - Widget: 返回包含所有选择按钮的容器组件
   */
  @override
  Widget build(BuildContext context) {
    // 获取控制器中的状态对象，包含所有数据状态
    MatchDataState state = controller.state;
    // 返回外层容器，设置背景色和内边距
    return Container(
      // 设置背景颜色，使用主题中的选择标签面板背景色
      // 该颜色会根据当前主题（日间/夜间）自动适配
      color: Get.theme.selectTabPanelBgColor,
      // 设置内边距：水平方向12.w，垂直方向12.w
      // 用于内容与容器边界的间距
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
      // 子组件：内层容器，包含所有选择按钮
      child: Container(
        // 设置内边距：垂直方向2.w，用于按钮与容器边界的间距
        padding: EdgeInsets.symmetric(vertical: 2.w),
        // 设置容器装饰样式
        decoration: BoxDecoration(
            // 设置背景颜色，使用主题中的分析文本标签背景色
            // 该颜色会根据当前主题自动适配
            color: Get.theme.analsTextTabBgColor,
            // 设置圆角，使用BorderRadius.all创建四个角都是8.w的圆角
            // 使容器呈现圆角矩形的视觉效果
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        // 子组件：使用Row横向排列所有选择按钮
        child: Row(
          // 使用map方法遍历state.generalEventList列表
          // generalEventList包含所有可用的事件类型（如：["全部事件", "关键事件"]）
          children: state.generalEventList.map((e) {
            // 对每个事件类型e，创建一个Expanded组件
            // Expanded确保每个按钮平均分配可用空间
            return Expanded(
                // 使用InkWell提供点击水波纹效果
                child: InkWell(
              // 点击事件处理：当用户点击按钮时执行
              onTap: () {
                // 调用控制器的setGeneralEventList方法
                // 参数为当前事件类型在列表中的索引位置
                // 该方法会更新当前选中的事件类型索引，触发UI刷新
                controller.setGeneralEventList(state.generalEventList.indexOf(e));
              },
              // InkWell的子组件：包含按钮的视觉内容
              child: Container(
                // 设置内容对齐方式为居中
                alignment: Alignment.center,
                // 设置按钮高度为25.w（屏幕宽度比例）
                height: 25.w,
                // 设置内边距：水平2.w，垂直2.w
                // 用于按钮文字与容器边界的间距
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                // 根据是否选中设置不同的装饰样式
                decoration: 
                    // 判断条件：当前按钮的索引是否等于控制器中记录的选中索引
                    state.currentGeneralEventIndex ==
                        state.generalEventList.indexOf(e)
                    // 如果选中：显示带背景色的圆角容器
                    ? BoxDecoration(
                        // 设置圆角，与父容器保持一致
                        borderRadius: BorderRadius.circular(8.w),
                        // 设置背景颜色为标签面板背景色，用于突出显示选中状态
                        color: Get.theme.tabPanelBackgroundColor,
                      )
                    // 如果未选中：不设置装饰（返回null，使用默认样式）
                    : null,
                // 按钮文字内容
                child: Text(
                  // 显示事件类型名称（如："全部事件"、"关键事件"等）
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
            ));
          }).toList(), // 将map结果转换为List，作为Row的children
        ),
      ),
    );
  }
}
