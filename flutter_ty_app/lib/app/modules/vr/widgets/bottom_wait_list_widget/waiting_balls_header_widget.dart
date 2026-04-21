import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';


import '../../../../utils/change_skin_tone_color_util.dart';


class WaitingBallsHeaderWidget extends StatelessWidget {
  const WaitingBallsHeaderWidget({
    super.key,
    required this.hpns,
  });

  final List<String> hpns;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 18.w),
      // decoration: BoxDecoration(
      //   image: Get.isDarkMode
      //       ? DecorationImage(
      //       image: NetworkImage(
      //         OssUtil.getServerPath(
      //           'assets/images/home/match_sticky_top.png',
      //         ),
      //       ),
      //       fit: BoxFit.cover)
      //       : null,
      // ),

      child: Row(
        children: [
          const SizedBox().expanded(),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 10.sp.scale,
              color: Get.isDarkMode
                  ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()

                  : '#303442'.hexColor,
              height: 14 / 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: hpns
                  .map(
                    (e) => Text(
                      e,
                      textAlign: TextAlign.center,
                    ).expanded(),
                  )
                  .toList(),
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
