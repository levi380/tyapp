import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'handicap_widget_a.dart';
import 'handicap_widget_b.dart';
import 'handicap_widget_c.dart';
import 'handicap_widget_d.dart';
import 'handicap_widget_e.dart';
import 'handicap_widget_f.dart';
import 'handicap_widget_g.dart';
import 'handicap_widget_h.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 让球攻略 列表数据组件 HandicapWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 让球攻略 列表数据组件 HandicapWidget
    - HandicapWidget
    ```
    /// 0球
    HandicapAWidget(
      isDark: isDark,
      index: index,
    );

    /// 0/0.5球
    HandicapBWidget(
      isDark: isDark,
      index: index,
    );

    ///  0.5球
    HandicapCWidget(
      isDark: isDark,
      index: index,
    );

    ///  0.5/1 球
    HandicapDWidget(
      isDark: isDark,
      index: index,
    );

    ///  1球 球
    HandicapEWidget(
      isDark: isDark,
      index: index,
    );

    ///  1/1.5 球
    HandicapFWidget(
      isDark: isDark,
      index: index,
    );

    ///  1.5 球
    HandicapGWidget(
      isDark: isDark,
      index: index,
    );

    ///  1.5/2 球
    HandicapHWidget(
      isDark: isDark,
      index: index,
    );

    ```
    】】】
 *
 */
class HandicapWidget extends StatelessWidget {
  const HandicapWidget({
    super.key,
    required this.isDark,
    required this.index,
  });

  final bool isDark;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      /// 0球
      return HandicapAWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 1) {
      /// 0/0.5球
      return HandicapBWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 2) {
      ///  0.5球
      return HandicapCWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 3) {
      ///  0.5/1 球
      return HandicapDWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 4) {
      ///  1球 球
      return HandicapEWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 5) {
      ///  1/1.5 球
      return HandicapFWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 6) {
      ///  1.5 球
      return HandicapGWidget(
        isDark: isDark,
        index: index,
      );
    } else if (index == 7) {
      ///  1.5/2 球
      return HandicapHWidget(
        isDark: isDark,
        index: index,
      );
    }

    return Container();
  }
}
