import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../generated/locales.g.dart';

class WhWidget extends StatelessWidget {
  const WhWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            context.isDarkMode
                ? 'assets/images/cp_zr_menu/wh_night.png'
                : 'assets/images/cp_zr_menu/wh_light.png',
            width: 240.w,
            height: 240.w,
          ),
          20.verticalSpaceFromWidth,
          Text(
            LocaleKeys.zr_cp_Lottery_Bet_Slips_under_maintenance.tr,
            style: TextStyle(
              fontSize: 14.sp.scale,
              fontWeight: FontWeight.w400,
              color: context.isDarkMode
                  ? const Color(0xFFFFFFFF).withValues(alpha:0.5)
                  : const Color(0xFF7981A4),
            ),
          )
        ],
      ),
    );
  }
}
