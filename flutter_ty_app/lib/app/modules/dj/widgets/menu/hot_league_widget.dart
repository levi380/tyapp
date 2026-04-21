import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/get_x_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_static.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/dj/dj_league_search/views/dj_league_search_view.dart';
import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/league/league_search_item.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';

import '../../../../../main.dart';
import '../../../../global/config_controller.dart';
import '../../../../global/config_controller_ext.dart';
import '../../../../widgets/image_view.dart';

class HotLeagueWidgetDJ extends GetView<DJHotLeagueController> {
  const HotLeagueWidgetDJ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DJHotLeagueController>(
      init: DJHotLeagueController(),
      global: true,
      builder: (logic) {
        // return logic.isSearch ? _search() : _leagueSearch();
        return _leagueSearch();
      },
    );
  }

  _leagueSearch() {
    return Container(
      height: isIPad ? 36.h : 24.w,
      padding: isIPad
          ? EdgeInsets.only(left: 10.w, right: 10.w, top: 8.w)
          : EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              onTap: (index) {
                DJController.to.isSearch = false;
                DJController.to.searchKeyWord = '';
                controller.setSelectedIndex(index);
              },
              indicator: BoxDecoration(),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              tabs: List.generate(controller.hotLeagueList.length, (index) {
                HotLeagueInfo league = controller.hotLeagueList[index];
                bool isSelected = controller.currentIndex == index;
                if (index == 0) {
                  return Container(
                    height: 32.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      league.name,
                      style: TextStyle(
                        fontSize: isIPad ? 16.sp.scale : 12.sp.scale,
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? const Color(0xff179CFF)
                            : Get.isDarkMode
                                ? Colors.white.withAlpha(50)
                                : const Color(0xff7981A4),
                      ),
                    ),
                  );
                }
                if (league.sportConfigInfo.mi == SportConfig.Featured.sportId.toString()) {
                  return league_search_Item(
                    tilte: LocaleKeys.home_popular_featured.tr,
                    icon: ImageView(
                      isSelected
                          ? DJController.to.DJState.hotLeagueSelectedActive
                          : DJController.to.DJState.hotLeagueSelected,
                      width: 18.w,
                      height: 18.w,
                    ),
                    isSelected: isSelected,
                  );
                }
                return league_search_Item(
                  tilte: league.name,
                  icon: ImageView(
                      isSelected
                          ? league.selected
                          : (Get.isDarkMode ? league.night : league.normal),
                      cdn: true,
                      width: 18.w,
                      height: 18.w),
                  isSelected: isSelected,
                );
              }),
            ),
          ),
          Obx(() {
            return ConfigController.to.accessConfig.value.searchSwitch
                ? InkWell(
                    onTap: () async {
                      // controller.isSearch = !controller.isSearch;
                      // controller.update();
                      // controller.focusNode.requestFocus();
                      final res = await DjLeagueSearchView.show();
                      if (res != null) {
                        SportConfigInfo sportMenu = res['sportMenu'];
                        String? searchText = res['searchText'];

                        if (ObjectUtil.isNotEmpty(searchText)) {
                          DJController.to.isSearch = true;
                          DJController.to.searchKeyWord = searchText ?? '';
                          if (sportMenu.mi.toString() ==
                                  DJController.to.DJState.gameId &&
                              ConfigController.to
                                      .getDjEuid(sportMenu.mi)
                                      .toString() ==
                                  DJController.to.DJState.djListReq.euid) {
                            DJController.to.search(searchText!);
                          } else {
                            await DJController.to.changeGame(sportMenu.mi,
                                ConfigController.to.getDjEuid(sportMenu.mi));
                          }
                        } else {
                          DJController.to.isSearch = false;
                          DJController.to.searchKeyWord = '';
                          if (sportMenu.mi.toString() ==
                                  DJController.to.DJState.gameId &&
                              ConfigController.to
                                      .getDjEuid(sportMenu.mi)
                                      .toString() ==
                                  DJController.to.DJState.djListReq.euid) {
                            DJController.to.search(searchText!);
                          } else {
                            await DJController.to.changeGame(sportMenu.mi,
                                ConfigController.to.getDjEuid(sportMenu.mi));
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      child: ImageView(
                          Get.isDarkMode
                              ? DJController.to.DJState.leagueSearchDark
                              : DJController.to.DJState.leagueSearchLight,
                          width: 20.w,
                          height: 20.h),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  );
          }),
        ],
      ),
    );
  }
}

class DJHotLeagueController extends GetxController
    with GetTickerProviderStateMixin {
  static DJHotLeagueController? get to =>
      Get.findOrNull<DJHotLeagueController>();

  List<HotLeagueInfo> hotLeagueList = [];

  /// 是否显示联赛过滤赛选
  RxBool showLeageuFilter = true.obs;

  // bool isSearch = false;
  int currentIndex = 0;

  // late TextEditingController editingController;
  // RxString searchKey = ''.obs;
  // late Worker worker;
  // FocusNode focusNode = FocusNode();
  late TabController tabController;

  @override
  void onInit() {
    AppLogger.debug("editingController.onInit == ");
    // editingController = TextEditingController()
    //   ..addListener(() {
    //     AppLogger.debug("editingController.text == " + editingController.text);
    //     searchKey.value = editingController.text;
    //   });
    // worker = debounce(searchKey, (val) {
    //   DJController.to.search(val);
    // }, time: const Duration(milliseconds: 1000));
    tabController = TabController(length: 0, vsync: this);
    super.onInit();
  }

  generateHotLeagueList(List<HotLeagueInfo> hotLeagueList) {
    AppLogger.debug("generateHotLeagueList == " + hotLeagueList.first.name);
    this.hotLeagueList = hotLeagueList;
    tabController = TabController(length: hotLeagueList.length, vsync: this);
    currentIndex = 0;
    AppLogger.debug("generateHotLeagueList == " + hotLeagueList.first.name);
    update();
  }

  setSelectedIndex(int index) {
    currentIndex = index;
    update();
    // TyHomeController.to.changeLeague(hotLeagueList[index]);
    //TODO 請求接口
    DJController.to.changeLeague(hotLeagueList[index]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // editingController.dispose();
    // focusNode.dispose();
    tabController.dispose();
    super.onClose();
  }
}
