import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/get_filter_match_list_new_d_entity.dart';
import '../../login/login_head_import.dart';
import '../../setting_menu/league_filter/manager/league_manager.dart';
import 'djvr_league_filter_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 联赛筛选 控制器 DjVrLeagueFilterController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞赛果冠军赛果 联赛筛选 控制器 DjVrLeagueFilterController
    - DjVrLeagueFilterController
    ```
    ///源数据
    late List<GetFilterMatchListNewDData> getFilterMatchListNewsData = [];

    ///搜索删选后数据
    late List<GetFilterMatchListNewDData> getFilterMatchListNews =
    getFilterMatchListNewsData.where((item) {
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

    return item.tournaments.any((tag) {
    return tag.nameText.toLowerCase().contains(lowerKeyword) ||
    tag.tnjc.toLowerCase().contains(lowerKeyword);

    /// 同时匹配 nameText 和 tnjc
    });
    });
    }).toList();

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
    ```
    】】】
 *
 */
class DjVrLeagueFilterController extends GetxController {
  Function(String stid) finishCb;

  DjVrLeagueFilterController({required this.finishCb});

  final DjVrLeagueFilterlogic logic = DjVrLeagueFilterlogic();

  TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);

  ///源数据
  late List<GetFilterMatchListNewDData> getFilterMatchListNewsData = [];

  ///搜索删选后数据
  late List<GetFilterMatchListNewDData> getFilterMatchListNews =
      getFilterMatchListNewsData.where((item) {
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

      return item.tournaments.any((tag) {
        return tag.nameText.toLowerCase().contains(lowerKeyword) ||
            tag.tnjc.toLowerCase().contains(lowerKeyword);

        /// 同时匹配 nameText 和 tnjc
      });
    });
  }).toList();



  List<String> indexNationList = [];
  List selectedList = LeagueManager.tid;


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

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  ///获取联赛筛选数据
  Future<void> initData() async {
    logic.downloadData = true;
    logic.noData = true;
    final res = await ResultApi.instance().getFilterMatchListNew(
      LeagueManager.type.value,
      LeagueManager.euid,
      '',
      TYUserController.to.getUid(),
      'v2_h5',
      '1',
      LeagueManager.md,
    );

    if (res.data.isNotEmpty) {
      logic.downloadData = false;
      logic.noData = false;
      getFilterMatchListNewsData = res.data;
      update();
      if (selectedList.isNotEmpty) {
        for (var element in getFilterMatchListNewsData) {
          for (var element2 in element.tournaments) {
            if (selectedList.contains(element2.id)) {
              element2.isSelect = true;
              element.isSelect =
                  element.tournaments.every((element) => element.isSelect);
            }
          }
          logic.isSelectCount = getFilterMatchListNewsData
              .expand((element) => element.tournaments)
              .where((tournament) => tournament.isSelect)
              .length;
          logic.selectAll = getFilterMatchListNewsData.every((item) {
            return item.isSelect &&
                item.tournaments.every((tournament) => tournament.isSelect);
          });
        }
      }
      logic.spell = getFilterMatchListNewsData[0].tournaments[0].spell;

      for (var element in getFilterMatchListNewsData) {
        indexNationList.add(element.spell);
      }
    } else {
      logic.downloadData = false;
      logic.noData = true;
      update();
    }

    ///整理完后刷新
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

    /// 过滤比赛列表，根据搜索文本进行匹配
    var filteredTournamentList = getFilterMatchListNews.map((item) {
      var filteredTags = item.tournaments.where((tag) {
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();

          /// 检查当前标签的 nameText 和 tnjc 是否包含关键字
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);
        });
      }).toList();

      return item.copyWith(tournaments: filteredTags);
    }).toList();

    for (var element in filteredTournamentList) {
      for (var element2 in element.tournaments) {
        if (element2.isSelect == true) {
          ids.add(element2.id);
          print('element2' + ids.toString());
        }
      }
    }
    finishCb(ids.join(','));
    LeagueManager.tid.value = ids;
    Get.back();
  }

  debounceSearch(value) {
    /// 检查搜索控制器的文本是否为空
    if (searchController.text.isEmpty) {
      /// 如果为空，回复默认列表数据
      getFilterMatchListNews = getFilterMatchListNewsData;

      /// 遍历列表，将每个项的选择状态设为 false
      for (var item in getFilterMatchListNews) {
        item.isSelect = false;
      }
    }

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 搜索过后数据滚动第一位置
    if (autoScrollController.hasClients &&
        autoScrollController.position.maxScrollExtent > 600) {
      /// 跳转到指定位置
      autoScrollController.jumpTo(2);
    }
    update();
  }

  ///清空搜索栏
  onClearSearchText() {
    searchController.text = '';
    getFilterMatchListNews = getFilterMatchListNewsData;
    update();
  }

  /// 全选
  onSelectAll() {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    var filteredTournamentList = getFilterMatchListNews.map((item) {
      var filteredTags = item.tournaments.where((tag) {
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();

          /// 检查当前标签的 nameText 和 tnjc 是否包含关键字
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);
        });
      }).toList();

      return item.copyWith(tournaments: filteredTags);
    }).toList();

    if (filteredTournamentList.isNotEmpty) {
      bool val = !logic.selectAll;
      logic.selectAll = val;
      for (var element in filteredTournamentList) {
        element.isSelect = val;
        for (var element2 in element.tournaments) {
          element2.isSelect = val;
        }
      }
      logic.isSelectCount = filteredTournamentList
          .expand((element) => element.tournaments)
          .where((tournament) => tournament.isSelect)
          .length;
    }

    update();
  }

  toOnVerticalDragDown(DragDownDetails details) {
    logic.location = (details.localPosition.dy - details.localPosition.dx) - 13;
    update();
  }

  toOnVerticalDragEnd(DragEndDetails details) {
    logic.indicator = false;
    update();
  }

  toOnVerticalDragUpdate(DragUpdateDetails details) {
    /*indicator = true;
    location = details.localPosition.dy + 10;

    double y = details.localPosition.dy;
    var itemHeight = screenHeight(Get.context!) / 2 / getFilterMatchListNewsData.length;
    int index = (y ~/ itemHeight).clamp(0, getFilterMatchListNewsData.length);

    slidingUpdate(index);
    currentIndex = index;
    update();*/
  }


}
