import 'package:flutter_ty_app/app/extension/num_extension.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/match_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 新手版UI组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # NoobbuildBetGroupTeam 函数

    ## 功能
    `NoobbuildBetGroupTeam` 函数用于获取赛事的让球方，并展示主队和客队的相关信息，包括队名、队标以及让球方的状态。

    - 是否是发球方 set_serving_side
    - 队伍logo
    - 队伍名称

    ## 代码实现

    ```dart
    ///是否是发球方
    bool set_serving_side(item, side) {
    return item.ms == 1 && item.mat == side;
    }
    ```

    】】】
 *
 */
/// @description: 获取赛事的让球方
/// @param {Object} match
/// @return {Number} 0未找到让球方 1主队为让球方 2客队为让球方
NoobbuildBetGroupTeam(MatchEntity matchEntity, BuildContext context) {
  int result = MatchUtil.getHandicapIndexBy(matchEntity);
  Color mhnColor = result == 1
      ? const Color(0xff74c4ff)
      : context.isDarkMode
          ? Colors.white.withValues(alpha:0.8999999761581421)
          : const Color(0xFF303442); //主队
  Color manColor = result == 2
      ? const Color(0xff74c4ff)
      : context.isDarkMode
          ? Colors.white.withValues(alpha:0.8999999761581421)
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
                  ? Colors.white.withValues(alpha:0.8999999761581421)
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
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  color: set_serving_side(matchEntity, 'away')
                      ? const Color(0xff4ab06a)
                      : Colors.transparent,
                ),
              ),
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
            ],
          ),
        ),
      ],
    ),
  );
}

///是否是发球方
bool set_serving_side(MatchEntity item, String side) {
  ///isServingSideCsidList 足篮不显示让球方
  List isServingSideCsidList = [SportData.sportCsid_1,SportData.sportCsid_2];
  return item.ms == 1
      && item.mat == side
      && !isServingSideCsidList.contains(item.csid);
}
