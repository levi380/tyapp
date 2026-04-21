import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/ZrItemInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/zr_controller.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/widgets/zr_record_stateless.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_list_entity.dart';

import '../../../../main.dart';
import '../../../utils/ty_text_scaler.dart';
import '../widgets/road_type_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-极简列表布局】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人列表-极简列表布局
    】】】
 *
 */
class ZrPageJiJian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrController>(builder: (logic) {
      List<ZrItemInfo> list = logic.state.processList;
      return Container(
        color:
            context.isDarkMode ? Colors.transparent : ZrState.bgColorLight,
        padding: EdgeInsets.only(left: ZrState.space8, right: ZrState.space8, top: ZrState.space8),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: ZrState.space8,
            crossAxisSpacing: ZrState.space8,
            childAspectRatio: isIPad ? 3.0 : 1.7,
          ),
          itemBuilder: (BuildContext context, int index) {
            ZrItemInfo info = list[index];
            ZrListEntity bean = info.originData!;

            var xianhong = "";
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
                      borderRadius: BorderRadius.circular(ZrState.radius8)),
                  child: Column(
                    children: [
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
                            ///台桌名字
                            Text(
                              info.tableName ?? '',
                              style: TextStyle(
                                  fontSize:  10.sp,
                                  color: context.isDarkMode
                                      ? ZrState.whiteAlpha09
                                      : const Color(0xff303442)
                                          .withValues(alpha:0.8)),
                            ),
                            //限红
                            Text(
                              xianhong,
                              style: TextStyle(
                                fontSize:  TyTextScaler.instance().scale(10.sp),
                                color: const Color(0xff303442).withValues(alpha:0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        var maxHeight = constraints.maxHeight;
                        AppLogger.debug('maxHeight = $maxHeight ');
                        return Stack(children: [
                          ///路纸控件
                          ZrRecordLess(
                            bean: bean,
                            mRoadList: info.mRoadList ?? [],
                          ),
                          Align(
                              alignment: Alignment.bottomRight,

                              ///路纸类型-图片
                              child: Padding(
                                padding: EdgeInsets.only(right: ZrState.space3),
                                child: RoadTypeWidget(
                                    roadPaperTypeImg: info.roadPaperTypeImg,
                                    height: 13.w),
                              )),
                        ]);
                      })),
                      SizedBox(
                        height: 5.w,
                      ),
                    ],
                  ),
                ));
          },
          itemCount: list.length,
        ),
      );
    });
  }
}
