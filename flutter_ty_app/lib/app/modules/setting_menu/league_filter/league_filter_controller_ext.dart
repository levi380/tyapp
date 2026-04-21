
import '../../../services/models/res/get_filter_match_list_entity.dart';


import '../../login/login_head_import.dart';
import 'league_filter_controller.dart';


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

extension LeagueFilterControllerExt on LeagueFilterController  {

  ///联赛头部下标
  void changeIndex(String indexId) {
    logic.click = false;

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
      if (getFilterMatchList[i].id == indexId) {
        logic.spell = getFilterMatchList[i].spell;
        logic.indicator = true;
        listObserverController.animateTo(
          index: i,
          duration: const Duration(milliseconds: 10),
          curve: Curves.ease,
        );
        Future.delayed(const Duration(milliseconds: 200), () {
          logic.indicator = false;
          update();
        });
        break;
      }
    }
    logic.click = true;
    update();
  }

  ///联赛title 展开隐藏
  onClickNationItemExpand(index) {
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

    getFilterMatchList[index].isExpand = !getFilterMatchList[index].isExpand;
    update();
  }

  ///联赛title 选中
  onSelectNationGroup(index) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤比赛列表
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

    getFilterMatchList[index].isSelect = !getFilterMatchList[index].isSelect;

    for (int i = 0;
    i < filteredTournamentList[index].sportVOs[0].tournamentList.length;
    i++) {
      filteredTournamentList[index].sportVOs[0].tournamentList[i].isSelect =
      !filteredTournamentList[index].sportVOs[0].tournamentList[i].isSelect;
    }
    logic.isSelectCount = filteredTournamentList
        .expand((element) => element.sportVOs[0].tournamentList)
        .where((tournament) => tournament.isSelect)
        .length;
    logic.selectAll = filteredTournamentList.every((item) {
      return item.isSelect &&
          item.sportVOs[0].tournamentList
              .every((tournament) => tournament.isSelect);
    });
    update();
  }

  ///联赛详情列表title 选中
  onSelectNationItem(id) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤比赛列表
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

    if (searchController.text.isEmpty) {
      for (var element in getFilterMatchList) {
        for (var element2 in element.sportVOs[0].tournamentList) {
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }
        element.isSelect = element.sportVOs[0].tournamentList
            .every((element) => element.isSelect);
      }
    } else {
      for (var element in filteredTournamentList) {
        for (var element2 in element.sportVOs[0].tournamentList) {
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }
        element.isSelect = element.sportVOs[0].tournamentList
            .every((element) => element.isSelect);
      }
      getFilterMatchList = filteredTournamentList;
    }

    logic.isSelectCount = getFilterMatchList
        .expand((element) => element.sportVOs[0].tournamentList)
        .where((tournament) => tournament.isSelect)
        .length;
    logic.selectAll = filteredTournamentList.every((item) {
      return item.isSelect &&
          item.sportVOs[0].tournamentList
              .every((tournament) => tournament.isSelect);
    });

    update();
  }

  ///输入框内容处理
  debounceSearch(value) {
    if (searchController.text.isEmpty) {
      getFilterMatchList = getFilterMatchListData;
      for (var item in getFilterMatchList) {
        item.isSelect = false;
      }
    }

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

    if (autoScrollController.hasClients &&
        autoScrollController.position.maxScrollExtent > 600) {
      autoScrollController.jumpTo(2);
    }
    update();
  }
}
