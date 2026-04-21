import 'package:filbet/generated/assets.dart';
import 'package:filbet/routes/app_pages.dart';
import 'package:filbet/src/home/appconfig_model.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageItemView extends StatelessWidget {
  const MessageItemView({
    super.key,
    required this.model,
    required this.isEdit,
    required this.type,
    required this.callback,
    required this.clickCallback,
  });

  final NoticeModel model;
  final bool isEdit;
  final int type;
  final VoidCallback callback;
  final VoidCallback clickCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67.r,
      color: appnewColors.bg1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isEdit)
            InkWell(
              onTap: () {
                model.checked.value = !model.checked.value;
              },
              child: Container(
                padding: EdgeInsets.only(left: 15.r, top: 15.r, bottom: 15.r),
                child: Obx(() {
                  return Image.asset(
                    model.checked.value
                        ? Assets.imagesCircleChecked
                        : Assets.imagesCircleNormal,
                    width: 16.r,
                    height: 16.r,
                  );
                }),
              ),
            ),
          Expanded(
            child: InkWell(
              onTap: () {
                clickCallback();
                Get.toNamed(Routes.MESSAGE_DETAIL,
                    arguments: {"type": type, 'model': model})?.then((value) {
                  if (value is bool && value) {
                    callback();
                  }
                });
              },
              child: Container(
                height: 67.r,
                margin: EdgeInsets.symmetric(horizontal: 15.r),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: appnewColors.colorLine4,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    iconView(),
                    SizedBox(width: 7.r),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 180.r),
                                      child: Text(
                                        model.title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: appnewColors.textMain,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (model.isTop == 1)
                                      Container(
                                        margin: EdgeInsets.only(left: 3.r),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.r),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          border: Border.all(
                                              color: Color(0xFFFF7255),
                                              width: 0.5),
                                        ),
                                        child: Text(
                                          '置顶',
                                          style: TextStyle(
                                            color: appnewColors.text25,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                formatYYMMDDToString(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        (model.createdAt ?? 0) * 1000)),
                                style: TextStyle(
                                  color: appnewColors.textFourth,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20.r),
                            child: Text(
                              model.content ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: appnewColors.textSecond,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconView() {
    return Container(
      height: 32.r,
      width: 32.r,
      child: Stack(
        children: [
          SKNetworkImage(
            imageUrl: model.iconUrl ?? '',
            width: 32.r,
            height: 32.r,
            customErrorWidget: Image.asset(
              Assets.mineIconNoticeDefault,
              width: 32.r,
              height: 32.r,
            ),
          ),
          if (model.readState == 0)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  color: Color(0xFFFF7255),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
