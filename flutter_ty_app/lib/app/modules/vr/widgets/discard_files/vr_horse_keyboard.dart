
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_common_decoration.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_common_box_shadow.dart';

/// VR赛马视图键盘组件
/// 包含快速输入和数字键盘功能
class VrHorseKeyboard extends StatelessWidget {
  const VrHorseKeyboard({
    super.key,
    required this.quickValue,
  });

  /// 快速输入选中的值
  final ValueNotifier<int?> quickValue;

  @override
  Widget build(BuildContext context) {
    return VrHorseViewCommonDecoration(
      padding: EdgeInsets.all(4.w),
      borderRadius: 12.w,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // -1 防止四舍五入超过总宽度导致换行
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

  /// 构建快速输入区域
  /// [maxWidth] 最大宽度，用于计算每个按钮的宽度
  Widget _buildQuickInput(double maxWidth) {
    final values = [
      100,
      500,
      1000,
      2000,
      5000,
    ];
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
              valueListenable: quickValue,
              builder: (context, selValue, child) {
                return Stack(
                  children: [
                    VrCommonBoxShadow(
                      onTap: () {
                        // 设置选中的快速输入值
                        quickValue.value = value;
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
  /// [maxWidth] 最大宽度，用于计算每个按钮的宽度
  Widget _buildKeyboard(double maxWidth) {
    final numValues = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      '.',
      0,
      '00',
    ];
    final funcValues = [
      '最大',
      'delete',
      'hide',
    ];
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
                    ? itemHeight * 2.w + 4.w
                    : value == 'delete1'
                        ? 0
                        : itemHeight,
                width: itemWidth,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        return VrCommonBoxShadow(
                          height: value == 'delete'
                              ? itemHeight * 2.w + 4.w
                              : itemHeight,
                          width: itemWidth,
                          child: Builder(
                            builder: (context) {
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
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

