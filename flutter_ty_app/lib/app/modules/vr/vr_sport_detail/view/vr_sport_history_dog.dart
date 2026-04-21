import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/widget/detal_progress_bar.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';

import '../../../../utils/change_skin_tone_color_util.dart';
import '../vr_sport_detail_state.dart';
import '../../../../utils/vr_rank_icon_utils.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-历史战绩-赛狗的布局】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情-历史战绩-赛狗的布局
    - 上期结果-处理显示文案，0为X
    - 综合评价-处理综合评价的星星
    - 活力表现-百分比
    】】】
 *
 */
class sportHistoryDogView extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.w,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(8)),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //     OssUtil.getServerPath(
                    //       'assets/images/home/color_background_skin.png',
                    //     ),
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                    color: ChangeSkinToneColorUtil.instance()
                        .getDarkBackgroundColor())
                : const BoxDecoration(
                    color: Colors.white,
                  ),
            child: Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? ChangeSkinToneColorUtil.instance()
                          .getDarkBackgroundColor()
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return itemBuild(context, index);
                    },
                    itemCount: controller.state.historyScoreDog.length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///vr历史分数百分比进度条
  Widget progressItem(index) {
    String scoreStr = controller.state.historyScore[index];

    List<String> group = scoreStr.split(':');
    int homeProgress = group[0].toInt() * 10;
    int awayProgress = group[1].toInt() * 10;
    return Container(
      margin: EdgeInsets.only(top: 13.w, left: 10.w, right: 10.w),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.w),
          alignment: Alignment.center,
          width: 70,
          child: Text(
            scoreStr.replaceAll(':', ' - '),
            style: const TextStyle(
                color: Color(0xff303442),
                fontWeight: FontWeight.w700,
                fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: detailProgressBarWidget(
                progress: homeProgress,
                type: detailProgressBarType.left,
                isBig: true,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            Expanded(
              flex: 1,
              child: detailProgressBarWidget(
                progress: awayProgress,
                type: detailProgressBarType.right,
                isBig: true,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ///比赛结果布局
  resultItem(String resultScore, List scoreList) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          decoration: BoxDecoration(
              color: const Color(0xffF2F2F6),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            children: [
              gridview(scoreList),
            ],
          ),
        ));
  }

  ///比赛结果色块列表
  gridview(List resultList) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 7.w),
      width: double.maxFinite,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 2.w,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (BuildContext context, int index) {
          int resultInt = resultList[index];
          String imageStr = 'Wimage';
          if (resultInt == 0) {
            imageStr = 'Dimage';
          } else if (resultInt == -1) {
            imageStr = 'Limage';
          }
          // 赛果图标
          String resultIcon = VrSportDetailState.resultIconSvg(imageStr);
          return ImageView(
            resultIcon,
            // fit: BoxFit.contain,
            width: 20,
            height: 16,
          );
        },
        itemCount: resultList.length,
      ),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    /*
    {"code":"0000000","data":[{"number":"1","form":44,"star":"3","name":"奥拉齐奥","forecast":[3,0,2,0,3]},{"number":"2","form":34,"star":"2","name":"南多","forecast":[0,0,0,0,0]},{"number":"3","form":61,"star":"5","name":"埃德·戈里","forecast":[0,2,1,0,1]},{"number":"4","form":40,"star":"3","name":"皮里图","forecast":[0,1,1,0,0]},{"number":"5","form":56,"star":"4","name":"比亚焦","forecast":[0,1,1,3,0]},{"number":"6","form":63,"star":"5","name":"","forecast":[2,0,2,0,0]}],"msg":"成功","ts":1710606701343}
 */
    VrHistoryDogEntity bean = controller.state.historyScoreDog[index];
    double firstW = 40.w;

    Color? textColor = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.9)
        : const Color(0xff303442);

    FontWeight? textFont = FontWeight.w500;

    ///处理显示文案，0为X
    var resultList = bean.forecast.map((e) {
      return e == 0 ? 'X' : '$e';
    }).toList();

    var result = '';
    resultList.forEach((element) {
      result += ' $element';
    });

    // bean.star.toInt()
    ///处理综合评价的星星
    // 综合评价选中图标
    String favSelIcon = VrSportDetailState.icoFavSel;
    // 综合评价未选中图标
    String favIcon = VrSportDetailState.icoFav;
    List<Widget> starWidget = [];
    for (int i = 0; i < 5; i++) {
      if (i < (bean.star ?? "0").toInt()) {
        starWidget.add(ImageView(
          favSelIcon,
          width: 14.w,
          height: 14.w,
        ));
      } else {
        starWidget.add(ImageView(
          favIcon,
          width: 14.w,
          height: 14.w,
        ));
      }
      starWidget.add(SizedBox(
        width: 4.w,
      ));
    }
    // ico_fav_sel
    // 排名图标
    String rankIcon =
        getIconByRankIndex(controller.state.topMenu?.menuId, index + 1);
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 20.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 4.w,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///前7名有专用图片
                        index < 7
                            ? SizedBox(
                                width: firstW,
                                child: ImageView(
                                  rankIcon,
                                  height: 18.w,
                                  width: 18.w,
                                ),
                              )
                            : SizedBox(
                                width: firstW,
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 18.w,
                                    height: 18.w,
                                    // decoration: BoxDecoration(
                                    //     color: Colors.white.withValues(alpha:0.16),
                                    //     borderRadius: BorderRadius.circular(4)),
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

                        ///名字
                        Expanded(
                          child: Text(
                            bean.name,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? ChangeSkinToneColorUtil.instance()
                            .getDarkBackgroundColor()
                        : const Color(0xffF2F2F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                  child: Column(
                    children: [
                      ///上期结果
                      Row(
                        children: [
                          Text(
                            LocaleKeys.virtual_sports_results_previous.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            result,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color(0xff179CFF),
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///综合评价
                      Row(
                        children: [
                          Text(
                            LocaleKeys.virtual_sports_comprehensive_rating.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Row(
                              children: starWidget,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),

                      ///活力表现
                      Row(
                        children: [
                          Text(
                            LocaleKeys.virtual_sports_vitality_performance.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: detailProgressBarWidget(
                              progress: bean.form,
                              type: detailProgressBarType.right,
                              isBig: true,
                              colorRight: const Color(0xffE95B5B),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),

                          ///百分比显示
                          Text(
                            '${bean.form}%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : const Color(0xff303442),
                                fontSize: 12.sp,
                                fontWeight: textFont),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              )
            ],
          ),
          SizedBox(
            height: 20.w,
          )
        ],
      ),
    );
  }

  ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
  String getIconByRankIndex(String? csid, int index) {
    String icon = VrRankIconUtils.getRankIcon(
        int.tryParse(csid ?? '1002') ?? 1002, index.toString());
    if (icon.isEmpty) {
      icon = VrSportDetailState.dogHorseRankIcon(index);
    }
    return icon;
  }
}
