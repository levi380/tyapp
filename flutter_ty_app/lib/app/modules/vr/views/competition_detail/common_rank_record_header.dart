import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';
import '../../vr_sport_state.dart';



const int _flex1 = 124;
const int _flex2 = 79;
const int _flex3 = 79;
const int _flex4 = 79;

class CommonRankRecordHeader extends StatelessWidget {
  const CommonRankRecordHeader({
    super.key,
  });

  Widget _buildCenterCell(
    String text, {
    required int flex,
    required double fontSize,
    required Color color,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: _flex1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Text(
              '球队',
              style: TextStyle(
                fontSize: 10.sp,
                color: '#949AB6'.hexColor,
              ),
            ),
          ),
        ),
        _buildCenterCell('比赛',
            flex: _flex2, fontSize: 10.sp, color: '#949AB6'.hexColor),
        _buildCenterCell('胜/平/负',
            flex: _flex3, fontSize: 10.sp, color: '#949AB6'.hexColor),
        _buildCenterCell('积分',
            flex: _flex4, fontSize: 10.sp, color: '#949AB6'.hexColor),
      ],
    );
  }
}

class CommonRankRecordItem extends StatelessWidget {
  const CommonRankRecordItem({
    super.key,
    required this.index,
    required this.name,
    this.top3UseImg = true,
  });

  final int index;
  final String name;
  final bool top3UseImg;

  Widget _buildItemCenterCell(
    String text, {
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: '#303442'.hexColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topThreeRankImg = [
      VRSportState.betRecordBadgeSvg(1),
      VRSportState.betRecordBadgeSvg(2),
      VRSportState.betRecordBadgeSvg(3),
    ];
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.isDarkMode
                ? AppColor.dividerColorDark
                : AppColor.dividerColorLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: _flex1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  if (top3UseImg && index < 3)
                    ImageView(
                      topThreeRankImg[index],
                      width: 20,
                      height: 20,
                    )
                  else
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: '#303442'.hexColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: '#303442'.hexColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildItemCenterCell('25', flex: _flex2),
          _buildItemCenterCell('5/5/6', flex: _flex3),
          _buildItemCenterCell('25', flex: _flex4),
        ],
      ),
    );
  }
}
