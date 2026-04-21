import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/change_skin_tone_color_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果  列表数据加载骨架屏动画组件 DownloadDataWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果  列表数据加载骨架屏动画组件 DownloadDataWidget
    - DownloadDataWidget
    ```
    DownloadDataWidget()
    ```
    】】】
 *
 */

class DownloadDataWidget extends StatelessWidget {
  const DownloadDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode ? Colors.black : const Color(0xFFF2F2F6),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: isIPad ? 4 : 3,
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              decoration: context.isDarkMode
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    color: context.isDarkMode ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()  : Colors.white,
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(
                10.w,
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: EdgeInsets.all(
                    10.w,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 18.h,
                              width: 18.w,
                              decoration: ShapeDecoration(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.10000000149011612)
                                    : Colors.grey.withValues(alpha:0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    25.r,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 10.h,
                              width: 150.w,
                              margin: EdgeInsets.only(
                                left: 10.w,
                              ),
                              decoration: ShapeDecoration(
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withValues(alpha:0.10000000149011612)
                                    : Colors.grey.withValues(alpha:0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 10.h,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 50.w,
                          top: 10.h,
                        ),
                        decoration: ShapeDecoration(
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha:0.10000000149011612)
                              : Colors.grey.withValues(alpha:0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15.r,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 10.h,
                                  width: 100.w,
                                  margin: EdgeInsets.only(
                                    top: 20.h,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: context.isDarkMode
                                        ? Colors.white
                                            .withValues(alpha:0.10000000149011612)
                                        : Colors.grey.withValues(alpha:0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 10.h,
                                  width: 150.w,
                                  margin: EdgeInsets.only(
                                    top: 25.h,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: context.isDarkMode
                                        ? Colors.white
                                            .withValues(alpha:0.10000000149011612)
                                        : Colors.grey.withValues(alpha:0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.r,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 10.h,
                                  width: 150.w,
                                  margin: EdgeInsets.only(top: 25.h),
                                  decoration: ShapeDecoration(
                                    color: context.isDarkMode
                                        ? Colors.white
                                            .withValues(alpha:0.10000000149011612)
                                        : Colors.grey.withValues(alpha:0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.r,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 10.h,
                                  width: 100.w,
                                  margin: EdgeInsets.only(
                                    top: 25.h,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: context.isDarkMode
                                        ? Colors.white
                                            .withValues(alpha:0.10000000149011612)
                                        : Colors.grey.withValues(alpha:0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 10.h,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(
                                    top: 20.h,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: context.isDarkMode
                                        ? Colors.white
                                            .withValues(alpha:0.10000000149011612)
                                        : Colors.grey.withValues(alpha:0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.r,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 3.h,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 32.h,
                                                  width: 50.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.r),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 32.h,
                                                  width: 50.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 32.h,
                                                  width: 50.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(children: [
                                            Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 49.h,
                                                  width: 50.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.w,
                                                    right: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 49.h,
                                                  width: 50.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.w,
                                                    right: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 49.h,
                                                  width: 55.w,
                                                  margin: EdgeInsets.only(
                                                    top: 3.w,
                                                    right: 3.h,
                                                  ),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 49.h,
                                                  width: 55.w,
                                                  margin: EdgeInsets.only(
                                                      top: 3.w, right: 3.h),
                                                  decoration: ShapeDecoration(
                                                    color: context.isDarkMode
                                                        ? Colors.white.withValues(alpha:
                                                            0.10000000149011612)
                                                        : Colors.grey
                                                            .withValues(alpha:0.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2.r,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ])
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
