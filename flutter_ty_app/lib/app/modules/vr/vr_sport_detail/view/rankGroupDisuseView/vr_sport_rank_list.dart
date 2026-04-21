import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_no_data_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';
import '../../vr_sport_detail_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-tabview内容组件-排名列表】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  vr详情-tabview内容组件-排名列表
    - 非世界杯列表（常规赛）
    】】】
 *
 */
class rankListWidget extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return controller.state.rankList.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                CommonScoreModelData model = controller.state.rankList[index];
                return SizedBox(
                  height: 50.w,
                  child: rowWidghte(
                    context: context,
                    index: index,
                    teamName: model.virtualTeamName,
                    type: model.totalCount.toString(),
                    reslut: model.winDrawLostDescription,
                    score: model.points.toString(),
                  ),
                );
              },
              childCount: controller.state.rankList.length,
            ),
          )
        : SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: const ResultsNoDataWidget(),
            ),
          );
  }

  /// 封装Text组件
  Widget _buildTextCell(
    String text, {
    int flex = 1,
    required Color textColor,
    required FontWeight? fontWeight,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: textColor, fontSize: 12.sp, fontWeight: fontWeight),
      ),
    );
  }

  ///排名列表样式 包含 排名标题 是一个样式
  rowWidghte(
      {required BuildContext context,
      required int index,
      required String teamName,
      required String type,
      required String reslut,
      required String score}) {
    Color? textColor = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.9)
        : const Color(0xff303442);

    FontWeight? textFont = FontWeight.w500;
    double fristW = 40.w;
    // 排名图标
    String rankIcon =
        index < 3 ? VrSportDetailState.betRecordNoIcon(index + 1) : "";
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.transparent : Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        ///前3名使用图来表示
                        index < 3
                            ? SizedBox(
                                width: fristW,
                                child: Center(
                                  child: ImageView(
                                    rankIcon,
                                    height: 18.w,
                                    width: 18.w,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: fristW,
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 18.w,
                                    height: 18.w,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                        Text(
                          teamName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12.sp,
                            fontWeight: textFont,
                          ),
                        ),
                      ],
                    )),
                _buildTextCell(
                  type,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  reslut,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
                _buildTextCell(
                  score,
                  textColor: textColor,
                  fontWeight: textFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 9.w, right: 9.w),
            height: 1,
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xfff2f2f6),
          )
        ],
      ),
    );
  }
}
