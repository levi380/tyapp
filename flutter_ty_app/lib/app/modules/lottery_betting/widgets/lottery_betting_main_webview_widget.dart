import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';

///webView相关部件
class LotteryBettingMainWebViewWidget extends StatefulWidget {
  const LotteryBettingMainWebViewWidget({super.key, required this.onValueChanged});

  final ValueChanged<MainMenu> onValueChanged;

  @override
  State<LotteryBettingMainWebViewWidget> createState() =>
      _LotteryBettingMainMenuWidgetState();
}

class _LotteryBettingMainMenuWidgetState
    extends State<LotteryBettingMainWebViewWidget> {
  final _tabs = MainMenu.menuList;

  var balanceWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      alignment: Alignment.center,
      child: Row(
        children: [
          //SDK 返回按钮
          if (oBContext != null)
            InkWell(
              onTap: () {
                Navigator.pop(oBContext!);
              },
              child: Container(
                width: 40.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  size: 22.w,
                ),
              ),
            ),
          Expanded(
            child: Row(
              children: _tabs
                  .asMap()
                  .entries
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        widget.onValueChanged(e.value);
                        //更新联赛删选默认时间
                        DateTime now = DateTime.now();
                        LeagueManager.md =
                            DateTime(now.year, now.month, now.day, 00, 00, 00)
                                .millisecondsSinceEpoch
                                .toString();
                      },
                      child: GetBuilder<TyHomeController>(
                          tag: MainTabController.to.uuid,
                          builder: (controller) {
                        return Text(
                          'new_menu_${e.value.mi}'.tr.subLength(7),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: e.value.mi == controller.homeState.menu.mi
                              ? const TextStyle(
                                  color: Color(0xFF127DCC),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )
                              : const TextStyle(
                                  color: Color(0xFFAFB3C8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                        );
                      }).paddingSymmetric(
                          horizontal:
                              ['vi', 'pt', 'ko'].contains(getLang()) ? 3 : 6),
                    ).ifExpanded(![
                      'tw',
                      'zh',
                      'en',
                      'ko',
                    ].contains(getLang())),
                  )
                  .toList(),
            ),
          ),
          _buildBalance(context),
        ],
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return GetBuilder<TYUserController>(builder: (controller) {
      return Container(
        height: 22.h,
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
        ),
        margin: EdgeInsets.only(left: 8.w),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha:0.03999999910593033)
              : const Color(0xFFF2F2F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            TYUserController.to.getBalance();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView('assets/images/home/icon_trans_nor.svg',
                  width: 16.w, height: 16.w),
              Container(
                width: 5.w,
              ),
              Text(
                controller.balance.value != null
                    ? controller.toAmountSplit(
                        controller.balance.value!.amount.toStringAsFixed(2))
                    : '-',
                style: TextStyle(
                  color: context.isDarkMode
                      ? const Color(0xE5FFFFFF)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'DIN Alternate',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
