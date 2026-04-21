import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/activity/views/match_progressbar.dart';
import 'package:filbet/src/activity/views/match_submit_dialog.dart';
import 'package:filbet/src/activity/views/match_submit_success.dart';
import 'package:filbet/src/activity/views/vertical_marquee.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//竞猜页
class MatchBettingContentList extends StatefulWidget {
  final MatchBettingController controller = Get.find<MatchBettingController>();

  PageRiddleConfigBean? pageRiddleConfigBean;
  String? ty;
  String? id;

  MatchBettingContentList(
      {super.key,
      required this.pageRiddleConfigBean,
      required this.ty,
      required this.id});

  @override
  State<StatefulWidget> createState() {
    return MatchBettingContentListState();
  }
}

class MatchBettingContentListState extends State<MatchBettingContentList> {
  var showResultBtn = 1; // 1 启用 2 不启用

  List<PageRiddleConfigGroupBean> pageRiddleConfigGroupList = [];
  List<String> showResultStr = [];

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var group = widget.pageRiddleConfigBean?.group;
    if (group != null && group.isNotEmpty) {
      pageRiddleConfigGroupList.clear();
      for (var entry in group.entries) {
        pageRiddleConfigGroupList
            .add(PageRiddleConfigGroupBean.fromJson(entry.value));
      }

      PageRiddleConfigGroupBean pageRiddleConfigGroupBean =
          pageRiddleConfigGroupList[widget.controller.tabIndex.value];
      List<ShowResult> showResult = pageRiddleConfigGroupBean.showResult ?? [];
      showResultBtn = pageRiddleConfigGroupBean.showResultBtn ?? 1;

      showResultStr.clear();
      for (int i = 0; i < showResult.length; i++) {
        showResultStr.add(
            "${showResult[i].username}竞彩${pageRiddleConfigGroupBean.leagueName}${pageRiddleConfigGroupBean.mainTeamName}VS ${pageRiddleConfigGroupBean.visitingTeamName}成功瓜分${pageRiddleConfigGroupBean.showResultAmount} 元奖池彩金");
      }
    }
    //该页面是否显示 1 显示 2 不显示，页面显示中
    pageRiddleConfigGroupList =
        pageRiddleConfigGroupList.where((a) => a.active == 1).toList();

