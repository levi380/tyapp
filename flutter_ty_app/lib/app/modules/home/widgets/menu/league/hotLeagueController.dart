import 'package:flutter_ty_app/app/extension/get_x_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/models/hot_league_info.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';


class HotLeagueController extends GetxController
    with GetTickerProviderStateMixin {
  static HotLeagueController? get to => Get.findOrNull<HotLeagueController>();

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
    // editingController = TextEditingController()
    //   ..addListener(() {
    //     searchKey.value = editingController.text;
    //   });
    // worker = debounce(searchKey, (val) {
    //   TyHomeController.to.search(val);
    // }, time: const Duration(milliseconds: 1000));
    tabController = TabController(length: 0, vsync: this);
    super.onInit();
  }

  generateHotLeagueList(List<HotLeagueInfo> hotLeagueList) {
    this.hotLeagueList = hotLeagueList;
    tabController = TabController(length: hotLeagueList.length, vsync: this);
    currentIndex = 0;
    update();
  }

  setSelectedIndex(int index) {
    currentIndex = index;
    update();
    TyHomeController.to.changeLeague(hotLeagueList[index]);
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
