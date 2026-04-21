import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/pin_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';

import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../../controllers/home_controller.dart';
import '../logo_placeholder_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7d3a63c7-df94-4a5e-a079-48f44ab7b750-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 新手版 】】】
    【【【 AUTO_PARAGRAPH_TITLE 收藏-赛事玩法数量 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - isGuanjun 是否是冠军页面
    - hasCollection 是否收藏    添加/取消收藏
    - matchEntity.tn 赛事玩法数量
    】】】
 *
 */

///首页列表联赛头部
///列表收缩部分
// ignore: must_be_immutable
class MatchListItemHeaderWidget extends StatelessWidget {
  MatchListItemHeaderWidget({
    super.key,
    required this.matchEntity,
    required this.onExpandChange,
    this.hasCollection = true,
    this.length = '',
    this.isGuanjun = false,
  });

  final bool hasCollection;
  final bool isGuanjun;
  final String length;
  final MatchEntity matchEntity;
  final ValueChanged<bool> onExpandChange;

  @override
  Widget build(BuildContext context) {
    final bool isExpand = isGuanjun
        ? (TyHomeController.to.homeState.expandStateCache[matchEntity.mid] ?? true)
        : matchEntity.isExpand;

    return GetBuilder<CollectionController>(
      id: '$COLLECTION_TID${matchEntity.tid}',
      builder: (logic) {
        return GestureDetector(
          onTap: () => onExpandChange(!isExpand),
          child: Container(
            height: 24.w,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                ///左侧蓝色竖条
                _buildLeftBar(),
                ///收藏按钮
                if (hasCollection) _buildCollectionButton(context),
                SizedBox(width: 4.w),

                ///  4325需求--------

                LogoPlaceholderWidget(
                  imageUrl: matchEntity.lurl,
                  width: 16.w,
                  height: 16.w,
                  base64Placeholder: 'placeholder_team.base64',
                  cdn: true,
                ),

                SizedBox(
                  width: 4.w,
                ),
                ///------------------4325需求-

                /// 联赛标题 + 数量
                _buildTitle(context),
                ///非冠军 置顶图标
                if (!isGuanjun) _buildPinWidget(),
                ///展开 / 收起箭头
                _buildExpandArrow(context, isExpand),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 左侧蓝色竖条
  Widget _buildLeftBar() {
    return Container(
      width: 2.w,
      height: 12.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(2.w)),
        color: const Color(0xff179CFF),
      ),
    );
  }

  /// 收藏按钮
  Widget _buildCollectionButton(BuildContext context) {
    return InkWell(
      onTap: () {
        isGuanjun
            ? CollectionController.to.addOrCancelTournamentGuanjun(matchEntity)
            : CollectionController.to.addOrCancelMatch(matchEntity);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: ImageView(
          _collectionIconPath(context),
          width: 16.w,
          height: 16.w,
        ),
      ),
    );
  }

  /// 收藏图标
  String _collectionIconPath(BuildContext context) {
    final bool isDark = context.isDarkMode;

    final bool isCollected = RouteCheckUtil.checkIsLogin() &&
        (isGuanjun
            ? (matchEntity.tf ||
            CollectionController.to.championCollectionMidList.contains(matchEntity.mid))
            : (matchEntity.mf ||
            CollectionController.to.isCollection(matchEntity)));

    if (isCollected) {
      return 'assets/images/home/ico_fav_nor_sel.svg';
    }

    return isDark
        ? 'assets/images/home/ico_fav_nor.png'
        : 'assets/images/home/ico_fav_nor_light.png';
  }

  /// 联赛标题 + 数量
  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(
            matchEntity.onTn.isNotEmpty ? matchEntity.onTn : matchEntity.tn,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp.scale,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.9)
                  : const Color(0xff303442),
              fontWeight: FontWeight.w600,
            ),
          ),
          if (length.isNotEmpty) ...[
            SizedBox(width: 4.w),
            Text(
              length,
              style: TextStyle(
                fontSize: 12.sp.scale,
                color: const Color(0xFFAFB3C8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 置顶图标
  Widget _buildPinWidget() {
    return PinWidget(
      isLeague: true,
      tid: matchEntity.tid,
      isDjInCommon: MatchUtil.isEsport(matchEntity),
    );
  }

  /// 展开 / 收起箭头封装
  Widget _buildExpandArrow(BuildContext context, bool isExpand) {
    final bool isDark = context.isDarkMode;
    final String asset = isExpand
        ? (isDark
        ? 'assets/images/league/item_expand_darkmode.png'
        : 'assets/images/league/item_expand.png')
        : (isDark
        ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
        : 'assets/images/league/ico_arrowright_nor.png');

    return Container(
      width: 24.w,
      height: 24.w,
      alignment: Alignment.center,
      child: ImageView(asset, width: 12.w),
    );
  }
}

