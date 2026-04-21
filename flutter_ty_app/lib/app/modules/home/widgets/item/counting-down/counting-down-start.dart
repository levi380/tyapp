import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class CountingdownStart extends StatefulWidget {
  const CountingdownStart(this.match, this.mgtTime, {super.key});

  final MatchEntity match;
  final String mgtTime;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountingdownStart> {
  late bool show;
  late int startMinutes;

  @override
  void dispose() {
    // timeout?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startMinutes = 1;
    show = false;
    countingDown();
  }

  void countingDown() {
    if (widget.mgtTime.isNotEmpty) {
      int startTime = int.tryParse(widget.mgtTime) ?? 0;

      int nowLocal = DateTime.now().millisecondsSinceEpoch;
      // int subLocalTime = nowLocal - initLocal;
      int nowServerTime = nowLocal + IntKV.diffTime.get()!;

      int subTime = startTime - nowServerTime;
      show = false;

      if (widget.match.mcg != 1 && subTime < 60 * 60 * 1000) {
        if (subTime > 0) {
          setState(() {
            show = true;
            startMinutes = DateTime.fromMillisecondsSinceEpoch(subTime).minute;
            if (startMinutes < 1) {
              startMinutes = 1;
            }
          });

        } else {
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show && startMinutes > 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            // i18nTc('list.after_time_start', [startMinutes.toString()]),
            startMinutes.toString(),
            style: const TextStyle(fontSize: 12.0), // Adjust font size as needed
          ),
        ),
      ),
    );
  }
}
