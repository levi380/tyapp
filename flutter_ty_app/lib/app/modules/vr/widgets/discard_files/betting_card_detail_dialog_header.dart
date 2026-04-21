import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/discard_files/betting_dialog_common_decoration.dart';

/// 投注详情对话框头部组件
class BettingCardDetailDialogHeader extends StatelessWidget {
  const BettingCardDetailDialogHeader({
    super.key,
    required this.type,
  });

  final int type;

  @override
  Widget build(BuildContext context) {
    if (type == 3) {
      return _buildOrderConfirmedHeader();
    }
    return _buildHeader();
  }

  /// 构建普通头部
  Widget _buildHeader() {
    return Row(
      children: [
        ImageView(
          'assets/images/vr/betting_tag_${type == 2 ? 'string' : 'single'}.png',
          width: 24.w,
          height: 24.w,
        ),
        SizedBox(width: 2.w),
        Text(
          type == 2 ? '' : '开云体育',
          style: TextStyle(
            fontSize: 16.sp.scale,
            fontWeight: FontWeight.w500,
            color: '#303442'.hexColor,
          ),
        ).expanded(),
        BettingDialogCommonDecoration(
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

  /// 构建订单确认头部
  Widget _buildOrderConfirmedHeader() {
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
}
