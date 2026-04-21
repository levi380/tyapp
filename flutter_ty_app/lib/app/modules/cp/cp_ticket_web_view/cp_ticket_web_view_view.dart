import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cp_ticket_web_view_controller.dart';

class CpTicketWebViewPage extends StatefulWidget {
  const CpTicketWebViewPage({Key? key}) : super(key: key);

  @override
  State<CpTicketWebViewPage> createState() => _CpTicketWebViewPageState();
}

class _CpTicketWebViewPageState extends State<CpTicketWebViewPage> {
  final controller = Get.find<CpTicketWebViewController>();
  final logic = Get.find<CpTicketWebViewController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpTicketWebViewController>(
      builder: (controller) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: context.isDarkMode
          //       ? AppColor.titleBackgroundColor
          //       : Colors.white,
          //   elevation: 0,
          //   centerTitle: true,
          //   leading: InkWell(
          //     onTap: () => Get.back(),
          //     child: Container(
          //       alignment: Alignment.centerLeft,
          //       padding: EdgeInsets.only(
          //         left: 10.w,
          //       ),
          //       child: Icon(
          //         Icons.arrow_back_ios,
          //         size: 20.w,
          //         color: context.isDarkMode
          //             ? Colors.white
          //             : const Color(0xFF303442),
          //       ),
          //     ),
          //   ),
          //   title: Text(
          //     LocaleKeys.setting_menu_rule_description.tr,
          //     style: TextStyle(
          //       color:
          //           context.isDarkMode ? Colors.white : const Color(0xFF303442),
          //       fontSize: 16.sp.scale,
          //       fontFamily: 'PingFang SC',
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          body: controller.webviewWidget,
        );
      },
    );
  }
}
