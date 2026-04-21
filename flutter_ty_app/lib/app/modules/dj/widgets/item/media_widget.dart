import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞列表-媒体视频布局 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞列表-媒体视频布局
    -显示直播逻辑

    ```
    matchEntity.mvs > -1
    ```

    -显示视频逻辑

    ```
    matchEntity.mms > 1 && [1, 2, 7, 10, 110].contains(matchEntity.ms)
    ```

    】】】
 *
 */
class MediaWidget extends StatelessWidget {
  final MatchEntity matchEntity;
  const MediaWidget({super.key, required this.matchEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.w,
      child: Row(
        children: [
          // 正常的 优先级 ： lvs 直播   muUrl 视频  animationUrl 动画
          if (TYUserController.to.userInfo.value?.ommv == 1)
            matchEntity.mvs > -1
                ? ImageView(
                    DJController.to.DJState.sportFootballSvg,
                    width: 18.w,
                    height: 18.w,
                  ).marginOnly(right: 4.w)
                : ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    child: ImageView(
                      DJController.to.DJState.sportFootballSvg,
                      width: 18.w,
                      height: 18.w,
                    ).marginOnly(right: 4.w),
                  ),

          ///  muUrl  视频
          (matchEntity.mms > 1 && [1, 2, 7, 10, 110].contains(matchEntity.ms))
              ? ImageView(
                  DJController.to.DJState.sportVideoSvg,
                  width: 18.w,
                  height: 18.w,
                ).marginOnly(right: 4.w)
              : ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: ImageView(
                    DJController.to.DJState.sportVideoSvg,
                    width: 18.w,
                    height: 18.w,
                  ).marginOnly(right: 4.w),
                ),

          // ImageView(
          //   'assets/images/sport/ico_footerball.svg',
          //   width: 18.w,
          //   height: 18.w,
          //   svgColor:Colors.grey
          // ).marginOnly(right: 4.w),
          // ImageView(
          //   'assets/images/sport/ico_video.svg',
          //   width: 18.w,
          //   height: 18.w,
          //   svgColor: matchEntity.mms<=0?Colors.grey:null,
          // ).marginOnly(right: 4.w),

        ],
      ),
    );
  }
}
