import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_navigator.dart';
import 'package:filbet/services/global/global_service.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///竞猜活动提交成功弹窗
class MatchSubmitSuccessDialog extends StatelessWidget {
  PageRiddleConfigBean? pageRiddleConfigBean;
  GameArea1Bean? gameArea1Bean;
  PageRiddleConfigGroupBean? pageRiddleConfigGroupBean;
  String? choiceStr;

  MatchSubmitSuccessDialog({
    super.key,
    this.gameArea1Bean,
    required this.pageRiddleConfigGroupBean,
    required this.pageRiddleConfigBean,
    required this.choiceStr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.w),
                child: Text(
                  "竞猜提交完成",
                  style: TextStyle(color: Color(0xff1D1D1F), fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.w),
                child: Text(
                  pageRiddleConfigGroupBean?.leagueName ?? "",
                  style: TextStyle(color: Color(0xff1D1D1F), fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                formatTimestampToTime02(pageRiddleConfigGroupBean?.gameTime ?? 0),
                style: TextStyle(color: Color(0xff1D1D1F), fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Expanded(
                      child: _teamInfo(pageRiddleConfigGroupBean?.mainTeamName ?? "",
                          pageRiddleConfigGroupBean?.mainTeamIcon ?? "")),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            gameArea1Bean?.title ?? "",
                            style: TextStyle(color: Color(0xff4C96FF), fontSize: 14.w, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: Text(
                            choiceStr ?? "",
                            style: TextStyle(color: Color(0xff4C96FF), fontSize: 14.w, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: _teamInfo(pageRiddleConfigGroupBean?.visitingTeamName ?? "",
                          pageRiddleConfigGroupBean?.visitingTeamIcon ?? ""))
                ],
              ),
              Container(
                width: 1.sw,
                height: 1.w,
                margin: EdgeInsets.only(top: 20.w),
                color: Color(0xffeeeeee),
              ),
              Row(
                children: [
                  Expanded(
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            height: 38.w,
                            alignment: Alignment.center,
                            width: 110.w,
                            child: Text(
                              "完成",
                              style: TextStyle(color: Color(0xff1D1D1F), fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                          onPressed: () {
                            ///提交
                            Get.back();
                          })),
                  Container(
                    width: 1.w,
                    height: 40.w,
                    color: Color(0xffeeeeee),
                  ),
                  Expanded(
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: 38.w,
                          alignment: Alignment.center,
                          width: 110.w,
                          child: Text(
                            "进入投注",
                            style: TextStyle(color: Color(0xff4C96FF), fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                          var gameType = pageRiddleConfigGroupBean?.gameType ?? "";
                          var platformId = pageRiddleConfigGroupBean?.platformId ?? "";
                          var gameId = pageRiddleConfigGroupBean?.gameId ?? "";
                          if (gameType.isNotEmpty && platformId.isNotEmpty && gameId.isNotEmpty) {
                            AppNavigator.gotoGame(
                                platformId ?? "", gameId ?? "", "", CategoryType.fromId(int.parse(gameType))!);
                          }
                        }),
                  ),
                ],
              )
            ],
          ),
        )
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
              style: TextStyle(color: Color(0xff6C6C89), fontSize: 10.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
