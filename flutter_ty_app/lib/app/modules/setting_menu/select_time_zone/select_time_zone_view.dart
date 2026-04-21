import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/select_time_zone/widgets/item_widget.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/app/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import 'select_time_zone_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-92b5c1c1-aea9-4179-92a5-95a0e2cbaa93-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 时区】】】
    【【【 AUTO_PARAGRAPH_TITLE 时区 视图页面 SelectTimeZonePage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 时区 视图页面 SelectTimeZonePage
    - SelectTimeZonePage
    ```
    ///布局
    Widget _body()

    ///列表
    Widget _item()
    ```
    】】】
 *
 */
class SelectTimeZonePage extends StatefulWidget {
  const SelectTimeZonePage({Key? key}) : super(key: key);

  @override
  State<SelectTimeZonePage> createState() => _SelectTimeZonePageState();
}

class _SelectTimeZonePageState extends State<SelectTimeZonePage> {
  final controller = Get.put(SelectTimeZoneController());
  final logic = Get.find<SelectTimeZoneController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectTimeZoneController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: context.isDarkMode
              ? ChangeSkinToneColorUtil.instance()
                  .getDarkBackgroundColor(noChange: true)
              : Color(0xFFF2F2F6),
          appBar: AppBar(
            backgroundColor: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.03999999910593033)
                : Colors.white,
            elevation: 1,
            centerTitle: true,
            leadingWidth: 45.w,
            systemOverlayStyle: context.isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
            title: Text(
              LocaleKeys.app_time_zone.tr,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: _body(),
        );
      },
    );
  }

  ///布局
  Widget _body() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child:

                ///时区列表
                TimeZoneUtils.needReload

                    ///无数据加载loading
                    ? Loading(
                        backHeader: false,
                      )
                    : _item(),
          ),
          SizedBox(
            height: context.mediaQuery.padding.bottom,
          )
        ],
      ),
    );
  }

  ///列表
  Widget _item() {
    return ListViewObserver(
      controller: controller.listObserverController,
      child: ListView.builder(
          controller: controller.autoScrollController,
          padding: EdgeInsets.zero,
          itemCount: TimeZoneUtils.timeZone.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemWidget(
              isDark: context.isDarkMode,
              onTap: () => controller.onSelect(index),
              title: TimeZoneUtils.timeZone.values.toList()[index],
              isSelected: TimeZoneUtils.zoneIndex ==
                      TimeZoneUtils.timeZone.keys.toList()[index]
                  ? true
                  : false,
              dividing: true,
            );
          }),
    );
  }

  @override
  void dispose() {
    Get.delete<SelectTimeZoneController>();
    super.dispose();
  }
}
