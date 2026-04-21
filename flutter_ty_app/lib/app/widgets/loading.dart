import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../modules/match_detail/constants/detail_constant.dart';
import 'image_view.dart';

/// loading showBack true 加载超过5秒显示返回按钮
class Loading extends StatefulWidget {
  const Loading({super.key, this.backHeader = false});
  final bool backHeader;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool showBack = false;

  @override
  void initState() {
    if(widget.backHeader){
      5.delay(() {
        if (mounted) {
          setState(() {
            showBack = true;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        alignment: Alignment.center,
        child: const ImageView(
          'assets/images/detail/odds-info-loading.webp',
          width: 50,
        ),
      ),
      if (showBack)
        Positioned(
          top: Get.context!=null?Get.mediaQuery.padding.top:0,
          left: 0,
          child: Container(
            height: obtyAppbarHeight,
            padding:
                EdgeInsets.only(left: 6.w, top: 4.h, bottom: 4.h, right: 14.w),
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 24.w,
                height: obtyAppbarHeight,
                alignment: Alignment.center,
                child: ImageView(
                  !Get.isDarkMode
                      ? "assets/images/detail/icon_arrowleft_nor.svg"
                      : "assets/images/detail/icon_arrowleft_nor_night.svg",
                  boxFit: BoxFit.fill,
                  width: 8.w,
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
