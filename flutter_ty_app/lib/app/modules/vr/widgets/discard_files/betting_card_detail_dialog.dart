

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_detail_dialog_bottom.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_detail_dialog_header.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_detail_dialog_input.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_card_detail_dialog_item_card.dart';

/// 投注详情对话框主组件
class BettingCartDetailDialog extends StatefulWidget {
  const BettingCartDetailDialog._({
    super.key,
    required this.type,
    required this.bettingType,
  });

  // 仅测试用
  final int type;
  final BettingType bettingType;

  factory BettingCartDetailDialog.single({
    Key? key,
  }) =>
      BettingCartDetailDialog._(
        key: key,
        type: 1,
        bettingType: BettingType.single,
      );

  factory BettingCartDetailDialog.multi({
    Key? key,
  }) =>
      BettingCartDetailDialog._(
        key: key,
        type: 2,
        bettingType: BettingType.multi,
      );

  factory BettingCartDetailDialog.orderStatus({
    Key? key,
  }) =>
      BettingCartDetailDialog._(
        key: key,
        type: 3,
        bettingType: BettingType.multi,
      );

  @override
  State<BettingCartDetailDialog> createState() =>
      _BettingCartDetailDialogState();
}

class _BettingCartDetailDialogState extends State<BettingCartDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height - 100.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildClose(),
            SizedBox(height: 12.w),
            GetBuilder<BettingCartController>(
              id: 'betting_content',
              builder: (controller) => Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 12.w),
                decoration: BoxDecoration(
                  color: AppColor.colorWhite,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.w),
                  ),
                ),
                child: Column(
                  children: [
                    BettingCardDetailDialogHeader(type: widget.type),
                    SizedBox(height: 8.w),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: widget.type == 3 ? 350.w : 450.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildItemCardList(),
                            if (widget.type != 3)
                              BettingCardDetailDialogInput(),
                          ],
                        ),
                      ),
                    ),
                    BettingCardDetailDialogBottom(
                      type: widget.type,
                      bettingType: widget.bettingType,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建关闭按钮
  Widget _buildClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: ImageView(
            'assets/images/shopcart/icon_close_white.svg',
            width: 28.w,
            height: 28.w,
          ).marginOnly(right: 20.w),
        ),
      ],
    );
  }

  /// 构建投注项卡片列表
  Widget _buildItemCardList() {
    return ListView.separated(
      itemCount: widget.type == 1 ? 1 : 5,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BettingCardDetailDialogItemCard(
          showDelete: widget.type == 2 && index > 0 && index % 2 == 0,
          disable: widget.type == 2 && index > 0 && index % 3 == 0,
          ratioChanged: widget.type == 2 && index > 0 && index % 2 == 0,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 4.w,
      ),
    );
  }
}
