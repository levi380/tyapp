import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/get_x_extension.dart';

import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../config/getx_navigation.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/api/result_api.dart';
import '../../../../services/models/res/get_filter_match_list_all_entity.dart';
import '../../../login/login_head_import.dart';
import '../manager/league_manager.dart';
import 'all_league_filter_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 滚球全部 控制器 AllLeagueFilterController  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 滚球全部 控制器  AllLeagueFilterController
    - AllLeagueFilterController
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

class AllLeagueFilterController extends GetxController {
  static AllLeagueFilterController? get to =>
      Get.findOrNull<AllLeagueFilterController>();

  Function(String stid) finishCb;

  AllLeagueFilterController({required this.finishCb});
  final AllLeagueFilterlogic logic = AllLeagueFilterlogic();
  TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);


  List<String> indexNationList = [];
  List selectedList = LeagueManager.tid;

  ///原接口数据
  late List<GetFilterMatchListAllDataSportVOs> sportVOs = [];

  ///根据搜索条件删选后数据
  late List<GetFilterMatchListAllDataSportVOs> getFilterMatchList =
      sportVOs.where((item) {
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
      return item.tournamentList.any((tag) {
        return tag.nameText.toLowerCase().contains(lowerKeyword) ||
            tag.tnjc.toLowerCase().contains(lowerKeyword);

        /// 同时匹配 nameText 和 tnjc
      });
    });
  }).toList();



  @override
  void onInit() {
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
      final res = await ResultApi.instance().getFilterMatchListAll(
        LeagueManager.type.value,
        LeagueManager.euid,
        '',
        TYUserController.to.getUid(),
        'v2_h5',
        '1',
        LeagueManager.md,
      );

      print(res.data);

      logic.noData = false;
      sportVOs = res.data[0].sportVOs;
      update();

      ///初始化已选中item
      if (selectedList.isNotEmpty) {
        for (var element in sportVOs) {
          for (var element2 in element.tournamentList) {
            if (selectedList.contains(element2.id)) {
              element2.isSelect = true;
              element.isSelect =
                  element.tournamentList.every((element) => element.isSelect);
            }
          }
          logic.isSelectCount = sportVOs
              .expand((element) => element.tournamentList)
              .where((tournament) => tournament.isSelect)
              .length;
          logic.selectAll = sportVOs.every((item) {
            return item.isSelect &&
                item.tournamentList.every((tournament) => tournament.isSelect);
          });
        }
      }
      for (var element in selectedList) {
        indexNationList.add(element.spell);
      }

      for (var element in sportVOs) {
        for (var element2 in element.tournamentList) {
          if (selectedList.contains(element2.id)) {
            element2.isSelect = true;
            element.isSelect =
                element.tournamentList.every((element) => element.isSelect);
          }
        }
      }

      logic.spell = sportVOs[0].spell;
      update();
    } catch (e) {
      AppLogger.debug('获取联赛筛选数据失败: $e');
    }
  }

  /// 全选
  onSelectAll() {
    bool val = !logic.selectAll;
    logic.selectAll = val;

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤搜索列表
    getFilterMatchList = sportVOs.where((item) {
      /// 如果搜索框为空，返回所有项目
      if (searchControllerText.isEmpty) {
        return true;
      }

      /// 检查每个关键字是否在比赛的标签中
      return keywords.every((keyword) {
        /// 将关键字转换为小写
        var lowerKeyword = keyword.toLowerCase();

        /// 检查当前项目的任何标签是否包含关键字
        return item.tournamentList
            .any((tag) => tag.nameText.toLowerCase().contains(lowerKeyword));
      });
    }).toList();

    /// 搜索后的数据筛选
    var filteredTournamentList = getFilterMatchList.map((item) {
      var filteredTags = item.tournamentList.where((tag) {
        /// 检查每个关键字是否在标签名称中
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();

          /// 检查标签名称是否包含关键字
          return tag.nameText.toLowerCase().contains(lowerKeyword);
        });
      }).toList();

      /// 返回一个新的项目副本，替换标签列表为过滤后的标签
      return item.copyWith(tournamentList: filteredTags);
    }).toList();

    for (var element in getFilterMatchList) {
      element.isSelect = val;
      for (var element2 in element.tournamentList) {
        element2.isSelect = val;
      }
    }
    logic.isSelectCount = filteredTournamentList
        .expand((element) => element.tournamentList)
        .where((tournament) => tournament.isSelect)
        .length;
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

    /// 过滤 搜索条件匹配数据
    getFilterMatchList = sportVOs.where((item) {
      /// 如果搜索文本为空，返回所有项目
      if (searchControllerText.isEmpty) {
        return true;
      }

      /// 检查每个关键词是否在项目的比赛标签中匹配
      return keywords.every((keyword) {
        /// 将关键词转换为小写
        var lowerKeyword = keyword.toLowerCase();

        /// 检查项目的比赛标签是否包含该关键词
        return item.tournamentList.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      });
    }).toList();

    /// 保留过滤搜索后数据
    var filteredTournamentList = getFilterMatchList.map((item) {
      /// 过滤比赛标签
      var filteredTags = item.tournamentList.where((tag) {
        /// 检查每个关键词是否在标签名称中匹配
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      }).toList();

      /// 返回一个新的列表
      return item.copyWith(tournamentList: filteredTags);
    }).toList();

    for (var element in filteredTournamentList) {
      for (var element2 in element.tournamentList) {
        if (element2.isSelect == true) {
          ids.add(element2.id);
        }
      }
    }
    finishCb(ids.join(','));
    LeagueManager.tid.value = ids;
    Get_TY.back();
  }

  ///清空搜索栏
  onClearSearchText() {
    searchController.text = '';
    getFilterMatchList = sportVOs;
    update();
  }

  toOnVerticalDragUpdate(DragUpdateDetails details) {
    /*indicator = true;
    location = details.localPosition.dy + 10;

    double y = details.localPosition.dy;
    var itemHeight = screenHeight(Get.context!) / 2 / sportVOs.length;
    int index = (y ~/ itemHeight).clamp(0, sportVOs.length);

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
  
}
