import 'dart:async';

import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b0c1dfdd-466f-4d36-b965-db8c08133b34-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  整点更新元数据 】】】
    【【【 AUTO_PARAGRAPH_TITLE 整点更新元数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 定时任务，每小时整点更新元数据。
    ```dart
  void _scheduleNextHour() {
    final now = DateTime.now();
    final nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    final durationUntilNextHour = nextHour.difference(now);
    _timer = Timer(durationUntilNextHour, _runHourlyTask);
  }

  void _runHourlyTask() {
    ConfigController.to.loadTournamentMatch();
    ConfigController.to.loadMenuMapping();
    ConfigController.to.loadMenuInit();
    ConfigController.to.loadNameList();
    ConfigController.to.loadOriginData();
    _scheduleNextHour();
  }
    ```
    】】】
 *
 */
class HourlyTaskRunner {
  Timer? _timer;

  void start() {
    _scheduleNextHour();
  }

  void stop() {
    _timer?.cancel();
  }

  ////定时任务 整点拉取
  void _scheduleNextHour() {
    final now = DateTime.now();
    final nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    final durationUntilNextHour = nextHour.difference(now);
    _timer = Timer(durationUntilNextHour, _runHourlyTask);
  }

  void _runHourlyTask() {
    ConfigController.to.loadTournamentMatch();
    ConfigController.to.loadMenuMapping();
    ConfigController.to.loadMenuInit();
    ConfigController.to.loadNameList();
    ConfigController.to.loadOriginData();
    _scheduleNextHour();
  }
}
