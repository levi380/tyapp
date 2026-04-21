import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/widget/match_select/vr_match_select_widget_cell.dart';
import 'package:get/get.dart';

import '../../../../../../main.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../vr_sport_detail_state.dart';

class VrMatchSelectWidget extends StatefulWidget {
  const VrMatchSelectWidget({
    super.key,
    required this.match,
    required this.matches,
    this.onTap,
    this.onSelect,
  });

  final MatchEntity match;
  final List<MatchEntity> matches;
  final VoidCallback? onTap;
  final ValueChanged<MatchEntity>? onSelect;

  @override
  State<VrMatchSelectWidget> createState() => _VrMatchSelectWidgetState();
}

class _VrMatchSelectWidgetState extends State<VrMatchSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 头部区域 + padding
            SizedBox(
              height: 200.h + Get.mediaQuery.padding.top,
            ),
            Expanded(
              child: Container(
                /// 最小高度单个item的高度
                color: Get.theme.matchSelectBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5.h),
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: ImageView(
                          VrSportDetailState.expandsIcon,
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                    ),
                    Container(
                      color: Get.theme.matchSelectBackgroundColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 15.w),
                      child: Row(
                        children: [
                          Text(
                            widget.match.tn,
                            style: TextStyle(
                              color: !Get.isDarkMode
                                  ? Get.theme.matchSelectTitleColor
                                  : Colors.white,
                              fontSize: isIPad ? 20.sp : 16.sp,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "(${widget.matches.length})",
                            style: TextStyle(
                              color: !Get.isDarkMode
                                  ? Get.theme.matchSelectTitleColor
                                  : Colors.white,
                              fontSize: isIPad ? 20.sp : 16.sp,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.matches.length,
                        shrinkWrap: true,
                        //列表项构造器
                        itemBuilder: (BuildContext context, int index) {
                          return VrMatchSelectWidgetCell(
                            match: widget.matches[index],
                            index: index,
                            onSelect: widget.onSelect,
                          );
                        },
                        //分割器构造器
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Get.theme.betPanelUnderlineColor,
                            height: 0.5,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
