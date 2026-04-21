import '../../../../generated/locales.g.dart';
import '../../../services/models/res/match_entity.dart';
import '../../login/login_head_import.dart';
import '../../match_detail/controllers/match_tools_methods.dart';
import '../pip_video_controller.dart';

class PipHeader extends StatelessWidget {
  const PipHeader({super.key, required this.controller, this.onClose});

  final PipVideoController controller;
  final VoidCallback? onClose;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.w,
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildVsScore(controller),
          if (onClose != null) _buildCloseButton(),
        ],
      ),
    );
  }

  _buildVsScore(PipVideoController controller) {
    MatchEntity? match = controller.state.match;
    if (match == null) return Container();
    // 视频直播、动画直播点击屏幕 显示隐藏
    return Positioned.fill(
      child: AnimatedOpacity(
        /// 顶部按钮控制
        opacity: controller.state.videoTopShow ? 1.0 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, 1.00),
              end: const Alignment(0, -1),
              colors: [
                Colors.black.withValues(alpha: 0),
                Colors.black.withValues(alpha: 0.8)
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(
                  match.mhn,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(right: 16),
              ),
              Text(
                eSportsScoring(match)
                    ? LocaleKeys.mmp_eports_scoring.tr
                    : match.ms != 110
                        ? getMsc(match.msc, vFlag: "-")
                        : "vs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'PingFang HK',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  match.man,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(left: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      left: 8,
      child: InkWell(
        onTap: onClose,
        child: ImageView(
          "assets/images/common/pip-live-close.png",
          width: 32.w,
        ),
      ),
    );
  }
}
