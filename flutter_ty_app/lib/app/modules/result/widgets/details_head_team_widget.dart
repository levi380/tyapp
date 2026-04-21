import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../main.dart';
import '../../../widgets/image_view.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 赛果详情头部  组件 DetailsHeadTeamWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 赛果详情头部  组件 DetailsHeadTeamWidget
    - DetailsHeadTeamWidget
    ```
    DetailsHeadTeamWidget(detailData: detailData, isHomeTeam: true)
    ```
    】】】
 *
 */

class DetailsHeadTeamWidget extends StatelessWidget {
  const DetailsHeadTeamWidget({
    super.key,
    required this.detailData,
    required this.isHomeTeam,
  });

  final MatchEntity? detailData;
  final bool? isHomeTeam;

  @override
  Widget build(BuildContext context) {
    var normalImage = isHomeTeam == true ? 'assets/images/home/home_team_logo.svg' : 'assets/images/detail/default_team_away.svg';
    var errorImage = isHomeTeam == true ? 'assets/images/detail/default_team_home.svg' : 'assets/images/detail/default_team_away.svg';
    var teamList = isHomeTeam == true ? detailData?.mhlu : detailData?.malu;
    var teamName = isHomeTeam == true ? detailData?.mhn : detailData?.man;
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 队徽 type 0表示主队 mhlu主队的url
          // 双打情况
          // (detailData?.mhn ?? "").contains('/') && (detailData?.man ?? "").contains('/')
          detailData?.malu.length > 1
              ? SizedBox(
            width: isIPad ? 114.w : 74.w,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: isIPad ? 84.w : 44.w,
                    height: isIPad ? 84.w : 44.w,
                    alignment: Alignment.center,
                    child: ImageView(
                      ObjectUtil.isNotEmpty(
                          (teamList as List).safeFirst)
                          ? (teamList).safeFirst
                          : normalImage,
                      width: isIPad ? 76.36.w : 40.w,
                      height: isIPad ? 76.36.w : 40.w,
                      cdn: true,
                      errorWidget: ImageView(
                        errorImage,
                        width: isIPad ? 76.36.w : 40.w,
                        height: isIPad ? 76.36.w : 40.w,
                      ),
                      // errorWidget:
                    ),
                  ),
                ),
                Positioned(
                  left: 30.w,
                  child: Container(
                    width: isIPad ? 84.w : 44.w,
                    height: isIPad ? 84.w : 44.w,
                    alignment: Alignment.center,
                    child: ImageView(
                      ObjectUtil.isNotEmpty(
                          (teamList).safe(1))
                          ? (teamList).safe(1)
                          : normalImage,
                      width: isIPad ? 76.36.w : 40.w,
                      height: isIPad ? 76.36.w : 40.w,
                      cdn: true,
                      errorWidget: ImageView(
                        errorImage,
                        width: isIPad ? 76.36.w : 40.w,
                        height: isIPad ? 76.36.w : 40.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
              : // 单打
          Container(
            width: isIPad ? 84.w : 44.w,
            height: isIPad ? 84.w : 44.w,
            alignment: Alignment.center,
            child:
            // controller.detailState.isDJDetail ?
            // ImageView(
            //   ObjectUtil.isNotEmpty(
            //       (match.mhlu as List).safeFirst)
            //       ? (match.mhlu as List).safeFirst
            //       : 'assets/images/home/home_team_logo.svg',
            //   width: isIPad ? 76.36.w : 40.w,
            //   height: isIPad ? 76.36.w : 40.w,
            //   dj: true,
            //   errorWidget: ImageView(
            //     'assets/images/detail/default_team_home.svg',
            //     width: isIPad ? 76.36.w : 40.w,
            //     height: isIPad ? 76.36.w : 40.w,
            //   ),
            // )
            //     :
            ImageView(
              ObjectUtil.isNotEmpty(
                  (teamList as List).safeFirst)
                  ? (teamList).safeFirst
                  : normalImage,
              width: isIPad ? 76.36.w : 40.w,
              height: isIPad ? 76.36.w : 40.w,
              cdn: true,
              errorWidget: ImageView(
                errorImage,
                width: isIPad ? 76.36.w : 40.w,
                height: isIPad ? 76.36.w : 40.w,
              ),
            ),
          ),

          SizedBox(height: isIPad ? 12.h : 4.h),
          Container(
            alignment: Alignment.center,
            width: isIPad ? 150.w : 100.w,
            child: Text(
              // controller.getTeamName(type: 1, match: match),
              teamName ?? '',
              maxLines: 2,
              // 有点球大战时显示一行
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isIPad ? 20.sp : 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // if (isShootout)
          // // 点球大战数据
          //   Container(
          //     width: 66.w,
          //     margin: EdgeInsets.only(top: 4.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: List.generate(5, (i) {
          //         int index = i + 1;
          //         return Container(
          //           width: 10.w,
          //           height: 10.w,
          //           alignment: Alignment.center,
          //           child: Container(
          //             width: 8.w,
          //             height: 8.w,
          //             decoration: (match.mscMap['S170$index']?.safeFirst ==
          //                 "-1" ||
          //                 match.mscMap['S170$index']?.safeFirst == null)
          //                 ? BoxDecoration(
          //               shape: BoxShape.circle, // 圆形
          //               color: Colors.transparent, // 内部透明
          //               border: Border.all(
          //                 color: Colors.white, // 边框为白色
          //                 width: 1.3.w, // 边框宽度
          //               ),
          //             )
          //                 : ShapeDecoration(
          //               color: FormatScore.isShootout(
          //                   match, index, 'mhn') ==
          //                   "1"
          //                   ? const Color(0xFF00B42A)
          //                   : FormatScore.isShootout(
          //                   match, index, 'mhn') ==
          //                   "0"
          //                   ? const Color(0xFFF53F3F)
          //                   : Colors.transparent,
          //               shape: const OvalBorder(),
          //             ),
          //           ),
          //         );
          //       }),
          //     ),
          //   )
        ],
      ),
    );
  }
}
