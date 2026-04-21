import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/models/res/match_entity.dart';

import '../../../../../config/analytic/analytics_utils.dart';

import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../utils/odds_util.dart';
import '../../../../../utils/toast_util.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
import '../../../constants/detail_constant.dart';
import '../../../models/odds_button_enum.dart';
import 'odds_button_mixins/odds_button_mixin.dart';
import 'odds_button_mixins/odds_button_state_mixin.dart';
import 'odds_button_mixins/odds_button_ui_mixin.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-6e82406f-f6da-4e10-bd14-0cfd64438046 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注列表+赛果列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 变赔投注按钮+赛果展示】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 投注变赔按钮
    】】】
 *
 */
class OddsButton extends StatefulWidget {
  const OddsButton({
    super.key,
    this.width,
    this.height,
    this.name,
    this.direction = OddsTextDirection.vertical,
    this.match,
    this.hps,
    this.ol,
    this.hl,
    this.isDetail = false,
    this.secondaryPaly = false,
    this.betType = OddsBetType.common,
    this.fullscreen = false,
    this.nameColor,
    this.playId = '',

    ///波胆类型  type = 0 时需要单独处理
    this.type = 1,
    this.radius,
  });

  final double? width;
  final double? height;

  final MatchEntity? match;
  final MatchHps? hps;
  final MatchHpsHlOl? ol;
  final MatchHpsHl? hl;

  /// 投注项文本 详情有写不同模板不同name拼接
  final String? name;

  /// 水平或者垂直
  final OddsTextDirection direction;

  /// 针对列表和详情某些样式不同 做区分
  final bool isDetail;
  final bool secondaryPaly;

  final OddsBetType betType;

  ///首页列表 子玩法id
  final String playId;
  final int type;

  final bool fullscreen;
  final Color? nameColor;

  // 圆角
  final double? radius;

  @override
  State<OddsButton> createState() => _OddsButtonState();
}

class _OddsButtonState extends State<OddsButton>
    with OddsButtonStateMixin, OddsButtonUiMixin, OddsButtonMixin {
  @override
  void initState() {
    oddsBetType = widget.betType;

    if (widget.ol != null) {
      // 组件初始化记录旧赔率oldOv
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
      oldDov = ol.dov; // 优惠赔率旧赔率
    }
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.ol?.oid);
        if (selected != checked) {
          setState(() {
            selected = checked;
          });
        }
      }
    });
    initCurCategoryTab();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void didUpdateWidget(covariant OddsButton oldWidget) {
    selected = ShopCartController.to.isCheck(widget.ol?.oid);
    // 组件更新时 更新旧赔率。
    // 赔率变化主要由数据仓库里面的赔率值驱动 与组件更新无太大关联
    if (oldWidget.ol != widget.ol &&
        widget.ol != null &&
        Get.currentRoute != Routes.matchDetail) {
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
      oldDov = ol.dov; // 优惠赔率旧赔率
    }
    initCurCategoryTab();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ol == null ||
        ObjectUtil.isEmpty(widget.ol?.oid) ||
        widget.match == null) {
      return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.fullscreen
              ? Colors.white.withValues(alpha: 0.08)
              : Get.theme.oddsButtonBackgroundColor,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 4.w)),
        ),
        child: widget.secondaryPaly == true &&
                widget.playId == playIdConfig.hpsBold
            ? bodanClose()
            : placeholder(),
      );
    }
    selected = ShopCartController.to.isCheck(widget.ol?.oid);
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getOid(widget.ol!.oid),
      builder: (controller) {
        MatchHpsHlOl ol =
            DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
        oddsChange(ol);
        bool addedOddsSwitch = true; // 优惠赔率开关
        addedOddsOpen = (ol.dov != 0 && addedOddsSwitch);
        OddsButtonState state = OddsUtil.betState(
            widget.match!.mhs, widget.hl!.hs, ol, widget.hps!.hsw,
            csid: widget.match!.csid);

        // 是否是增值赔率玩法集
        bool isInAddedOddsTab = (widget.ol?.isInAddedTab ?? false) &&
            curCategoryTabId == ADDED_ODDS_CATEGORY_ID;
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                /*
              * 如果有键盘 先隐藏键盘
              * */
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                // ol.result == null 排除赛果
                if (widget.match != null &&
                    widget.hps != null &&
                    ol.result == null) {
                  if (state == OddsButtonState.open) {
                    /// 设置当前投注类型
                    adjustOddsBetType();
                    ShopCartController.to.addBet(
                      widget.match!,
                      widget.hps!,
                      widget.hl,
                      ol,
                      betType: oddsBetType,
                      isDetail: widget.isDetail,
                      secondaryPaly: widget.secondaryPaly,
                      vrNo: vrNo,
                    );
                    setState(() {
                      selected = ShopCartController.to.isCheck(widget.ol?.oid);
                    });
                  }
                }
                // 处理埋点
                Analytics.handleHpidTracking(widget.hps!.hpid);
              },
              child: Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  /// 详情页展示优惠赔率
                  color: selected
                      ? widget.fullscreen
                          ? Colors.white.withValues(alpha: 0.2)
                          : Get.theme.oddsButtonSelectedBackgroundColor
                      : addedOddsOpen &&
                              state == OddsButtonState.open &&
                              !isInAddedOddsTab
                          ? (widget.fullscreen
                              ? Color(0x19FEAE2B)
                              : Get.theme.addOddsButtonBackgroundColor)
                          : widget.fullscreen
                              ? Colors.white.withValues(alpha: 0.08)
                              : Get.theme.oddsButtonBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 8)),
                  shadows: widget.isDetail
                      ? [
                          BoxShadow(
                            color: widget.fullscreen
                                ? Colors.transparent
                                : Get.theme.oddsButtonShadowColor,
                            blurRadius: 8,
                            offset: Offset(0, 2.h),
                            spreadRadius: 0,
                          )
                        ]
                      : null,
                ),
                child: buildBody(widget.ol!, ol),
              ),
            ),
            // 1、增值赔率投注项 2、详情增值赔率玩法集
            if ((addedOddsOpen && state == OddsButtonState.open) ||
                (widget.ol?.isInAddedTab ?? false))
              Positioned(
                top: !widget.fullscreen ? -11.w : -11,
                right: (widget.ol?.isInAddedTab == true &&
                        curCategoryTabId == ADDED_ODDS_CATEGORY_ID)
                    ? 10
                    : 4,
                child: Builder(builder: (context) {
                  double width = 19;
                  if (widget.isDetail) {
                    width = !widget.fullscreen ? 22.w : 22;
                  }

                  return ImageView(
                    'assets/images/common/up-tip.gif',
                    width: width,
                    onTapDown: (TapDownDetails details) {
                      ToastUtils.showDiscountOddsToast(details);
                    },
                  );
                }),
              )
          ],
        );
      },
    );
  }
}
