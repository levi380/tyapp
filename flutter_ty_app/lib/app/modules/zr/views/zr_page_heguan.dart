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

import '../../../utils/ty_text_scaler.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-荷官页面】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人列表-荷官页面
    】】】
 *
 */
class ZrPageHeGuan extends StatelessWidget {
  late BuildContext mContext;

  @override
  Widget build(BuildContext context) {
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
            mContext = context;
            return itemWidget(context, index, logic, list);
          },
          itemCount: list.length,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemExtent: ZrState.listItemExtent150,
          cacheExtent: double.maxFinite,
        ),
      );
    });
  }

  Widget itemWidget(BuildContext context, int index, ZrController logic,
      List<ZrItemInfo> list) {
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
          margin: EdgeInsets.symmetric(horizontal: ZrState.space8),
          child: Stack(children: [
            Container(
              height: ZrState.listItemExtent150,
              decoration: BoxDecoration(

                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 2, //阴影范围
                //     spreadRadius: 0.1, //阴影浓度
                //     color: Colors.grey.withValues(alpha:0.2), //阴影颜色
                //   ),
                // ],

                  color: context.isDarkMode
                      ? ZrState.cardBgDarkAlpha04
                      : Colors.white,
                  borderRadius: BorderRadius.circular(ZrState.radius8)),
              margin: EdgeInsets.all(ZrState.space5),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(ZrState.space4),
                  decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? ZrState.cardBgDarkAlpha04
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(ZrState.radius8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${info.tableName}",
                        style: TextStyle(
                            fontSize:  12.sp,
                            color: context.isDarkMode
                                ? ZrState.whiteAlpha09
                                : const Color(0xff303442).withValues(alpha:0.8)),
                      ),

                      ///限红
                      Text(
                        xianhong,
                        style: TextStyle(
                            fontSize:  10.sp,
                            color: context.isDarkMode
                                ? ZrState.whiteAlpha09
                                : const Color(0xff303442).withValues(alpha:0.8)),
                      ),
                      const Spacer(),
                      RoadTypeWidget(
                        roadPaperTypeImg: info.roadPaperTypeImg,
                        height: 12.w,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 89.w,
                        height: 120.w,
                        child: Stack(children: [
                          SizedBox(
                              width: 89.w,
                              child: ImageView(
                                  ZrState.heguanDeskBg,
                                  boxFit: BoxFit.cover,
                                  width: 89.w,
                                  height: 120.w)),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ImageView(
                              bean.dealerPic,
                              width: 89.w,
                              height: 120.w,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          bean.dealerCountry == ""
                              ? const SizedBox.shrink()
                              : Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                                width: 19.w,
                                height: 19.w,
                                child: ImageView(info.flagImgSrc ?? '')),
                          )
                        ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: ZrRecordLess(
                                    bean: bean,
                                    blockSize: 14.5,
                                    mRoadList: info.mRoadList ?? [],
                                  )),
                              ///下方数据
                              Container(
                                color: mContext.isDarkMode
                                    ? ZrState.cardBgDarkAlpha04
                                    : Colors.transparent,
                                padding: EdgeInsets.only(
                                    left: 4.w,
                                    right: 4.w,
                                    top: 3.w,
                                    bottom: 2.w),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: Row(
                                    children: [
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
                                    ],
                                  )),
                                  Row(
                                    children: [
                                      ///在线人数
                                      Container(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: ImageView(
                                            context.isDarkMode
                                                ? ZrState.heguanOnlineIconDark
                                                : ZrState.heguanOnlineIconLight,
                                            width: 12.w,
                                            height: 12.w,
                                            color: mContext.isDarkMode
                                                ? ZrState.whiteAlpha09
                                                : const Color(0xff303442),
                                          )),
                                      Text(
                                        bean.tableOnline.onlineNumber,
                                        style: TextStyle(
                                            fontSize:  TyTextScaler.instance().scale(10.sp),
                                            color: mContext.isDarkMode
                                                ? ZrState.whiteAlpha09
                                                : const Color(0xff303442)),
                                      )
                                    ],
                                  )
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 87.w,
                height: 25.w,
                margin: EdgeInsets.only(bottom: 5.w),
                child: Stack(children: [
                  info.gameTypeImg == null
                      ? const SizedBox.shrink()
                      : SizedBox(
                      width: 87.w,
                      height: 25.w,
                      child: ImageView(
                        info.gameTypeImg ?? '',
                        boxFit: BoxFit.fill,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Center(
                      child: Text(
                        bean.dealerName,
                        style: TextStyle(
                          fontSize:  TyTextScaler.instance().scale(9.sp),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            )
          ]),
        ));
  }
}
