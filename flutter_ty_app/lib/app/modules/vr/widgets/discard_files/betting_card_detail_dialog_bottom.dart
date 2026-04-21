import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_dialog_common_decoration.dart';

/// 投注详情对话框底部操作区组件
class BettingCardDetailDialogBottom extends StatefulWidget {
  const BettingCardDetailDialogBottom({
    super.key,
    required this.type,
    required this.bettingType,
  });

  final int type;
  final BettingType bettingType;

  @override
  State<BettingCardDetailDialogBottom> createState() =>
      _BettingCardDetailDialogBottomState();
}

class _BettingCardDetailDialogBottomState
    extends State<BettingCardDetailDialogBottom> {
  late BettingType _bettingType;

  @override
  void initState() {
    super.initState();
    _bettingType = widget.bettingType;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 3) {
      return _buildOrderTotalAndConfirm();
    }
    return _buildSlider();
  }

  /// 构建滑动条/底部操作区
  Widget _buildSlider() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: AppColor.colorWhite,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAutoAcceptRow(),
              _buildActionButtons(),
            ],
          ).marginOnly(bottom: 20.w).safeArea(top: false),
        ),
        if (widget.type == 2) _buildScrollDownIcon(),
      ],
    );
  }

  /// 构建自动接受最佳赔率行
  Widget _buildAutoAcceptRow() {
    return Row(
      children: [
        ImageView(
          'assets/images/shopcart/check.png',
          width: 16.w,
          height: 16.w,
        ),
        SizedBox(width: 4.w),
        Text(
          '自动接受最佳赔率',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: '#7981A4'.hexColor,
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 8.w);
  }

  /// 构建操作按钮
  Widget _buildActionButtons() {
    return Row(
      children: [
        if (widget.type == 2) ...[
          ImageView(
            'assets/images/vr/icon_betting_delete.svg',
            width: 50.w,
          ),
          SizedBox(width: 8.w),
        ],
        _buildBetButton().expanded(),
        _buildToggleButton(),
      ],
    );
  }

  /// 构建投注按钮
  Widget _buildBetButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        height: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              '#45B0FF'.hexColor,
              '#179CFF'.hexColor,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBetButtonContent(),
            _buildDismissibleArrow(),
          ],
        ),
      ),
    );
  }

  /// 构建投注按钮内容
  Widget _buildBetButtonContent() {
    return Row(
      children: [
        ImageView(
          'assets/images/vr/icon_circle_arrow_right.png',
          width: 44.w,
          color: Colors.transparent,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '投注',
                style: TextStyle(
                  color: AppColor.colorWhite,
                  fontSize: 16.sp.scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '  ${widget.type == 2 ? '合计' : '可赢'}',
                style: TextStyle(
                  color: AppColor.colorWhite.withValues(alpha: 0.6),
                  fontSize: 14.sp.scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '0.00',
                style: TextStyle(
                  color: AppColor.colorWhite.withValues(alpha: 0.6),
                  fontSize: 16.sp.scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).expanded(),
        _buildArrowIcons(),
      ],
    );
  }

  /// 构建箭头图标组
  Widget _buildArrowIcons() {
    return Row(
      children: [
        ImageView(
          'assets/images/icon/icon_arrow_right_grey.png',
          width: 16.w,
        ),
        ImageView(
          'assets/images/icon/icon_arrow_right_grey_01.png',
          width: 16.w,
        ),
        ImageView(
          'assets/images/icon/icon_arrow_right_grey_light.png',
          width: 16.w,
        ),
      ],
    ).marginOnly(right: 13.w);
  }

  /// 构建可滑动箭头
  Widget _buildDismissibleArrow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          alignment: Alignment.centerLeft,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            dismissThresholds: const {
              DismissDirection.startToEnd: 0.75,
            },
            confirmDismiss: (_) async {
              await 3.seconds.delay();
              return true;
            },
            child: Container(
              width: constraints.maxWidth - 44.w,
              alignment: Alignment.centerLeft,
              child: ImageView(
                'assets/images/vr/icon_circle_arrow_right.png',
                width: 44.w,
                height: 44.w,
              ),
            ),
          ),
        );
      },
    );
  }

  /// 构建切换按钮
  Widget _buildToggleButton() {
    return GestureDetector(
      onTap: () {
        if (_bettingType == BettingType.single) {
          _bettingType = BettingType.multi;
        } else if (_bettingType == BettingType.multi) {
          _bettingType = BettingType.single;
        }
        BettingCartController.of.onBettingTypeChanged(_bettingType);
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          color: '#E8F5FF'.hexColor,
          shape: BoxShape.circle,
        ),
        height: 50.w,
        width: 50.w,
        margin: EdgeInsets.only(left: 8.w),
        child: widget.type == 2
            ? Text(
                '单关\n投注',
                style: TextStyle(
                  fontSize: 14.sp.scale,
                  fontWeight: FontWeight.w500,
                  color: '#179CFF'.hexColor,
                ),
              ).center
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageView(
                    'assets/images/shopcart/add.png',
                    width: 16.w,
                    color: '#179CFF'.hexColor,
                  ),
                  Text(
                    '串',
                    style: TextStyle(
                      fontSize: 16.sp.scale,
                      fontWeight: FontWeight.w500,
                      color: '#179CFF'.hexColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 构建滚动向下图标
  Widget _buildScrollDownIcon() {
    return Positioned(
      top: -20.w,
      left: 0,
      right: 0,
      child: ImageView(
        'assets/images/vr/icon_scrolldown.svg',
        width: 20.w,
        height: 20.w,
      ).center,
    );
  }

  /// 构建订单总计和确认
  Widget _buildOrderTotalAndConfirm() {
    return Column(
      children: [
        SizedBox(height: 4.w),
        BettingDialogCommonDecoration(
          padding: EdgeInsets.all(12.w),
          borderRadius: 12.w,
          child: Column(
            children: [
              _buildTotalRow(
                title: '投注金额',
                subtitle: '600,256.00',
              ),
              _buildTotalRow(
                title: '可赢金额',
                subtitle: '3,958,256.00',
              ).marginSymmetric(vertical: 12.w),
              _buildTotalRow(
                title: '注单号',
                subtitle: 'LX21351531351311321',
                subtitleStyle: TextStyle(
                  fontSize: 12.sp.scale,
                  color: '#7981A4'.hexColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 48.w),
          decoration: BoxDecoration(
            color: '#179CFF'.hexColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Text(
            '确认',
            style: TextStyle(
              fontSize: 16.sp.scale,
              color: AppColor.colorWhite,
              fontWeight: FontWeight.w500,
            ),
          ).center,
        ).marginOnly(top: 8.w),
      ],
    ).marginOnly(bottom: 20.w).safeArea(top: false);
  }

  /// 构建总计行
  Widget _buildTotalRow({
    required String title,
    required String subtitle,
    TextStyle? subtitleStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp.scale,
            color: '#7981A4'.hexColor,
          ),
        ),
        Text(
          subtitle,
          style: subtitleStyle ??
              TextStyle(
                fontSize: 16.sp.scale,
                color: '#303442'.hexColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
