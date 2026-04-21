import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/widgets/common_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';

class BottomSelectModel {
  final String? title;
  final String? subTitle;
  final String? imgUrl;
  final String? keyValue;

  final double? width;
  final double? height;

  BottomSelectModel({
    this.title,
    this.subTitle,
    this.imgUrl,
    this.keyValue,
    this.width,
    this.height,
  });
}

class SelectBottomSheet extends StatefulWidget {
  const SelectBottomSheet(
      {super.key,
      required this.onValueChanged,
      required this.itemList,
      this.selectedItem,
      required this.title,
      this.subTitle,
      this.stypeType = 0,
      this.isCenterTitle = false,
      this.isAutoGoBack = true,
      this.showClose = false,
      this.showCancel = true});

  final ValueChanged<BottomSelectModel> onValueChanged;
  final List<BottomSelectModel> itemList;
  final BottomSelectModel? selectedItem;
  final String title;
  final String? subTitle;
  final bool? isAutoGoBack;
  final bool? isCenterTitle;
  final int stypeType;
  final bool showClose;
  final bool? showCancel;
  @override
  State<SelectBottomSheet> createState() => _SelectBottomSheetState();
}

class _SelectBottomSheetState extends State<SelectBottomSheet> {
  Rx<BottomSelectModel> selectedItemModel = BottomSelectModel().obs;
  RxBool isEnable = false.obs;
  String? defKeyValue;

  @override
  void initState() {
    if (widget.selectedItem != null) {
      selectedItemModel.value = widget.selectedItem!;
      defKeyValue = selectedItemModel.value.keyValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemh =
        widget.itemList.length >= 4 ? 56.w * 4 : widget.itemList.length * 56.w;
    final h = 118.w + ScreenUtil().bottomBarHeight + itemh;
    var closeWidget = Positioned(
      right: 16.w,
      top: 24.h,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset(
            Assets.popupClose,
            fit: BoxFit.fill,
            width: 16.w,
            height: 16.w,
          )),
    );

    if (widget.stypeType == 0) {
      final itemh = widget.itemList.length >= 4
          ? 64.w * 4
          : widget.itemList.length * 64.w;
      final h = 140.h + ScreenUtil().bottomBarHeight + itemh;
      return Stack(
        children: [
          Container(
              height: h,
              width: 1.sw,
              // margin: EdgeInsets.only(left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                  color: appnewColors.bg1,
                  borderRadius: BorderRadius.circular(16.w)),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 20.w, left: 20.w, bottom: 20.h),
                    alignment: widget.isCenterTitle == true
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: appnewColors.text1),
                    ),
                  ),

                  Container(
                      height: itemh,
                      // color: Colors.red,
                      child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.itemList.length,
                              itemBuilder: (context, index) {
                                BottomSelectModel item = widget.itemList[index];

                                return GestureDetector(
                                  onTap: () {
                                    print('点击');
                                    if (selectedItemModel.value.keyValue !=
                                        item.keyValue) {
                                      selectedItemModel.value = item;
                                      if (defKeyValue != null) {
                                        isEnable.value =
                                            (defKeyValue != item.keyValue);
                                      } else {
                                        defKeyValue =
                                            selectedItemModel.value.keyValue;
                                        isEnable.value = true;
                                      }
                                    }

                                    //widget.onValueChanged(item);
                                  },
                                  child: Obx(() {
                                    return Container(
                                      height: 48.w,
                                      margin: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 8.h,
                                          top: 8.h),
                                      padding: EdgeInsets.only(
                                        left: 12.w,
                                        right: 14.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: Color(0xffF2F2F6),
                                        border: Border.all(
                                          color: item.keyValue ==
                                                  selectedItemModel
                                                      .value.keyValue
                                              ? appnewColors.bg
                                              : Colors.transparent,
                                          width: 1.w,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ///图标 标题
                                          Row(
                                            children: [
                                              ///图片
                                              Image.asset(
                                                widget.itemList[index].imgUrl ??
                                                    "",
                                                width: item.width ?? 20.w,
                                                height: item.height ?? 20.w,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),

                                              ///标题
                                              Text(
                                                item.title ?? '',
                                                style: TextStyle(
                                                    color: appnewColors.text1,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            item.keyValue ==
                                                    selectedItemModel
                                                        .value.keyValue
                                                ? Assets.headerCheck
                                                : Assets.popupUnselected,
                                            width: 20.w,
                                            height: 20.w,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),

                          ///按钮
                        ]),
                      )),
                  Spacer(),

                  Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      child:

                          /// 底部按钮
                          ///
                          widget.showCancel == true
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                          height: 44.w,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: appnewColors.bg,
                                                  width: 1), // 边框颜色和宽度
                                              foregroundColor:
                                                  appnewColors.bg, // 文字颜色
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20), // 圆角
                                              ),
                                              // 内边距
                                            ),
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              "cancel".tr,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Obx(() {
                                      return Container(
                                          height: 44.w,
                                          child: InkWell(
                                              onTap: () {
                                                if (isEnable.value) {
                                                  widget.onValueChanged(
                                                      selectedItemModel.value);
                                                  if (widget.isAutoGoBack ??
                                                      true) {
                                                    Get.back();
                                                  }
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  gradient: LinearGradient(
                                                    colors: isEnable.value
                                                        ? appnewColors.btnbg1
                                                        : appnewColors
                                                            .btnbg6, // 渐变的颜色数组
                                                    begin: Alignment
                                                        .topCenter, // 从上到下
                                                    end: Alignment.bottomCenter,
                                                    tileMode: TileMode
                                                        .repeated, // 镜像平铺 平点
                                                  ),
                                                ),
                                                child: Text(
                                                  'confirm'.tr,
                                                  style: TextStyle(
                                                    color: appnewColors.bg1,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )));
                                    })),
                                  ],
                                )
                              : Obx(
                                  () => CommonActionButton.confirm(
                                    isEnable.value,
                                    onPressed: () {
                                      if (isEnable.value) {
                                        widget.onValueChanged(
                                            selectedItemModel.value);
                                        if (widget.isAutoGoBack ?? true) {
                                          Get.back();
                                        }
                                      }
                                    },
                                  ),
                                )),

