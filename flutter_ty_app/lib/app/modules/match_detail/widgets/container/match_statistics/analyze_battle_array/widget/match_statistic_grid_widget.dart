import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/custom_position_toast.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/widget/analyze_statistic_circle_progress_view.dart';




/// 正面交手网格组件
/// 用于显示正面交手页面的统计网格，包括多个圆形进度视图
class MatchStatisticGridWidget {
  /// 构建正面交手-比赛网格
  /// 显示多个统计数据的圆形进度视图，支持点击显示详情
  /// [controller] 比赛统计控制器，包含网格数据
  /// [context] 构建上下文，用于显示Toast
  /// 返回包含网格视图的容器
  static Widget build({
    required MatchStatisticController controller,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 16.w),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 178 / 84,
          mainAxisSpacing: 4.w,
          crossAxisSpacing: 4.w,
        ),
        itemCount: controller.state.gridColorBeans.length,
        itemBuilder: (context, index) {
          return AnalyzeStatisticCircleProgressView(
              index, controller.state.gridColorBeans[index],
              progress: 0.5,
              width: 70.w,
              height: 70.w,
              progressWidth: 10, 
              analyzeStatisticCircleProgressViewFunction:
                  (String content, TapDownDetails details) {
            // 计算Toast显示位置
            final globalPosition = details.globalPosition;
            double left = index % 2 == 0 ? -0.08.sw : -0.55.sw;
            // 显示自定义位置的Toast
            CustomPositionToast.showCustom(
              context: context,
              message: content,
              isLeft: index % 2 == 0,
              position: Offset(
                  globalPosition.dx + left, globalPosition.dy + 10.w), // 指定具体坐标
            );
          });
        },
      ),
    );
  }
}

