import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../../utils/oss_util.dart';
import '../widget/basketball_remain_time_widget.dart';

///头部篮球结束页面
class BasketballFinishedWidget extends StatefulWidget {
  const BasketballFinishedWidget({
    super.key,
    required this.teams,
    required this.mhlu,
    required this.malu,
    this.score,
    this.onNextMatchCountdownEnd,
  });

  final List<String> teams;
  final String mhlu;
  final String malu;
  final VrSportReplayDetailScoreRanking? score;
  final VoidCallback? onNextMatchCountdownEnd;

  @override
  State<BasketballFinishedWidget> createState() =>
      _BasketballFinishedWidgetState();
}

class _BasketballFinishedWidgetState extends State<BasketballFinishedWidget> {
  bool _showFinish = false;

  @override
  void initState() {
    5.seconds.delay(() {
      _showFinish = true;
      if (mounted) setState(() {});
    });
    15.seconds.delay(() {
      widget.onNextMatchCountdownEnd?.call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_showFinish) {
      return const BasketballRemainTimeWidget(isFinish: true);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                OssUtil.getServerPath(
                  'assets/images/vr/vr_basketball_finished_top_bg.png',
                ),
              ),
              scale: 3,
            ),
          ),
          padding:  EdgeInsets.symmetric(horizontal: 26.w, vertical: 2.w),
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.virtual_sports_match_status_ended.tr,
            style: TextStyle(
              color: '#303442'.hexColor,
              fontSize: 10.sp.scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              color: AppColor.colorWhite,
              constraints:  BoxConstraints(minHeight: 54.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints:  BoxConstraints(minWidth: 80.w),
                    alignment: Alignment.center,
                    child: Text(
                      widget.teams.firstOrNull ?? '布莱顿海鸥',
                      style: TextStyle(
                        color: '#303442'.hexColor,
                        fontSize: 12.sp.scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: '#303442'.hexColor,
                    constraints:
                         BoxConstraints(minWidth: 36.w, minHeight: 28.w),
                    alignment: Alignment.center,
                    child: Text(
                      widget.score?.home ?? '0',
                      style: TextStyle(
                        color: AppColor.colorWhite,
                        fontSize: 20.sp.scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                   SizedBox(width: 4.w),
                  Container(
                    color: '#303442'.hexColor,
                    constraints:
                         BoxConstraints(minWidth: 36.w, minHeight: 28.w),
                    alignment: Alignment.center,
                    child: Text(
                      widget.score?.away ?? '0',
                      style: TextStyle(
                        color: AppColor.colorWhite,
                        fontSize: 20.sp.scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    constraints:  BoxConstraints(minWidth: 80.w),
                    alignment: Alignment.center,
                    child: Text(
                      widget.teams.lastOrNull ?? '维拉人',
                      style: TextStyle(
                        color: '#303442'.hexColor,
                        fontSize: 12.sp.scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -18.w,
              child: ImageView(
                widget.mhlu,
                cdn: true,
                width: 36.w,
                height: 36.w,
              ),
            ),
            Positioned(
              right: -18.w,
              child: ImageView(
                widget.malu,
                cdn: true,
                width: 36.w,
                height: 36.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
