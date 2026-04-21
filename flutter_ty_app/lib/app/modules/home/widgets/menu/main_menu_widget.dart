import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/utils/amount_util.dart';
import 'package:flutter_ty_app/app/utils/route_check_util.dart';

import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../main_tab/main_tab_controller.dart';
import '../../../setting_menu/league_filter/manager/league_manager.dart';
import '../../models/match_list_type.dart';

///赛事类型菜单
class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({
    super.key,
    required this.onValueChanged,
  });

  final ValueChanged<MainMenu> onValueChanged;

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget>
    with SingleTickerProviderStateMixin {
  final _tabs = MainMenu.menuList;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.only(bottom: 6.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          /// SDK / 原生返回按钮
          _buildBackButton(context),

          if (isSDK == false) SizedBox(width: 5.w),

          /// 主菜单 Tab
          Expanded(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(),
              onTap: _onTabChanged,
              tabs: _tabs
                  .map((menu) => _buildTabItem(context, menu))
                  .toList(),
            ),
          ),

          /// 余额展示
          _buildBalance(context),
        ],
      ),
    );
  }


  /// 菜单点击处理逻辑
  void _onTabChanged(int index) {
    widget.onValueChanged(_tabs[index]);

    /// 更新联赛默认时间
    final now = DateTime.now();
    if (index == 2 || index == 3) {
      LeagueManager.md = '';
    } else {
      LeagueManager.md = DateTime(
        now.year,
        now.month,
        now.day,
        0,
        0,
        0,
      ).millisecondsSinceEpoch.toString();
    }
  }


  /// 返回按钮（SDK / 原生）
  Widget _buildBackButton(BuildContext context) {
    if (oBContext != null) {
      return _backIcon(
        context,
        onTap: () => Navigator.pop(oBContext!),
      );
    }

    if (back == true) {
      return _backIcon(
        context,
        onTap: SystemNavigator.pop,
      );
    }

    return const SizedBox();
  }

  Widget _backIcon(BuildContext context, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 40.w,
        child: Icon(
          Icons.arrow_back_ios,
          size: 22.w,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  /// 单个 菜单Tab
  Widget _buildTabItem(BuildContext context, MainMenu menu) {
    return GetBuilder<TyHomeController>(
      tag: MainTabController.to.uuid,
      builder: (controller) {
        final isSelected = menu.mi == controller.homeState.menu.mi;
        final isDisable = controller.homeState.listType ==
            MatchListType.zr ||
            controller.homeState.listType == MatchListType.cp;

        return Container(
          margin: EdgeInsets.only(
            left: menu.mi == 2 ? 5.w : 12.w,
            right: _tabs.last.mi == menu.mi ? 15.w : 0.w,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'new_menu_${menu.mi}'.tr,
              style: _tabTextStyle(context, isSelected, isDisable),
            ),
          ),
        );
      },
    );
  }

  TextStyle _tabTextStyle(
      BuildContext context,
      bool isSelected,
      bool isDisable,
      ) {
    if (isDisable) {
      return TextStyle(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.3)
            : const Color(0xFFAFB3C8),
        fontSize: 14.sp.scale,
        fontWeight: FontWeight.w400,
        fontFamily: 'PingFang SC',
      );
    }

    if (isSelected) {
      return TextStyle(
        color: context.isDarkMode
            ? const Color(0xFF127DCC)
            : const Color(0xFF179CFF),
        fontSize: 16.sp.scale,
        fontWeight: FontWeight.w500,
        fontFamily: 'PingFang SC',
      );
    }

    return TextStyle(
      color: context.isDarkMode
          ? Colors.white.withValues(alpha: 0.3)
          : const Color(0xFFAFB3C8),
      fontSize: 14.sp.scale,
      fontWeight: FontWeight.w400,
      fontFamily: 'PingFang SC',
    );
  }

  /// 余额区域
  Widget _buildBalance(BuildContext context) {
    return GetBuilder<TYUserController>(
      builder: (controller) {
        return Container(
          height: 22.w,
          margin: EdgeInsets.only(left: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: ShapeDecoration(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.04)
                : const Color(0xFFF2F2F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: TYUserController.to.getBalance,
            child: Row(
              children: [
                _buildCurrencyIcon(),
                SizedBox(width: 5.w),
                _buildBalanceText(controller, context),
              ],
            ),
          ),
        );
      },
    );
  }

  ///余额币种icon
  Widget _buildCurrencyIcon() {
    final currency = TYUserController.to.currCurrency();
    if (currency == 'USDT') {
      return ImageView(
        'assets/images/home/icon_trans_nor_USDT.svg',
        width: 16.w,
        height: 16.w,
      );
    }
    if (currency == 'RMB') {
      return ImageView(
        'assets/images/home/icon_trans_nor_RMB.svg',
        width: 16.w,
        height: 16.w,
      );
    }
    return const SizedBox();
  }

  ///余额数字
  Widget _buildBalanceText(
      TYUserController controller, BuildContext context) {
    final text = RouteCheckUtil.checkIsLogin() == false
        ? '0.00'
        : controller.balance.value != null
        ? controller.toAmountSplit(
      AmountUtil.numberFormat(
          controller.balance.value!.amount),
    )
        : '-';

    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: context.isDarkMode
            ? const Color(0xE5FFFFFF)
            : const Color(0xFF303442),
        fontSize: 14.sp.scale,
        fontFamily: 'DIN Alternate',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

