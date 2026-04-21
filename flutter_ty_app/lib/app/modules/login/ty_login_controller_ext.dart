import 'package:flutter_ty_app/app/modules/login/ty_login_controller.dart';
import 'login_head_import.dart';

extension TyLoginControllerExt on TyLoginController{
  ///用户选择环境弹框
  toSelect() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) => StatefulBuilder(
          // 嵌套一个StatefulBuilder 部件
            builder: (context, bottomSheetUpdate) => BottomSheet(
              builder: (BuildContext context) {
                return Container(
                  height: 600.h,
                  decoration: const BoxDecoration(
                    color: AppColor.activeBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40.h,
                        decoration: const BoxDecoration(
                          color: AppColor.mhBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              ' ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              '模拟登录环境选择',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                margin: EdgeInsets.only(right: 15.w),
                                child: ImageView(
                                  "assets/images/icon/activity-rule-close.png",
                                  boxFit: BoxFit.fill,
                                  width: 25.w,
                                  height: 25.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('生产维护');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == '生产维护'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '生产维护',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == '生产维护')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('开发');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == '开发'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '开发',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == '开发')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('测试');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == '测试'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '测试',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == '测试')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('隔离');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == '隔离'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '隔离',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == '隔离')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('试玩');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == '试玩'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '试玩',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == '试玩')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetUpdate(() {
                                  goToSelect('MINI');
                                  update();
                                });
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                height: 50.h,
                                decoration: env == 'MINI'
                                    ? ShapeDecoration(
                                  color: const Color(0x4C3E65FF),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF3E65FF)),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                )
                                    : ShapeDecoration(
                                  color: Colors.white.withValues(alpha:
                                  0.05000000074505806),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20.w, right: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'MINI',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (env == 'MINI')
                                        ImageView(
                                          "assets/images/icon/common-select.png",
                                          boxFit: BoxFit.fill,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              onClosing: () {},
            )));
  }
}