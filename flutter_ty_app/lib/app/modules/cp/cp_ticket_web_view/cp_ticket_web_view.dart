import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cp_ticket_web_view_controller.dart';

class CpTicketWebPage extends StatefulWidget {
  const CpTicketWebPage({Key? key}) : super(key: key);

  @override
  State<CpTicketWebPage> createState() => _CpTicketWebViewPageState();
}

class _CpTicketWebViewPageState extends State<CpTicketWebPage> {
  final controller = Get.find<CpTicketWebViewController>();
  final logic = Get.find<CpTicketWebViewController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpTicketWebViewController>(
      builder: (controller) {
        return Scaffold(
          body: controller.webviewWidget,
        );
      },
    );
  }
}
