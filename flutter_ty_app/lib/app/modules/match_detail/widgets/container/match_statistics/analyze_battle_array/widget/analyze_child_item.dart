import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/battle_array_controller.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../../login/login_head_import.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事联系人信息
    】】】
 *
 */
class AnalyzeChildItem extends StatelessWidget {
  AnalyzeChildItem(this.entity, {super.key, required this.controller,this.showNumber=true});

  final Up entity;
  final bool?  showNumber;
  final BattleArrayController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: 116.w,
      height: 106.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          border: Border.all(color: MatchStatisticMatchHistoryState.commonBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Color(0xFFF2F2F6),
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: MatchStatisticMatchHistoryState.commonBackgroundGrayColor,
              borderRadius: BorderRadius.all(Radius.circular(50.w)),
            ),
            child: entity.thirdPlayerPicUrl?.isEmpty == true
                ? Icon(
                    Icons.person,
                    size: 35.w,
                  )
                : ClipOval(
                    child: Container(
                      child: ImageView(
                        boxFit: BoxFit.fill,
                        (entity.thirdPlayerPicUrl ?? ""),
                        errorWidget: Icon(
                          Icons.person,
                          size: 35.w,
                        ),
                        width: 40.w,
                        height: 40.w,
                        cornerRadius: 40.w,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 6.w,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              entity.thirdPlayerName ?? entity.playerName ?? "",

              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Get.theme.tabPanelSelectedColor,
                fontSize: isIPad ? 15.sp : 11.sp,
              ),
            ),
          ),
          SizedBox(
            height: 8.w,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(showNumber==true)
              Container(
                alignment: Alignment.center,
                child: Text(
                  " ${entity.shirtNumber ?? "-"} ",
                  style: TextStyle(
                      color: controller.state.tabController?.index == 0
                          ? Get.theme.secondTabPanelSelectedFontColor
                          : MatchStatisticMatchHistoryState.battleArrayChildItemTextColor,
                      fontSize: isIPad ? 15.sp : 11.sp,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  entity.positionName ?? "",
                  style: TextStyle(
                      color: Get.theme.tabPanelSelectedColor,
                      fontSize: isIPad ? 15.sp : 11.sp),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
