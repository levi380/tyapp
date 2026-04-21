import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/match_circle_progress_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

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
class FootballCircleProgressRow extends StatelessWidget {
  // 构造函数，使用const关键字优化性能
  // super.key: 传递给父类StatelessWidget的key，用于Widget树中的唯一标识
  // required this.controller: 必需的参数，传入MatchDataController实例
  // required this.awayColor: 必需的参数，传入客队颜色（用于进度条显示）
  // required this.manColor: 必需的参数，传入主队颜色（用于进度条显示）
  const FootballCircleProgressRow({
    super.key,
    required this.controller,
    required this.awayColor,
    required this.manColor,
  });

  // 定义控制器属性，类型为MatchDataController
  // 该控制器负责管理比赛数据的状态和业务逻辑
  final MatchDataController controller;
  // 定义客队颜色属性，类型为Color
  // 用于进度条的颜色显示，通常为橙色或黄色系
  final Color awayColor;
  // 定义主队颜色属性，类型为Color
  // 用于进度条的颜色显示，通常为红色系
  final Color manColor;

  /**
   * 构建Widget树
   * 
   * 该方法根据数据状态构建圆形进度条行：
   * 1. 检查数据是否为空，为空则返回空组件
   * 2. 遍历数据列表，为每个数据项创建圆形进度条
   * 3. 根据数据值计算进度条比例和背景颜色
   * 
   * 参数：
   * - context: 构建上下文，提供访问主题、媒体查询等信息的接口
   * 
   * 返回：
   * - Widget: 返回包含所有圆形进度条的Row组件
   */
  @override
  Widget build(BuildContext context) {
    // 获取控制器中的状态对象，包含所有数据状态
    MatchDataState state = controller.state;
    // 判断：如果环形数据列表为空，返回空组件
    // ringData存储的是需要显示为圆形进度条的数据（如：控球率、进攻次数等）
    if (state.ringData.isEmpty) return const SizedBox();

    // 返回一个Row组件，横向排列所有圆形进度条
    return Row(
      // 设置主轴对齐方式为spaceAround（均匀分布，两端留空）
      // 使进度条在水平方向上均匀分布
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // 设置主轴尺寸为最大（占满可用空间）
      mainAxisSize: MainAxisSize.max,
      // 使用map方法遍历ringData列表，为每个数据项创建圆形进度条
      children: state.ringData.map((e) {
        // 初始化进度值为0（0.0到1.0之间，表示进度条的填充比例）
        double progress = 0;
        // 初始化背景颜色列表，包含两个颜色（用于渐变效果）
        // 默认使用灰色作为背景色
        List<Color> backgroundColor = [
          MatchDataState.progressBackgroundColor,
          MatchDataState.progressBackgroundColor
        ];
        // 判断：如果主队和客队数值都为0（无数据）
        if (e.home == 0 && e.away == 0) {
          // 设置进度值为0（不显示进度）
          progress = 0;
          // 设置背景颜色为灰色（表示无数据状态）
          backgroundColor = [
            MatchDataState.progressBackgroundColor,
            MatchDataState.progressBackgroundColor
          ];
        } 
        // 判断：如果主队有数据但客队为0（主队占优）
        else if ((e.home > 0) && (e.away == 0)) {
          // 设置进度值为0（不显示进度条，因为客队为0无法计算比例）
          progress = 0;
          // 设置背景颜色为蓝色系渐变（主队颜色）
          backgroundColor = [
            MatchDataState.progressManGradientColor1,
            MatchDataState.progressManGradientColor2
          ];
        } 
        // 判断：如果主队为0但客队有数据（客队占优）
        else if ((e.home == 0) && (e.away > 0)) {
          // 设置进度值为0（不显示进度条，因为主队为0无法计算比例）
          progress = 0;
          // 设置背景颜色为橙色系渐变（客队颜色）
          backgroundColor = [
            MatchDataState.progressAwayGradientColor1,
            MatchDataState.progressAwayGradientColor2
          ];
        } 
        // 如果主队和客队都有数据，计算进度条比例
        else {
          // 根据数据类型计算进度值
          // 判断：如果数据类型为"S104"（可能是控球率等需要反向显示的数据）
          progress = ["S104"].contains(e.score_type)
              // 反向计算：1减去比例除以100（例如：控球率30%显示为70%的进度）
              ? (1 - e.proportion.toDouble() / 100)
              // 正向计算：比例除以100（例如：控球率70%显示为70%的进度）
              : (e.proportion.toDouble() / 100);
        }
        // 返回MatchCircleProgressView组件，显示圆形进度条
        return MatchCircleProgressView(
          // 传入数据实体e，包含所有数据信息
          e,
          // 传入计算得到的进度值（0.0到1.0之间）
          progress: progress,
          // 传入主队数值字符串（转换为整数后格式化为字符串）
          leftString: "${e.home.toInt()}",
          // 传入客队数值字符串（转换为整数后格式化为字符串）
          rightString: "${e.away.toInt()}",
          // 设置进度条宽度：iPad设备使用85.w，其他设备使用55.w
          // w是屏幕宽度比例单位，确保在不同设备上显示一致
          width: isIPad ? 85.w : 55.w,
          // 设置进度条高度：iPad设备使用85.w，其他设备使用55.w
          // 保持正方形，与宽度一致
          height: isIPad ? 85.w : 55.w,
          // 传入背景颜色列表（用于渐变效果）
          backgroundColor: backgroundColor,
          // 传入进度条颜色（使用客队颜色）
          progressColor: awayColor,
          // 传入图标路径
          // 根据数据项在列表中的索引+1，拼接对应的图标文件名
          // 例如：第1项使用icon_bottom_anayze_icon1.png，第2项使用icon_bottom_anayze_icon2.png
          imgPath:
              "assets/images/bets/icon_bottom_anayze_icon${state.ringData.indexOf(e) + 1}.png",
          // 传入中心内容文本（使用本地化键值）
          // LocaleKeys.match_result_dangerous_offense.tr表示"危险进攻"的多语言文本
          centerContent: LocaleKeys.match_result_dangerous_offense.tr,
        );
      }).toList(), // 将map结果转换为List，作为Row的children
    );
  }
}
