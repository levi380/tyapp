// 导入数字扩展，提供数字相关的扩展方法（如.scale等）
import 'package:flutter_ty_app/app/extension/num_extension.dart';
// 导入登录相关的通用导入文件，包含常用的Flutter和GetX依赖
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
// 导入比赛统计控制器，用于管理比赛统计数据的业务逻辑和状态
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
// 导入比赛实体模型，包含比赛数据的定义
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
// 导入日期格式化工具类，用于格式化时间显示
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
// 导入比分格式化工具类，用于格式化比分显示
import 'package:flutter_ty_app/app/utils/format_score_util.dart';
// 导入主应用文件，包含全局配置和工具类（如isIPad等）


// 导入VR体育详情相关的导入文件，包含VR相关的依赖
import '../../../../../../vr/vr_sport_detail/import_head.dart';


/**
 * 正面交手工具类
 * 
 * 功能说明：
 * - 提供正面交手页面相关的工具方法
 * - 包含吐司消息显示、比赛阶段内容格式化等功能
 * 
 * 使用场景：
 * - 在比赛统计页面中显示正面交手信息
 * - 在阵容页面中显示比赛状态和时间
 */
/// 正面交手工具类
/// 提供正面交手页面相关的工具方法
class MatchStatisticUtils {
  /**
   * 弹出吐司消息
   * 
   * 功能说明：
   * - 在指定位置显示一个菜单样式的吐司消息
   * - 根据点击位置计算弹窗位置
   * - 支持自定义文本内容
   * 
   * 参数：
   * - controller: 比赛统计控制器，包含Toast相关的状态（如toastItemKey等）
   * - text: 要显示的文本内容，类型为String
   * 
   * 返回：
   * - Future: 返回Future，用于处理菜单选择结果
   */
  /// 弹出吐司消息
  /// 在指定位置显示一个菜单样式的吐司消息
  /// [controller] 比赛统计控制器，包含Toast相关的状态
  /// [text] 要显示的文本内容
  /// 返回Future，用于处理菜单选择结果
  static Future showToastMessage(
    MatchStatisticController controller,
    String text,
  ) {
    // 获取控制器中的状态对象
    final state = controller.state;
    // 计算对应点击位置 弹窗
    // 从toastItemKey获取对应的RenderBox对象，用于计算位置
    final RenderBox button =
        state.toastItemKey.currentContext!.findRenderObject() as RenderBox;
    // 计算按钮的全局位置（左上角坐标）
    var leftoffset = button.localToGlobal(Offset.zero);
    // 计算弹窗的顶部位置：按钮底部向下偏移6倍按钮高度
    var topoffset = button.localToGlobal(Offset(0, 6 * button.size.height));

    // 显示菜单样式的弹窗
    return showMenu(
      // 设置菜单约束：最小高度30，最大高度100，最小宽度70，最大宽度150
      constraints: const BoxConstraints(
          minHeight: 30, maxHeight: 100, minWidth: 70, maxWidth: 150),
      // 设置上下文，使用GetX的全局上下文
      context: Get.context!,
      // 设置菜单形状为圆角矩形，圆角半径为8
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // 设置菜单位置：使用RelativeRect.fromLTRB创建相对位置
      // left: leftoffset.dx（按钮左边缘）
      // top: topoffset.dy - 15.h - (25 * 1)（按钮底部向下偏移，再减去菜单项高度）
      // right: 1.sw（屏幕右边缘）
      // bottom: 0（屏幕底部）
      position: RelativeRect.fromLTRB(leftoffset.dx,
          topoffset.dy - 15.h - (25 * (1)), 1.sw, 0),
      // 菜单栏位置
      // 生成菜单项列表
      items: List.generate(
          // 生成1个菜单项
          1,
          // 为每个索引创建PopupMenuItem
          (index) => PopupMenuItem(
                // 设置菜单项高度为25.h.scale（考虑文本缩放）
                height: 25.h.scale,
                // 设置内边距：左侧8.h
                padding: EdgeInsets.only(left: 8.h),
                // 设置菜单项值为索引
                value: index,
                // 菜单项子组件：使用Row横向排列
                child: Row(
                  // 设置主轴大小为最小（不占据多余空间）
                  mainAxisSize: MainAxisSize.min,
                  // Row的子组件列表
                  children: [
                    // 文本容器
                    Container(
                      // 设置对齐方式为左对齐
                      alignment: Alignment.centerLeft,
                      // 容器子组件：显示文本
                      child: Text(
                        // 设置文本对齐方式为左对齐
                        textAlign: TextAlign.start,
                        // 显示传入的文本内容
                        text,
                        // 设置文本样式
                        style: TextStyle(
                          // 字体大小为8.sp.scale（考虑文本缩放）
                          fontSize: 8.sp.scale,
                          // 字体粗细为500（中等粗细）
                          fontWeight: FontWeight.w500,
                          // 文字颜色为灰色（0xffAFB3C8）
                          color: const Color(0xffAFB3C8),
                        ),
                      ),
                    ),
                    // 添加水平间距：5.w
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
              )),
      // 设置菜单阴影高度为5.0
      elevation: 5.0,
    ).then((value) async {
      // 处理选项菜单返回的值（当前未使用）
      // 处理选项菜单返回的值
    });
  }

  /**
   * 赛事阶段显示内容 下部分(比赛时间or开赛时间)
   * 
   * 功能说明：
   * - 根据比赛状态返回相应的显示文本
   * - 支持显示开赛时间、倒计时、比分等不同内容
   * - 根据比赛状态（ms）判断显示内容
   * 
   * 参数：
   * - match: 比赛实体，包含比赛状态信息（如ms、mgt等）
   * - startTime: 是否显示开赛时间，类型为bool?，默认false
   * - longTime: 长时间字符串，用于倒计时显示，类型为String?，默认为空字符串
   * 
   * 返回：
   * - String: 返回格式化后的显示文本
   */
  /// 赛事阶段显示内容 下部分(比赛时间or开赛时间)
  /// 根据比赛状态返回相应的显示文本
  /// [match] 比赛实体，包含比赛状态信息
  /// [startTime] 是否显示开赛时间，默认false
  /// [longTime] 长时间字符串，用于倒计时显示
  /// 返回格式化后的显示文本
  static String matchStageContentBottom(
    MatchEntity? match, {
    bool? startTime = false,
    String? longTime = "",
  }) {
    // 获取比赛状态码，如果为null则默认为0（未开赛）
    int ms = match?.ms ?? 0;
    // 判断：如果比赛状态为0（赛事未开赛）
    // 赛事未开赛
    if (ms == 0) {
      // 判断：如果startTime为true（需要显示开赛时间）
      // 即将开赛的赛事不显示日期
      if (startTime == true) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        // 使用本地化键值获取"距离开赛"的文本，并替换占位符{0}为longTime
        return LocaleKeys.list_after_time_start.tr
            .replaceAll("{0}", longTime ?? "");
      } 
      // 如果startTime为false（不需要显示开赛时间）
      else {
        // 格式化显示HH:MM（小时:分钟）
        // 使用FormatDate.formatHHMM方法格式化开赛时间（mgt字段）
        return FormatDate.formatHHMM(int.tryParse(match?.mgt ?? "0") ?? 0);
      }
    }
    // 判断：如果比赛状态为110（赛前切滚球）
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      // 使用本地化键值获取"即将开赛"的文本（ms_110对应的文本）
      return "ms_$ms".tr;
    } 
    // 判断：如果比赛状态为1、2、3、4（比赛进行中或已结束）
    else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      // 使用FormatScore.formatTotalScore方法格式化主队和客队的总比分
      // 0表示主队，1表示客队
      return "${FormatScore.formatTotalScore(match, 0)} - ${FormatScore.formatTotalScore(match, 1)}";
    }
    // 其他情况返回空字符串
    return "";
  }
}
