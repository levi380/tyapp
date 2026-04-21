/**
 * @Author swifter
 * @Date 2024/3/3 10:18
 */
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../global/server-time.dart';
import '../../../../widgets/RoundedUnderlineTabIndicator.dart';
import '../../../setting_menu/league_filter/manager/league_manager.dart';
import '../../models/main_menu.dart';

class DateTimeMenuWidget extends StatelessWidget {
  const DateTimeMenuWidget({
    super.key,
    required this.menu,
    required this.onDateTimeChanged,
  });

  final MainMenu menu;
  final ValueChanged<int?> onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    if (!(menu.isEarly || menu.isMatchBet)) return const SizedBox();

    List<_DateItem> dateTimeList = _buildDateTimeList(menu.isEarly);

    return DefaultTabController(
      length: dateTimeList.length,
      key: ValueKey(menu.mi),
      child: Container(
        height: 23.w,
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          onTap: (index) {
            ///更新联赛筛选时间戳
            int? val = dateTimeList[index].value;
            onDateTimeChanged(val);
            LeagueManager.md = val == null ? '' : val.toString();
          },
          padding: EdgeInsets.zero,
          indicator: RoundedUnderlineTabIndicator(
            color: const Color(0xFF179CFF),
            radius: 4.0.w,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: const Color(0xFF179CFF),
          unselectedLabelColor: context.isDarkMode
              ? Colors.white.withAlpha(50)
              : const Color(0xFF7981A4),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp.scale,
            fontWeight: FontWeight.w400,
            fontFamily: 'PingFang SC',
          ),
          labelStyle: TextStyle(
            fontSize: 12.sp.scale,
            fontWeight: FontWeight.w500,
            fontFamily: 'PingFang SC',
          ),
          tabs: dateTimeList.map((e) => Tab(text: e.title)).toList(),
        ),
      ).marginOnly(bottom: 5.h),
    );
  }

  /// 生成日期列表：全部/今日 + 七天的日期
  List<_DateItem> _buildDateTimeList(bool isEarly) {
     List<_DateItem> list = [];

    /// 早盘：显示 “全部”
    /// 滚球：显示 “今日”
    list.add(
      _DateItem(
        title: isEarly
            ? LocaleKeys.app_h5_match_all.tr
            : LocaleKeys.menu_itme_name_today.tr,
        value: isEarly ? null : 0,
      ),
    );

     DateTime now = DateTime.now();
     DateTime dateNoon = DateTime(now.year, now.month, now.day, 12, 0, 0);
    /// 服务器时间 补齐差值
     int nowServerTime = dateNoon.millisecondsSinceEpoch + serverTime.diffTime;
     DateTime date = DateTime.fromMillisecondsSinceEpoch(nowServerTime);

    for (int i = 0; i < 8; i++) {
      date = date.add(const Duration(days: 1));
      bool isLast = i == 7 ? true : false;
      list.add(
        _DateItem(
          title: isLast
              ? LocaleKeys.list_other.tr
              : '${date.month.toString().padLeft(2, '0')}/${date.day}',
          value: isLast ? -date.millisecondsSinceEpoch : date.millisecondsSinceEpoch,
        ),
      );
    }

    return list;
  }
}

/// 日期单独内部模型
class _DateItem {
  final String title;
  final int? value;
  const _DateItem({
    required this.title,
    required this.value,
  });
}

