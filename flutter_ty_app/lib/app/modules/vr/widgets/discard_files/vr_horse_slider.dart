
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_horse_view_shadow.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_util.dart';

/// VR赛马视图滑动投注组件
/// 包含自动接受最佳赔率选项和投注按钮
class VrHorseSlider extends StatelessWidget {
  const VrHorseSlider({
    super.key,
    required this.type,
  });

  /// 视图类型：1-单投，2-串投
  final int type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: AppColor.colorWhite,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAutoAcceptCheckbox(),
              _buildBettingButton(),
            ],
          ).marginOnly(bottom: 20.w).safeArea(top: false),
        ),
        if (type == 2) _buildScrollIndicator(),
      ],
    );
  }

  /// 构建自动接受最佳赔率复选框
  Widget _buildAutoAcceptCheckbox() {
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
            fontSize: 12.sp.scale,
            fontWeight: FontWeight.w600,
            color: '#7981A4'.hexColor,
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 8.w);
  }

  /// 构建投注按钮区域
  Widget _buildBettingButton() {
    return Row(
      children: [
        if (type == 2) ...[
          ImageView(
            'assets/images/vr/icon_betting_delete.svg',
            width: 50.w,
          ),
          SizedBox(width: 8.w),
        ],
        _buildMainBettingButton().expanded(),
        _buildSecondaryButton(),
      ],
    );
  }

  /// 构建主投注按钮（可滑动）
  Widget _buildMainBettingButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
        VrHorseViewUtil.of.showOrderStatus();
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
            _buildButtonContent(),
            _buildSwipeableIndicator(),
          ],
        ),
      ),
    );
  }

  /// 构建按钮内容（文本和图标）
  Widget _buildButtonContent() {
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
                text: '  ${type == 2 ? '合计' : '可赢'}',
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
        VrHorseViewShadow(
          child: Container(),
        ),
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

  /// 构建可滑动的指示器
  Widget _buildSwipeableIndicator() {
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
              // 滑动确认逻辑
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

  /// 构建次要按钮（单关投注或串关按钮）
  Widget _buildSecondaryButton() {
    return Container(
      decoration: BoxDecoration(
        color: '#E8F5FF'.hexColor,
        shape: BoxShape.circle,
      ),
      height: 50.w,
      width: 50.w,
      margin: EdgeInsets.only(left: 8.w),
      child: type == 2
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
    );
  }

  /// 构建滚动指示器（仅串投时显示）
  Widget _buildScrollIndicator() {
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
}

