import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/await_bets/await_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/await_bets/await_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/bookin_bets/bookin_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/bookin_bets/bookin_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/lapse_bets/lapse_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/lapse_bets/lapse_bets_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/unsettled_bets_title_view.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../utils/bus/bus.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示不同类型的未结算投注（未结算、预约中、已失效），并提供切换功能。
    - `final logic`：获取 `UnsettledBetsLogic` 的实例，用于管理状态和逻辑。
    - `Color? color`：根据主题动态设置背景颜色。
    - 创建一个透明背景的 `AlertDialog`，包含关闭按钮和主体内容。
    - 创建一个关闭按钮，点击后关闭对话框。
    - 创建对话框的主体内容，包括未结算投注类型的选择和对应的投注视图。
    - 根据当前类型动态加载不同的投注页面（未结算、预约中、已失效）。
    - 使用 `Get` 进行依赖注入和状态管理。
    】】】
 *
 */
class UnsettledBetsPage extends StatefulWidget {
  const UnsettledBetsPage({Key? key}) : super(key: key);

  @override
  State<UnsettledBetsPage> createState() => _UnsettledBetsPageState();
}

class _UnsettledBetsPageState extends State<UnsettledBetsPage> {
  final logic = Get.find<UnsettledBetsLogic>();
  final state = Get.find<UnsettledBetsLogic>().state;
  Color? color;

  @override
  Widget build(BuildContext context) {
    color = Color(context.isDarkMode ? 0xFF1E2029 : 0xFFFFFFFF);
    return GetBuilder<UnsettledBetsLogic>(
      builder: (logic) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          insetPadding: EdgeInsets.fromLTRB(
            48.w,

            ///适配IPad
            isIPad ? 80.h : 40.h,
            48.w,
            0.h,
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            0,
            0,
            0,
            0,
          ),
          titlePadding: const EdgeInsets.fromLTRB(
            0,
            0,
            0,
            0,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: _buildCloseButton(),
          content: _body(),
        );
      },
    );
  }

  ///关闭按钮
  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Bus.getInstance().emit(EventType.tyCloseDialog);
      },
      child: Row(
        children: [
          const Spacer(),
          Container(
            height: isIPad ? 30.w : 28.w,
            width: isIPad ? 30.w : 28.w,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withAlpha(85)
                  : Colors.white.withValues(alpha: 0.30000001192092896),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    ).marginZero.marginOnly(
          bottom: 10.h,
        );
  }

  //内容
  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
      ),
      width: 400.w,
      child: Container(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: Color(
            context.isDarkMode ? 0xff1E2029 : 0xFFF2F2F6,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UnsettledBetsTitleView(
              selectType: logic.state.type,
              onChanged: (int value) {
                logic.setType(value);
              },
            ).marginOnly(top: 12.h),
            _contentBetsView(logic.state.type)
          ],
        ),
      ),
    );
  }

  Widget _contentBetsView(int type) {
    Widget item = Container();

    ///未结算
    if (logic.state.type == 0) {
      Get.delete<BookinBetsLogic>();
      Get.delete<LapseBetsLogic>();
      Get.lazyPut(
        () => AwaitBetsLogic(),
      );
      item = AwaitBetsPage();

      ///预约中
    } else if (logic.state.type == 1) {
      Get.delete<AwaitBetsLogic>();
      Get.delete<LapseBetsLogic>();
      Get.lazyPut(
        () => BookinBetsLogic(),
      );
      item = BookinBetsPage();

      ///已失效
    } else if (logic.state.type == 2) {
      Get.delete<AwaitBetsLogic>();
      Get.delete<BookinBetsLogic>();
      Get.lazyPut(
        () => LapseBetsLogic(),
      );
      item = LapseBetsPage();
    }
    return item;
  }

  @override
  void dispose() {
    Get.delete<UnsettledBetsLogic>();
    Get.delete<AwaitBetsLogic>();
    Get.delete<BookinBetsLogic>();
    Get.delete<LapseBetsLogic>();
    super.dispose();
  }
}
