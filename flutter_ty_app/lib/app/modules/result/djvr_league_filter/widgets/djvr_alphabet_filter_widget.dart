
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../services/models/res/get_filter_match_list_new_d_entity.dart';
import '../../../../utils/oss_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3a9df28f-c590-402c-a99e-edc66a224cb3-dj 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果电竞冠军联赛筛选】】】
    【【【 AUTO_PARAGRAPH_TITLE  电竞赛果冠军赛果 字母排序列表组件 DjVrAlphabetFilterWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  电竞赛果冠军赛果 字母排序列表组件 DjVrAlphabetFilterWidget
    - DjVrAlphabetFilterWidget
    ```
    ///字母排序列表
    DjVrAlphabetFilterWidget(
      isDark: context.isDarkMode,
      toOnVerticalDragDown: (details) => controller.toOnVerticalDragDown(details),
      toOnVerticalDragEnd: (details) => controller.toOnVerticalDragEnd(details),
      toOnVerticalDragUpdate: (details) => controller.toOnVerticalDragUpdate(details),
      getFilterMatchListNewsData: controller.getFilterMatchListNewsData,
      changeIndex: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex,
      indicator: controller.indicator,
      location: controller.location,
      searchController:  controller.searchController,
      spell:  controller.spell,
    )
    ```
    】】】
 *
 */

class DjVrAlphabetFilterWidget extends StatelessWidget {
  const DjVrAlphabetFilterWidget({
    super.key,
    required this.isDark,
    required this.toOnVerticalDragDown,
    required this.toOnVerticalDragEnd,
    required this.toOnVerticalDragUpdate,
    required this.getFilterMatchListNewsData,
    required this.changeIndex,
    required this.currentIndex,
    required this.indicator,
    required this.location,
    required this.searchController,
    required this.spell,
  });

  final bool isDark;
  final void Function(dynamic) toOnVerticalDragDown;
  final void Function(dynamic) toOnVerticalDragEnd;
  final void Function(dynamic) toOnVerticalDragUpdate;
  final List<GetFilterMatchListNewDData> getFilterMatchListNewsData;
  final void Function(dynamic) changeIndex;
  final int currentIndex;
  final bool indicator;
  final double location;
  final dynamic searchController;
  final dynamic spell;

  @override
  Widget build(BuildContext context) {
    /// 用于存储已见过的 spell
    var seenSpells = <String>{};

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();
    var getFilterMatchListNews = getFilterMatchListNewsData.where((item) {
      /// 检查每个 item 的 tournaments 是否包含所有关键字
      bool hasMatchingTournament = keywords.every((keyword) {
        var lowerKeyword = keyword.toLowerCase();
        return item.tournaments.any((tag) =>
        tag.nameText.toLowerCase().contains(lowerKeyword) ||
            tag.tnjc.toLowerCase().contains(lowerKeyword)  // 添加对 tnjc 的匹配
        );
      });

      /// 检查 tournaments 中的 spell 是否已经存在
      if (hasMatchingTournament) {
        for (var tournament in item.tournaments) {
          if (!seenSpells.contains(tournament.spell.toLowerCase())) {
            seenSpells.add(tournament.spell.toLowerCase());
            return true;
          }
        }
      }
      return false;

    }).toList();


    return Stack(
      children: [
        if (getFilterMatchListNews.isNotEmpty && getFilterMatchListNews[0].tournaments.isNotEmpty)
        Positioned(
          height: double.maxFinite,
          width: 30.w,
          right: 0,
          top: 60.h,
          child: GestureDetector(
            onVerticalDragDown: (DragDownDetails details) =>
                toOnVerticalDragDown(details),
            onVerticalDragEnd: (DragEndDetails details) =>
                toOnVerticalDragEnd(details),
            onVerticalDragUpdate: (DragUpdateDetails details) =>
                toOnVerticalDragUpdate(details),
            child: Container(
              margin: EdgeInsets.only(
                top: 20.h,
              ),
              child: Column(
                children: getFilterMatchListNews[0].tournaments.map((tournament) => tournament.spell).toSet().map((uniqueSpell) {
                  var tournament = getFilterMatchListNews[0].tournaments.firstWhere((t) => t.spell == uniqueSpell,);
                  return GestureDetector(
                    onTap: ()=> changeIndex(tournament.id),
                    child: Container(
                      alignment: Alignment.center,
                      height: 16.w,
                      width: 16.w,
                      decoration: spell == uniqueSpell
                          ? const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      )
                          : null,
                      child: Text(
                        uniqueSpell,
                        style: TextStyle(
                          color: spell == uniqueSpell
                              ? Colors.white
                              : const Color(0xFF7981A4),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        indicator == true
            ? Positioned(
                right: 25.w,
                top: location + 60,
                child: Container(
                  width: 58,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          "assets/images/icon/bg_sellabel.png",
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: Text(
                      spell,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
