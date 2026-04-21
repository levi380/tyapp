import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/activity_turntable_detail_model.dart';
import 'package:filbet/http/entity/resp_winner_record.dart';
import 'package:filbet/src/activity/activityDetail_turntable/widgets/turntable_widget.dart';
import 'package:filbet/src/activity/activityDetail_turntable/activity_detail_turntable_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/app_utils.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/dialog/turntable_rewards_dialog.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/network_image.dart';

// 动态标题 AppBar
class _DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ActivityDetailTurntableController controller;

  const _DynamicAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomAppbar.normalTitle(
          bgColor: Color(0xFFFBF4EE),
          maxLines: 2,
          title: controller.turntableDetailModel.value.promo?.name ?? '',
        ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + Get.mediaQuery.padding.top);
}

class ActivityDetailTurntableView
    extends GetView<ActivityDetailTurntableController> {
  const ActivityDetailTurntableView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      backgroundColor: Color(0xFFFBF4EE),
      showBgTexture: false,
      appBar: _DynamicAppBar(controller: controller),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                topImageView(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tabView(),
                    winnerView(),
                    turntableAndBottomView(),
                    drawsNumView(),
                    lookRecordView(),
                    activityInfoTop(),
                    rewardsImageView(),
                    activityInfo(),
                    SizedBox(
                      height: 20.r,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget topImageView() {
    return Obx(() {
      return SKNetworkImage(
        imageUrl:
            controller.turntableDetailModel.value.config?.pageConfig?.h5Main ??
                '',
        placeholderType: 1,
        fit: BoxFit.fitWidth,
        expand: false,
      );
    });
  }

  Widget tabView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.r),
      margin: EdgeInsets.only(top: 443.r),
      child: Obx(() {
        List<Plays> plays =
            controller.turntableDetailModel.value.config?.plays ?? [];
        if (plays.length <= 1) {
          return SizedBox();
        }
        return Row(
          spacing: 15.r,
          children: [
            if (plays.isNotEmpty) tabItemView(plays[0].h5Title ?? '', 0),
            if (plays.length >= 2) tabItemView(plays[1].h5Title ?? '', 1),
          ],
        );
      }),
    );
  }

  Widget winnerView() {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.clickWinnerRecord();
        },
        child: Container(
          height: 30.r,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            left: 14.r,
            right: 14.r,
            bottom: 20.r,
            top: 26.r,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFEFEFC),
                Color(0xFFFBEEEA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE8D2CB),
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: controller.winnerRecord.isEmpty
                ? SizedBox.shrink()
                : _WinnerScrollView(
                    winnerRecords: controller.winnerRecord,
                  ),
          ),
        ),
      );
    });
  }

  Widget turntableAndBottomView() {
    return SizedBox(
      height: Get.width - 15.r * 2 + 70.r,
      child: Stack(
        children: [
          Positioned(
            bottom: 71.r,
            left: 15.r,
            right: 15.r,
            child: turntableView(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomImageView(),
          ),
        ],
      ),
    );
  }

  Widget turntableView() {
    return Obx(() {
      List<Plays> plays =
          controller.turntableDetailModel.value.config?.plays ?? [];
      if (controller.tabIndex.value < plays.length) {
        Plays currentPlay = plays[controller.tabIndex.value];
        List<Prizes> prizes = currentPlay.prizes ?? [];

        // 提取奖品名字列表（从 prizes 中获取 prizeName）
        List<String> prizeNames = prizes
            .map((prize) => prize.prizeName ?? '')
            .where((name) => name.isNotEmpty)
            .toList();

        // 提取奖品图片URL列表（从 prizes 中获取 prizeImg）
        List<String> prizeImages = prizes
            .map((prize) => prize.prizeImg ?? '')
            .where((img) => img.isNotEmpty)
            .toList();

        // 使用奖品数量作为 itemCount，如果为空则使用默认值 10
        final itemCount = prizes.isNotEmpty ? prizes.length : 10;

        return Container(
          alignment: Alignment.center,
          child: TurntableWidget(
            itemCount: itemCount,
            size: Get.width - 15.r * 2,
            prizeNames: prizeNames.isNotEmpty ? prizeNames : null,
            prizeImages: prizeImages.isNotEmpty ? prizeImages : null,
            onSpin: () async {
              if (controller.remainingTimes.value <= 0) {
                AppUtils.showToast('可抽次数不足');
                throw Exception('可抽次数不足'); // 抛出异常，阻止转盘转动
              }
              var resp = await controller.applyTurntableActivity();
              if (resp == null) {
                throw Exception('抽奖失败'); // 如果API失败，也阻止转盘转动
              }
              int index = prizes.indexWhere((element) {
                return element.prizeId == resp.prizeId;
              });
              if (index < 0) {
                throw Exception('未找到对应奖品'); // 如果找不到奖品，也阻止转盘转动
              }
              // controller.queryActivityDetail();
              return index; // 返回 prizeIndex (0~9)
            },
            onFinish: (index) {
              print('抽中了 $index');
              if (index >= 0) {
                Get.dialog(
                  TurntableRewardsDialog(model: prizes[index]),
                  barrierColor: Color(0xFF000000),
                );
              }
            },
          ),
        );
      }
      return Container(
        alignment: Alignment.center,
        width: Get.width - 15.r * 2,
        height: Get.width - 15.r * 2,
      );
    });
  }

  Widget bottomImageView() {
    return Obx(() {
      List<Plays> plays =
          controller.turntableDetailModel.value.config?.plays ?? [];
      if (controller.tabIndex.value < plays.length) {
        return SKNetworkImage(
          imageUrl: plays[controller.tabIndex.value].h5SpinnerBg ?? '',
          placeholderType: 1,
          width: Get.width - 30.r,
          height: Get.width * 124 / 354,
          fit: BoxFit.fitWidth,
          expand: false,
        );
      }
      return SizedBox();
    });
  }

  Widget drawsNumView() {
    return Container(
      width: 170.r,
      height: 42.r,
      margin: EdgeInsets.only(top: 100.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.activityBgDrawsNum,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '可抽 ',
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 16.sp,
            ),
          ),
          Obx(() {
            List<Plays> plays =
                controller.turntableDetailModel.value.config?.plays ?? [];
            num play1Count =
                controller.turntableDetailModel.value.times?.play1Available ??
                    0;
            num play2Count =
                controller.turntableDetailModel.value.times?.play2Available ??
                    0;
            if (controller.tabIndex.value < plays.length) {
              controller.remainingTimes.value =
                  plays[controller.tabIndex.value].playType == 1
                      ? play1Count.toInt()
                      : play2Count.toInt();
            }
            return Text(
              '${controller.remainingTimes.value}',
              style: TextStyle(
                color: appnewColors.textBlue,
                fontSize: 16.sp,
              ),
            );
          }),
          Text(
            ' 次',
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget lookRecordView() {
    return Container(
      margin: EdgeInsets.only(top: 16.r),
      child: InkWell(
        onTap: () {
          controller.clickRecord();
        },
        child: Text(
          '查看您的抽奖记录 >>',
          style: TextStyle(
            color: appnewColors.textBlue,
          ),
        ),
      ),
    );
  }

  Expanded tabItemView(String title, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.tabIndex.value = index;
        },
        child: Container(
          height: 40.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: controller.tabIndex.value == index
                ? null
                : Border.all(
                    color: Color(0xFFD5D7DF),
                    width: 1,
                  ),
            gradient: LinearGradient(
              colors: [
                controller.tabIndex.value == index
                    ? Color(0xFF8EBBFC)
                    : Colors.white,
                controller.tabIndex.value == index
                    ? Color(0xFF4793FF)
                    : Colors.white,
              ],
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: controller.tabIndex.value == index
                  ? Colors.white
                  : appnewColors.textMain,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget rewardsImageView() {
    return Obx(() {
      List<Plays> plays =
          controller.turntableDetailModel.value.config?.plays ?? [];
      if (controller.tabIndex.value < plays.length) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 14.r, vertical: 15.r),
          child: SKNetworkImage(
            imageUrl: plays[controller.tabIndex.value].h5PrizeList ?? '',
            placeholderType: 1,
            width: Get.width - 30.r,
            height: Get.width * 368 / 347,
            fit: BoxFit.fitWidth,
            expand: false,
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget activityInfoTop() {
    return Obx(() {
      List<Plays> plays =
          controller.turntableDetailModel.value.config?.plays ?? [];
      if (controller.tabIndex.value < plays.length) {
        Plays model = plays[controller.tabIndex.value];
        return Container(
          margin: EdgeInsets.only(top: 25.r),
          child: activityInfoContainer(
            Column(
              children: [
                activityInfoItemView(
                    '活动对象', model.targetType == 1 ? '全部会员' : '指定等级'),
                activityInfoItemView('抽奖次数',
                    '每${model.getAmount ?? '--'}元${model.getType == 1 ? '有效投注' : '存款'}可获得1次抽奖机会'),
                activityInfoItemView('抽奖时间',
                    '${formatTimestampToTime01(controller.turntableDetailModel.value.promo?.startAt ?? 0)}至${formatTimestampToTime01(controller.turntableDetailModel.value.promo?.endAt?.toInt() ?? 0)}'),
              ],
            ),
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget activityInfo() {
    return activityInfoContainer(
      Obx(() {
        return Html(
          shrinkWrap: true,
          data: controller.turntableDetailModel.value.promo?.summary ?? '',
          onLinkTap: (
            String? url,
            Map<String, String> attributes,
            element,
          ) {
            controller.openExternalLinks(url);
          },
        );
      }),
    );
  }

  Widget activityInfoContainer(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.r),
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.activityActivityInfoTitle,
            height: 26.r,
          ),
          child,
        ],
      ),
    );
  }

  Widget activityInfoItemView(String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 12.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: appnewColors.textMain,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 8.r),
          Text(
            content,
            style: TextStyle(
              color: appnewColors.textSecond,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

/// 中奖记录向上滚动组件
class _WinnerScrollView extends StatefulWidget {
  final List<WinnerRecord> winnerRecords;

  const _WinnerScrollView({
    required this.winnerRecords,
  });

  @override
  State<_WinnerScrollView> createState() => _WinnerScrollViewState();
}

class _WinnerScrollViewState extends State<_WinnerScrollView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.winnerRecords.length;
        });
        _controller.reset();
        if (widget.winnerRecords.length > 1) {
          _controller.forward();
        }
      }
    });

    if (widget.winnerRecords.length > 1) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatWinnerText(WinnerRecord record) {
    // 格式化用户名（隐藏中间部分）
    String username = record.username ?? '';
    String displayName = username;
    if (username.length > 4) {
      displayName =
          '${username.substring(0, 2)}****${username.substring(username.length - 2)}';
    }

    // 格式化奖品名称和金额
    String prizeName = record.prizeName ?? '';
    String rewardAmount = record.rewardAmount ?? '0';

    return '恭喜$displayName抽中$prizeName ${rewardAmount}元礼金';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.winnerRecords.isEmpty) {
      return SizedBox.shrink();
    }

    final currentRecord = widget.winnerRecords[_currentIndex];
    final nextIndex = (_currentIndex + 1) % widget.winnerRecords.length;
    final nextRecord = widget.winnerRecords[nextIndex];

    return Container(
      height: 30.r,
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // 当前显示的记录（向上移出）
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(0, -_animation.value * 30.r),
                  child: Opacity(
                    opacity: 1 - _animation.value,
                    child: Text(
                      _formatWinnerText(currentRecord),
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              // 下一个记录（从下方移入）
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(0, (1 - _animation.value) * 30.r),
                  child: Opacity(
                    opacity: _animation.value,
                    child: Text(
                      _formatWinnerText(nextRecord),
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
