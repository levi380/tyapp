import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/ZrItemInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/road_type_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/text_circle.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/text_row.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/zr_record_stateless.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-路纸列表布局】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人列表-路纸列表布局
    】】】
 *
 */
class ZrPageLuZhi extends StatelessWidget {
  late BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return GetBuilder<ZrController>(builder: (logic) {
      List<ZrItemInfo> list = logic.state.processList;
      return Container(
        color:
            context.isDarkMode ? Colors.transparent : ZrState.bgColorLight,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return itemWidget(context, index, logic, list);
          },
          itemCount: list.length,
        ),
      );
    });
  }

  Widget itemWidget(
      BuildContext context, int index, logic, List<ZrItemInfo> list) {
    ZrItemInfo info = list[index];
    ZrListEntity bean = info.originData!;
    var xianhong = "";
    // var xianhong = "限红:${bean.tableLimitMin??''}～${bean.tableLimitMax??''}";

    int all = 0;
    if (bean.bootReport != null) {
      all = bean.bootReport!.totalCount;
    }
    return InkWell(
        onTap: () {
          final zrController = Get.find<ZrController>();
          zrController.toGame(bean.tableId);
        },
        child: Container(
          height: ZrState.listItemExtent150,
          margin: EdgeInsets.symmetric(horizontal: ZrState.space5),
          child: Container(
            decoration: BoxDecoration(
                color: context.isDarkMode
                    ? ZrState.cardBgDarkAlpha04
                    : Colors.white,
                borderRadius: BorderRadius.circular(ZrState.radius8)),
            margin: EdgeInsets.all(ZrState.space5),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? ZrState.cardBgDarkAlpha04
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(ZrState.radius8)),
                padding: EdgeInsets.all(ZrState.space4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      info.tableName ?? '',
                      style: TextStyle(
                          fontSize:  12.sp,
                          color: context.isDarkMode
                              ? ZrState.whiteAlpha09
                              : const Color(0xff303442).withValues(alpha:0.8)),
                    ),
                    Text(
                      xianhong,
                      style: TextStyle(
                          fontSize:  10.sp,
                          color: const Color(0xff303442).withValues(alpha:0.8)),
                    ),
                    RoadTypeWidget(
                      roadPaperTypeImg: info.roadPaperTypeImg,
                      height: 12.w,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///路纸控件
                          SizedBox(
                              height: 90.w,
                              child: ZrRecordLess(
                                bean: bean,
                                blockSize: 14.5,
                                mRoadList: info.mRoadList ?? [],
                              )),
                          Container(
                            color: mContext.isDarkMode
                                ? ZrState.cardBgDarkAlpha04
                                : Colors.transparent,
                            padding: EdgeInsets.only(
                                left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///显示局数布局
                                TextRow(
                                    color: context.isDarkMode
                                        ? Colors.white.withValues(alpha:0.9)
                                        : const Color(0xff303442),
                                    text: LocaleKeys
                                        .zr_cp_Lottery_Bet_Slips_number_games
                                        .tr,
                                    count: all),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ///显示庄闲和数量布局
                                TextCircle(
                                    color: const Color(0xFFF75042),
                                    tag: LocaleKeys
                                        .zr_cp_footer_menu_zr_zrtext_4_contents6
                                        .tr,
                                    count: info.zhuangNum),
                                SizedBox(
                                  width: 10.w,
                                ),
                                TextCircle(
                                    color: const Color(0xFF1277F6),
                                    tag: LocaleKeys
                                        .zr_cp_footer_menu_zr_zrtext_4_contents4
                                        .tr,
                                    count: info.xianduiNum),
                                SizedBox(
                                  width: 10.w,
                                ),
                                TextCircle(
                                    color: const Color(0xFF05B662),
                                    tag: LocaleKeys
                                        .zr_cp_footer_menu_zr_zrtext_4_contents9
                                        .tr,
                                    count: info.heNum),
                                SizedBox(
                                  width: 10.w,
                                ),
                                TextRow(
                                    color: const Color(0xffE53935),
                                    text: LocaleKeys
                                        .zr_cp_footer_menu_zr_zrtext_4_contents13
                                        .tr,
                                    count: info.zhuangduiNum),
                                SizedBox(
                                  width: 10.w,
                                ),
                                TextRow(
                                    color: const Color(0xff1E88E5),
                                    text: LocaleKeys
                                        .zr_cp_footer_menu_zr_zrtext_4_contents11
                                        .tr,
                                    count: info.xianduiNum),
                                const Spacer(),
                                ///在线人数
                                Container(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: ImageView(
                                      ZrState.luzhiOnlinePeopleIcon,
                                      width: 12.w,
                                      height: 12.w,
                                      color: mContext.isDarkMode
                                          ? ZrState.whiteAlpha09
                                          : Colors.grey,
                                    )),
                                Text(
                                  bean.tableOnline.onlineNumber,
                                  style: TextStyle(
                                      fontSize:  10.sp,
                                      color: context.isDarkMode
                                          ? ZrState.whiteAlpha09
                                          : const Color(0xff303442)
                                              .withValues(alpha:0.8)),
                                ),
                              ],
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
