import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';

import '../../../utils/ty_text_scaler.dart';

///球种和球种下面 联赛tab
class VrSportMenuTabBar extends StatefulWidget {
  const VrSportMenuTabBar({
    Key? key,
    this.defaultSelIndex = 0,
    required this.vrSportMenus,
    required this.onMenuChanged,
    this.topNamePrefix = 'VR',
  }) : super(key: key);

  final List<VrSportsMenuEntity> vrSportMenus;
  // 无特殊要求不需要传
  final int defaultSelIndex;
  final void Function(VrSportsMenuEntity? topMenu, VrSportsMenuEntity? subMenu)
      onMenuChanged;
  final String topNamePrefix;

  @override
  State<VrSportMenuTabBar> createState() => VrSportMenuTabBarState();
}

class VrSportMenuTabBarState extends State<VrSportMenuTabBar>
    with TickerProviderStateMixin {
  VrSportsMenuEntity? _topMenu;
  VrSportsMenuEntity? _subMenu;

  void _onTopMenuChanged() {
    if (_topMenuTabController.indexIsChanging) return;

    _topMenu = widget.vrSportMenus[_topMenuTabController.index];
    _selIndex = _topMenuTabController.index;
    _safeSetState(() {});
    _updateSubMenus();
  }

  ///支持 主动切换 _subMenuTabController
  void jumpToSubIndex(int index) {
    if (_subMenuTabController == null) return;
    if (index < 0 || index >= (_topMenu?.subList.length ?? 0)) return;
    _subMenuTabController!.animateTo(index);
    _onSubMenuChanged(); // 触发回调
  }


  void _updateSubMenus() {
    if ((_topMenu?.subList.length ?? 0) > 1) {
      _subMenuTabController = TabController(
        length: _topMenu!.subList.length,
        vsync: this,
      )..addListener(_onSubMenuChanged);
    } else {
      _subMenuTabController?.removeListener(_onSubMenuChanged);
      _subMenuTabController?.dispose();
      _subMenuTabController = null;
    }
    if (_topMenu?.subList.isNotEmpty == true) {
      _subMenu = _topMenu?.subList.first;
    }
    // 回调
    widget.onMenuChanged(_topMenu, _subMenu);
  }

  void _onSubMenuChanged() {
    if (_subMenuTabController?.indexIsChanging == true) return;
    _subMenu = _topMenu?.subList[_subMenuTabController?.index ?? 0];
    // 回调
    widget.onMenuChanged(_topMenu, _subMenu);
  }

  final Map<String, Map<String, String>> _vrSportsMenuImgs = {
    '1001': {
      'imgName': 'vr_home_football.png',
      'darkImgName': 'vr_home_football_dark.png',
      'imgNameSel': 'vr_home_football_sel.png',
    },
    '1004': {
      'imgName': 'vr_home_basketball.png',
      'darkImgName': 'vr_home_basketball_dark.png',
      'imgNameSel': 'vr_home_basketball_sel.png',
    },
    '1011': {
      'imgName': 'vr_home_horse.png',
      'darkImgName': 'vr_home_horse_dark.png',
      'imgNameSel': 'vr_home_horse_sel.png',
    },
    '1002': {
      'imgName': 'vr_home_dog.png',
      'darkImgName': 'vr_home_dog_dark.png',
      'imgNameSel': 'vr_home_dog_sel.png',
    },
    '1010': {
      'imgName': 'vr_home_motorcycle.png',
      'darkImgName': 'vr_home_motorcycle_dark.png',
      'imgNameSel': 'vr_home_motorcycle_sel.png',
    },
    '1009': {
      'imgName': 'vr_home_dirt_bike.png',
      'darkImgName': 'vr_home_dirt_bike_dark.png',
      'imgNameSel': 'vr_home_dirt_bike_sel.png',
    },
  };

  ///联赛 text
  List<Widget> get _subMenus => (_topMenu?.subList.length ?? 0) > 1
      ? List.generate(
          _topMenu!.subList.length,
          (index) {
            final menu = _topMenu!.subList[index];
            return Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Text(menu.name,
              textAlign: TextAlign.center,
              ),
            );
          },
        )
      : [];

  int _selIndex = 0;

  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  late final TabController _topMenuTabController;
  TabController? _subMenuTabController;

  @override
  void initState() {
    _topMenuTabController = TabController(
      length: widget.vrSportMenus.length,
      vsync: this,
    )..addListener(_onTopMenuChanged);
    if (widget.vrSportMenus.isNotEmpty) {
      _topMenu = widget.vrSportMenus.first;
      _updateSubMenus();
    }
    super.initState();
  }

  @override
  void dispose() {
    try {
      _topMenuTabController.removeListener(_onTopMenuChanged);
      _topMenuTabController.dispose();
      _subMenuTabController?.removeListener(_onSubMenuChanged);
      _subMenuTabController?.dispose();
    } catch (e) {
      AppLogger.debug('dispose error: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VrSportsMenuEntity? selectSport = widget.vrSportMenus[_selIndex];
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? Colors.transparent : AppColor.colorWhite,
          constraints: BoxConstraints(minWidth: Get.width),
          child: TabBar(
            controller: _topMenuTabController,
            isScrollable: true,
            indicator: const BoxDecoration(),
            labelPadding: EdgeInsets.symmetric(horizontal: 9.w),
            indicatorPadding: EdgeInsets.zero,
            tabs: List.generate(widget.vrSportMenus.length, (index) {
              final sport = widget.vrSportMenus[index];
              final isSelected = _selIndex == index;

              final imgMap = _vrSportsMenuImgs[sport.menuId];
              final imgName =
                  'assets/images/vr/${isSelected ? (imgMap?['imgNameSel'] ?? '') : (imgMap?[Get.isDarkMode ? 'darkImgName' : 'imgName'] ?? '')}';
              String eventName = widget.topNamePrefix + sport.name;
              int unreadCount = sport.count ?? 0;

              return _buildSportColumn(
                imgName: imgName,
                eventName: eventName,
                unreadCount: unreadCount,
                isSelected: isSelected,
              );
            }),
          ),
        ),
        // subMenus
       ///球种下面的联赛 tab
        if (_subMenus.isNotEmpty)
          Container(
            key: ValueKey('sub_menus_${selectSport.menuId }'),
            width: MediaQuery.of(context).size.width,
            color: Get.isDarkMode ? Colors.transparent : AppColor.colorWhite,
            padding: const EdgeInsets.only(top: 8),
            height: 35.w,
            child: TabBar(
              controller: _subMenuTabController,
              // padding: EdgeInsets.symmetric(horizontal: 2.w),
              isScrollable: true,
              // indicatorPadding: EdgeInsets.only(left: 14.w),

              labelPadding: EdgeInsets.only(bottom: 6.w),
              labelColor: context.isDarkMode ? const Color(0xFF127DCC) : '#179CFF'.hexColor,
              labelStyle: TextStyle(
                fontSize: 12.sp.scale,
                // height: 16 / 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: context.isDarkMode ? const Color(0xFFFFFFFF).withValues(alpha:0.5) :'#7981A4'.hexColor,
              unselectedLabelStyle: TextStyle(
                fontSize: 12.sp.scale,
                // height: 16 / 12,
              ),
              // indicator: UnderlineTabIndicator(
              //   borderRadius: BorderRadius.circular(2.r),
              //   borderSide: BorderSide(
              //     width: 2.sp.scale,
              //     color: context.isDarkMode ? const Color(0xFF127DCC) :'#179CFF'.hexColor,
              //   ),
              // ),
              indicator: CustomTabIndicator(
                // insets: EdgeInsets.only(left: 10,right: 10),
                width: 40,
                borderSide: BorderSide(
                  width: 3.0,
                  color:  context.isDarkMode ? const Color(0xFF127DCC) :'#179CFF'.hexColor,
                ),
              isVrSport: true
              ),
              tabs: _subMenus,
            ),
          ),
      ],
    );
  }

  Widget _buildSportColumn({
    required String imgName,
    required String eventName,
    int unreadCount = 0,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 5.w),
      child: Column(
        children: [
          const SizedBox(height: 2),
          Stack(
            clipBehavior: Clip.none,
            children: [
              ImageView(
                imgName,
                width: 24.w,
                height: 24.w,
              ),
              if (unreadCount > 0)
                Positioned(
                  right: -7,
                  top: -2,
                  child: Text(
                    '${unreadCount > 99 ? '99+' : unreadCount}',
                    style: TextStyle(
                      color: !isSelected
                          ? (Get.isDarkMode
                              ? AppColor.colorWhite.withValues(alpha:0.3)
                              : 'AFB3C8'.hexColor)
                          : (Get.isDarkMode
                              ? AppColor.colorWhite.withValues(alpha:0.9)
                              : '303442'.hexColor),
                      fontSize: TyTextScaler.instance().scale(10.sp),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          Container(height: 2.h,),
          Text(
            eventName,
            style: TextStyle(
              color: !isSelected
                  ? (Get.isDarkMode
                      ? AppColor.colorWhite.withValues(alpha:0.3)
                      : 'AFB3C8'.hexColor)
                  : (Get.isDarkMode
                      ? AppColor.colorWhite.withValues(alpha:0.9)
                      : '303442'.hexColor),
              fontSize: 10.sp.scale,
            ),
          ),
        ],
      ),
    );
  }

}
