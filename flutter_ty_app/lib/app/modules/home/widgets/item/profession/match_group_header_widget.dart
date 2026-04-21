import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';

import '../../../../../widgets/image_view.dart';
import '../../../controllers/collection_controller.dart';
import '../logo_placeholder_widget.dart';

///列表联赛标题
class MatchGroupHeaderWidget extends StatelessWidget {
  const MatchGroupHeaderWidget({super.key, required this.combineInfo});

  final CombineInfo combineInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ///点击折叠
        _toggleFoldState();
      },
      child: Container(
        height: 24.w,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 2.w,
              height: 12.w,
              decoration: BoxDecoration(
                // 右上 右下圆角
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2.w),
                  bottomRight: Radius.circular(2.w),
                ),
                color: const Color(0xff179CFF),
              ),
            ),
            if (!TyHomeController.to.homeState.menu.isMatchBet)
              Obx(() {
                if (ConfigController.to.accessConfig.value.collectSwitch) {
                  return GetBuilder<CollectionController>(builder: (logic) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logic.addOrCancelTournament(
                            combineInfo.tid, combineInfo.data!);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: ImageView(
                          (RouteCheckUtil.checkIsLogin() &&
                                  (logic.isCollectionTournament(
                                      combineInfo.data!)))
                              ? 'assets/images/home/ico_fav_nor_sel.svg'
                              : context.isDarkMode
                                  ? 'assets/images/home/ico_fav_nor.png'
                                  : 'assets/images/home/ico_fav_nor_light.png',
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
            SizedBox(
              width: 4.w,
            ),
            ///  4325需求--------
            LogoPlaceholderWidget(
                imageUrl: combineInfo.data?.lurl ?? "",
                width: 16.w,
                height: 16.w,
                base64Placeholder: 'placeholder_team.base64',
                cdn: true,
            ),
            // ImageView(
            //   "assets/images/home/list/placeholder_team.png",
            //     // combineInfo.data?.lurl ?? "assets/images/home/list/placeholder_team.png",
            //   width: 16.w,
            //   height: 16.w,
            // ),
            SizedBox(
              width: 4.w,
            ),
            ///---------------4325需求
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      combineInfo.tn,
                      style: TextStyle(
                        fontSize: 12.sp.scale,
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha:0.8999999761581421)
                            : const Color(0xff303442),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  4.horizontalSpace,
                ],
              ),
            ),
            if (combineInfo.data!.isDZ)
              ImageView(
                'assets/image/dianzi.svg',
                width: 14.w,
                height: 14.w,
                cdn: true,
              ).marginOnly(right: 12.w),
            PinWidget(
              matchEntity: combineInfo.data!,
              tid: combineInfo.tid,
              isLeague: true,
              isDjInCommon: MatchUtil.isEsport(combineInfo.data!),
            ),
            ///列表折叠显示数量
            // Container(
            //     margin: EdgeInsets.only(left: 6.w),
            //   child:   FoldMatchManager.isFoldByTid(
            //       combineInfo.tid, combineInfo.sectionGroupEnum!)
            //       ? Text(
            //     textAlign: TextAlign.center,
            //     combineInfo.matchCount.toString(),
            //     style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       fontFamily: 'DIN Alternate',
            //       color: context.isDarkMode
            //           ? Colors.white.withValues(alpha:0.8999999761581421)
            //           : const Color(0xffAFB3C8),
            //       fontSize: 12.sp.scale,
            //     ),
            //   )
            //       : SizedBox(),
            // ),
            /// 展开 和 收起时都显示数量
            Container(
              margin: EdgeInsets.only(left: 6.w),
              child:   Text(
                textAlign: TextAlign.center,
                combineInfo.matchCount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DIN Alternate',
                  color: Get.isDarkMode
                      ? Colors.white.withValues(alpha:0.8999999761581421)
                      : const Color(0xffAFB3C8),
                  fontSize: 12.sp.scale,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              alignment: Alignment.center,
              child: ImageView(
                !FoldMatchManager.isFoldByTid(
                        combineInfo.tid, combineInfo.sectionGroupEnum!)
                    ? context.isDarkMode
                        ? 'assets/images/league/item_expand_darkmode.png'
                        : 'assets/images/league/item_expand.png'
                    : context.isDarkMode
                        ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                        : 'assets/images/league/ico_arrowright_nor.png',
                width: 12.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 折叠状态切换的逻辑抽离到单独的方法
  void _toggleFoldState() {
    bool isFold = FoldMatchManager.isFoldByTid(
        combineInfo.tid, combineInfo.sectionGroupEnum!);
    FoldMatchManager.setFoldByTid(
        combineInfo.tid, combineInfo.sectionGroupEnum!, !isFold);

    // /展开/收起赛事列表埋点
    Analytics.track(AnalyticsEvent.btn_expand_collapse, pagePath: '', clickTarget: (AnalyticsEvent.btn_expand_collapse).toString());
    TyHomeController.to.update();
  }
}
