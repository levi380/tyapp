import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_tools_methods.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

/// 球队信息显示Widget
/// 封装了球队名称、队徽等信息的显示逻辑
class TeamInfoWidget extends StatelessWidget {
  /// 球队类型：1-主队，2-客队
  final int teamType;
  
  /// 赛事实体
  final MatchEntity match;
  
  /// 控制器标签
  final String tag;
  
  /// 中心名称（用于显示额外信息，如双打时的第二个队员名称）
  final String? centerName;
  
  /// 是否为点球大战
  final bool isShootout;

  /// 构造函数
  /// [teamType] 球队类型：1-主队，2-客队
  /// [match] 赛事实体
  /// [tag] 控制器标签
  /// [centerName] 中心名称
  /// [isShootout] 是否为点球大战
  const TeamInfoWidget({
    super.key,
    required this.teamType,
    required this.match,
    required this.tag,
    this.centerName,
    this.isShootout = false,
  });

  /// 构建主队信息Widget
  /// 返回包含队徽和队名的Widget
  Widget _buildHomeTeam() {
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 队徽
        Container(
          width: isIPad ? 28.w : 28.w,
          height: isIPad ? 28.w : 28.w,
          alignment: Alignment.center,
          child: controller.detailState.isDJDetail
              ? ImageView(
                  ObjectUtil.isNotEmpty((match.mhlu as List).safeFirst)
                      ? (match.mhlu as List).safeFirst
                      : 'assets/images/home/home_team_logo.svg',
                  width: isIPad ? 28.w : 40.w,
                  height: isIPad ? 28.w : 40.w,
                  dj: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_home.svg',
                    width: 40.w,
                    height: 40.w,
                  ),
                )
              : ImageView(
                  ObjectUtil.isNotEmpty((match.mhlu as List).safeFirst)
                      ? (match.mhlu as List).safeFirst
                      : 'assets/images/home/home_team_logo.svg',
                  width: isIPad ? 28.w : 40.w,
                  height: isIPad ? 28.w : 40.w,
                  cdn: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_home.svg',
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
        ),
        SizedBox(width: 4.w),
        // 队名
        Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(maxWidth: 100.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTeamName(type: 1, match: match),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Get.theme.tabPanelSelectedColor,
                  fontSize: isIPad ? 20.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              // 显示中心名称（如双打时的第二个队员）
              if (centerName != null)
                Text(
                  "($centerName)",
                  maxLines: isShootout ? 1 : 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Get.theme.tabPanelSelectedColor,
                    fontSize: isIPad ? 20.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  /// 构建客队信息Widget
  /// 返回包含队名和队徽的Widget
  Widget _buildAwayTeam() {
    MatchDetailController controller =
        Get.find<MatchDetailController>(tag: tag);
    
    // 判断是否为双打（客队有多个队徽）
    bool isDoubleTeam = match.malu.length > 1;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100.w),
                child: Text(
                  getTeamName(type: 2, match: match),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Get.theme.tabPanelSelectedColor,
                    fontSize: isIPad ? 20.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // 显示中心名称（如双打时的第二个队员）
              if (centerName != null)
                Text(
                  "($centerName)",
                  maxLines: isShootout ? 1 : 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Get.theme.tabPanelSelectedColor,
                    fontSize: isIPad ? 20.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
        ),
        SizedBox(width: 4.w),
        // 双打情况：显示两个队徽
        if (isDoubleTeam)
          SizedBox(
            width: isIPad ? 28.w : 28.w,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: isIPad ? 28.w : 28.w,
                    height: isIPad ? 28.w : 28.w,
                    alignment: Alignment.center,
                    child: ImageView(
                      ObjectUtil.isNotEmpty((match.malu as List).safeFirst)
                          ? (match.malu as List).safeFirst
                          : 'assets/images/detail/default_team_away.svg',
                      width: isIPad ? 28.w : 40.w,
                      height: isIPad ? 28.w : 40.w,
                      cdn: true,
                      errorWidget: ImageView(
                        'assets/images/detail/default_team_away.svg',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30.w,
                  child: Container(
                    width: isIPad ? 28.w : 28.w,
                    height: isIPad ? 28.w : 28.w,
                    alignment: Alignment.center,
                    child: ImageView(
                      ObjectUtil.isNotEmpty((match.malu as List).safe(1))
                          ? (match.malu as List).safe(1)
                          : 'assets/images/detail/default_team_away.svg',
                      width: isIPad ? 28.w : 40.w,
                      height: isIPad ? 28.w : 40.w,
                      cdn: true,
                      errorWidget: ImageView(
                        'assets/images/detail/default_team_away.svg',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        // 单打情况：显示一个队徽
        else
          Container(
            width: isIPad ? 28.w : 28.w,
            height: isIPad ? 28.w : 28.w,
            alignment: Alignment.center,
            child: controller.detailState.isDJDetail
                ? ImageView(
                    ObjectUtil.isNotEmpty((match.malu as List).safeFirst)
                        ? (match.malu as List).safeFirst
                        : 'assets/images/detail/default_team_away.svg',
                    width: isIPad ? 28.w : 40.w,
                    height: isIPad ? 28.w : 40.w,
                    dj: true,
                    errorWidget: ImageView(
                      'assets/images/detail/default_team_away.svg',
                      width: 40.w,
                      height: 40.w,
                      cdn: true,
                    ),
                  )
                : ImageView(
                    ObjectUtil.isNotEmpty((match.malu as List).safeFirst)
                        ? (match.malu as List).safeFirst
                        : 'assets/images/detail/default_team_away.svg',
                    width: isIPad ? 28.w : 40.w,
                    height: isIPad ? 28.w : 40.w,
                    cdn: true,
                    errorWidget: ImageView(
                      'assets/images/detail/default_team_away.svg',
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
          ),
      ],
    );
  }

  /// 构建Widget
  /// 根据球队类型返回对应的Widget（主队或客队）
  /// [context] BuildContext上下文
  /// 返回值：对应的球队信息Widget
  @override
  Widget build(BuildContext context) {
    // 根据球队类型返回对应的Widget
    if (teamType == 1) {
      return _buildHomeTeam();
    } else {
      return _buildAwayTeam();
    }
  }
}