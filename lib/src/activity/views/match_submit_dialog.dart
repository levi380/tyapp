import 'package:filbet/src/activity/controllers/match_betting_controller.dart';
import 'package:filbet/src/activity/model/config_model.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

///竞猜活动提交弹窗
class MatchSubmitDialog extends StatelessWidget {
  PageRiddleConfigBean? pageRiddleConfigBean;
  GameArea1Bean? gameArea1Bean;
  PageRiddleConfigGroupBean? pageRiddleConfigGroupBean;
  final MatchBettingController controller = Get.find<MatchBettingController>();
  String? ty;
  String? id;
  String? choiceStr;

  MatchSubmitDialog({
    super.key,
    this.gameArea1Bean,
    required this.pageRiddleConfigGroupBean,
    required this.pageRiddleConfigBean,
    required this.ty,
    required this.id,
    required this.choiceStr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 125.w,
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(//league_name
                  pageRiddleConfigGroupBean?.leagueName ?? "",
                  style: TextStyle(color: Color(0xff1D1D1F), fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.w, bottom: 5.w),
                child: Text(
                  formatTimestampToTime02(pageRiddleConfigGroupBean?.gameTime ?? 0),
                  style: TextStyle(color: Color(0xff6C6C89), fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        pageRiddleConfigGroupBean?.mainTeamName ?? "",
                        style: TextStyle(color: Color(0xff4C96FF), fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        "VS",
                        style: TextStyle(color: Color(0xff6C6C89), fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      child: Text(
                        pageRiddleConfigGroupBean?.visitingTeamName ?? "",
                        style: TextStyle(color: Color(0xffDB6372), fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                height: 38.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xff4C96FF), borderRadius: BorderRadius.circular(8.w)),
                width: 110.w,
                child: Text(
                  "提交竞猜",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () async {
                String contestActiveId =
                    "${pageRiddleConfigBean?.pageNum ?? ""}-${pageRiddleConfigGroupBean?.groupId ?? ""}-${gameArea1Bean?.areaId ?? ""}";
                // String contestActiveId = "${pageRiddleConfigBean?.pageNum ?? ""}-${gameArea1Bean?.areaId ?? ""}";

                // String contestResult =
                //     "${pageRiddleConfigGroupBean?.groupId ?? ""}-${gameArea1Bean?.areaId ?? ""}-$choiceStr";
                String contestResult =
                    "$choiceStr";
                final isSuccess = await controller.promoApply(
                  id ?? "",
                  ty ?? "",
                  contestActiveId,
                  1,
                  contestResult,
                );

                if (isSuccess) {
                  Get.back(result: true);
                }
              })
        ],
      ),
    );
  }
}
