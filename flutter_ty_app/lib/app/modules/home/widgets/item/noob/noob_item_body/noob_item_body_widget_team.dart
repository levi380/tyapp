

import 'package:flutter_ty_app/app/extension/num_extension.dart';


import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/utils/match_util.dart';


import '../../../../../../services/models/res/match_entity.dart';
import '../../../../controllers/home_controller.dart';
import '../noob_build_bet_group_team.dart';


class NoobItemBodyWidgetTeam extends StatelessWidget {
  const NoobItemBodyWidgetTeam({
    super.key,
    required this.matchEntity,
    required this.punishHome,
    required this.punishAway,
  });

  final MatchEntity matchEntity;
  final String punishHome;
  final String punishAway;
  @override
  Widget build(BuildContext context) {
    int result = MatchUtil.getHandicapIndexBy(matchEntity);
    Color mhnColor = result == 1
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442); //主队
    Color manColor = result == 2
        ? const Color(0xff74c4ff)
        : context.isDarkMode
        ? Colors.white.withValues(alpha: 0.8999999761581421)
        : const Color(0xFF303442); //客队
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (punishHome.isNotEmpty &&
                          punishHome != '0' &&
                          TyHomeController.to.visiable)
                      // isShowRed
                      //
                      // ///进球动画
                      //     ? GlobalFadeTransition(
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 3.w),
                      //     width: 15.w,
                      //     height: 16.w,
                      //     alignment: Alignment.center,
                      //     decoration: ShapeDecoration(
                      //       color: const Color(0xFFF53F3F),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(2.r)),
                      //     ),
                      //     child: Text(
                      //       punishHome,
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 12.sp,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
                      // ).marginOnly(right: 4.w)

                      ///红牌动画
                      //     :
                        Container(
                          margin: EdgeInsets.only(left: 1.w),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          alignment: Alignment.center,
                          width: 15.w,
                          height: 16.w,
                          child: Text(
                            punishHome,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).marginOnly(right: 4.w),
                      Container(
                        width: 100.w,
                        child: Text(
                          matchEntity.mhn,
                          style: TextStyle(
                            color: mhnColor,
                            fontSize: 12.sp.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                ImageView(
                  (matchEntity.mhlu as List).safeFirst == "" ||
                      (matchEntity.mhlu as List).safeFirst == null
                      ? 'assets/images/home/home_team_logo.svg'
                      : (matchEntity.mhlu as List).safeFirst,
                  width: 20.w,
                  height: 20.w,
                  cdn: true,
                ),
                Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w)),
                      color: set_serving_side(matchEntity, 'home')
                          ? const Color(0xff4ab06a)
                          : Colors.transparent,
                    )),
              ],
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            alignment: Alignment.center,
            child: Text(
              'VS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 12.sp.scale,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 4.w,
                    height: 4.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w)),
                      color: set_serving_side(matchEntity, 'away')
                          ? const Color(0xff4ab06a)
                          : Colors.transparent,
                    )),
                ImageView(
                  (matchEntity.malu as List).safeFirst == "" ||
                      (matchEntity.malu as List).safeFirst == null
                      ? 'assets/images/home/home_team_logo.svg'
                      : (matchEntity.malu as List).safeFirst,
                  width: 20.w,
                  height: 20.w,
                  cdn: true,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        child: Text(
                          matchEntity.man,
                          style: TextStyle(
                            color: manColor,
                            fontSize: 12.sp.scale,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),

                      if (punishAway.isNotEmpty &&
                          punishAway != '0' &&
                          TyHomeController.to.visiable)
                      // isShowRed
                      //
                      // ///进球动画
                      //     ? GlobalFadeTransition(
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 3.w),
                      //     width: 15.w,
                      //     height: 16.w,
                      //     alignment: Alignment.center,
                      //     decoration: ShapeDecoration(
                      //       color: const Color(0xFFF53F3F),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(2.r)),
                      //     ),
                      //     child: Text(
                      //       punishAway,
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 12.sp,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
                      // ).marginOnly(right: 4.w)
                      //
                      // ///红牌动画
                      //     :
                        Container(
                          margin: EdgeInsets.only(left: 1.w),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          alignment: Alignment.center,
                          width: 15.w,
                          height: 16.w,
                          child: Text(
                            punishAway,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).marginOnly(left: 4.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}