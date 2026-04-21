
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/vr_horse_view_common_decoration.dart';

/// VR赛马视图订单相关组件
/// 包含订单确认头部、订单总计和确认按钮
class VrHorseOrderWidgets {
  /// 构建订单确认头部
  /// 显示订单已确认的图标和文本
  static Widget buildOrderConfirmedHeader() {
    return Column(
      children: [
        ImageView(
          'assets/images/vr/betting_order_status_confirmed.svg',
          width: 140.w,
        ),
        SizedBox(height: 8.w),
        Text(
          '注单已确认',
          style: TextStyle(
            fontSize: 16.sp.scale,
            fontWeight: FontWeight.w500,
            color: '#179CFF'.hexColor,
          ),
        ),
      ],
    );
  }

  /// 构建订单总计和确认按钮
  /// 显示投注金额、可赢金额、注单号等信息，以及确认按钮
  static Widget buildOrderTotalAndConfirm() {
    return Column(
      children: [
        SizedBox(height: 4.w),
        VrHorseViewCommonDecoration(
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
  /// [title] 标题文本
  /// [subtitle] 副标题文本
  /// [subtitleStyle] 副标题样式（可选）
  static Widget _buildTotalRow({
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