    // 置顶 1 置顶 2不置顶
    var pinTop = widget.pageRiddleConfigBean?.pinTop ?? 2;
    return Column(
      children: [
        if (widget.pageRiddleConfigBean?.group?.isNotEmpty == true ||
            widget.pageRiddleConfigBean?.appContentImg?.isNotEmpty == true)
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(left: 11.w, right: 11.w, top: 15.w),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
            child: Column(
              children: [
                if (pinTop == 1) UIStylePinTop1() else UIStylePinTop2(),
              ],
            ),
          ),
        Container(
          width: 1.sw,
          margin:
              EdgeInsets.only(left: 11.w, right: 11.w, top: 15.w, bottom: 38.h),
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
          child: Column(
            children: [_buildRule()],
          ),
        ),
      ],
    );
  }

  Widget UIStylePinTop1() {
    return Column(
      children: [
        if (pageRiddleConfigGroupList.length > 1) _buildBetTab(),
        _buildMatchList(),
        _buildBanner(),
        _buildBetHistoryNotice(),
      ],
    );
  }

  Widget UIStylePinTop2() {
    return Column(
      children: [
        _buildBanner(),
        _buildBetHistoryNotice(),
        if (pageRiddleConfigGroupList.length > 1) _buildBetTab(),
        _buildMatchList(),
      ],
    );
  }

  ///banner区域
  Widget _buildBanner() {
    var appContentImg = widget.pageRiddleConfigBean?.appContentImg ?? "";
    return appContentImg.isNotEmpty
        ? SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Image.network(
                staticImageResolver(appContentImg),
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        : SizedBox();
  }

  ///竞猜记录公告
  Widget _buildBetHistoryNotice() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20.w, bottom: 10.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                PageRiddleConfigGroupBean item =
                    pageRiddleConfigGroupList[widget.controller.tabIndex.value];

                var gameTime = item.gameTime ?? 0;

                var mainTeamName = item.mainTeamName ?? "";
                var visitingTeamName = item.visitingTeamName ?? "";

                Get.toNamed(Routes.MATCH_BETTING_HIS, arguments: {
                  "id": widget.id ?? "",
                  "gameTime": gameTime,
                  "mainTeamName": mainTeamName,
                  "visitingTeamName": visitingTeamName
                });

                ///竞猜提交成功弹窗
                // Get.dialog(MatchSubmitSuccessDialog());
              },
              child: Container(
                height: 24.w,
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(color: Color(0xff4C96FF), width: 1.w)),
                child: Text(
                  "竞猜记录",
                  style: TextStyle(
                      color: Color(0xff4C96FF),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            if (showResultBtn == 1 && showResultStr.isNotEmpty)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.MATCH_WINER_HIS,
                        arguments: pageRiddleConfigGroupList[
                                    widget.controller.tabIndex.value]
                                .showResult ??
                            []);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: VerticalMarquee(
                      data: showResultStr,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///竞猜tab
  Widget _buildBetTab() {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 每行3列
            mainAxisSpacing: 10.w, // 主轴方向间距（上下）
            crossAxisSpacing: 10.w, // 交叉轴方向间距（左右）
            childAspectRatio: 100 / 32, // 宽高比 (宽 / 高)
          ),
          itemCount: pageRiddleConfigGroupList.length,
          itemBuilder: (context, index) {
            PageRiddleConfigGroupBean item = pageRiddleConfigGroupList[index];
            return GestureDetector(
              child: Obx(() {
                bool isSel = widget.controller.tabIndex.value == index;
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEEEEEE), width: 1.w),
                      color: isSel ? Color(0xff4C96FF) : Colors.white,
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Text(
                    item.appTitle ?? "",
                    style: TextStyle(
                        color: isSel ? Colors.white : Color(0xff4C96FF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                );
              }),
              onTap: () {
                setState(() {
                  widget.controller.tabIndex.value = index;
                });
              },
            );
          }),
    );
  }

  ///赛事竞猜列表
  Widget _buildMatchList() {
    if (pageRiddleConfigGroupList.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 15.w),
        width: 1.sw,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(color: Color(0xffEEEEEE), width: 1.w)),
        child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var item =
                  pageRiddleConfigGroupList[widget.controller.tabIndex.value];
              return _buildRiddleConfig(widget.controller.tabIndex.value, item);
            }),
      );
    } else {
      return Text("");
    }
  }

  Widget _buildRiddleConfig(int index, PageRiddleConfigGroupBean item) {
    var gameArea = item.gameArea;
    var groupId = item.groupId ?? 1;
    if (gameArea != null && gameArea.isNotEmpty) {
      List<GameArea1Bean> gameArea1Bean = [];
      gameArea1Bean.clear();
      for (var entry in gameArea.entries) {
        gameArea1Bean.add(GameArea1Bean.fromJson(entry.value));
      }

      int expiredAt = item.submissionDeadline ?? 0;
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      String appendTime = "";
      if (expiredAt - timestamp > 0) {
        Duration diff = DateTime.fromMillisecondsSinceEpoch(expiredAt)
            .difference(DateTime.fromMillisecondsSinceEpoch(timestamp));

        final days = diff.inDays;
        final hours = diff.inHours % 24;
        final minutes = diff.inMinutes % 60;
        final inSeconds = diff.inSeconds % 60;
        appendTime =
            '提交倒计时：${days}${"day".tr}${hours < 10 ? "0$hours" : hours}时${minutes < 10 ? "0$minutes" : minutes}分${inSeconds < 10 ? "0$inSeconds" : inSeconds}秒';
      }
      return Column(
        children: [
          SizedBox(height: 15.h),
          Text(
            item.leagueName ?? "",
            style: TextStyle(
              color: Color(0xff4C96FF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.w, bottom: 5.w),
            child: Text(
              formatTimestampToTime02(item.gameTime ?? 0),
              style: TextStyle(
                color: Color(0xff6C6C89),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                _teamInfo(item.mainTeamName ?? "", item.mainTeamIcon ?? ""),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 10.w),
                  child: Column(
                    children: [
                      Text(
                        "VS",
                        style: TextStyle(
                            color: Color(0xff6C6C89),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      if (appendTime.isNotEmpty)
                        Text(
                          appendTime,
                          style: TextStyle(
                              color: Color(0xffDB6372),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      if (widget.controller.isSubmit.value)
                        Center(
                          child: Text(
                            "提交完成，赛事结束48小时内，\n可于[竞猜记录]查询",
                            style: TextStyle(
                                color: Color(0xffDB6372),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                    ],
                  ),
                )),
                _teamInfo(
                    item.visitingTeamName ?? "", item.visitingTeamIcon ?? "")
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.w),
            child: MatchProgressBar(
              progress: 0.5,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.w),
            child: Text(
              "本场奖池礼金",
              style: TextStyle(
                  color: Color(0xff1D1D1F),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w),
            width: 134.w,
            height: 16.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xffF8F8FF),
                borderRadius: BorderRadius.circular(8.w)),
            child: Text(
              item.bounsPool ?? "",
              style: TextStyle(
                  color: Color(0xff1D1D1F),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ListView.builder(
              itemCount: gameArea1Bean.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(
                    index, groupId, gameArea1Bean[index], item);
              })
        ],
      );
    } else {
      return Text("");
    }
  }

  Widget _buildListItem(int index, int groupId, GameArea1Bean gameArea1Bean,
      PageRiddleConfigGroupBean pageRiddleConfigGroupBean) {
    var choice = gameArea1Bean.choice;
    var pageNum_groupId_areaId =
        "${widget.pageRiddleConfigBean?.pageNum ?? 1}-$groupId-${gameArea1Bean.areaId}";
    if (choice != null && choice.isNotEmpty) {
      List<String> choiceList = [];
      choiceList.clear();
      for (var entry in choice.entries) {
        choiceList.add(entry.value);
      }

      var list = widget.controller.riddleList
          .where((a) => a.activeId == pageNum_groupId_areaId)
          .toList();
      var activeId = "";
      var submitResult = "";
      if (list.isNotEmpty) {
        activeId = list.first.activeId ?? "";
        submitResult = list.first.submitResult ?? "";
      }
      widget.controller.isSubmit.value = activeId.isNotEmpty;

      var color = Color(0xff12D775);
      switch (index) {
        case 0:
          color = Color(0xff4C96FF);
          break;
        case 1:
          color = Color(0xff12D775);
          break;
        case 2:
          color = Color(0xffDB6372);
          break;
      }

      return Container(
        margin: EdgeInsets.only(top: 20.w),
        child: Column(
          children: [
            Text(
              gameArea1Bean.title ?? "",
              style: TextStyle(
                  color: color, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.w,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行3列
                  mainAxisSpacing: 10.w, // 主轴方向间距（上下）
                  crossAxisSpacing: 10.w, // 交叉轴方向间距（左右）
                  childAspectRatio: 89 / 30, // 宽高比 (宽 / 高)
                ),
                itemCount: choiceList.length,
                itemBuilder: (context, index) {
                  var endsWith = submitResult.endsWith(choiceList[index]);
                  bool isSel = activeId.isNotEmpty && endsWith;
                  return GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isSel
                                  ? color
                                  : Color(
                                      0xffEEEEEE,
                                    ),
                              width: 1.w),
                          color: isSel ? color : Colors.white,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Text(
                        choiceList[index],
                        style: TextStyle(
                            color: isSel ? Colors.white : Color(0xff6C6C89),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () async {
                      final isSuccess = await Get.bottomSheet(MatchSubmitDialog(
                        gameArea1Bean: gameArea1Bean,
                        pageRiddleConfigGroupBean: pageRiddleConfigGroupBean,
                        pageRiddleConfigBean: widget.pageRiddleConfigBean,
                        ty: widget.ty,
                        id: widget.id,
                        choiceStr: choiceList[index],
                      ));
                      widget.controller.promoReportList();

                      if (isSuccess) {
                        Get.dialog(MatchSubmitSuccessDialog(
                          gameArea1Bean: gameArea1Bean,
                          pageRiddleConfigGroupBean: pageRiddleConfigGroupBean,
                          pageRiddleConfigBean: widget.pageRiddleConfigBean,
                          choiceStr: choiceList[index],
                        ));
                      }
                    },
                  );
                })
          ],
        ),
      );
    } else {
      return Text("");
    }
  }

  Widget _teamInfo(String teamName, String imgUrl) {
    return Column(
      children: [
        SizedBox(
          width: 30.w,
          height: 30.w,
          child: SKNetworkImage(
            radius: BorderRadius.all(Radius.circular(15.h)),
            fit: BoxFit.cover,
            imageUrl: imgUrl,
            placeholderType: 2,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.w),
          child: Text(
            teamName,
            style: TextStyle(
                color: Color(0xff6C6C89),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  ///活动规则
  Widget _buildRule() {
    return Container(
      padding:
          EdgeInsets.only(left: 11.w, right: 11.w, top: 14.h, bottom: 38.h),
      margin: EdgeInsets.only(left: 11.w, right: 11.w, top: 14.w, bottom: 38.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.w)),
      width: 1.sw,
      child: Column(
        children: [
          Text(
            "活动规则",
            style: TextStyle(
                color: Color(0xff1D1D1F),
                fontSize: 20.w,
                fontWeight: FontWeight.w500),
          ),
          Html(
            shrinkWrap: true,
            data: widget.pageRiddleConfigBean?.webSummary ?? '',
            onLinkTap: (
              String? url,
              Map<String, String> attributes,
              element,
            ) {},
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }
}
