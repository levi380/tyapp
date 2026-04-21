import 'package:get/get_rx/src/rx_types/rx_types.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 VrResultslogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 VrResultslogic
    - VrResultslogic
    ```
    ///结束时间
    late String endTime;
    ///开始时间
    late String startTime;
    ///页数
    int page = 1;
    /// 加载页
    RxBool loading = false.obs;


    ///菜单数据
    late List<VirtualMenusData> vRMenuListData = [];

    ///菜单默认索引
    int vRMenuIndex = 0;
    String vRMenuMenuId = '1001';

    ///联赛标题数据
    late List<VirtualMenusDataSubList> vRLeagueSubList = [];
    int vRLeagueIndex = 0;
    String vRLeagueMenuId = '516778647047262210';
    late List<QueryTournamentScoreResultDataRecords> recordsList = [];

    ///展开收起
    bool isExpand = true;

    ///联赛筛选开关
    bool vRLeagueMen = false;

    ///球类开关
    bool vRMen = false;
    ```
    】】】
 *
 */

class VrResultslogic {
  int dateIndex = 0;

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;

  String euid = '1';
  String tid = '';

  ///结束时间
  late String endTime;
  ///开始时间
  late String startTime;
  ///页数
  int page = 1;
  /// 加载页
  RxBool loading = false.obs;

  ///菜单图片资源
  final Map<String, Map<String, String>> vrSportsMenuImg = {
    '1001': {
      'imgName': 'vr_home_football.png',
      'darkImgName': 'vr_home_football_dark.png',
      'imgNameSel': 'vr_home_football_sel.png',
    },
    '1004': {
      'imgName': 'vr_home_basketball.png',
      'darkImgName': 'vr_home_basketball_dark.png',
      'imgNameSel': 'vr_home_basketball_sel.png',
    },
    '1011': {
      'imgName': 'vr_home_horse.png',
      'darkImgName': 'vr_home_horse_dark.png',
      'imgNameSel': 'vr_home_horse_sel.png',
    },
    '1002': {
      'imgName': 'vr_home_dog.png',
      'darkImgName': 'vr_home_dog_dark.png',
      'imgNameSel': 'vr_home_dog_sel.png',
    },
    '1010': {
      'imgName': 'vr_home_motorcycle.png',
      'darkImgName': 'vr_home_motorcycle_dark.png',
      'imgNameSel': 'vr_home_motorcycle_sel.png',
    },
    '1009': {
      'imgName': 'vr_home_dirt_bike.png',
      'darkImgName': 'vr_home_dirt_bike_dark.png',
      'imgNameSel': 'vr_home_dirt_bike_sel.png',
    },
  };

  ///菜单默认索引
  int vRMenuIndex = 0;
  String vRMenuMenuId = '1001';

  int vRLeagueIndex = 0;
  String vRLeagueMenuId = '516778647047262210';


  ///展开收起
  bool isExpand = true;

  ///联赛筛选开关
  bool vRLeagueMen = false;

  ///球类开关
  bool vRMen = false;

  VrResultslogic() {
    ///Initialize variables
  }
}
