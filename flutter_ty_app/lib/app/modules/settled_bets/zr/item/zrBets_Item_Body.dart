import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/item/subItemTitle.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/settled_zr_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/widgets/live_util.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/zr/widgets/zrbets_live_history.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../core/constant/common/module/keyword.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../../utils/text_Utitl.dart';
import '../../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结算/已结算注单 zrBetsItemBody】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - LiveUtils.getGameTypeName 游戏类型名称
    - LiveUtils.getBetPointName 投注类型  投注比例
    - itemData?.roundNo 投注单号
    - itemData!.createTime 投注时间
    - itemData!.betAmount 投注额
    - itemData!.maxWinAmount 可赢额
    - itemData!.validBetAmount 有效投注
    - itemData!.netAmount 派彩
    - itemData!.betStatus 注单状态

    ## 描述
    用于展示彩票真人投注的具体项，包括投注信息、结果和相关操作。

    ## 属性
    - `index`: 位置索引，用于标识当前项的位置。
    - `settled`: 结算状态，0 表示未结算，1 表示已结算。
    - `logic`: `SettledZrBetsLogic` 实例，负责业务逻辑处理。
    - `itemData`: `GetOrderListZrDataList` 实例，包含当前投注项的数据。

    ## 方法

    ### 1. `initState`
    - 初始化状态，获取并分类闲庄数据。

    ### 2. `build`
    - 构建 UI 组件，展示投注信息和结果。

    ### 3. UI 组件构成
    - **Container**: 外层容器，设置边距和背景色。
    - **Row**: 显示游戏类型和视频按钮。
    - **TextUtitls.normalText**: 显示游戏类型名称。
    - **GestureDetector**: 点击后获取视频路径并导航到历史页面（仅在已结算时）。

    - **投注信息区域**:
    - **投注类型和赔率**: 显示投注类型及赔率。
    - **玩家和庄家列表**: 根据结算状态展示玩家和庄家的手牌图标。
    - **赢家显示**: 显示赢家信息（仅在已结算时）。

    ### 4. 辅助方法
    - `subItemTitle`: 用于生成投注单号、投注时间和投注额的标题。

    ## 其他说明
    - 使用 `WidgetsBinding.instance.addPostFrameCallback` 确保在构建完成后更新状态。
    - 支持暗黑模式和亮色模式的样式适配。

    】】】
 *
 */
class zrBetsItemBody extends StatefulWidget {
  final int index; //位置索引
  final int settled; //settled 0 未结算  1 已结
  final SettledZrBetsLogic logic;
  final GetOrderListZrDataList itemData;

  const zrBetsItemBody(
      {super.key,
      required this.index,
      required this.itemData,
      required this.settled,
      required this.logic});

  @override
  State<zrBetsItemBody> createState() => _zrBetsItemBodyState();
}

