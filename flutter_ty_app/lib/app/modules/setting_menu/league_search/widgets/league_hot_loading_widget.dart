import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选  搜索暂无数据组件 LeagueHotLoadingWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选  搜索暂无数据组件 LeagueHotLoadingWidget
    - LeagueHotLoadingWidget
    ```
    LeagueHotLoadingWidget()
    ```
    】】】
 *
 */

class LeagueHotLoadingWidget extends StatelessWidget {
  const LeagueHotLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                alignment: Alignment.centerLeft,
                width: 171.w,
                height: 40.h,
                decoration: ShapeDecoration(
                  color: Colors.grey.withValues(alpha:0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
            ),
          ),
          30.verticalSpace,
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 30,
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 171.w,
                            height: 15.h,
                            decoration: ShapeDecoration(
                              color: Colors.grey.withValues(alpha:0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 171.w,
                            height: 15.h,
                            decoration: ShapeDecoration(
                              color: Colors.grey.withValues(alpha:0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
