import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/group_bet/widgets/group_bet_switch_button.dart';

import 'package:get/get.dart';

import '../controllers/sponser_controller.dart';

class SponserView extends GetView<SponserController> {
  const SponserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 47,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Obx(() {
                return GroupBetSwitchButton(
                  currentIndex: controller.index.value,
                  onToggle: (index) {
                    controller.index.value = index;
                  },
                  titles: ['热门', '时间'],
                  itemWidth: 72,
                  borderRadius: 12,
                  itemHeight: 30,
                );
              }),

            ],
          ),
        ),
        const Center(
          child: Text(
            'SponserView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
