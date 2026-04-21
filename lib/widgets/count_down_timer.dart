import 'dart:async';

import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    super.key,
    required this.content,
    required this.countdownSeconds,
    required this.callback,
    this.textColor,
    this.decoration,
  });

  final String content;
  final int countdownSeconds;
  final VoidCallback callback;
  final Color? textColor;
  final Decoration? decoration;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.countdownSeconds;
    _startCountDown();
  }

  @override
  void didUpdateWidget(covariant CountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countdownSeconds != widget.countdownSeconds) {
      _remainingSeconds = widget.countdownSeconds;
      _startCountDown();
    }
  }

  void _startCountDown() {
    _timer?.cancel();
    if (_remainingSeconds <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCountingDown = _remainingSeconds > 0;
    return InkWell(
      onTap: isCountingDown ? null : widget.callback,
      child: Container(
        decoration: isCountingDown ? widget.decoration : null,
        child: Text(
          isCountingDown ? '${_remainingSeconds}S' : widget.content,
          style: TextStyle(
            fontSize: 14.sp,
            color: widget.textColor ?? appnewColors.text7,
          ),
        ),
      ),
    );
  }
}
