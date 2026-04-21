import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/controllers/match_winner_controller.dart';
import 'package:filbet/src/activity/views/match_betting_content_list.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///中奖名单
class MatchWinnerHistory extends GetView<MatchWinnerController> {
  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.bg1,
        title: '中奖名单',
      ),
      body: Column(
        children: [_line(), Expanded(child: _buildListView())],
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      child: ListView.builder(
          itemCount: controller.noticeList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(index);
          }),
    );
  }

  Widget _buildListItem(int index) {
    var showResult = controller.noticeList[index];
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Text(
              "恭喜 ${showResult.username} 抽中     运势如虹:${showResult.winAmount}元礼金",
              style: TextStyle(color: Color(0xff656565), fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          _line()
        ],
      ),
    );
  }

  Widget _line() {
    return Image.asset(Assets.activityMatchWinnerLine);
  }
}
