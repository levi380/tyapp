import 'package:get/get.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5732f2fd-0654-44e8-9f55-3612d1f8073a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 联赛筛选 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛筛选 状态管理 LeagueManager  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 联赛筛选 状态管理 LeagueManager
    - LeagueManager
    ```
    static RxList tid = [].obs;

    static String euid = '40203';

    static RxInt type = 3.obs;

    static String md = '';

    // 热门 时间排序
    static RxInt sort = 1.obs;

    // 入口名字 判断是否清空已选择联赛 home result
    // h5 是点赛果就清楚已选择联赛
    static String entryName = 'home';
    ```
    】】】
 *
 */
class LeagueManager {
  LeagueManager._privateConstructor();

  static final LeagueManager _instance = LeagueManager._privateConstructor();

  static LeagueManager get instance {
    return _instance;
  }

  static RxList tid = [].obs;

  static String euid = '40203';

  static RxInt type = 3.obs;

  static String md = '';

  // 热门 时间排序
  static RxInt sort = 1.obs;

  // 入口名字 判断是否清空已选择联赛 home result
  // h5 是点赛果就清楚已选择联赛
  static String entryName = 'home';

}