                  SizedBox(height: ScreenUtil().bottomBarHeight + 16.w), //
                ],
              )),
          if (widget.showClose) closeWidget
        ],
      );
    }
    return Container(
        height: h,
        width: 1.sw,
        // margin: EdgeInsets.only(left: 20.w, right: 20.w),
        decoration: BoxDecoration(
            color: appnewColors.bg1, borderRadius: BorderRadius.circular(16.w)),
        child: Column(
          children: [
            _buildTitle(),
            Container(
                margin: EdgeInsets.only(
                  top: 10.w,
                ),
                height: itemh,
                // color: Colors.red,
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.itemList.length,
                        itemBuilder: (context, index) {
                          BottomSelectModel item = widget.itemList[index];
                          return GestureDetector(
                            onTap: () {
                              print('点击');
                              if (selectedItemModel.value.keyValue !=
                                  item.keyValue) {
                                selectedItemModel.value = item;
                                if (defKeyValue != null) {
                                  isEnable.value =
                                      (defKeyValue != item.keyValue);
                                } else {
                                  defKeyValue =
                                      selectedItemModel.value.keyValue;
                                  isEnable.value = true;
                                }
                              }

                              //widget.onValueChanged(item);
                            },
                            child: Obx(() {
                              return Container(
                                margin:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                padding: EdgeInsets.only(
                                  top: 15.h,
                                  bottom: 15.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: widget.itemList.length == index + 1
                                          ? Colors.transparent
                                          : appnewColors.colorLine, // 边框颜色
                                      width: 1, // 边框宽度
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///图标 标题
                                    Row(
                                      children: [
                                        ///图片
                                        Image.asset(
                                          widget.itemList[index].imgUrl ?? "",
                                          width: item.width ?? 20.w,
                                          height: item.height ?? 20.w,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),

                                        ///标题
                                        Text(
                                          item.title ?? '',
                                          style: TextStyle(
                                              color: appnewColors.text1,
                                              fontSize: 16.sp),
                                        )
                                      ],
                                    ),
                                    Image.asset(
                                      item.keyValue ==
                                              selectedItemModel.value.keyValue
                                          ? Assets.headerCheck
                                          : Assets.popupUnselected,
                                      width: 20.w,
                                      height: 20.w,
                                    )
                                  ],
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),

                    ///按钮
                  ]),
                )),
            Spacer(),
            _buildBtn(),
          ],
        ));
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 20.w),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                // width: 30.w,
                height: 30.w,
                child: Center(
                    child: Text(
                  widget.title,
                  style: TextStyle(color: appnewColors.text1, fontSize: 16.sp),
                ))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Container(
                width: 30.w,
                height: 30.w,
                child: Center(
                  child: Image.asset(
                    Assets.mineIconCloes,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBtn() {
    return Obx(() {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: 16.w + ScreenUtil().bottomBarHeight),
          height: 44.w,
          child: InkWell(
              onTap: () {
                if (isEnable.value) {
                  widget.onValueChanged(selectedItemModel.value);
                  if (widget.isAutoGoBack ?? true) {
                    Get.back();
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    colors: isEnable.value
                        ? appnewColors.btnbg1
                        : appnewColors.btnbg6, // 渐变的颜色数组
                    begin: Alignment.topCenter, // 从上到下
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated, // 镜像平铺 平点
                  ),
                ),
                child: Text(
                  'confirm'.tr,
                  style: TextStyle(
                    color: appnewColors.bg1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )));
    });
  }
}
