import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../../../../main.dart';
import '../../../../login/login_head_import.dart';

class league_search_Item extends StatelessWidget {
  const league_search_Item({
    super.key,
    required this.tilte,
    // required this.onTap,
    required this.icon,
    required this.isSelected,
  });

  final Widget icon;
  final String tilte;
  final bool isSelected;
  // final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 4,
          ),
          Text(
            tilte,
            style: TextStyle(
              fontSize: isIPad ? 14.sp.scale : 12.sp.scale,
              fontWeight: FontWeight.w400,
              color: isSelected
                  ? const Color(0xff179CFF)
                  : context.isDarkMode
                      ? Colors.white.withAlpha(50)
                      : const Color(0xff7981A4),
            ),
          )
        ],
      ),
    );
  }
}
