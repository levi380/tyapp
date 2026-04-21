import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_dialog_common_decoration.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_common_box_shadow.dart';

/// 投注详情对话框输入区域组件
class BettingCardDetailDialogInput extends StatefulWidget {
  const BettingCardDetailDialogInput({super.key});

  @override
  State<BettingCardDetailDialogInput> createState() =>
      _BettingCardDetailDialogInputState();
}

class _BettingCardDetailDialogInputState
    extends State<BettingCardDetailDialogInput> {
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
    return Column(
      children: [
        _buildInput().marginSymmetric(vertical: 8.w),
        _buildKeyboardArea(),
      ],
    );
  }

  /// 构建输入框
  Widget _buildInput() {
    return Row(
      children: [
        BettingDialogCommonDecoration(
          borderRadius: 12.w,
          height: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '限额 0.00-100,000',
                  hintStyle: TextStyle(
                    fontSize: 14.sp.scale,
                    color: '#C9CDDB'.hexColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ).expanded(),
              Text(
                'RMB',
                style: TextStyle(
                  fontSize: 14.sp.scale,
                  color: '#C9CDDB'.hexColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).expanded(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 44.w,
          decoration: BoxDecoration(
            color: '#179CFF'.hexColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Row(
            children: [
              ImageView(
                'assets/images/shopcart/add.png',
                width: 20.w,
                height: 20.w,
              ),
              Text(
                '预约',
                style: TextStyle(
                  fontSize: 16.sp.scale,
                  color: AppColor.colorWhite,
                ),
              ).marginOnly(left: 4.w),
            ],
          ),
        ).marginOnly(left: 8.w),
      ],
    );
  }

  /// 构建键盘区域
  Widget _buildKeyboardArea() {
    return BettingDialogCommonDecoration(
      padding: EdgeInsets.all(4.w),
      borderRadius: 12.w,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final maxWidth = constraints.maxWidth - 1;
          return Column(
            children: [
              _buildQuickInput(maxWidth),
              SizedBox(height: 4.w),
              _buildKeyboard(maxWidth),
            ],
          );
        },
      ),
    );
  }

  /// 构建快速输入按钮
  Widget _buildQuickInput(double maxWidth) {
    final values = [100, 500, 1000, 2000, 5000];
    final spacing = 4.w;
    final itemWidth =
        (maxWidth - (values.length - 1) * spacing) / values.length;

    return Container(
      padding: EdgeInsets.only(bottom: 4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.isDarkMode
                ? AppColor.dividerColorDark
                : AppColor.dividerColorLight,
          ),
        ),
      ),
      child: Wrap(
        spacing: spacing,
        children: List.generate(
          values.length,
          (index) {
            final value = values[index];
            return ValueListenableBuilder(
              valueListenable: _quickValue,
              builder: (context, selValue, child) {
                return Stack(
                  children: [
                    VrCommonBoxShadow(
                      onTap: () {
                        _quickValue.value = value;
                      },
                      height: 36.w,
                      width: itemWidth,
                      child: Text(
                        '$value',
                        style: TextStyle(
                          fontSize: 18.sp.scale,
                          fontWeight: FontWeight.w700,
                          color: '#179CFF'.hexColor,
                        ),
                      ).center,
                    ),
                    if (selValue == value)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ImageView(
                          'assets/images/shopcart/text_selected.svg',
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 构建数字键盘
  Widget _buildKeyboard(double maxWidth) {
    final numValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, '.', 0, '00'];
    final funcValues = ['最大', 'delete', 'hide'];
    final spacing = 4.w;
    const columns = 4;
    final itemWidth = (maxWidth - (columns - 1) * spacing) / columns;
    final itemHeight = 36.w;

    return Row(
      children: [
        Wrap(
          spacing: spacing,
          runSpacing: 4.w,
          children: List.generate(
            numValues.length,
            (index) {
              final value = numValues[index];
              return VrCommonBoxShadow(
                height: itemHeight,
                width: itemWidth,
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 22.sp.scale,
                    fontWeight: FontWeight.w700,
                    color: '#303442'.hexColor,
                  ),
                ).center,
              );
            },
          ),
        ).expanded(),
        SizedBox(width: spacing),
        Wrap(
          spacing: 4.w,
          direction: Axis.vertical,
          children: List.generate(
            funcValues.length,
            (index) {
              final value = funcValues[index];
              return VrCommonBoxShadow(
                height: value == 'delete'
                    ? itemHeight * 2 + 4.w
                    : itemHeight,
                width: itemWidth,
                child: _buildKeyboardButton(value, itemHeight, itemWidth),
              );
            },
          ),
        ),
      ],
    );
  }

  /// 构建键盘按钮
  Widget _buildKeyboardButton(String value, double itemHeight, double itemWidth) {
    if (value == 'delete') {
      return UnconstrainedBox(
        child: ImageView(
          'assets/images/vr/icon_keyboard_delete.svg',
          width: 24.w,
          height: 24.w,
        ),
      );
    }
    if (value == 'hide') {
      return UnconstrainedBox(
        child: ImageView(
          'assets/images/vr/icon_keyboard_hide.svg',
          width: 24.w,
          height: 24.w,
        ),
      );
    }
    return Text(
      value,
      style: TextStyle(
        fontSize: 22.sp.scale,
        fontWeight: FontWeight.w700,
        color: '#303442'.hexColor,
      ),
    ).center;
  }
}
