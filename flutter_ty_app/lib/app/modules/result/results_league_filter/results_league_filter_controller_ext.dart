import 'package:flutter_ty_app/app/modules/result/results_league_filter/results_league_filter_controller.dart';
import '../../../services/models/res/get_filter_match_list_new_d_entity.dart';
import '../../login/login_head_import.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-245a3681-af98-492f-85f3-b3190a23bc35-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 普通赛果联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  普通赛果 联赛筛选 控制器 ResultsLeagueFilterController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  普通赛果 联赛筛选 控制器 ResultsLeagueFilterController
    - ResultsLeagueFilterPage
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

    /// 检查 tournaments 是否为空
    if (item.tournaments.isEmpty) {
    return false;
    }

    return keywords.every((keyword) {
    var lowerKeyword = keyword.toLowerCase();
    return item.tournaments.any((tag) {
    /// 检查标签的 nameText 和 tnjc 是否包含关键字
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
extension ResultsLeagueFilterControllerExt on ResultsLeagueFilterController {


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

  void slidingUpdate(int index) {
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
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

      getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
        if (searchControllerText.isEmpty) {
          return true;
        }
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();
          return item.tournaments.any((tag) => tag.nameText
              .toLowerCase()
              .contains(lowerKeyword)); // 将 tag.nameText 转换为小写
        });
      }).toList();

      for (int i = 0; i < getFilterMatchListNews.length; i++) {
        if (i == index) {
          logic.spell = getFilterMatchListNews[i].spell;
        }
      }
      logic.currentIndex = index;
      update();
    }
    update();
  }

  /// 点击单个分组折叠
  onClickItemExpand(index) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤匹配列表，基于搜索控制器的文本
    getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }

      if (item.tournaments.isEmpty) {
        return false;
      }

      /// 检查每个关键字是否在当前项的标签中找到
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查当前项的每个标签是否包含关键字
        return item.tournaments.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      });
    }).toList();

    /// 切换指定索引项的展开状态
    getFilterMatchListNews[index].isExpand =
    !getFilterMatchListNews[index].isExpand;

    update();
  }

  /// 联赛分组头部选中
  onSelectGroup(index) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤匹配列表，基于搜索控制器的文本
    getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }

      if (item.tournaments.isEmpty) {
        return false;
      }

      /// 检查每个关键字是否在当前项的标签中找到
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查当前项的每个标签是否包含关键字
        return item.tournaments.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      });
    }).toList();

    /// 创建一个新的过滤后的比赛列表
    var filteredTournamentList = getFilterMatchListNews.map((item) {
      /// 过滤当前项的标签
      var filteredTags = item.tournaments.where((tag) {
        /// 检查每个关键字是否在标签中找到
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();

          /// 检查标签名称和 tnjc 是否包含关键字
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      }).toList();

      /// 返回一个新的项，包含过滤后的标签
      return item.copyWith(tournaments: filteredTags);
    }).toList();

    ///切换指定索引项的选择状态
    getFilterMatchListNews[index].isSelect =
    !getFilterMatchListNews[index].isSelect;

    /// 切换过滤后的比赛列表中指定索引项的每个标签的选择状态
    for (int i = 0; i < filteredTournamentList[index].tournaments.length; i++) {
      filteredTournamentList[index].tournaments[i].isSelect =
      !filteredTournamentList[index].tournaments[i].isSelect;
    }

    /// 计算被选择的搜索数量
    logic.isSelectCount = filteredTournamentList
        .expand((element) => element.tournaments)
        .where((tournament) => tournament.isSelect)
        .length;

    /// 判断子 item 是否选中
    logic.selectAll = filteredTournamentList.every((item) {
      return item.isSelect &&
          item.tournaments.every((tournament) => tournament.isSelect);
    });

    update();
  }

  /// 联赛分组item 选中
  onSelectItem(id) {
    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤匹配列表，基于搜索控制器的文本
    getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }

      if (item.tournaments.isEmpty) {
        return false;
      }

      /// 检查每个关键字是否在当前项的标签中找到
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查当前项的每个标签是否包含关键字
        return item.tournaments.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      });
    }).toList();

    /// 创建一个新的过滤后的比赛列表
    var filteredTournamentList = getFilterMatchListNews.map((item) {
      /// 过滤当前项的标签
      var filteredTags = item.tournaments.where((tag) {
        /// 检查每个关键字是否在标签中找到
        return keywords.every((keyword) {
          var lowerKeyword = keyword.toLowerCase();

          /// 检查标签名称和 tnjc 是否包含关键字
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      }).toList();

      /// 返回一个新的项，包含过滤后的标签
      return item.copyWith(tournaments: filteredTags);
    }).toList();

    /// 根据搜索文本是否为空来选择匹配项
    if (searchController.text.isEmpty) {
      /// 遍历所有匹配项
      for (var element in getFilterMatchListNews) {
        /// 遍历每个项的标签
        for (var element2 in element.tournaments) {
          /// 如果标签的 ID 匹配，切换选择状态
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }

        /// 更新项的选择状态，检查所有标签是否均被选择
        element.isSelect =
            element.tournaments.every((element) => element.isSelect);
      }
    } else {
      /// 遍历过滤后的比赛列表
      for (var element in filteredTournamentList) {
        /// 遍历每个项的标签
        for (var element2 in element.tournaments) {
          /// 如果标签的 ID 匹配，切换选择状态
          if (element2.id == id) {
            element2.isSelect = !element2.isSelect;
          }
        }

        /// 更新项的选择状态，检查所有标签是否均被选择
        element.isSelect =
            element.tournaments.every((element) => element.isSelect);
      }

      /// 更新匹配列表为过滤后的列表
      getFilterMatchListNews = filteredTournamentList;
    }

    /// 计算被选择的标签数量
    logic.isSelectCount = getFilterMatchListNews
        .expand((element) => element.tournaments)
        .where((tournament) => tournament.isSelect)
        .length;

    /// 判断子 item 是否选中

    logic.selectAll = filteredTournamentList.isNotEmpty &&
        filteredTournamentList[0]
            .tournaments
            .every((tournament) => tournament.isSelect);
    update();
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

    /// 过滤匹配列表，基于搜索控制器的文本
    getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
      if (searchControllerText.isEmpty) {
        return true;
      }

      if (item.tournaments.isEmpty) {
        return false;
      }

      /// 检查每个关键字是否在当前项的标签中找到
      return keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();

        /// 检查当前项的每个标签是否包含关键字
        return item.tournaments.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword);

          /// 同时匹配 nameText 和 tnjc
        });
      });
    }).toList();

    for (int i = 0; i < getFilterMatchListNews.length; i++) {
      if (getFilterMatchListNews[i].id == indexId) {
        logic.spell = getFilterMatchListNews[i].spell;
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
}
