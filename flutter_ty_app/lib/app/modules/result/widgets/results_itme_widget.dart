import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_itme_1_widget.dart';


import 'package:sticky_headers/sticky_headers/widget.dart';


import '../../../services/models/res/get_notice_list_by_id_entity.dart';
import '../../../utils/change_skin_tone_color_util.dart';




import '../gaming_results/gaming_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 普通赛果列表 组件   ResultsItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 普通赛果列表 组件   ResultsItemWidget
    - ResultsItemWidget
    ```
    ResultsItemWidget(
    isDark: context.isDarkMode,
    dataItem: dataItem,
    onExpandItem: () => controller.onExpandItem(dataItem),
    onGoToDetails: (item) => controller.onGoToDetails(item, widget.titleIndex),
    index: index,
    sportId: controller.sportid,
    )
    ```
    】】】
 *
 */
class ResultsItemWidget extends StatelessWidget {
  const ResultsItemWidget({
    super.key,
    required this.isDark,
    required this.dataItem,
    this.onExpandItem,
    required this.index,
    required this.onGoToDetails,
    required this.sportId,
    required this.isIcon,
    required this.onIsIcon,
    required this.noticeListByIdData,
    required this.mid,
  });

  final bool isDark;
  final TidDataList dataItem;
  final VoidCallback? onExpandItem;
  final int index;
  final void Function(dynamic) onGoToDetails;
  final String sportId;
  final bool isIcon;
  final void Function(dynamic, dynamic) onIsIcon;
  final List<GetNoticeListByIdData> noticeListByIdData;
  final String mid;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? null : const Color(0xFFF2F2F6),
      child: Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
        decoration: isDark
            ? ShapeDecoration(
                color: ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor(
                        colorStyle_1: Color(0xFF2B2D33),
                        colorStyle_2: Color(0xFF23292D),
                        colorStyle_3: Color(0xFF26242A)),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: Colors.white.withValues(alpha: 0.03999999910593033),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ])
            : ShapeDecoration(
                color: const Color(0xFFF8F9FA),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
        child: StickyHeader(
          header: InkWell(
            onTap: onExpandItem,
            child: Container(
              color: Get.isDarkMode
                  ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(
                      colorStyle_1: Color(0xFF2B2D33),
                      colorStyle_2: Color(0xFF23292D),
                      colorStyle_3: Color(0xFF26242A))
                  : const Color(0xffF8F9FA),
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageView(
                        'assets/images/icon/title_tag.png',
                        width: 2.w,
                        height: 15.w,
                      ),
                      Container(
                        width: 8.w,
                      ),
                      ImageView(
                        dataItem.lurl.isEmpty
                            ? "assets/images/home/list/placeholder_team.png"
                            : dataItem.lurl,
                        cdn: true,
                        width: 20.w,
                        height: 20.w,
                        errorWidget: ImageView(
                          "assets/images/home/list/placeholder_team.png",
                          cdn: true,
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                      Container(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 300.w,
                        child: AutoSizeText(
                          dataItem.tn,
                          style: TextStyle(
                            color:
                                isDark ? Colors.white : const Color(0xFF303442),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: Transform.rotate(
                      angle: dataItem.isExpand ? 0 : -pi / 2,
                      child: ImageView(
                        context.isDarkMode
                            ? 'assets/images/icon/results_folding_dark.png'
                            : 'assets/images/icon/results_folding_light.png',
                        width: 13.w,
                        height: 13.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: Column(
            children: [
              dataItem.isExpand
                  ? Container(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.07999999821186066)
                          : const Color(0xFFE4E6ED),
                      height: 0.5.h,
                    )
                  : Container(),
              ResultsItem1Widget(
                isDark: context.isDarkMode,
                dataItem: dataItem,
                onGoToDetails: onGoToDetails,
                onIsIcon: onIsIcon,
                isIcon: isIcon,
                mid: mid,
                noticeListByIdData: noticeListByIdData,
                index: index,
                sportId: sportId,
              ),
              SizedBox(
                height: 5.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
