import 'dart:ffi';

import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/services/user/user_service.dart';
import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/src/dialog/sk_base_dialog.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/base_util.dart';
import 'package:filbet/utils/event_bus.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MatchContestConfigList extends StatefulWidget {
  final MatchBettingController controller = Get.find<MatchBettingController>();

  PageContestConfig? pageContestConfig;
  String? ty;
  String? id;

  MatchContestConfigList(
      {super.key,
      required this.pageContestConfig,
      required this.ty,
      required this.id});

  @override
  State<StatefulWidget> createState() {
    return MatchContestConfigListState();
  }
}

class MatchContestConfigListState extends State<MatchContestConfigList> {
  var applyRecordBtn = 2;

  List<PageContestConfigGroup> pageContestConfigGroup = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tempList = widget.pageContestConfig?.group ?? [];
    //该页面是否显示 1 显示 2 不显示，页面显示中
    var list = tempList.where((a) => a.active == 1).toList();
    pageContestConfigGroup = list;

    // 置顶 1 置顶 2不置顶
    var pinTop = widget.pageContestConfig?.pinTop ?? 2;
    //1 显示 2 不显示
    applyRecordBtn = widget.pageContestConfig?.applyRecordBtn ?? 2;
    return Column(
      children: [
        if (widget.pageContestConfig?.group?.isNotEmpty == true ||
            widget.pageContestConfig?.appContentImg?.isNotEmpty == true)
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(left: 11.w, right: 11.w, top: 15.w),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
            child: Column(
              children: [
                if (pinTop == 1) UIStylePinTop1() else UIStylePinTop2()
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
            children: [
              _buildRule(),
            ],
          ),
        ),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
          child: Column(
            children: [
              _bottomApply(),
            ],
          ),
        ),
      ],
    );
  }

  Widget UIStylePinTop1() {
    return Column(
      children: [
        if (pageContestConfigGroup.length > 1) _buildBetTab(),
        _buildMatchList(),
        _buildBanner(),
        // _buildBetHistoryNotice(),
      ],
    );
  }

  Widget UIStylePinTop2() {
    return Column(
      children: [
        _buildBanner(),
        // _buildBetHistoryNotice(),
        if (pageContestConfigGroup.length > 1) _buildBetTab(),
        _buildMatchList(),
      ],
    );
  }

  ///banner区域
  Widget _buildBanner() {
    var appContentImg = widget.pageContestConfig?.appContentImg ?? "";
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
            // Container(
            //   height: 24.w,
            //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5.w), border: Border.all(color: Color(0xff4C96FF), width: 1.w)),
            //   child: Text(
            //     "竞猜记录",
            //     style: TextStyle(color: Color(0xff4C96FF), fontSize: 10.sp, fontWeight: FontWeight.w400),
            //   ),
            // ),
            // Expanded(
            //     child: Container(
            //   margin: EdgeInsets.only(left: 10.w),
            //   child: Text(
            //     "y***vfd竞猜意甲第32轮联赛拿玻里VSAC米",
            //     maxLines: 1,
            //     style: TextStyle(color: Color(0xff6C6C89), fontSize: 12.sp, fontWeight: FontWeight.w400),
            //   ),
            // ))
          ],
        ),
      ),
      onTap: () {
        var gameTime =
            pageContestConfigGroup[widget.controller.tabIndex.value].gameTime ??
                0;
        var mainTeamName =
            pageContestConfigGroup[widget.controller.tabIndex.value]
                    .mainTeamName ??
                "";
        var visitingTeamName =
            pageContestConfigGroup[widget.controller.tabIndex.value]
                    .visitingTeamName ??
                "";

        Get.toNamed(Routes.MATCH_BETTING_HIS, arguments: {
          "id": widget.id ?? "",
          "gameTime": gameTime,
          "mainTeamName": mainTeamName,
          "visitingTeamName": visitingTeamName
        });

        ///中奖名单
        // Get.toNamed(Routes.MATCH_WINER_HIS);

        ///竞猜提交成功弹窗
        // Get.dialog(MatchSubmitSuccessDialog());
      },
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
          itemCount: pageContestConfigGroup.length,
          itemBuilder: (context, index) {
            PageContestConfigGroup item = pageContestConfigGroup[index];
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
                    item.contestInfo ?? "",
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
    if (pageContestConfigGroup.isNotEmpty) {
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
                  pageContestConfigGroup[widget.controller.tabIndex.value];
              return _buildRiddleConfig(index, item);
            }),
      );
    } else {
      return Text("");
    }
  }

  Widget _buildRiddleConfig(int index, PageContestConfigGroup item) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Text(
          item.leagueName ?? "",
          style: TextStyle(
            color: appnewColors.textBlue,
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
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        var gameType = item.gameType ?? "";
                        var platformId = item.platformId ?? "";
                        var gameId = item.gameId ?? "";
                        if (gameType.isNotEmpty &&
                            platformId.isNotEmpty &&
                            gameId.isNotEmpty) {
                          AppNavigator.gotoGame(
                              item.platformId ?? "",
                              item.gameId ?? "",
                              item.leagueName ?? "",
                              CategoryType.fromId(int.parse(gameType))!);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: appnewColors.textBlue,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "进入投注",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
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
      ],
    );
  }

  Widget _teamInfo(String teamName, String imgUrl) {
    return Container(
      child: Column(
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
      ),
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
            data: widget.pageContestConfig?.webSummary ?? '',
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

  Widget _bottomApply() {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 24.h),
      width: double.infinity,
      child: Row(
        children: [
          if (widget.pageContestConfig?.applyEnter == 1 && applyRecordBtn == 1)
            Expanded(
              child: InkWell(
                  onTap: () {
                    // todo 申请记录为空是 不显示弹窗
                    widget.controller.clickApplyRecord();
                  },
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: appnewColors.bgBlue, // ✅ 边框切换
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "申请记录",
                        style: TextStyle(
                            color: appnewColors.textBlue,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
            ),
          if (applyRecordBtn == 1)
            SizedBox(
              width: 15.w,
            ),
          // 会员申请入口 1启用 2不启用，启用会员申请
          if (widget.pageContestConfig?.applyEnter == 1)
            Expanded(
              child: InkWell(
                onTap: () async {
                  if (UserService.to.state.isVisitor) {
                    EventBus.emit(EventType.goToLogin);
                  } else {
                    var contestActiveId =
                        "${widget.pageContestConfig?.pageNum}";
                    var isSuccess = await widget.controller.promoApply(
                        widget.id ?? "",
                        widget.ty ?? "",
                        contestActiveId,
                        2,
                        "");
                    if (isSuccess) {
                      widget.controller.promoReportList();
                      Get.bottomSheet(Container(
                        width: double.infinity,
                        height: 205.h,
                        decoration: BoxDecoration(
                          color: appnewColors.bg1,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.r)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 20.h),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        "温馨提示",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff11183C)),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10.r,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          Get.back();
                                        },
                                        child: Image.asset(Assets.mineIconCloes,
                                            fit: BoxFit.fill,
                                            width: 20.r,
                                            height: 20.r),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              "申请成功",
                              style: TextStyle(
                                  color: appnewColors.text1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            )),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 44.h,
                                margin: EdgeInsets.only(
                                    left: 16.w, right: 16.w, bottom: 36.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r)),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft, // 渐变起点
                                    end: Alignment.centerRight, // 渐变终点
                                    colors: [
                                      Color(0xff78AFFF),
                                      Color(0xff4C96FF),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "确定",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    }
                  }
                },
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: appnewColors.bgBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      "立即申请",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
