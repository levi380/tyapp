import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


/**比分空间，左右布局*/
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 比分空间，左右布局 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 比分空间，左右布局

    】】】
 *
 */
class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key, required this.matchEntity, required this.name, required this.score});

  final String name;
  final String score;
  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: /* isIPad ? 80.h :*/ 32.h,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: /*isIPad ? 20.sp.scale : */ 12.sp.scale,
                        color: context.isDarkMode ? Colors.white.withValues(alpha:0.9) : DJController.to.DJState.djPrimaryTextColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          matchEntity.ms != 110 && !show_start_counting_down(matchEntity) && !show_counting_down(matchEntity)
              ? const SizedBox()
              : Text(
                  score,
                  style: TextStyle(
                    fontSize: /* isIPad ? 20.sp.scale :*/ 14.sp.scale,
                    color: context.isDarkMode ? Colors.white.withValues(alpha:0.9) : DJController.to.DJState.djPrimaryTextColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DIN Alternate',
                  ),
                )
        ],
      ),
    );
  }

  /// @description: 多少分钟后开赛显示
  /// @param {Object} item 赛事对象
  /// @return {String}
  bool show_start_counting_down(MatchEntity item) {
    var r = false;
// 滚球中不需要显示多少分钟后开赛
    if (item.ms == 1) {
      return r;
    }
    return r;
  }

//赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
  /// @param {Object} item 赛事对象
  /// @return {Boolean}
  bool show_counting_down(MatchEntity item) {
    return [1, 2, 10].contains(item.ms * 1);
  }
}
