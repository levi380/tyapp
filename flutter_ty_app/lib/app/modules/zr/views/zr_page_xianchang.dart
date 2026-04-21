

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/ZrItemInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/road_type_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/xianchan_tag.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/zr_record_stateless.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';
import 'package:flutter_ty_app/main.dart';



import '../widgets/table_online_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-现场列表布局】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人列表-现场列表布局
    】】】
 *
 */
class ZrPageXianchang extends StatelessWidget {
  late BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrController>(builder: (ZrController logic) {
      List<ZrItemInfo> list = logic.state.processList;

      return Container(
        color:
        context.isDarkMode ? Colors.transparent : ZrState.bgColorLight,
        padding: EdgeInsets.only(top: ZrState.space8, left: ZrState.space8, right: ZrState.space8,),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: ZrState.space8,
            crossAxisSpacing: ZrState.space8,
            childAspectRatio: isIPad ? 1.02 : 0.75,
          ),
          itemBuilder: (BuildContext context, int index) {
            ZrItemInfo info = list[index];
            ZrListEntity bean = info.originData!;

            mContext = context;

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
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? ZrState.cardBgDarkAlpha04
                        : Colors.white,
                    borderRadius: BorderRadius.circular(ZrState.radius8,),),
                  child: Column(
                    children: [
                      SizedBox(
                        height: isIPad ? 235.h : 140.h,
                        child: Stack(
                          children: [

                            ///现场图片
                            Stack(
                              children: [
                                ImageView(
                                  bean.dealerPicInstant,
                                  width: double.maxFinite,
                                  boxFit: BoxFit.fitWidth,
                                  cornerRadius: 8,
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: ZrState.space3),
                                      child: RoadTypeWidget(
                                          roadPaperTypeImg:
                                          info.roadPaperTypeImg,
                                          height: 15.w),
                                    )),
                              ],
                            ),


                            Container(
                              margin: EdgeInsets.only(top: 5.h,left: 6.w,right: 6.w),
                              child: Row(
                                children: [
                                  ///台桌名字
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 130.w,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha:0.3),
                                        borderRadius: BorderRadius.circular(ZrState.radius20)),
                                    child:Container(
                                      margin: EdgeInsets.only(left: ZrState.space5,right: ZrState.space5),
                                      child:  Text(
                                        "${info.tableName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'PingFang SC',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black.withValues(alpha:0.3),
                                            borderRadius: BorderRadius.circular(ZrState.radius20)),
                                      child: Container(
                                        margin: EdgeInsets.only(left: ZrState.space3,right: ZrState.space3),
                                        child: TableOnlineWidget(
                                          bean: bean,
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            )


                          ],
                        ),
                      ),
                      Expanded(
                          child: Stack(children: [

                            ///路纸控件
                            ZrRecordLess(
                              bean: bean,
                              mRoadList: info.mRoadList ?? [],
                            ),
                          ])),

                      ///显示庄闲和
                      Container(
                        color: mContext.isDarkMode
                            ? ZrState.cardBgDarkAlpha04
                            : Colors.transparent,
                        padding: EdgeInsets.only(
                          left: ZrState.space4, right: ZrState.space4, top: 1.w, bottom: 1.w,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            XianChangTag(
                                img: ZrState.xianchangTongjiIcon,
                                text: all),
                            XianChangTag(
                                img: ZrState.xianchangZhuangIcon,
                                text: info.zhuangNum),
                            XianChangTag(
                                img: ZrState.xianchangXianIcon,
                                text: info.xianNum),
                            XianChangTag(
                                img: ZrState.xianchangHeIcon,
                                text: info.heNum),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
          itemCount: logic.state.processList.length,
        ),
      );
    });
  }
}
