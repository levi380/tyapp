import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/sport.dart';
import '../../login/login_head_import.dart';
import '../../match_detail/extension/theme_extension.dart';
import '../pip_video_controller.dart';

class VideoSwitchButtons extends StatelessWidget {
  const VideoSwitchButtons({super.key, required this.controller});

  final PipVideoController controller;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = controller.state.match;

    if (match == null) {
      return Container();
    }

    /// 动画 + 视频按钮 显示逻辑
    /// <!-- mvs状态：-1：没有配置源 | 0 ：已配置，但是不可用 | 1：已配置，可用，播放中 | 2：已配置，可用，播放中 -->
    if (match.mvs > -1 ||
        (match.mms > 1 &&
            [
              SportData.sportMs_1,
              SportData.sportMs_2,
              SportData.sportMs_7,
              SportData.sportMs_10,
              SportData.sportMs_110
            ].contains(match.ms))) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4.w,
        children: [
          if (match.mms > 1 || match.pmms == 1)
            // 视频直播
            InkWell(
              onTap: () => controller.loadVideo(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageView(
                      'assets/images/detail/live-app.svg',
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      LocaleKeys.match_info_video_live.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: Get.theme.fontSize_12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (match.mvs > -1 && TYUserController.to.userInfo.value?.ommv != 0)
            InkWell(
              onTap: () => controller.loadAnimation(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageView(
                      'assets/images/detail/animate-app2.svg',
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      LocaleKeys.match_info_animation_live.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: Get.theme.fontSize_12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      );
    } else {
      return Container();
    }
  }
}
