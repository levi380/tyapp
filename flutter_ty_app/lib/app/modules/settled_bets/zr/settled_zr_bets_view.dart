import 'package:flutter_ty_app/app/modules/settled_bets/zr/settled_zr_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/item/zrBets_Item_Body.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/widgets/zr_stateWidget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../utils/oss_util.dart';
import '../../../utils/utils.dart';
import '../../../../main.dart';
import '../../login/login_head_import.dart';
import '../../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import '../../unsettled_bets/widgets/footer_view.dart';
import '../../unsettled_bets/widgets/no_data_hints/no_data_hints_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票真人投注结算页面 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    ## 参数
    - `settled`: 整数，表示投注状态。
    - `0`: 未结算
    - `1`: 已结算

    ## 组件结构

    ### 1. `build` 方法
    - 返回一个 `AlertDialog`，包含关闭按钮和主体内容。

    ### 2. `_buildCloseButton`
    - 创建关闭按钮，点击后关闭对话框。

    ### 3. `_body` 方法
    - 使用 `GetBuilder` 监听状态变化。
    - 根据 `logic.loading` 状态渲染不同内容：
    - 加载状态：显示加载视图。
    - 数据加载完成：显示投注信息或无数据提示。

    ### 4. `_title`
    - 构建导航部分的标题。

    ### 5. `_subtitle`
    - 显示投注统计信息：
    - 总投注单数
    - 总投注额
    - 总有效投注
    - 总派彩（仅在已结算时显示）

    ### 6. 列表显示
    - 使用 `ListView.builder` 显示投注项目，支持上拉加载。
    - 在 `dispose` 方法中删除 `SettledZrBetsLogic` 实例，释放资源。

    】】】
 *
 */

/// *
/// 彩票真人投注结算
/// settled 0 未结算  1 已结
///

class settledZrBetsPage extends StatefulWidget {
  final int settled;

  const settledZrBetsPage({super.key, required this.settled});

  @override
  State<settledZrBetsPage> createState() => _settledZrBetsPageState();
}

class _settledZrBetsPageState extends State<settledZrBetsPage> {
  final logic = Get.find<SettledZrBetsLogic>();
  final state = Get.find<SettledZrBetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding:
            EdgeInsets.fromLTRB(55.w, isIPad ? 120.h : 80.h, 55.w, 80.h),
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _buildCloseButton(),
        //SingleChildScrollView
        content: _body());
  }

  ///关闭按钮
  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
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
                  : Colors.white.withValues(alpha:0.30000001192092896),
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
    ).marginZero.marginOnly(bottom: 10.h);
  }

  Widget _body() {
    return GetBuilder<SettledZrBetsLogic>(
      builder: (logic) {
        return InkWell(
          onTap: () => {
            //  Navigator.of(context).pop(),
          },
          child: logic.loading
              ?

              ///loading 页
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        child: Container(
                            width: 400.w,
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                                color: context.isDarkMode
                                    ? const Color(0xFF1E2029)
                                    : const Color(0xFFF2F2F6),
                              ),
                              child: _title(),
                            ))),
                    const BetsLoadingView(),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          Navigator.of(context).pop(),
                        },
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: Container(
                    width: 400.w,
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        image: context.isDarkMode
                            ? DecorationImage(
                                image: NetworkImage(
                                  OssUtil.getServerPath(
                                    'assets/images/home/color_background_skin.png',
                                  ),
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: context.isDarkMode
                            ? Colors.white.withValues(alpha:0.03999999910593033)
                            : const Color(0xFFF2F2F6),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _title(),

                          ///空数据 隐藏组件
                          if (logic.listData.isNotEmpty)
                            _subtitle(logic.zrdata),
                          logic.listData.isEmpty
                              ? NoDataHintsView(
                                  type: widget.settled == 0 ? 0 : 3,
                                  orderType: 1,
                                )
                              : Expanded(
                                  child: SmartRefresher(
                                      //不允许下拉刷新
                                      enablePullDown: false,
                                      //允许上拉加载
                                      enablePullUp: false,
                                      controller: logic.refreshController,
                                      footer: const FooterView(),
                                      onLoading: logic.onLoadMore,
                                      //列表组件
                                      child: ListView.builder(
                                        itemCount: logic.listData.length,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return zrBetsItemBody(
                                            key: ValueKey(index),
                                            logic: logic,
                                            itemData: logic.listData[index],
                                            settled: widget.settled,
                                            index: index,
                                          );
                                        },
                                      )))
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  //导航部分
  Widget _title() {
    return SizedBox(
      height: 35.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          stateWidget(context.isDarkMode, 1, context, logic),
          stateWidget(context.isDarkMode, 2, context, logic),
          stateWidget(context.isDarkMode, 3, context, logic),
          stateWidget(context.isDarkMode, 5, context, logic),
        ],
      ),
    );
  }

  ///注单总额
  Widget _subtitle(GetOrderListZrData zrData) {
    return Container(
      constraints: BoxConstraints(minHeight: 35.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///总投注单数
          Expanded(
            child: subItemTitle(
                context.isDarkMode,
                LocaleKeys.zr_cp_Lottery_Bet_Slips_total_number_of_bets.tr,
                '${zrData.total}',
                0),
          ),
          div(context.isDarkMode),

          ///总投注额
          Expanded(
            child: subItemTitle(
                context.isDarkMode,
                LocaleKeys.zr_cp_Lottery_Bet_Slips_total_stake.tr,
                setAmount(zrData.totalBetAmount.toString()),
                0),
          ),
          div(context.isDarkMode),

          ///总有效投注
          Expanded(
            child: subItemTitle(
                context.isDarkMode,
                widget.settled == 1
                    ? LocaleKeys.zr_cp_Lottery_Bet_Slips_total_valid_bets.tr
                    : LocaleKeys.zr_cp_Lottery_Bet_Slips_total_win_amount.tr,
                widget.settled == 1
                    ? setAmount(zrData.totalValidBetAmount.toString())
                    : setAmount(zrData.totalCanWinAmount.toString()),
                0),
          ),
          if (widget.settled == 1) div(context.isDarkMode),
          if (widget.settled == 1)

            ///总派彩
            Expanded(
              child: subItemTitle(
                  context.isDarkMode,
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_total_payout.tr,
                  '${zrData.totalWinAmount}',
                  1),
            )
        ],
      ),
    ).marginZero.marginOnly(bottom: 12.h, top: 12.h);
  }

  //分割线
  Widget div(bool isDarkMode) {
    return Container(
        width: 1,
        height: 27.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.white.withValues(alpha:0.07999999821186066)
              : const Color(0xFFE4E6ED),
        ));
  }

//delete
  @override
  void dispose() {
    Get.delete<SettledZrBetsLogic>();
    super.dispose();
  }
}
