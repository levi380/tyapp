import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/http/entity/activity_turntable_detail_model.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TurntableRewardsDialog extends StatefulWidget {
  const TurntableRewardsDialog({
    super.key,
    required this.model,
  });

  final Prizes model;

  @override
  State<TurntableRewardsDialog> createState() => _TurntableRewardsDialogState();
}

class _TurntableRewardsDialogState extends State<TurntableRewardsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 旋转的背景图片
          RotationTransition(
            turns: _animation,
            child: Container(
              width: Get.width - 16.r,
              height: Get.width - 16.r,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.activityBgDialog),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // 不旋转的内容
          Container(
            width: 317.r,
            height: 272.r,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.activityBgTurntableReward),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 65.r),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.1667, 0.7917],
                        colors: [
                          Color(0xFFFBF7B5),
                          Color(0xFFFFDE6F),
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      "恭喜您抽中",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.r),
                  child: Text(
                    widget.model.rewardType == 2
                        ? '${widget.model.rewardValue}'
                        : '${widget.model.rewardValue ?? ''}元礼金',
                    style: TextStyle(
                      color: Color(0xffFFDECC),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 36.r,
                    width: 210.r,
                    margin: EdgeInsets.only(bottom: 17.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFAD89),
                          Color(0xFFFD3838),
                        ],
                      ),
                    ),
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
