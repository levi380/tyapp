import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../widgets/image_view.dart';

enum NavButtonType {
  matchResult, // 赛果
  text,
  refresh, // 刷新
}

class NavButton extends StatefulWidget {
  const NavButton({
    super.key,
    this.title,
    required this.onTap,
    this.type = NavButtonType.text,
  });

  final String? title;
  final VoidCallback onTap;
  final NavButtonType type;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton>
    with SingleTickerProviderStateMixin {
  final _refreshSubject = BehaviorSubject<Function>();
  late AnimationController _animationController;

  @override
  void initState() {
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      // 防抖
      callback();
    });
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _refreshSubject.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? w;
    // if (widgets.type == NavButtonType.matchResult) {
    //   return InkWell(
    //     onTap: widgets.onTap,
    //     child: ImageView(
    //       Get.isDarkMode
    //           ? 'assets/images/detail/bottom_nav_result2.svg'
    //           : 'assets/images/detail/match-result-icon.png',
    //       width: 38.h,
    //     ),
    //   );
    // } else
    if (widget.type == NavButtonType.refresh) {
      return InkWell(
        onTap: () {
          _refreshSubject.add(widget.onTap);
          if (_animationController.status == AnimationStatus.completed ||
              _animationController.status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: ImageView(
            Get.isDarkMode
                ? 'assets/images/detail/bottom_nav_refresh2.svg'
                : 'assets/images/detail/detail-refresh.png',
            width: 36.h,
          ),
        ),
      );
    } else {
      w = InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          height: 36.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageView(
                widget.type == NavButtonType.matchResult
                    ? 'assets/images/detail/bottom_nav_result2.svg'
                    : 'assets/images/detail/bottom_nav_text.svg',
                width: 36.h,
                height: 36.h,
              ),
              Positioned(
                bottom: 0.h,
                child: Container(
                  height: 13.5.h,
                  width: 33.75.h,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: padding),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFCA65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.62.r),
                    ),
                  ),
                  child: Text(
                    widget.title ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF845F00),
                      fontSize: 9.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                    strutStyle:
                        const StrutStyle(height: 0.9, forceStrutHeight: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 36.h,
      width: 36.h,
      decoration: ShapeDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha:0.04)
            : const Color(0xFFE8F5FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.50.r),
        ),
      ),
      alignment: Alignment.center,
      child: w,
    );
  }
}
