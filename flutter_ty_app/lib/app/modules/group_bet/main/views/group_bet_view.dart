import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/group_bet/sponser/views/sponser_view.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/balance_widget.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../participate/views/participate_view.dart';
import '../../widgets/group_bet_switch_button.dart';
import '../controllers/group_bet_controller.dart';

class GroupBetView extends GetView<GroupBetController> {
  const GroupBetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 44,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ).paddingOnly(left: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ongoing);
                          },
                          child: Text(
                            '合买大厅',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Color(0xFF303442),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      return GroupBetSwitchButton(
                        currentIndex: controller.index.value,
                        onToggle: (index) {
                          controller.index.value = index;
                        },
                        titles: ['发起', '参与'],
                        itemWidth: 48,
                        itemHeight: 30,
                        borderRadius: 8,
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BalanceWidget().marginOnly(right: 16),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (controller.index.value == 0) {
                  return SponserView();
                } else {
                  return ParticipateView();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
