import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/get_x_extension.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/services/api/result_api.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_filter_match_list_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../login/login_head_import.dart';
import 'league_filter_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 控制器 LeagueFilterController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 控制器 LeagueFilterController
    - LeagueFilterController
    ```
    ///全选
    bool selectAll = false;

    ///指示器图片状态
    bool indicator = false;

    ///有无数据状态
    bool noData = false;
    int currentIndex = 0;
    double location = 0;

    /// 只有一条数据 不显示分组头
    bool onlyOne = false;

    bool click = true;

    List<String> indexNationList = [];
    List selectedList = LeagueManager.tid;

    ///源数据列表
    late List<GetFilterMatchListData> getFilterMatchListData = [];

    ///搜索筛选后数据
    late List<GetFilterMatchListData> getFilterMatchList =
    getFilterMatchListData.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
    return true;
    }

    return keywords.every((keyword) {
    var lowerKeyword = keyword.toLowerCase();
    return item.sportVOs[0].tournamentList.any((tag) {
    return tag.nameText.toLowerCase().contains(lowerKeyword) ||
    tag.tnjc.toLowerCase().contains(lowerKeyword);

    /// 同时匹配 nameText 和 tnjc
    });
    });
    }).toList();
    ```
    】】】
 *
 */

class LeagueFilterController extends GetxController {
  static LeagueFilterController? get to =>
      Get.findOrNull<LeagueFilterController>();

  Function(String stid) finishCb;

