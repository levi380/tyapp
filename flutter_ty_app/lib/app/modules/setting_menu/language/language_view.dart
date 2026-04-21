import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/language/widgets/language_item.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';
import '../../../db/app_cache.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import 'language_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-c9236939-488f-4411-b9f4-78a79e1f9e8e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 切换语言】】】
    【【【 AUTO_PARAGRAPH_TITLE 切换语言 视图 LanguagePage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 切换语言 视图 LanguagePage
    - LanguagePage
    ```
    ///头部组件
    _title(context),

    ///列表组件
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: loadListLanguages(),
    ),
    ```
    】】】
 *
 */
class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final logic = Get.find<LanguageLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageLogic>(builder: (logic) {
      return Scaffold(
        body: _body(),
      );
    });
  }

  Widget _body() {
    return Container(
      color: context.isDarkMode
          ? ChangeSkinToneColorUtil.instance()
              .getDarkBackgroundColor(noChange: true)
          : Colors.white,
      child: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              ///头部组件
              _title(context),
              Container(
                height: 10.h,
                color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
              ),

              ///列表组件
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: loadListLanguages(),
              ),
              Expanded(
                child: Container(
                  height: 10.h,
                  color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
                ),
              ),
            ],
          ),
          Obx(() => MainTabController.to.isFireworksPaly.value &&
                  FireworksController.to.isFireworksActivityValid(
                      MainTabController.to.activityEntity,
                      FireworksController.to.serverNow)
              ? FireworksAnimation(
                  id: MainTabController.to.fireworksId.value,
                  beginTime: MainTabController.to.beginTime.value,
                  endTime: MainTabController.to.endTime.value,
                  type: MainTabController.to.fireworksType.value,
                  number: MainTabController.to.fireworksNumber,
                  championName: MainTabController.to.championName.value,
                  championIcon: MainTabController.to.championIcon.value,
                )
              : Container()),
        ],
      )),
    );
  }

  /**
   * 标题
   */
  Widget _title(BuildContext context) {
    return Container(
      color: context.isDarkMode
          ? Colors.white.withValues(alpha: 0.03999999910593033)
          : Colors.white,
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () {
                if (!logic.state.changelan) {
                  Get.back();
                }
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.setting_menu_chan_lan.tr,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: SizedBox(
              width: 25.w,
            ),
          ),
        ],
      ).marginOnly(left: 14.w, right: 14.w),
    );
  }

  /**
   * 列表组件
   */
  List<Widget> loadListLanguages() {
    ///初始化语言列表
    logic.getLanguage();
    List<Widget> children = [];
    //获取当前语言
    String language = StringKV.language.get() ?? "";
    int current = 0;
    if (language.isNotEmpty) {
      for (int i = 0; i < logic.state.itemLanguage.length; i++) {
        if (logic.state.itemLanguage[i].contains(language)) {
          current = i;
          break;
        }
      }
    }
    //设置国际化条目
    for (int i = 0; i < logic.state.itemName.length; i++) {
      children.add(LanguageItem(
        title: logic.state.itemName[i],
        imageUrl: logic.state.itemIcon[i],
        isSelected: i == current,
        onTap: () {
          //切换语言的事件处理
          logic.setLanguage(logic.state.itemLanguage[i]);
        },
      ));
    }
    return children;
  }
}
