import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_card.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_input.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_keyboard.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_order.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_slider.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_common_decoration.dart';

/// VR赛马视图主组件
/// 支持单投、串投和订单状态三种类型
class VrHorseView extends StatefulWidget {
  const VrHorseView._({
    super.key,
    required this.type,
  });

  /// 视图类型：1-单投，2-串投，3-订单状态
  final int type;

  /// 创建单投视图
  factory VrHorseView.single({
    Key? key,
  }) =>
      VrHorseView._(
        key: key,
        type: 1,
      );

  /// 创建串投视图
  factory VrHorseView.multi({
    Key? key,
  }) =>
      VrHorseView._(
        key: key,
        type: 2,
      );

  /// 创建订单状态视图
  factory VrHorseView.orderStatus({
    Key? key,
  }) =>
      VrHorseView._(
        key: key,
        type: 3,
      );

  @override
  State<VrHorseView> createState() => _VrHorseViewState();
}

/// VR赛马视图状态类
/// 管理视图的状态和UI构建
class _VrHorseViewState extends State<VrHorseView> {
  /// 快速输入选中的值
  late ValueNotifier<int?> _quickValue;

  @override
  void initState() {
    super.initState();
    _quickValue = ValueNotifier(null);
  }

  @override
  void dispose() {
    _quickValue.dispose();
    super.dispose();
  }

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
            Container(
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
                  if (widget.type == 3)
                    VrHorseOrderWidgets.buildOrderConfirmedHeader()
                  else
                    _buildHeader(),
                  SizedBox(height: 8.w),
                  ConstrainedBox(
                    constraints:
                    BoxConstraints(maxHeight: widget.type == 3 ? 300.w : 400.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildItemList(),
                          if (widget.type != 3) ...[
                            VrHorseInput().marginSymmetric(vertical: 8.w),
                            VrHorseKeyboard(quickValue: _quickValue),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (widget.type == 3)
                    VrHorseOrderWidgets.buildOrderTotalAndConfirm()
                  else
                    VrHorseSlider(type: widget.type),
                ],
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

  /// 构建头部区域
  /// 显示投注类型标签、标题和余额信息
  Widget _buildHeader() {
    return Row(
      children: [
        ImageView(
          'assets/images/vr/betting_tag_${widget.type == 2
              ? 'string'
              : 'single'}.png',
          width: 24.w,
          height: 24.w,
        ),
        SizedBox(width: 2.w),
        Text(
          widget.type == 2 ? '' : '开云体育',
          style: TextStyle(
            fontSize: 16.sp.scale,
            fontWeight: FontWeight.w500,
            color: '#303442'.hexColor,
          ),
        ).expanded(),
        VrHorseViewCommonDecoration(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
          borderRadius: 20.w,
          child: Row(
            children: [
              Text(
                '966,520,770.00',
                style: TextStyle(
                  fontSize: 20.sp.scale,
                  fontWeight: FontWeight.w700,
                  color: '#303442'.hexColor,
                ),
              ),
              SizedBox(width: 4.w),
              ImageView(
                'assets/images/shopcart/refresh.svg',
                width: 20.w,
                height: 20.w,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建投注项列表
  /// 根据类型显示不同数量的投注项卡片
  Widget _buildItemList() {
    return ListView.separated(
      itemCount: widget.type == 1 ? 1 : 5,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return VrHorseCard(
          showDelete: widget.type == 2 &&
              index > 0 &&
              index % 2 == 0,
          disable: widget.type == 2 &&
              index > 0 &&
              index % 3 == 0,
          ratioChanged: widget.type == 2 &&
              index > 0 &&
              index % 2 == 0,
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(
            height: 4.w,
          ),
    );
  }
}
