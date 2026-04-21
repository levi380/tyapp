import 'package:common_utils/common_utils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../controllers/statistic/history_performance_controller.dart';

/// 历史表现头部 - 队伍图标区域
///
/// 根据主客队（tabIndex/controller.tabIndex）显示单打或双打图标
class HistoryPerformanceTeamImage extends StatelessWidget {
  final HistoryPerformanceController controller;
  final String tag;
  final int? tabIndex;

  const HistoryPerformanceTeamImage({
    super.key,
    required this.controller,
    required this.tag,
    this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(tag),
      builder: (dataController) {
        final detailController =
            Get.find<MatchDetailController>(tag: controller.tag);
        final match = dataController.getMatchById(tag);
        final isHome = (tabIndex ?? controller.tabIndex) == 0;
        return isHome
            ? _buildHomeTeamImage(match, detailController)
            : _buildAwayTeamImage(match, detailController);
      },
    );
  }

  static Widget _buildHomeTeamImage(
    MatchEntity? match,
    MatchDetailController detailController,
  ) {
    if ((match?.mhlu.length ?? 0) > 1) {
      return SizedBox(
        width: isIPad ? 114.w : 40.w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSingleTeamImage(
                imageUrl: (match!.mhlu as List).first,
                defaultImage: 'assets/images/home/home_team_logo.svg',
                errorImage: 'assets/images/detail/default_team_home.svg',
                width: isIPad ? 84.w : 40.w,
                height: isIPad ? 84.w : 40.w,
                imageWidth: isIPad ? 76.36.w : 40.w,
                imageHeight: isIPad ? 76.36.w : 40.w,
                isDJ: false,
              ),
            ),
            Positioned(
              left: 30.w,
              child: _buildSingleTeamImage(
                imageUrl: (match.mhlu as List).safe(1),
                defaultImage: 'assets/images/home/home_team_logo.svg',
                errorImage: 'assets/images/detail/default_team_home.svg',
                width: isIPad ? 84.w : 44.w,
                height: isIPad ? 84.w : 44.w,
                imageWidth: isIPad ? 76.36.w : 40.w,
                imageHeight: isIPad ? 76.36.w : 40.w,
                isDJ: false,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      width: isIPad ? 40.w : 40.w,
      height: isIPad ? 40.w : 40.w,
      alignment: Alignment.center,
      child: detailController.detailState.isDJDetail
          ? _buildDJTeamImage(
              imageUrl: (match?.mhlu as List?)?.safeFirst,
              defaultImage: 'assets/images/home/home_team_logo.svg',
              errorImage: 'assets/images/detail/default_team_home.svg',
            )
          : _buildNormalTeamImage(
              imageUrl: (match?.mhlu as List?)?.safeFirst,
              defaultImage: 'assets/images/home/home_team_logo.svg',
              errorImage: 'assets/images/detail/default_team_home.svg',
            ),
    );
  }

  static Widget _buildAwayTeamImage(
    MatchEntity? match,
    MatchDetailController detailController,
  ) {
    return SizedBox(
      width: isIPad ? 80.w : 40.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (match?.malu.length ?? 0) > 1
              ? SizedBox(
                  width: isIPad ? 114.w : 74.w,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildSingleTeamImage(
                          imageUrl: (match!.malu as List).safeFirst,
                          defaultImage:
                              'assets/images/detail/default_team_away.svg',
                          errorImage:
                              'assets/images/detail/default_team_away.svg',
                          width: isIPad ? 84.w : 44.w,
                          height: isIPad ? 84.w : 44.w,
                          imageWidth: isIPad ? 76.36.w : 40.w,
                          imageHeight: isIPad ? 76.36.w : 40.w,
                          isDJ: false,
                        ),
                      ),
                      Positioned(
                        left: 30.w,
                        child: _buildSingleTeamImage(
                          imageUrl: (match!.malu as List).safe(1),
                          defaultImage:
                              'assets/images/detail/default_team_away.svg',
                          errorImage:
                              'assets/images/detail/default_team_away.svg',
                          width: isIPad ? 84.w : 44.w,
                          height: isIPad ? 84.w : 44.w,
                          imageWidth: isIPad ? 76.36.w : 40.w,
                          imageHeight: isIPad ? 76.36.w : 40.w,
                          isDJ: false,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: isIPad ? 84.w : 44.w,
                  height: isIPad ? 84.w : 44.w,
                  alignment: Alignment.center,
                  child: detailController.detailState.isDJDetail
                      ? _buildDJTeamImage(
                          imageUrl: (match?.malu as List?)?.safeFirst,
                          defaultImage:
                              'assets/images/detail/default_team_away.svg',
                          errorImage:
                              'assets/images/detail/default_team_away.svg',
                        )
                      : _buildNormalTeamImage(
                          imageUrl: (match?.malu as List?)?.safeFirst,
                          defaultImage:
                              'assets/images/detail/default_team_away.svg',
                          errorImage:
                              'assets/images/detail/default_team_away.svg',
                        ),
                ),
        ],
      ),
    );
  }

  static Widget _buildSingleTeamImage({
    required String? imageUrl,
    required String defaultImage,
    required String errorImage,
    required double width,
    required double height,
    required double imageWidth,
    required double imageHeight,
    required bool isDJ,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: ImageView(
        ObjectUtil.isNotEmpty(imageUrl) ? imageUrl! : defaultImage,
        width: imageWidth,
        height: imageHeight,
        cdn: true,
        errorWidget: ImageView(
          errorImage,
          width: 40.w,
          height: 40.w,
        ),
      ),
    );
  }

  static Widget _buildDJTeamImage({
    required String? imageUrl,
    required String defaultImage,
    required String errorImage,
  }) {
    return ImageView(
      ObjectUtil.isNotEmpty(imageUrl) ? imageUrl! : defaultImage,
      width: isIPad ? 76.36.w : 40.w,
      height: isIPad ? 76.36.w : 40.w,
      dj: true,
      errorWidget: ImageView(
        errorImage,
        width: 40.w,
        height: 40.w,
      ),
    );
  }

  static Widget _buildNormalTeamImage({
    required String? imageUrl,
    required String defaultImage,
    required String errorImage,
  }) {
    return ImageView(
      ObjectUtil.isNotEmpty(imageUrl) ? imageUrl! : defaultImage,
      width: isIPad ? 76.36.w : 40.w,
      height: isIPad ? 76.36.w : 40.w,
      cdn: true,
      errorWidget: ImageView(
        errorImage,
        width: 40.w,
        height: 40.w,
      ),
    );
  }
}