  LeagueFilterController({required this.finishCb});
  final LeagueFilterlogic logic = LeagueFilterlogic();
  TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);



  List<String> indexNationList = [];
  List selectedList = LeagueManager.tid;

  ///源数据列表
  late List<GetFilterMatchListData> getFilterMatchListData = [];

  ///搜索筛选后数据
  late List<GetFilterMatchListData> getFilterMatchList =
      getFilterMatchListData.where((item) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    if (searchControllerText.isEmpty) {
      return true;
    }

    return keywords.every((keyword) {
      var lowerKeyword = keyword.toLowerCase();
      return item.sportVOs[0].tournamentList.any((tag) {
        return tag.nameText.toLowerCase().contains(lowerKeyword) ||
            tag.tnjc.toLowerCase().contains(lowerKeyword);

        /// 同时匹配 nameText 和 tnjc
      });
    });
  }).toList();



  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) {
        Bus.getInstance().emit(EventType.tyOpenDialog);
      }
    });

    ///初始化数据
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    autoScrollController = AutoScrollController();
    super.onReady();
  }

  @override
  void onClose() {
    autoScrollController.dispose();
    super.onClose();
  }

  ///获取联赛筛选数据
  Future<void> initData() async {
    try {
      logic.noData = true;
      final res = await ResultApi.instance().getFilterMatchList(
        LeagueManager.type.value,
        LeagueManager.euid,
        '',
        TYUserController.to.getUid(),
        'v2_h5',
        '1',
        LeagueManager.md,
      );
      logic.noData = false;
      getFilterMatchListData = res.data;
      if (selectedList.isNotEmpty) {
        for (var element in getFilterMatchListData) {
          for (var element2 in element.sportVOs[0].tournamentList) {
            if (selectedList.contains(element2.id)) {
              element2.isSelect = true;
              element.isSelect = element.sportVOs[0].tournamentList
                  .every((element) => element.isSelect);
            }
          }
        }
        logic.isSelectCount = getFilterMatchListData
            .expand((element) => element.sportVOs[0].tournamentList)
            .where((element2) => element2.isSelect)
            .length;
        logic.selectAll = getFilterMatchListData.every((item) {
          return item.isSelect &&
              item.sportVOs[0].tournamentList
                  .every((tournament) => tournament.isSelect);
        });
      }
      for (var element in getFilterMatchListData) {
        indexNationList.add(element.spell);
      }
      logic.spell = getFilterMatchListData[0].spell;
      update();
    } catch (e) {
      logic.noData = false;
      update();
      AppLogger.debug('e ${e.toString()}');
    }
  }

  /// 全选
  onSelectAll() {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 搜索条件后的列表
    getFilterMatchList = getFilterMatchListData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }

      /// 检查每个关键字是否在与列表匹配
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查第一个 sportVO 的任何标签是否包含关键字
        return item.sportVOs[0].tournamentList
            .any((tag) => tag.nameText.toLowerCase().contains(lowerKeyword));
      });
    }).toList();

    ///搜索过滤后的列表
    var filteredTournamentList = getFilterMatchList.map((item) {
      /// 创建一个新的项目副本，替换 sportVOs 列表
      var newItem = item.copyWith(
        sportVOs: item.sportVOs.map((sportVO) {
          /// 对每个 sportVO 进行标签过滤
          return sportVO.copyWith(
            tournamentList: sportVO.tournamentList.where((tag) {
              /// 检查每个关键字是否在标签名称中
              return keywords.every((keyword) {
                var lowerKeyword = keyword.toLowerCase();

                /// 检查标签名称是否包含关键字
                return tag.nameText.toLowerCase().contains(lowerKeyword);
              });
            }).toList(),
          );
        }).toList(),
      );
      return newItem;
    }).toList();

    if (filteredTournamentList.isNotEmpty) {
      bool val = !logic.selectAll;
      logic.selectAll = val;

      for (var element in getFilterMatchList) {
        element.isSelect = val;
        for (var element2 in element.sportVOs[0].tournamentList) {
          element2.isSelect = val;
        }
      }

      logic.isSelectCount = filteredTournamentList
          .expand((element) => element.sportVOs[0].tournamentList)
          .where((tournament) => tournament.isSelect)
          .length;
    }

    update();
  }

  /// 点击完成
  onFinish() {
    List<String> ids = [];

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    getFilterMatchList = getFilterMatchListData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();
        return item.sportVOs[0].tournamentList.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);
        });
      });
    }).toList();

    var filteredTournamentList = getFilterMatchList.map((item) {
      var newItem = item.copyWith(
        sportVOs: item.sportVOs.map((sportVO) {
          return sportVO.copyWith(
            tournamentList: sportVO.tournamentList.where((tag) {
              return keywords.every((keyword) {
                var lowerKeyword = keyword.toLowerCase();

                /// 同时匹配 nameText 和 tnjc 字段
                return tag.nameText.toLowerCase().contains(lowerKeyword) ||
                    tag.tnjc.toLowerCase().contains(lowerKeyword);
              });
            }).toList(),
          );
        }).toList(),
      );
      return newItem;
    }).toList();

    for (var element in filteredTournamentList) {
      for (var element2 in element.sportVOs[0].tournamentList) {
        if (element2.isSelect == true) {
          ids.add(element2.id);
        }
      }
    }
    finishCb(ids.join(','));
    LeagueManager.tid.value = ids;
    Get.back();
  }

  ///清空搜索栏
  onClearSearchText() {
    searchController.text = '';
    getFilterMatchList = getFilterMatchListData;
    update();
  }

  ///***************** GestureDetector 拖拽更新回调  *****************///
  toOnVerticalDragUpdate(DragUpdateDetails details) {
    /*  indicator = true;
    location = details.localPosition.dy + 10;

    double y = details.localPosition.dy;
    var itemHeight = screenHeight(Get.context!) / 2 / getFilterMatchListData.length;
    int index = (y ~/ itemHeight).clamp(0, getFilterMatchListData.length);

    slidingUpdate(index);
    currentIndex = index;
    update();*/
  }

  void slidingUpdate(int index) {
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }

  toOnVerticalDragDown(DragDownDetails details) {
    logic.location = (details.localPosition.dy - details.localPosition.dx) - 13;
    update();
  }

  toOnVerticalDragEnd(DragEndDetails details) {
    logic.indicator = false;
    update();
  }

  ///监听当前联赛头部下标
  onObserves(index) {
    if (logic.click == true) {
      /// 获取用户输入的文本并转换为小写
      String searchControllerText = searchController.text.toLowerCase();

      /// 将输入文本按字符分割成列表
      List<String> keywords = searchControllerText.split('');

      /// 使用 map 方法遍历每个字符串，并去掉头尾空格
      keywords = keywords.map((keyword) => keyword.trim()).toList();

      getFilterMatchList = getFilterMatchListData.where((item) {
        if (searchControllerText.isEmpty) {
          return true;
        }
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();
          return item.sportVOs[0].tournamentList.any((tag) {
            return tag.nameText.toLowerCase().contains(lowerKeyword) ||
                tag.tnjc.toLowerCase().contains(lowerKeyword);
          });
        });
      }).toList();

      for (int i = 0; i < getFilterMatchList.length; i++) {
        if (i == index) {
          logic.spell = getFilterMatchList[i].spell;
        }
      }

      update();
    }
  }

}
