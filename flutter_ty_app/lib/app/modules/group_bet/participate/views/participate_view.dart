import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/participate_controller.dart';

class ParticipateView extends GetView<ParticipateController> {
  const ParticipateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'ParticipateView is working',
          style: TextStyle(fontSize: 20),
        ),
    );
  }
}
