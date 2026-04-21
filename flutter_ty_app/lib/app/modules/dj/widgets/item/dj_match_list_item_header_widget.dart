import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';


import '../../../../utils/change_skin_tone_color_util.dart';

import '../../../../widgets/image_view.dart';
import '../../../home/widgets/item/logo_placeholder_widget.dart';

///电竞-专业版，新手版 联赛标题，联赛数量，展开/收起控件
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞-专业版，新手版 联赛标题，联赛数量，展开/收起控件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞-专业版，新手版 联赛标题，联赛数量，展开/收起控件
    # `联赛级收藏`

    ```
    InkWell(
    onTap: () {
    DJController.to.collect(matchEntity);
    },
    child: ImageView(
    matchEntity.mf
    ? 'assets/images/home/ico_fav_nor_sel.svg'
    : context.isDarkMode
    ? context.isDarkMode
    ? 'assets/images/home/ico_fav_nor.png'
    : 'assets/images/home/ico_fav_nor_light.png'
    : 'assets/images/home/ico_fav_nor_light.png',
    width: 16.w,
    height: 16.w,
    ),
    ),
    ```

    # `联赛级置顶`

    ```
    PinWidget(
    isLeague: true,
    matchEntity: matchEntity,
    tid: matchEntity.tid,
    ),
    ```

    # `收起/展开通知上层控件`

    ```
    onExpandChange(!matchEntity.isExpand);
    ```

    】】】
 *
 */
class DJMatchListItemHeaderWidget extends StatelessWidget {
  const DJMatchListItemHeaderWidget({
    super.key,
    required this.matchEntity,
    required this.onExpandChange,
    // required this.onCollectionChange,
    this.hasCollection,
    this.count = 0,
    this.isPinned = false,
  });

  final MatchEntity matchEntity;
  final ValueChanged<bool> onExpandChange;

  // final ValueChanged<bool> onCollectionChange;
  final bool? hasCollection;
  final int count;

  /// 置顶状态
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///收起/展开通知上层控件
        onExpandChange(!matchEntity.isExpand);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5.w, right: 5.w),
        decoration: matchEntity.isExpand
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: !Get.isDarkMode
                        ? Color(0xFFE4E6ED)
                        : Colors.white.withValues(alpha:0.08),
                  ),
                ),
              )
            : null,
        child: Container(
          height: /*isIPad ? 50.h : */ 24.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(colorStyle_1: Color(0xFF2B2D33) ,colorStyle_2: Color(0xFF23292D),colorStyle_3: Color(0xFF26242A)) : Color(0xFFF8F9FA),

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
              bottomLeft: Radius.circular(matchEntity.isExpand ?  0: 8.r),
              bottomRight: Radius.circular(matchEntity.isExpand ?  0: 8.r),
            ),
            border: Border(
              top: isPinned
                  ? BorderSide.none
                  : BorderSide(
                      width: 1,
                      color: !Get.isDarkMode
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.08),
                    ),
              left: BorderSide(
                width: 1,
                color: !Get.isDarkMode
                    ? Colors.white
                    : Colors.white.withValues(alpha:0.08),
              ),
              right: BorderSide(
                width: 1,
                color: !Get.isDarkMode
                    ? Colors.white
                    : Colors.white.withValues(alpha:0.08),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 2.w,
                height: 12.h,
                decoration: BoxDecoration(
                  // 右上 右下圆角
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(2.r),
                    bottomRight: Radius.circular(2.r),
                  ),
                  color: const Color(0xff179CFF),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Obx(() {
                if (ConfigController.to.accessConfig.value.collectSwitch) {
                  return GetBuilder<CollectionController>(builder: (logic) {
                    return InkWell(
                      onTap: () {
                        // 电竞联赛收藏
                        logic.addOrCancelTournamentDJ(matchEntity.tid);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: ImageView(
                          (RouteCheckUtil.checkIsLogin() &&
                              (logic.isCollectionTournament(matchEntity)))
                              ? DJController.to.DJState.favSelectedSvg
                              : context.isDarkMode
                              ? DJController.to.DJState.favNormalDark
                              : DJController.to.DJState.favNormalLight,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                    );
                  });
                } else {
                  return 0.verticalSpaceFromWidth;
                }
              }),

              ///  4325需求--------
              SizedBox(
                width: 4.w,
              ),

              LogoPlaceholderWidget(
                  imageUrl: matchEntity.lurl,
                  width: 16.w,
                  height: 16.w,
                  base64Placeholder: 'placeholder_team.base64',
                dj: true,
                cdn: true,
              ),

              SizedBox(
                width: 4.w,
              ),
              ///------------------  4325需求

              Expanded(
                child: Text(
                  matchEntity.tn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: /*isIPad ? 20.sp.scale : */ 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.9)
                        : const Color(0xff303442),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PinWidget(
                isLeague: true,
                matchEntity: matchEntity,
                tid: matchEntity.tid,
                isDjInCommon: true,
              ),
              ///收起时显示数量，展开的时候不显示
              Text(
                count == 0  ? "" : "$count",
                style: TextStyle(
                  fontSize: 12.sp.scale,
                  color:
                      // Color(0xff303442),
                      context.isDarkMode
                          ? Colors.white.withValues(alpha:0.9)
                          : const Color(0xffC9C9C9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  ///收起/展开通知上层控件
                  onExpandChange(!matchEntity.isExpand);
                },
                child: Container(
                  width: 24.h,
                  height: 24.h,
                  alignment: Alignment.center,
                  child: ImageView(
                    matchEntity.isExpand
                        ? (context.isDarkMode
                            ? DJController.to.DJState.leagueItemExpandDark
                            : DJController.to.DJState.leagueItemExpandLight)
                        : (context.isDarkMode
                            ? DJController.to.DJState.leagueArrowRightDark
                            : DJController.to.DJState.leagueArrowRightLight),
                    width: 12.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
