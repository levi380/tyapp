import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';

import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../vr/vr_sport_detail/import_head.dart';

///电竞-专业版 赔率

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-cb8d4c89-159a-4a88-8bdb-f10510cb162f-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞-专业版 赔率 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞-专业版 赔率
    # `_buildOddGroup`

    `构建赔率组 布局，电竞专业版都为两行两列布局`

    # `_buildOdds`

    `构建赔率布局，一列的赔率`

    】】】
 *
 */
class OddGroupWidget extends StatefulWidget {
  final MatchEntity matchEntity;

  const OddGroupWidget({super.key, required this.matchEntity});

  @override
  State<OddGroupWidget> createState() => _OddGroupWidgetState();
}

class _OddGroupWidgetState extends State<OddGroupWidget> {
  late PageController pageController;

  @override
  void initState() {
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    Bus.getInstance().on(EventType.changeBetType, (index) {
      pageController.animateToPage(index,
          duration: Duration(
              milliseconds: DJController.to.DJState.changeBetTypeAnimMs),
          curve: Curves.ease);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MatchHps?> matchHpsList = [];
    matchHpsList.addAll(widget.matchEntity.hps);

    /// 不足三个补足三个
    if (matchHpsList.length < 3) {
      matchHpsList.addAll(List.filled(3 - matchHpsList.length, null).toList());
    }

    // 三个一组（按配置列数分组）
    int lenght =
        (matchHpsList.length / DJController.to.DJState.oddsGroupColumns).ceil();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: isIPad
              ? ((Get.width - 28.w - 8.w) * 0.5)
              : DJController.to.DJState.oddsWidgetWidthPhone.w,
          height: DJController.to.DJState.oddsPageHeightPhone.h +
              (TyTextScaler.instance().isScale
                  ? DJController.to.DJState.textScaleDeltaPage
                  : 0),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                Bus.getInstance().emit(EventType.changeBetType, index);
              });
            },
            children: List.generate(lenght, (index) {
              int start = index * 3;
              int end = ((index + 1) * 3).clamp(0, matchHpsList.length);
              List<MatchHps?> groupList =
                  matchHpsList.getRange(start, end).toList();
              return _buildOddGroup(groupList);
            }),
          ),
        ),
      ],
    );
  }

  ///构建赔率组 布局，电竞专业版都为两行两列布局
  Widget _buildOddGroup(List<MatchHps?> groupList) {
    List<Widget> widgets = [];
    for (int i = 0; i < groupList.length; i++) {
      MatchHps? element = groupList[i];
      List<MatchHpsHlOl> ol = [];
      int count = DJController.to.DJState.oddsGroupRows; //需要占位数
      int defaultNum = DJController.to.DJState.oddsGroupRows; //最大行数
      if (element != null && element.hl.safeFirst?.ol != null) {
        ol = element.hl[0].ol;
        count = defaultNum - ol.length;
      }
      if (count > 0) {
        //占位
        for (int j = 0; j < count; j++) {
          var fakeOl = MatchHpsHlOl();
          ol.add(fakeOl);
        }
      }
      widgets.add(
        _buildOdds(element, ol),
      );
    }
    return SizedBox(
      width: DJController.to.DJState.oddsWidgetWidthPhone.w,
      height: DJController.to.DJState.oddsRowHeightPhone.h +
          (TyTextScaler.instance().isScale
              ? DJController.to.DJState.textScaleDeltaRow
              : 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: widgets),
    );
  }

  ///构建赔率布局，一列的赔率
  Widget _buildOdds(MatchHps? hps, List<MatchHpsHlOl> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list.map((e) {
        return OddsButton(
            betType: OddsBetType.esport,
            height: DJController.to.DJState.oddsRowHeightPhone.h +
                (TyTextScaler.instance().isScale
                    ? DJController.to.DJState.textScaleDeltaRow
                    : 0),
            width: isIPad
                ? ((Get.width - 28.w - 18.w) * 0.5) /
                    DJController.to.DJState.oddsGroupColumns
                : DJController.to.DJState.oddsButtonWidthPhone.w,
            match: widget.matchEntity,
            hps: hps,
            ol: e,
            hl: hps?.hl.safeFirst,
            radius: DJController.to.DJState.oddsButtonRadius.toDouble());
      }).toList(),
    );
  }
}
