import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/switch_button.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/systemchrome.dart';

import 'lottery_betting_switch_button.dart';

class LotteryBettingSwitchContainerWidget extends StatelessWidget {
  const LotteryBettingSwitchContainerWidget({
    Key? key,
    required this.onNewChange,
    required this.childrenTitles,
    required this.selIndex,
  }) : super(key: key);

  final List<String> childrenTitles;
  final int selIndex;
  final ValueChanged<int> onNewChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          LotteryBettingSwitchButton(
            onChanged: (value) {
              onNewChange(value);
            },
            childrenTitles: childrenTitles,
            selIndex: selIndex,
          ).expanded(),
          const SizedBox(width: 8),
          SwitchButton(
            onChild: Text(
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_daytime.tr,
            ),
            value: TyHomeController.to.homeState.isLight,
            offChild: Text(
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_night.tr,
            ),
            onChanged: (value) {
              Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
              BoolKV.theme.save(!value);
              TyHomeController.to.homeState.isLight = value;
              TyHomeController.to.update();
              SystemUtils.isDarkMode(!value);
            },
          ),
        ],
      ),
    );
  }
}