class _zrBetsItemBodyState extends State<zrBetsItemBody> {
  List<String> bankerList = [];
  List<String> playerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          ///闲庄分类
          if (widget.itemData.roundResult.isNotEmpty) {
            bankerList =
                widget.logic.getHand(widget.itemData.roundResult, "banker");
            playerList =
                widget.logic.getHand(widget.itemData.roundResult, "player");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: widget.index == widget.logic.listData.length - 1
            ? null
            : Border(
                bottom: BorderSide(
                width: 0.5.h,
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.07999999821186066)
                    : const Color(0xFFF2F2F6),
              )),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.index == 0 ? 12 : 0),
            topRight: Radius.circular(widget.index == 0 ? 12 : 0),
            bottomLeft: Radius.circular(
                widget.index == widget.logic.listData.length - 1 ? 12 : 0),
            bottomRight: Radius.circular(
                widget.index == widget.logic.listData.length - 1 ? 12 : 0)),
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : Colors.white,
      ),
      padding:
          EdgeInsets.only(top: 16.h, left: 12.w, right: 12.w, bottom: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///游戏类型名称
              TextUtitls.normalText(
                  LiveUtils.getGameTypeNameLocale(
                          widget.itemData.gameTypeName) +
                      " ${widget.itemData.tableCode}",
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  height: 0.88),
              if (widget.settled == 1)
                GestureDetector(
                  onTap: () {
                    ///获取视频路径
                    widget.logic
                        .getRoundsVideoPath([widget.itemData.roundNo]).then(
                            (value) => Get.to(() => zrBetsLiveHistory(
                                  itemData: widget.itemData,
                                  logic: widget.logic,
                                )));
                  },
                  child: ImageView(
                    context.isDarkMode
                        ? "assets/images/bets/icon_video_night.png"
                        : "assets/images/bets/icon_video.png",
                    boxFit: BoxFit.cover,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
            ],
          ).marginZero.marginOnly(bottom: 8.h),
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.03999999910593033)
                    : const Color(0xFFF2F2F6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///投注类型  投注比例
                  TextUtitls.normalText(
                    LiveUtils.getBetPointNameLocale(
                            widget.itemData.betPointName) +
                        ' @ ${widget.itemData.odds.toString()} ',
                    textAlign: TextAlign.center,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ).marginZero.marginOnly(bottom: 4.h),
                  if (widget.settled == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList.length,
                                  shrinkWrap: true,
                                  reverse: true,

                                  ///倒叙数据
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return playerList.length > 2
                                        ? Row(
                                            children: [
                                              index == playerList.length - 1
                                                  ? Transform.rotate(
                                                      angle: 90 * 3.14159 / 180,
                                                      // 逆时针旋转90度
                                                      child: Container(
                                                          child: ImageView(
                                                        "assets/images/bets/${playerList[playerList.length - 1]}.png",
                                                        boxFit: BoxFit.contain,
                                                        width: 20.w,
                                                        height: 30.h,
                                                      )))
                                                  : Container(
                                                      padding: EdgeInsets.only(
                                                          right: index != 0
                                                              ? 4.w
                                                              : 0,
                                                          left: index ==
                                                                  playerList
                                                                          .length -
                                                                      2
                                                              ? 10.w
                                                              : 0),
                                                      child: ImageView(
                                                        "assets/images/bets/${playerList[index]}.png",
                                                        boxFit: BoxFit.contain,
                                                        width: 20.w,
                                                        height: 30.h,
                                                      ))
                                            ],
                                          )
                                        : Container(

                                            /// 因为数据倒叙所以0索引在第一位
                                            padding: EdgeInsets.only(
                                                right: index != 0 ? 4.w : 0),
                                            child: ImageView(
                                              "assets/images/bets/${playerList[index]}.png",
                                              boxFit: BoxFit.contain,
                                              width: 20.w,
                                              height: 30.h,
                                            ));
                                  }),
                            ).marginZero.marginOnly(bottom: 4.h),
                            if (widget.itemData.roundResult2.isNotEmpty)
                              TextUtitls.normalText(
                                widget.logic.getScore(
                                    Get.locale!
                                                .toLanguageTag()
                                                .contains('zh-CN') ||
                                            Get.locale!
                                                .toLanguageTag()
                                                .contains('zh-TW')
                                        ? widget.itemData.roundResult2
                                        : widget.itemData.roundResult2
                                            .replaceAll('庄', 'B')
                                            .replaceAll('闲', 'P'),
                                    "player"),
                                textAlign: TextAlign.center,
                                color: context.isDarkMode
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : const Color(0xFF7981A3),
                                fontSize: 12.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              )
                          ],
                        ),
                        if (widget.itemData.roundResult2.isNotEmpty)
                          Container(
                              alignment: Alignment.center,
                              width: 55.w,
                              child: Text(
                                widget.logic
                                    .getWinner(widget.itemData.roundResult2),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : const Color(0xFF7981A3),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bankerList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return bankerList.length > 2
                                        ? Row(
                                            children: [
                                              index == bankerList.length - 1
                                                  ? Transform.rotate(
                                                      angle: 90 * 3.14159 / 180,
                                                      // 逆时针旋转90度
                                                      child: Container(

                                                          /// 因为数据倒叙所以0索引在第一位
                                                          child: ImageView(
                                                        "assets/images/bets/${bankerList[bankerList.length - 1]}.png",
                                                        boxFit: BoxFit.contain,
                                                        width: 20.w,
                                                        height: 30.h,
                                                      )))
                                                  : Container(

                                                      /// 因为数据倒叙所以0索引在第一位
                                                      padding: EdgeInsets.only(
                                                          right: index ==
                                                                  bankerList
                                                                          .length -
                                                                      2
                                                              ? 10.w
                                                              : 4.w),
                                                      child: ImageView(
                                                        "assets/images/bets/${bankerList[index]}.png",
                                                        boxFit: BoxFit.contain,
                                                        width: 20.w,
                                                        height: 30.h,
                                                      ))
                                            ],
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(
                                                right: index !=
                                                        bankerList.length - 1
                                                    ? 4.w
                                                    : 0),
                                            child: ImageView(
                                              "assets/images/bets/${bankerList[index]}.png",
                                              boxFit: BoxFit.contain,
                                              width: 20.w,
                                              height: 30.h,
                                            ),
                                          );
                                  }),
                            ).marginZero.marginOnly(bottom: 4.h),
                            if (widget.itemData.roundResult2.isNotEmpty)
                              Text(
                                widget.logic.getScore(
                                    Get.locale!
                                                .toLanguageTag()
                                                .contains('zh-CN') ||
                                            Get.locale!
                                                .toLanguageTag()
                                                .contains('zh-TW')
                                        ? widget.itemData.roundResult2
                                        : widget.itemData.roundResult2
                                            .replaceAll('庄', 'B')
                                            .replaceAll('闲', 'P'),
                                    "banker"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : const Color(0xFF7981A3),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                ],
              )).marginZero.marginOnly(bottom: 8.h),

          ///投注单号
          subItemTitle(
                  context,
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_slip_number.tr,
                  widget.itemData.roundNo)
              .marginZero
              .marginOnly(bottom: 8.h),

          ///投注时间
          subItemTitle(
                  context,
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_time.tr,
                  DateUtil.formatDateMs(
                    widget.itemData.createTime,
                    format: DateFormats.full,
                  ).toString())
              .marginOnly(bottom: 8.h),

          ///投注额
          subItemTitle(
                  context,
                  LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr,
                  "${double.parse(widget.itemData.betAmount).toStringAsFixed(2)} "
                  "${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}")
              .marginZero
              .marginOnly(bottom: 8.h),

          ///可赢额
          if (widget.settled == 0)
            subItemTitle(context, LocaleKeys.zr_cp_Lottery_Bet_Slips_winning.tr,
                    "${double.parse(widget.itemData.maxWinAmount.toString()).toStringAsFixed(2)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    color: const Color(0xFF179CFF))
                .marginZero
                .marginOnly(bottom: 8.h),

          ///有效投注
          if (widget.settled == 1)
            subItemTitle(
                    context,
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_valid_bet.tr,
                    "${double.parse(widget.itemData.validBetAmount).toStringAsFixed(2)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}")
                .marginZero
                .marginOnly(bottom: 8.h),

          ///派彩
          if (widget.settled == 1)
            subItemTitle(context, LocaleKeys.zr_cp_Lottery_Bet_Slips_payout.tr,
                    "${double.parse(widget.itemData.netAmount).toStringAsFixed(2)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                    color: const Color(0xFFF53F3F))
                .marginOnly(bottom: 8.h),

          ///注单状态
          subItemTitle(
              context,
              LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_status.tr,
              widget.logic
                  .formatBetStatus(int.parse(widget.itemData.betStatus)),
              color: widget.settled == 0
                  ? context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442)
                  : const Color(0xFF127DCC)),
        ],
      ),
    );
  }
}
