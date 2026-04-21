import 'dart:async';

import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalMarquee extends StatefulWidget {
  final List<String> data;

  const VerticalMarquee({
    super.key,
    required this.data,
  });

  @override
  State<VerticalMarquee> createState() => _VerticalMarqueeState();
}

class _VerticalMarqueeState extends State<VerticalMarquee> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _currentIndex++;
      if (_currentIndex >= widget.data.length) {
        _currentIndex = 0;
      }

      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19.h,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: appnewColors.text2),
            ),
          );
        },
      ),
    );
  }
}
