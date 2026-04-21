import 'dart:math';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/widget/detal_progress_bar.dart';
import '../vr_sport_detail_state.dart';
import '../../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-历史战绩-足球/篮球】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情-历史战绩-足球/篮球
    - 解析分数列表
    - 显示主客队胜负比例
    - 显示胜平负历史色块
    # `progressItem`

    - `百分比widget`
    - `按照比分的暂用百分比显示进度条`

    ```
    List<String> group = scoreStr.split(':');
    int homeProgress = group[0].toInt() * 10;
    int awayProgress = group[1].toInt() * 10;
    ```

    - 百分比控件
    -progress-进度

    -type 方向，向左右延伸

    -isBig 是否高亮

    ```
    detailProgressBarWidget(
    progress: homeProgress,
    type: detailProgressBarType.left,
    isBig: true),
    ```

    # `resultItem`

    - `底下的输赢平战绩`

    # `rowRecord`

    - `输赢平控件`
    - `处理胜平负色块，一行最多7个，多出7个换行`

    ```
    List<Widget> row = [];
    for (int j = 0; j < currentMaxRow; j++) {
    int resultInt = resultList[i * 7 + j];
    String imageStr = 'Wimage';
    if (resultInt == 0) {
    imageStr = 'Dimage';
    } else if (resultInt == -1) {
    imageStr = 'Limage';
    }

    row.add(SizedBox(
    width: 4.w,
    ));
    row.add(ImageView(
    VrSportDetailState.resultIconPng(imageStr),
    width: 20.w,
    height: 16.w,
    ));
    }
    ```

    】】】
 *
 */
class sportHistoryDataView extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    List<int> left = [];
    List<int> right = [];
    if (controller.state.historyScore.isNotEmpty) {
      ///解析分数列表
      controller.state.historyScore.forEach((element) {
        List<String> group = element.split(':');
        if (group[0].toInt() > group[1].toInt()) {
          left.add(1);
          right.add(-1);
        } else if (group[0].toInt() < group[1].toInt()) {
          left.add(-1);
          right.add(1);
        } else if (group[0].toInt() == group[1].toInt()) {
          left.add(0);
          right.add(0);
        }
      });
    }

    return Container(
      decoration: context.isDarkMode
          ? BoxDecoration(
              // image: DecorationImage(
              //   image: NetworkImage(
              //     OssUtil.getServerPath(
              //       'assets/images/home/color_background_skin.png',
              //     ),
              //   ),
              //   fit: BoxFit.cover,
              // ),
              color:
                  ChangeSkinToneColorUtil.instance().getDarkBackgroundColor())
          : const BoxDecoration(
              color: Colors.transparent,
            ),
      child: Container(
        decoration: BoxDecoration(
            color: context.isDarkMode
                ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                : Colors.white,
            borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.all(5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 队伍名称
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5.w),
                      alignment: Alignment.centerRight,
                      child: Text(
                        controller.state.match?.teams.safeFirst ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha: 0.9)
                              : const Color(0xff303442),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.state.match?.teams.safeLast ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha: 0.9)
                              : const Color(0xff303442),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///比分列表
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return progressItem(context, index);
                },
                itemCount: controller.state.historyScore.length,
              ),

              ///下方胜平负色块以及百分比显示
              Container(
                margin: EdgeInsets.only(
                    top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    resultItem(context, 'left', left),
                    SizedBox(
                      width: 10.w,
                    ),
                    resultItem(context, 'right', right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///百分比widget
  Widget progressItem(BuildContext context, index) {
    String scoreStr = controller.state.historyScore[index];

    List<String> group = scoreStr.split(':');
    int homeProgress = group[0].toInt() * 10;
    int awayProgress = group[1].toInt() * 10;

    ///按照比分的暂用百分比显示进度条
    return Container(
      margin: EdgeInsets.only(top: 13.w, left: 12.w, right: 12.w),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.w),
          alignment: Alignment.center,
          width: 70.w,
          child: Text(
            scoreStr.replaceAll(':', ' - '),
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.9)
                  : const Color(0xff303442),
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ),

        ///历史战绩 主客队比分百分比
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

  ///底下的输赢平战绩
  resultItem(BuildContext context, String resultScore, List scorelist) {
    final score = scorelist.where((element) => element == 1).length;
    // 胜率
    final percent =
        '${(score / (max(1, scorelist.length)) * 100).toStringAsFixed(0)}%';
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
              : const Color(0xffF2F2F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              percent,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xff303442),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            rowRecord(scorelist),
          ],
        ),
      ),
    );
  }

  ///输赢平控件
  rowRecord(List resultList) {
    int columnNum = (resultList.length / 7 + 1).toInt();
    int lastRowNum = (resultList.length % 7).toInt();

    // AppLogger.debug("resultList.length = ${resultList.length}");
    // AppLogger.debug("columnNum = $columnNum  lastRowNum = $lastRowNum");
    List<Widget> column = [];

    for (int i = 0; i < columnNum; i++) {
      int currentMaxRow = 7;
      if (i == columnNum - 1) {
        currentMaxRow = lastRowNum;
      }

      ///处理胜平负色块，一行最多7个，多出7个换行
      List<Widget> row = [];
      for (int j = 0; j < currentMaxRow; j++) {
        int resultInt = resultList[i * 7 + j];
        String imageStr = 'Wimage';
        if (resultInt == 0) {
          imageStr = 'Dimage';
        } else if (resultInt == -1) {
          imageStr = 'Limage';
        }
        // 赛果图标
        String resultIcon = VrSportDetailState.resultIconPng(imageStr);

        row.add(SizedBox(
          width: 4.w,
        ));
        row.add(ImageView(
          resultIcon,
          width: 20.w,
          height: 16.w,
        ));
      }
      column.add(SizedBox(
        height: 5.w,
      ));
      column.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ));
    }

    return Column(
      children: column,
    );
  }
}
