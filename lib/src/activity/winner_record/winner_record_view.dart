import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/src/activity/winner_record/winner_record_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/dashed_line.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/custom_scffold.dart';

class WinnerRecordView extends GetView<WinnerRecordController> {
  const WinnerRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        title: '中奖名单',
        bgColor: appnewColors.bg1,
      ),
      body: SafeArea(
        child: dataView(),
      ),
    );
  }

  Widget dataView() {
    return Column(
      children: [
        DashedLine(color: Color(0xFFE1DDDC), dashWidth: 2.r, dashSpace: 2.r),
        Expanded(child: dataListView()),
      ],
    );
  }

  Widget dataListView() {
    return Obx(() {
      return ListView.separated(
        itemBuilder: (context, index) {
          var model = controller.winnerRecord[index];
          return dataItemView(model);
        },
        itemCount: controller.winnerRecord.length,
        separatorBuilder: (BuildContext context, int index) {
          return DashedLine(
            color: Color(0xFFE1DDDC),
            dashWidth: 2.r,
            dashSpace: 2.r,
          );
        },
      );
    });
  }

  Widget dataItemView(WinnerRecord model) {
    return Container(
      height: 52.r,
      padding: EdgeInsets.only(left: 30.r),
      child: Row(
        spacing: 25.r,
        children: [
          Text(
            _formatWinnerName(model),
            style: TextStyle(
              color: Color(0xFF656565),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              _formatWinnerGift(model),
              style: TextStyle(
                color: Color(0xFF656565),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatWinnerName(WinnerRecord record) {
    // 格式化用户名（隐藏中间部分）
    String username = record.username ?? '';
    String displayName = username;
    if (username.length > 4) {
      displayName =
          '${username.substring(0, 2)}****${username.substring(username.length - 2)}';
    }
    return '恭喜$displayName抽中';
  }

  String _formatWinnerGift(WinnerRecord record) {
    // 格式化奖品名称和金额
    String prizeName = record.prizeName ?? '';
    String rewardAmount = record.rewardAmount ?? '0';
    return '$prizeName:$rewardAmount${record.rewardType == 1 ? '元礼金' : ''}';
  }
}
