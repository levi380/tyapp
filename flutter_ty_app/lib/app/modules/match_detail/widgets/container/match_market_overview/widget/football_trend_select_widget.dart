

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../vr/vr_sport_detail/import_head.dart';
import '../../match_statistics/analyze_battle_array/widget/custom_position_toast.dart';
import '../../../../states/match_market_overview_state.dart';

typedef FootballTrendSelectWidgetFunction = Widget? Function(
    int itemIndex,
    );
class FootballTrendSelectWidget extends StatefulWidget{
  List<String> morePlays=[];
  int selectIndex;
  FootballTrendSelectWidgetFunction footballTrendSelectWidgetFunction;

  FootballTrendSelectWidget(this.morePlays,this.selectIndex,this.footballTrendSelectWidgetFunction);
  @override
  State<StatefulWidget> createState() {
    return FootballTrendSelectWidgetState();
  }
}
class FootballTrendSelectWidgetState extends State<FootballTrendSelectWidget>{
  int selectIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectIndex=widget.selectIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.morePlays.length,
        (index) => GestureDetector(
          onTap: () {
            widget.footballTrendSelectWidgetFunction(index);
            selectIndex = index;
            // 关闭Toast
            CustomPositionToast.dismiss();
            // 延迟setState调用，避免在关闭过程中更新状态导致语义断言错误
            Future.microtask(() {
              if (mounted) {
                setState(() {});
              }
            });
          },
          child: Container(
            height: 25.h,
            padding: EdgeInsets.only(left: 8.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    widget.morePlays[index],
                    style: TextStyle(
                      fontSize: (12.sp),
                      fontWeight: FontWeight.w500,
                      color: index == selectIndex
                          ? (context.isDarkMode
                              ? MatchMarketOverviewState.footballTrendMenuSelectedTextColorDark
                              : MatchMarketOverviewState.footballTrendMenuSelectedTextColorLight)
                          : context.isDarkMode
                              ? MatchMarketOverviewState.footballTrendMenuUnselectedTextColorDark
                              : MatchMarketOverviewState.footballTrendMenuUnselectedTextColorLight,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Visibility(
                  visible: index == selectIndex,
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: context.isDarkMode
                        ? MatchMarketOverviewState.footballTrendMenuCheckIconColorDark
                        : MatchMarketOverviewState.footballTrendMenuCheckIconColorLight,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



}