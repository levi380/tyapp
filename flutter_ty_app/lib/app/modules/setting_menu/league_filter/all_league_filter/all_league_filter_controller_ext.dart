
import '../../../../services/models/res/get_filter_match_list_all_entity.dart';
import '../../../login/login_head_import.dart';
import 'all_league_filter_controller.dart';

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

extension AllLeagueFilterControllerExt on AllLeagueFilterController   {

  ///监听当前联赛头部下标
  onObserves(index) {
    if (logic.click == true) {
      logic.currentIndex = index;

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

      for (int i = 0; i < getFilterMatchList.length; i++) {
        if (i == index) {
          logic.spell = getFilterMatchList[i].spell;
        }
      }
      update();
    }
  }

  ///联赛头部下标
  void changeIndex(String indexId) {
    logic.click = false;

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
    sportVOs[index].isExpand = !sportVOs[index].isExpand;
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

    /// 切换选定状态
    getFilterMatchList[index].isSelect = !getFilterMatchList[index].isSelect;

    /// 更新选中状态
    for (int i = 0;
    i < filteredTournamentList[index].tournamentList.length;
    i++) {
      filteredTournamentList[index].tournamentList[i].isSelect =
      !filteredTournamentList[index].tournamentList[i].isSelect;
    }

    /// 计算选中数量
    logic.isSelectCount = filteredTournamentList
        .expand((element) => element.tournamentList)
        .where((tournament) => tournament.isSelect)
        .length;

    /// 判断item 是否都选中,全选按钮
    logic.selectAll = filteredTournamentList.every((item) {
      return item.isSelect &&
          item.tournamentList.every((tournament) => tournament.isSelect);
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

    ///根据搜索框文本的状态，切换选定状态
    if (searchController.text.isEmpty) {
      /// 如果搜索文本为空，遍历所有匹配的项目
      for (var element in getFilterMatchList) {
        for (var element2 in element.tournamentList) {
          /// 如果找到匹配的 ID，切换其选定状态
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }

        /// 更新项目的选定状态
        element.isSelect =
            element.tournamentList.every((element) => element.isSelect);
      }
    } else {
      /// 如果搜索文本不为空，遍历过滤后的项目
      for (var element in filteredTournamentList) {
        for (var element2 in element.tournamentList) {
          /// 如果找到匹配的 ID，切换其选定状态
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }

        /// 更新项目的选定状态
        element.isSelect =
            element.tournamentList.every((element) => element.isSelect);
      }

      /// 更新匹配列表为过滤后的列表
      getFilterMatchList = filteredTournamentList;
    }

    /// 选中数量
    logic.isSelectCount = getFilterMatchList
        .expand((element) => element.tournamentList)
        .where((tournament) => tournament.isSelect)
        .length;

    ///是否全部选中
    logic.selectAll = filteredTournamentList.every((item) {
      return item.isSelect &&
          item.tournamentList.every((tournament) => tournament.isSelect);
    });

    update();
  }

  ///输入框变化筛选
  debounceSearch(value) {
    if (searchController.text.isEmpty) {
      getFilterMatchList = sportVOs;
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

    getFilterMatchList = sportVOs.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查 tournamentList 中的每个标签是否包含关键字
        return item.tournamentList.any((tag) {
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
