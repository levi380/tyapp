import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../services/models/res/get_filter_match_list_all_entity.dart';
import '../../../../utils/oss_util.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 滚球全部 字母排序列表组件 AllAlphabetFilterWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 滚球全部 字母排序列表组件 AllAlphabetFilterWidget
    - AllAlphabetFilterWidget
    ```
    ///滚球全部 字母排序列表
    AllAlphabetFilterWidget(
      isDark: context.isDarkMode,
      toOnVerticalDragDown: (details) =>
      controller.toOnVerticalDragDown(details),
      toOnVerticalDragEnd: (details) =>
      controller.toOnVerticalDragEnd(details),
      toOnVerticalDragUpdate: (details) =>
      controller.toOnVerticalDragUpdate(details),
      sportVOs: controller.sportVOs,
      changeIndex: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex,
      indicator: controller.indicator,
      location: controller.location,
      searchController: controller.searchController,
      spell: controller.spell,
    )
    ```
    】】】
 *
 */
class AllAlphabetFilterWidget extends StatelessWidget {
  const AllAlphabetFilterWidget({
    super.key,
    required this.isDark,
    required this.toOnVerticalDragDown,
    required this.toOnVerticalDragEnd,
    required this.toOnVerticalDragUpdate,
    required this.sportVOs,
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
  final List<GetFilterMatchListAllDataSportVOs> sportVOs;
  final void Function(dynamic) changeIndex;
  final int currentIndex;
  final bool indicator;
  final double location;
  final dynamic searchController;
  final dynamic spell;

  @override
  Widget build(BuildContext context) {
    /// 创建一个集合来存储 item
    var seenSpells = <String>{};

    /// 获取用户输入的文本并转换为小写
    String searchControllerText = searchController.text.toLowerCase();

    /// 将输入文本按字符分割成列表
    List<String> keywords = searchControllerText.split('');

    /// 使用 map 方法遍历每个字符串，并去掉头尾空格
    keywords = keywords.map((keyword) => keyword.trim()).toList();

    /// 过滤 sportVOs 列表以获取匹配的项目
    var getFilterMatchList = sportVOs.where((item) {
      /// 检查每个关键词是否在条件中匹配
      bool hasMatchingTournament = keywords.every((keyword) {
        /// 将关键词转换为小写
        var lowerKeyword = keyword.toLowerCase();

        /// 检查项目的比赛标签是否包含该关键词
        return item.tournamentList.any((tag) {
          return tag.nameText.toLowerCase().contains(lowerKeyword) ||
              tag.tnjc.toLowerCase().contains(lowerKeyword); // 同时匹配 nameText 和 tnjc
        });
      });

      if (hasMatchingTournament && !seenSpells.contains(item.spell.toLowerCase())) {
        /// 将匹配的 item 加入集合中
        seenSpells.add(item.spell.toLowerCase());
        return true;
      }
      return false;
    }).toList();


    return Stack(
      children: [
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
                children:
                    List<Widget>.generate(getFilterMatchList.length, (index) {
                  if (getFilterMatchList[index].id == '0') {
                    return GestureDetector(
                      onTap: () => changeIndex(getFilterMatchList[index].id),
                      child: Container(
                        alignment: Alignment.center,
                        child: ImageView(
                          spell == getFilterMatchList[index].spell
                              ? "assets/images/icon/icon_hot_not_select.png"
                              : "assets/images/icon/icon_hot_select.png",
                          height: 18.w,
                          width: 18.w,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => changeIndex(getFilterMatchList[index].id),
                      child: Container(
                        alignment: Alignment.center,
                        height: 16.w,
                        width: 16.w,
                        decoration: spell == getFilterMatchList[index].spell
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              )
                            : null,
                        child: Text(
                          getFilterMatchList[index].spell,
                          style: TextStyle(
                            color: spell == getFilterMatchList[index].spell
                                ? Colors.white
                                : const Color(0xFF7981A4),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }
                }),
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
                      spell == 'DIANZIZUQIU' ? 'D' : spell,
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
