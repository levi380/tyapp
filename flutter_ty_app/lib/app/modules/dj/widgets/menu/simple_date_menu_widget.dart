import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-409e307b-dbbb-44b3-97fa-a03a45f3b225-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 电竞 】】】
    【【【 AUTO_DOCUMENT_TITLE 电竞头部 】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞头部 顶部日期控件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 顶部日期控件
    # `点击日期返回上层，并设置当前选中的日期`

    ```
    widgets.onValueChanged(e);
    DJController.to.DJState.selectDate = e;
    ```
    】】】
 *
 */
class SimpleDateMenuWidget extends StatefulWidget {
  final List<DjDateEntityEntity>? djDateEntity;

  SimpleDateMenuWidget(
      {super.key, this.djDateEntity, required this.onValueChanged});

  final ValueChanged<DjDateEntityEntity> onValueChanged;

  @override
  State<SimpleDateMenuWidget> createState() => _SimpleDateMenuWidgetState();
}

class _SimpleDateMenuWidgetState extends State<SimpleDateMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 0.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          widget.djDateEntity == []
              ? const SizedBox()
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.djDateEntity!
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                ///点击日期返回上层，并设置当前选中的日期
                                widget.onValueChanged(e);
                                DJController.to.DJState.selectDate = e;
                              },
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      e.menuName.toString(),
                                      style: e.menuId ==
                                              DJController
                                                  .to.DJState.selectDate?.menuId
                                          ? TextStyle(
                                              color: context.isDarkMode
                                                  ? const Color(0xFF127DCC)
                                                  : const Color(0xFF179CFF),
                                              fontSize: isIPad
                                                  ? 16.sp.scale
                                                  : 12.sp.scale,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'PingFang SC',
                                            )
                                          : TextStyle(
                                              color: context.isDarkMode
                                                  ? const Color(0xFFFFFFFF)
                                                      .withValues(alpha: 0.3)
                                                  : const Color(0xFFAFB3C8),
                                              fontSize: isIPad
                                                  ? 16.sp.scale
                                                  : 12.sp.scale,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'PingFang SC',
                                            ),
                                    ).paddingSymmetric(horizontal: 6),
                                  ),
                                  SizedBox(
                                    height: 3.w,
                                  ),
                                  Container(
                                    width: 30.w,
                                    height: 2.w,
                                    color: e.menuId ==
                                            DJController
                                                .to.DJState.selectDate?.menuId
                                        ? context.isDarkMode
                                            ? const Color(0xFF127DCC)
                                            : const Color(0xFF179CFF)
                                        : Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
          // _buildBalance(),
        ],
      ),
    );
  }
}
