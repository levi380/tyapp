import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/no_data_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/view/rankGroupDisuseView/vr_sport_disuse_list.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';
import '../../vr_sport_detail_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE  vr详情-tabview内容组件-小组赛列表】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 小组赛列表
    】】】
 *
 */
class groupListWidget extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = context.isDarkMode ? Colors.transparent : Colors.white;
    Color? textColor = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.9)
        : const Color(0xff303442);
    // 背景图
    String bgImage = VrSportDetailState.colorBackgroundSkin;
    // TODO: implement build
    return Obx(() => controller.state.groudIndex.value == 0
        ? controller.state.groupList.isNotEmpty

            ///小组赛列表
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    GroupSoureModelDataGroupData model =
                        controller.state.groupList[index];
                    return Container(
                      padding: EdgeInsets.only(bottom: 10.w),
                      // color: Colors.grey.shade100,
                      decoration: context.isDarkMode
                          ? BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  OssUtil.getServerPath(
                                    bgImage,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.white,
                            ),
                      child: listWidget(index, model, bgColor, textColor),
                    );
                  },
                  childCount: controller.state.groupList.length,
                ),
              )
            : SliverFillRemaining(
                child: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: const NoDataWidget(),
                ),
              )
        :

        ///淘汰赛列表
        disuseListWidget());
  }

  ///小组赛列表
  listWidget(int index, GroupSoureModelDataGroupData model, Color bgColor,
      Color textColor) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
          // color: Colors.white.withValues(alpha:0.16),
          color: bgColor,
          borderRadius: BorderRadius.circular(4.w)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 3.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff127DCC),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(2.r),
                              topLeft: Radius.circular(0.r),
                              bottomRight: Radius.circular(2.r),
                              bottomLeft: Radius.circular(0.r)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.w),
                        child: Text(
                          '${model.groupId} ${LocaleKeys.virtual_sports_group.tr}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white.withValues(alpha: 0.08),
            height: 1.w,
          ),
          grouplistHeadWidget(bgColor, textColor),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (ctx, index) {
              GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList
                  itemModel =
                  model.sVirtualSportXZTeamRankingDetailPOList[index];
              String teamName = itemModel.virtualTeamName;
              String type = itemModel.totalCount.toString();
              String reslut = itemModel.winDrawLostDescription;
              String jin = itemModel.goalsScored.toString();
              String shi = itemModel.goalsConceded.toString();
              String jingshengqiu = itemModel.goalsWinning.toString();
              String jifen = itemModel.points.toString();
              return SizedBox(
                height: 50,
                child: groupRowWidghte(
                    index: index + 1,
                    teamName: teamName,
                    type: type,
                    reslut: reslut,
                    jin: jin,
                    shi: shi,
                    jingshengqiu: jingshengqiu,
                    jifen: jifen,
                    bgColor: bgColor,
                    textC: textColor),
              );
            },
            itemCount: model.sVirtualSportXZTeamRankingDetailPOList.length,
            cacheExtent: double.maxFinite,
          ),
        ],
      ),
    );
  }

  ///小组赛标题
  Widget grouplistHeadWidget(Color bgColor, Color textColor) {
    return SizedBox(
      height: 30,
      child: groupRowWidghte(
          index: 0,
          teamName: LocaleKeys.virtual_sports_team.tr,
          type: LocaleKeys.virtual_sports_game.tr,
          reslut: LocaleKeys.virtual_sports_win_tie_loss.tr,
          jin: LocaleKeys.virtual_sports_advance.tr,
          shi: LocaleKeys.virtual_sports_lose.tr,
          jingshengqiu: LocaleKeys.virtual_sports_goal_difference.tr,
          jifen: LocaleKeys.virtual_sports_integral.tr,
          bgColor: bgColor,
          textC: textColor),
    );
  }

  /// 封装Text组件
  Widget _buildTextCell(
    String text, {
    required int flex,
    required Color textColor,
    required FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
    TextOverflow? overflow,
    bool isFitted = false,
  }) {
    Widget textWidget = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style:
          TextStyle(color: textColor, fontSize: 13.sp, fontWeight: fontWeight),
    );

    if (isFitted) {
      textWidget = FittedBox(child: textWidget);
    }

    return Expanded(
      flex: flex,
      child: textWidget,
    );
  }

  ///小组赛列表 包含 小组赛标题 是一个样式
  groupRowWidghte(
      {required int index,
      required String teamName,
      required String type,
      required String reslut,
      required String jin,
      required String shi,
      required String jingshengqiu,
      required String jifen,
      required Color bgColor,
      required Color textC}) {
    Color? textColor = index == 0
        ? textC.withValues(alpha: 0.4)
        : textC.withValues(alpha: 0.9);
    FontWeight? textFont = index == 0 ? FontWeight.w400 : FontWeight.w500;
    double fristW = 40.w;
    return Container(
      decoration: const BoxDecoration(
          // color: index == 0 ? Colors.white.withValues(alpha:0.08) : Colors.transparent,
          ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                index == 0
                    ? SizedBox(
                        width: fristW,
                      )
                    : SizedBox(
                        width: fristW,
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                                // color: Colors.white.withValues(alpha:0.16),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              index.toString(),
                              style: TextStyle(
                                  color: textC,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                _buildTextCell(
                  teamName,
                  flex: 5,
                  textColor: textColor,
                  fontWeight: textFont,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                _buildTextCell(
                  type,
                  flex: 3,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  reslut,
                  flex: 4,
                  textColor: textColor,
                  fontWeight: textFont,
                  isFitted: (index == 0 && reslut.length > 6),
                ),
                _buildTextCell(
                  jin,
                  flex: 2,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  shi,
                  flex: 2,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  jingshengqiu,
                  flex: 3,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  jifen,
                  flex: 2,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
              ],
            ),
          ),
          Visibility(
              visible: index > 0,
              child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                height: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ))
        ],
      ),
    );
  }
}
